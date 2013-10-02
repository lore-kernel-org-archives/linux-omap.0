From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: [RFC 01/15] scripts/dtc: fix most memory leaks in dtc
Date: Wed, 2 Oct 2013 22:59:34 +1000
Message-ID: <20131002125934.GF6506@voom.fritz.box>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <1380041541-17529-2-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380041541-17529-2-git-send-email-bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2013 at 06:52:07PM +0200, Benoit Cousson wrote:
> From: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

As noted elsewhere, please write patches against upstream dtc, not the
version in the kernel.  git://git.kernel.org/pub/scm/utils/dtc/dtc.git

> There are a few memory leaks in dtc which until now were not that importa=
nt
> since they were all in the parser and only one instance of the parser was=
 run
> per instance of dtc. The following commits will add a validation of dts t=
hrough
> schema which have the same syntax as dts, i.e. the parser of dts will be =
reused
> to parse schema. The consequence is that instead of having the parser run=
ning
> only one time for an instance of the dtc process, the parser will run
> many many times and thus the leak that were not important until now becom=
es
> urgent to fix.

Hrm, yeah.  I'm aware that I haven't been very careful with memory
leaks within the parser.  Essentially, I've been treating the process
as a pool allocator with exactly one pool - I've even considered
getting rid of those free()s we do have.

If the parser's going to be invoked repeatedly, then, yes, that
certainly needs fixing.  Whether individually fixing each leak or
using a explicit pool allocator is a better option is less clear.

> dtc-lexer: Do not duplicate the string which contains literals because the
> string is directly converted afterward to an integer and is never used ag=
ain.
> livetree: Add a bunch of free helper functions to clean properly the
> dt.

This is no good.  Making this assumption is a layering violation - if
the parser was changed so that this literal wasn't converted until
after another token was read, the yytext value copied in here would no
longer be valid and would break horribly.

