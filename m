From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: [RFC 00/15] Device Tree schemas and validation
Date: Thu, 3 Oct 2013 00:29:14 +1000
Message-ID: <20131002142914.GI6506@voom.fritz.box>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524B4B20.4020002@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v2/QI0iRXglpx0hK"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <524B4B20.4020002-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--v2/QI0iRXglpx0hK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 04:22:24PM -0600, Stephen Warren wrote:
> On 09/24/2013 10:52 AM, Benoit Cousson wrote:
> > Hi All,
> >=20
> > Following the discussion that happened during LCE-2013 and the email
> > thread started by Tomasz few months ago [1], here is a first attempt
> > to introduce:
> > - a schema language to define the bindings accurately
> > - DTS validation during device tree compilation in DTC itself
>=20
> Sorry, this is probably going to sound a bit negative. Hopefully you
> find it constructive though.
>=20
> > The syntax for a schema is the same as the one for dts. This choice has
> > been made to simplify its development, to maximize the code reuse and
> > finally because the format is human-readable.
>=20
> I'm not convinced that's a good decision.
>=20
> DT is a language for representing data.
>=20
> The validation checks described by schemas are rules, or code, and not
> static data.
>=20
> So, while I'm sure it's possible to shoe-horn at least some reasonable
> subset of DT validation into DT syntax itself, I feel it's unlikely to
> yield something that's scalable enough.

I tend to agree.

