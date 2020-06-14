/**
 * Visits the symbols in a file and maps their C name. This is used by the
 * documentation engine to equalize references to symbols in VAPIs with 
 * references to symbols in corresponding GIRs. It is also used to map
 * references to C names in documentation text to references to symbols
 * in VAPIs.
 *
 * @see Vls.CodeHelp.get_symbol_cname
 */
class Vls.CNameMapper : Vala.CodeVisitor {
    private Gee.HashMap<string, Vala.Symbol> cname_to_sym;

    public CNameMapper (Gee.HashMap<string, Vala.Symbol> cname_to_sym) {
        this.cname_to_sym = cname_to_sym;
    }

    private void map_cname (string cname, Vala.Symbol sym) {
        // debug ("mapping C name %s -> symbol %s (%s)", cname, sym.get_full_name (), sym.type_name);
        cname_to_sym[cname] = sym;
    }

    private void try_map_cname (Vala.Symbol sym) {
        map_cname (CodeHelp.get_symbol_cname (sym), sym);
    }

    public override void visit_source_file (Vala.SourceFile source_file) {
        source_file.accept_children (this);
    }

    public override void visit_class (Vala.Class cl) {
        try_map_cname (cl);
        cl.accept_children (this);
    }

    public override void visit_constant (Vala.Constant c) {
        try_map_cname (c);
    }

    public override void visit_creation_method (Vala.CreationMethod m) {
        try_map_cname (m);
    }

    public override void visit_delegate (Vala.Delegate d) {
        try_map_cname (d);
    }

    public override void visit_enum (Vala.Enum en) {
        try_map_cname (en);
        en.accept_children (this);
    }

    public override void visit_enum_value (Vala.EnumValue ev) {
        try_map_cname (ev);
    }

    public override void visit_error_domain (Vala.ErrorDomain edomain) {
        try_map_cname (edomain);
        edomain.accept_children (this);
    }

    public override void visit_error_code (Vala.ErrorCode ecode) {
        try_map_cname (ecode);
    }

    public override void visit_field (Vala.Field f) {
        try_map_cname (f);
    }

    public override void visit_interface (Vala.Interface iface) {
        try_map_cname (iface);
        iface.accept_children (this);
    }

    public override void visit_method (Vala.Method m) {
        try_map_cname (m);
    }

    public override void visit_namespace (Vala.Namespace ns) {
        try_map_cname (ns);
        ns.accept_children (this);
    }

    public override void visit_property (Vala.Property prop) {
        try_map_cname (prop);
    }

    public override void visit_struct (Vala.Struct st) {
        try_map_cname (st);
        st.accept_children (this);
    }
}