>=20
> Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  scripts/dtc/dtc-lexer.l             |   2 +-
>  scripts/dtc/dtc-lexer.lex.c_shipped |   2 +-
>  scripts/dtc/dtc.c                   |   1 +
>  scripts/dtc/dtc.h                   |   1 +
>  scripts/dtc/livetree.c              | 108 ++++++++++++++++++++++++++++++=
+++---
>  5 files changed, 105 insertions(+), 9 deletions(-)
>=20
> diff --git a/scripts/dtc/dtc-lexer.l b/scripts/dtc/dtc-lexer.l
> index 3b41bfc..4f63fbf 100644
> --- a/scripts/dtc/dtc-lexer.l
> +++ b/scripts/dtc/dtc-lexer.l
> @@ -146,7 +146,7 @@ static int pop_input_file(void);
>  		}
> =20
>  <V1>([0-9]+|0[xX][0-9a-fA-F]+)(U|L|UL|LL|ULL)? {
> -			yylval.literal =3D xstrdup(yytext);
> +			yylval.literal =3D yytext;
>  			DPRINT("Literal: '%s'\n", yylval.literal);
>  			return DT_LITERAL;
>  		}
> diff --git a/scripts/dtc/dtc-lexer.lex.c_shipped b/scripts/dtc/dtc-lexer.=
lex.c_shipped
> index 2d30f41..5c0d27c 100644
> --- a/scripts/dtc/dtc-lexer.lex.c_shipped
> +++ b/scripts/dtc/dtc-lexer.lex.c_shipped
> @@ -1054,7 +1054,7 @@ case 10:
>  YY_RULE_SETUP
>  #line 148 "dtc-lexer.l"
>  {
> -			yylval.literal =3D xstrdup(yytext);
> +			yylval.literal =3D yytext;
>  			DPRINT("Literal: '%s'\n", yylval.literal);
>  			return DT_LITERAL;
>  		}
> diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
> index a375683..215ae92 100644
> --- a/scripts/dtc/dtc.c
> +++ b/scripts/dtc/dtc.c
> @@ -256,5 +256,6 @@ int main(int argc, char *argv[])
>  		die("Unknown output format \"%s\"\n", outform);
>  	}
> =20
> +	free_dt(bi);
>  	exit(0);
>  }
> diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
> index 3e42a07..9c45fd2 100644
> --- a/scripts/dtc/dtc.h
> +++ b/scripts/dtc/dtc.h
> @@ -245,6 +245,7 @@ struct boot_info {
>  struct boot_info *build_boot_info(struct reserve_info *reservelist,
>  				  struct node *tree, uint32_t boot_cpuid_phys);
>  void sort_tree(struct boot_info *bi);
> +void free_dt(struct boot_info *bi);
> =20
>  /* Checks */
> =20
> diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
> index b61465f..5c8692c 100644
> --- a/scripts/dtc/livetree.c
> +++ b/scripts/dtc/livetree.c
> @@ -20,6 +20,10 @@
> =20
>  #include "dtc.h"
> =20
> +static void free_node_list(struct node *n);
> +static void free_node(struct node *n);
> +static void free_property(struct property *p);
> +
>  /*
>   * Tree building functions
>   */
> @@ -144,7 +148,7 @@ struct node *merge_nodes(struct node *old_node, struc=
t node *new_node)
> =20
>  	/* Add new node labels to old node */
>  	for_each_label_withdel(new_node->labels, l)
> -		add_label(&old_node->labels, l->label);
> +		add_label(&old_node->labels, xstrdup(l->label));
> =20
>  	/* Move properties from the new node to the old node.  If there
>  	 * is a collision, replace the old value with the new */
> @@ -156,7 +160,7 @@ struct node *merge_nodes(struct node *old_node, struc=
t node *new_node)
> =20
>  		if (new_prop->deleted) {
>  			delete_property_by_name(old_node, new_prop->name);
> -			free(new_prop);
> +			free_property(new_prop);
>  			continue;
>  		}
> =20
> @@ -165,7 +169,7 @@ struct node *merge_nodes(struct node *old_node, struc=
t node *new_node)
>  			if (streq(old_prop->name, new_prop->name)) {
>  				/* Add new labels to old property */
>  				for_each_label_withdel(new_prop->labels, l)
> -					add_label(&old_prop->labels, l->label);
> +					add_label(&old_prop->labels, xstrdup(l->label));
> =20
>  				old_prop->val =3D new_prop->val;
>  				old_prop->deleted =3D 0;
> @@ -191,7 +195,7 @@ struct node *merge_nodes(struct node *old_node, struc=
t node *new_node)
> =20
>  		if (new_child->deleted) {
>  			delete_node_by_name(old_node, new_child->name);
> -			free(new_child);
> +			free_node(new_child);
>  			continue;
>  		}
> =20
> @@ -211,7 +215,7 @@ struct node *merge_nodes(struct node *old_node, struc=
t node *new_node)
> =20
>  	/* The new node contents are now merged into the old node.  Free
>  	 * the new node. */
> -	free(new_node);
> +	free_node(new_node);
> =20
>  	return old_node;
>  }
> @@ -532,13 +536,13 @@ cell_t get_node_phandle(struct node *root, struct n=
ode *node)
>  	if (!get_property(node, "linux,phandle")
>  	    && (phandle_format & PHANDLE_LEGACY))
>  		add_property(node,
> -			     build_property("linux,phandle",
> +			     build_property(xstrdup("linux,phandle"),
>  					    data_append_cell(empty_data, phandle)));
> =20
>  	if (!get_property(node, "phandle")
>  	    && (phandle_format & PHANDLE_EPAPR))
>  		add_property(node,
> -			     build_property("phandle",
> +			     build_property(xstrdup("phandle"),
>  					    data_append_cell(empty_data, phandle)));
> =20
>  	/* If the node *does* have a phandle property, we must
> @@ -707,3 +711,93 @@ void sort_tree(struct boot_info *bi)
>  	sort_reserve_entries(bi);
>  	sort_node(bi->dt);
>  }
> +
> +static void free_marker_list(struct marker *m)
> +{
> +	struct marker *marker, *marker_next;
> +
> +	if (!m)
> +		return;
> +
> +	for (marker =3D m, marker_next =3D marker ? marker->next : NULL;
> +	     marker;
> +	     marker =3D marker_next, marker_next =3D marker ? marker->next : NU=
LL) {

Rather hard to read version of safe-against-free list iteration.

> +		free(marker->ref);
> +		free(marker);
> +	}
> +}
> +
> +static void free_label_list(struct label *l)
> +{
> +	struct label *label, *label_next;
> +
> +	if (!l)
> +		return;
> +
> +	for (label =3D l, label_next =3D label ? label->next : NULL;
> +	     label;
> +	     label =3D label_next, label_next =3D label ? label->next : NULL) {
> +		free(label->label);
> +		free(label);
> +	}
> +}
> +
> +static void free_property(struct property *p)
> +{
> +	if (!p)
> +		return;
> +
> +	free_label_list(p->labels);
> +	free_marker_list(p->val.markers);
> +	free(p->val.val);
> +	free(p->name);
> +	free(p);
> +}
> +
> +static void free_property_list(struct property *p)
> +{
> +	struct property *next;
> +
> +	if (!p)
> +		return;
> +
> +	for (next =3D p->next; p; p =3D next, next =3D p ? p->next : NULL)
> +		free_property(p);
> +}
> +
> +static void free_node(struct node *n)
> +{
> +	if (!n)
> +		return;
> +
> +	free_node_list(n->children);
> +	free_label_list(n->labels);
> +	free_property_list(n->proplist);
> +	free(n->fullpath);
> +	if (n->name && *n->name)

*n->name .. so, the name can (and must) be statically allocated if
it's exactly "".  Not a useful optimization, I think.

> +		free(n->name);
> +	free(n);
> +}
> +
> +static void free_node_list(struct node *n)
> +{
> +	struct node *next;
> +
> +	if (!n)
> +		return;
> +
> +	for (next =3D n->next_sibling;
> +	     n;
> +	     n =3D next, next =3D n ? n->next_sibling : NULL) {
> +		free_node(n);
> +	}
> +}
> +
> +void free_dt(struct boot_info *bi)
> +{
> +	if (!bi)
> +		return;
> +
> +	free_node_list(bi->dt);
> +	free(bi);
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSTBi2AAoJEGw4ysog2bOS+M0QAORsAbHtwCajX/gUynCBbWm+
IxoFdiG+l0PgcKOWnPDV2e76I/tePy0FbmUPJIi4i9Tw0MAEV5y/dTwH4GXI9pZu
t0dAW9YAF3/0miCskHRonjFCpCB+zi9Gf2wkHesajLu7gACAJs7BmTqXsONk+Vdp
9NiWnjLuiLwmtgGGYCSA57XfGcho/f/P7LzbKhm9a1tMuk/NOLqUxnlK9oNtii6u
+d+WWMUOXtM7UdHqAlcjiKLqT+EJXJTkHjZ8GMhTir7dAzmY2WqvVeR1wlDfd8wg
fhtjSxBe66rrtnvKrX9hhS3lEup4Ebmm7squsbZfuegPz2ZboxIjy8II18jIK9IH
CAV44zaFUnWI2KGZon1UxjJ7qAWsiTnMe//trmGJUt/K44lKM4C4DSdqHaBG6IYW
A6ik8TwOMY74hp5lJtYVaOALidJfM7e9+CIyOvOyuUcOxtI6zsDvSllMMS3ejAzi
gnFkNMB9PI+qxX7lapx9CrwRvgvOl7KpHICnqyDEy4Ub0Uh4DTa21AQLeD9mc8SI
LW14oTxQ2ZpfF4fZbB2o+sguJnmytmeeZpyWNXZ8Nk9UszavC5v0L7A1En+8aP0b
mEOBXUbwbMsa58aIQ9OW7jSbqbbK4H5VO3Og9OWrQ+N/zIwMTfS8sApz/iB1FWDB
LTsHmhoS/SBmtYHAkuwu
=GUW6
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