> For example, it's easy to specify that a property must be 2 cells long.
> What if it could be any multiple of two? That's a lot of numbers to
> explicitly enumerate as data. Sure, you can then invent syntax to
> represent that specific rule (parameterized by 2), but what about the
> next similar-but-different rule? The only approach I can think of to
> that is to allow the schema to contain arbitrary expressions, which
> would likely need to morph into arbitary statements not just
> expressions. Once you're there, I think the schema would be better
> represented as a programming language rather than as a data structure
> that could have code hooked into it.
>=20
> > How to:
> >  * Associate a schema to one or several nodes
> >=20
> > As said earlier a schema can be used to validate one or several nodes
> > from a dts. To do this the "compatible" properties from the nodes which
> > should be validated must be present in the schema.
> >=20
> > 	timer1: timer@4a318000 {
> > 		compatible =3D "ti,omap3430-timer";
> ...
> > To write a schema which will validate OMAP Timers like the one above,
> > one may write the following schema:
> >=20
> > 	/dts-v1/;
> > 	/ {
> > 		compatible =3D "ti,omap[0-9]+-timer";
>=20
> What about DT nodes that don't have a compatible value? We certainly
> have some of those already like /memory and /chosen. We should be able
> to validate their schema too. This probably doesn't invalidate being
> able to look things up by compatible value though; it just means we need
> some additional mechanisms too.

More to the point, what about the properties of a node whose format is
defined not by this node's binding but by some other nodes binding.
e.g. the exact format of reg and ranges is at least partially
determined by the parent bus's binding, and interrupts is defined
partially by the interrupt parent's binding.  gpio properties are
defined by a combination of a global binding and the gpio parent,
IIRC.

> >  * Define constraints on properties
> >=20
> > To define constraints on a property one has to create a node in a schema
> > which has as name the name of the property that one want to validate.
> >=20
> > To specify constraints on the property "ti,hwmods" of OMAP Timers one
> > can write this schema:
> >=20
> > 	/dts-v1/;
> > 	/ {
> > 		compatible =3D "ti,omap[0-9]+-timer";
> > 		ti,hwmods {
> > 			...
> > 		};
>=20
> compatible and ti,hwmods are both properties in the DT file. However, in
> the schema above, one appears as a property, and one as a node. I don't
> like that inconsistency. It'd be better if compatible was a node too.

Essentially what's going on here is that to describe the constraint on
a property, a node with corresponding name is defined to encode the
parameters of that constraint.  It kind of works, but it's forced.  It
also hits problems since nodes and properties are technically in
different namespaces, although they rarely collide in real cases.

> > If one want to use a regular as property name one can write this schema:
> >=20
> > 	/dts-v1/;
> > 	/ {
> > 		compatible =3D "abc";
> > 		def {
> > 			name =3D "def[0-9]";
>=20
> Isn't it valid to have a property named "name" within the node itself?
> How do you differentiate between specifying the node name and the name
> property?

Or to look at it another way, how do you differentiate between nodes
representing encoded constraints for a property, and nodes
representing nodes directly.

> What if the node name needs more validation than just a regex. For
> example, suppose we want to validate the
> unit-name-must-match-reg-address rule. We need to write some complex
> expression using data extracted from reg to calculate the unit address.
> Equally, the node name perhaps has to exist in some global list of
> acceptable node names. It would be extremely tricky if not impossible to
> do that with a regex.
>=20
> > 			...
> > 		};
> > 	};
> >=20
> > Above one can see that the "name" property override the node name.
>=20
> Override implies that dtc would change the node name during compilation.
> I think s/override/validate/ or s/override/overrides the validation
> rules for/?

Actually, dtc already contains checks that a "name" property (if
present) matches the unit name.  Name properties vs. node names work a
bit differently in the flat-tree world versus traditional OF, and this
checks ensures that flat trees don't do (at least some) things which
would break the OF traditional approach.

> >  * Require the presence of a property inside a node or inside one of its
> > parents
> ...
> > /dts-v1/;
> > / {
> >     compatible =3D "ti,twl[0-9]+-rtc";
> >     interrupt-controller {
> >         is-required;
> >         can-be-inherited;
>=20
> interrupt-controller isn't a good example here, since it isn't a
> property that would typically be inherited. Why not use interrupt-parent
> instead?
>=20
> > One can check if 'node' has the following subnode 'subnode1', 'subnode2=
',
> > and 'abc' with the schema below:
> >=20
> > /dts-v1/;
> > / {
> >     compatible =3D "comp";
> >     children =3D "abc", "subnode[0-9]";
> > };
>=20
> How is the schema for each sub-node specified?
>=20
> What if some nodes are optional and some required? The conditions where
> a sub-node is required might be complex, and I think we'd always want to
> be able to represent them in whatever schema language we chose.
>=20
> The most obvious way would be to make each sub-node's schema appear as a
> sub-node within the main node's schema, but then how do you tell if a
> schema node describes a property or a node?
>=20
> Note that the following DT file is currently accepted by dtc even if it
> may not be the best choice of property and node names:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> /dts-v1/;
>=20
> / {
> 	foo =3D <1>;
> 	foo {};
> };
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Note that node / property name collisions are not entirely theoretical
either.  They are permitted in IEEE1275 and there are real Apple
device trees in the wild which have them.  It's rare and discouraged,
obviously.

> >  * Constraints on array size
> >=20
> > One can specify the following constraints on array size:
> >  - length: specify the exact length that an array must have.
> >  - min-length: specify the minimum number of elements an array must hav=
e.
> >  - max-length: specify the maximum number of elements an array must hav=
e.
>=20
> This seems rather inflexible; it'll cover a lot of the simple cases, but
> hit a wall pretty soon. For example, how would it validate a property
> that is supposed to include 3 GPIO specifiers, where the GPIO specifiers
> are going to have DT-specific lengths, since the length of each
> specifier is defined by the node that the phandles reference?
>=20
>=20
> Overall, I believe perhaps the single most important aspect of any DT
> schema is schema inheritance or instancing, and this proposal doesn't
> appear to address that issue at all.
>=20
> Inheritance of schemas:
>=20
> For example, any node that is addressed must contain a reg property. The
> constraints on that property are identical in all bindings; it must
> consist of #address-cells + #size-cells integer values (cells). We don't
> want to have to cut/paste that rule into every single binding
> definition. Rather, we should simply say something like "this binding
> uses the reg property", and the schema validation tool will look up the
> definition of "reg property", and hence know how to validate it.
>=20
> Similarly, any binding that describes a GPIO controller will have some
> similar requirements; the gpio-controller and #gpio-cells properties
> must be present. The schema should simply say "I'm a GPIO controller",
> and the schema tool should add some extra requirements to nodes of that
> type.
>=20
> Instancing of schemas:
>=20
> Any binding that uses GPIOs should be able to say that a particular
> property (e.g. "enable-gpios") is-a GPIO-specifier (with parameters
> "enable" for the property name, min/max/expression length, etc.), and
> then the schema validation tool would know to apply rules for a
> specifier list to that property (and be able to check the property name).

Yes, I agree both of those are important.


So, here's a counter-proposal of at least a rough outline of how I
think schemas could work, in a way that's still based generally on dt
syntax.

First, define the notion of dt "patterns" or "templates".  A dt
pattern is to a dt node or subtree as a regex is to a string - it
provides a reasonably expressive way of defining a family of dt
nodes.  These would be defined in an extension / superset of dt
syntax.

A schema would then be defined as a set of implications:
	If node X matches pattern A, =3D> it must also match pattern B

For example:
	If a node has a compatible property with string "foodev"
	 =3D> it must have various foodev properties.

	If a node has a "reg" property (at all)
	 =3D> it must have the format required by reg

	If a node has an "interrupts" property
	 =3D> it must have either "interrupt-parent" or "interrupt-map"


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--v2/QI0iRXglpx0hK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSTC26AAoJEGw4ysog2bOSMKcP/ivt06JjN7M4ke4RuLii/Dp+
5U189OnAZjBgKj6cSo6Z+Nvr5cQ7j9tH8FdsxEMEg6DHWvvdGbsNDOvgr0m4dlwc
uhgkbMX/dA8PfcKuwucKmPiRDa8Wq9BMShKsjuVw28itqCP6lTvbEQJrTQH/rVHB
hshsryiUCCQNPEBHZMOZJamGf5RoRHCl/pUQ7Qz0v6vXmmT73fD4LRSlokLDVf3G
7/H/Fo7+9/3sP8ovdCYLBuCzp2ARFNCgWHMG4eO3/viLPKjj9XOxIBP2vgdleGve
KgPRneTm/EOspHUR8jXeEtKiYIn5N+7HdQBrXwmPGIXyWt4n4/MyogZkHtc/hssI
ZnMe7Am/7fT6bsw/rs5lj9ZaGy5wMElQhSncaJFuFFpv7B4bPrSey/bevdyiRVKA
vswEZgunvKR07v3FzrVbfuI7vP76DxEqxhjZ+jz8Qp4DycP6XdAF04K3pSfUAK4b
9ATw74pi41t8XdcgOK5anhMfeVer9It3ki1BMR83Tl8/i7VsOzkLTsBIQ7jlvdQw
5FAFyYa6ytqEu+xEr/zJaeOTqulBKy6ktuwOpN9chNuIQ8YKbcSIQCQ0VMgpHOZj
dnuZ5ItNDqcOE9apaP5S/Zp3HdwkRSRSxf1JGHbJGeO13he2SSPeVgpTSyM2s19k
E5ZAnz1g6VoYSbapdO3Y
=6IIE
-----END PGP SIGNATURE-----

--v2/QI0iRXglpx0hK--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
