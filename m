From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC 00/15] Device Tree schemas and validation
Date: Tue, 01 Oct 2013 16:22:24 -0600
Message-ID: <524B4B20.4020002@wwwdotorg.org>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/24/2013 10:52 AM, Benoit Cousson wrote:
> Hi All,
> 
> Following the discussion that happened during LCE-2013 and the email
> thread started by Tomasz few months ago [1], here is a first attempt
> to introduce:
> - a schema language to define the bindings accurately
> - DTS validation during device tree compilation in DTC itself

Sorry, this is probably going to sound a bit negative. Hopefully you
find it constructive though.

> The syntax for a schema is the same as the one for dts. This choice has
> been made to simplify its development, to maximize the code reuse and
> finally because the format is human-readable.

I'm not convinced that's a good decision.

DT is a language for representing data.

The validation checks described by schemas are rules, or code, and not
static data.

So, while I'm sure it's possible to shoe-horn at least some reasonable
subset of DT validation into DT syntax itself, I feel it's unlikely to
yield something that's scalable enough.

For example, it's easy to specify that a property must be 2 cells long.
What if it could be any multiple of two? That's a lot of numbers to
explicitly enumerate as data. Sure, you can then invent syntax to
represent that specific rule (parameterized by 2), but what about the
next similar-but-different rule? The only approach I can think of to
that is to allow the schema to contain arbitrary expressions, which
would likely need to morph into arbitary statements not just
expressions. Once you're there, I think the schema would be better
represented as a programming language rather than as a data structure
that could have code hooked into it.

> How to:
>  * Associate a schema to one or several nodes
> 
> As said earlier a schema can be used to validate one or several nodes
> from a dts. To do this the "compatible" properties from the nodes which
> should be validated must be present in the schema.
> 
> 	timer1: timer@4a318000 {
> 		compatible = "ti,omap3430-timer";
...
> To write a schema which will validate OMAP Timers like the one above,
> one may write the following schema:
> 
> 	/dts-v1/;
> 	/ {
> 		compatible = "ti,omap[0-9]+-timer";

What about DT nodes that don't have a compatible value? We certainly
have some of those already like /memory and /chosen. We should be able
to validate their schema too. This probably doesn't invalidate being
able to look things up by compatible value though; it just means we need
some additional mechanisms too.

>  * Define constraints on properties
> 
> To define constraints on a property one has to create a node in a schema
> which has as name the name of the property that one want to validate.
> 
> To specify constraints on the property "ti,hwmods" of OMAP Timers one
> can write this schema:
> 
> 	/dts-v1/;
> 	/ {
> 		compatible = "ti,omap[0-9]+-timer";
> 		ti,hwmods {
> 			...
> 		};

compatible and ti,hwmods are both properties in the DT file. However, in
the schema above, one appears as a property, and one as a node. I don't
like that inconsistency. It'd be better if compatible was a node too.

> If one want to use a regular as property name one can write this schema:
> 
> 	/dts-v1/;
> 	/ {
> 		compatible = "abc";
> 		def {
> 			name = "def[0-9]";

Isn't it valid to have a property named "name" within the node itself?
How do you differentiate between specifying the node name and the name
property?

What if the node name needs more validation than just a regex. For
example, suppose we want to validate the
unit-name-must-match-reg-address rule. We need to write some complex
expression using data extracted from reg to calculate the unit address.
Equally, the node name perhaps has to exist in some global list of
acceptable node names. It would be extremely tricky if not impossible to
do that with a regex.

> 			...
> 		};
> 	};
> 
> Above one can see that the "name" property override the node name.

Override implies that dtc would change the node name during compilation.
I think s/override/validate/ or s/override/overrides the validation
rules for/?

>  * Require the presence of a property inside a node or inside one of its
> parents
...
> /dts-v1/;
> / {
>     compatible = "ti,twl[0-9]+-rtc";
>     interrupt-controller {
>         is-required;
>         can-be-inherited;

interrupt-controller isn't a good example here, since it isn't a
property that would typically be inherited. Why not use interrupt-parent
instead?

> One can check if 'node' has the following subnode 'subnode1', 'subnode2',
> and 'abc' with the schema below:
> 
> /dts-v1/;
> / {
>     compatible = "comp";
>     children = "abc", "subnode[0-9]";
> };

How is the schema for each sub-node specified?

What if some nodes are optional and some required? The conditions where
a sub-node is required might be complex, and I think we'd always want to
be able to represent them in whatever schema language we chose.

The most obvious way would be to make each sub-node's schema appear as a
sub-node within the main node's schema, but then how do you tell if a
schema node describes a property or a node?

Note that the following DT file is currently accepted by dtc even if it
may not be the best choice of property and node names:

==========
/dts-v1/;

/ {
	foo = <1>;
	foo {};
};
==========

>  * Constraints on array size
> 
> One can specify the following constraints on array size:
>  - length: specify the exact length that an array must have.
>  - min-length: specify the minimum number of elements an array must have.
>  - max-length: specify the maximum number of elements an array must have.

This seems rather inflexible; it'll cover a lot of the simple cases, but
hit a wall pretty soon. For example, how would it validate a property
that is supposed to include 3 GPIO specifiers, where the GPIO specifiers
are going to have DT-specific lengths, since the length of each
specifier is defined by the node that the phandles reference?


Overall, I believe perhaps the single most important aspect of any DT
schema is schema inheritance or instancing, and this proposal doesn't
appear to address that issue at all.

Inheritance of schemas:

For example, any node that is addressed must contain a reg property. The
constraints on that property are identical in all bindings; it must
consist of #address-cells + #size-cells integer values (cells). We don't
want to have to cut/paste that rule into every single binding
definition. Rather, we should simply say something like "this binding
uses the reg property", and the schema validation tool will look up the
definition of "reg property", and hence know how to validate it.

Similarly, any binding that describes a GPIO controller will have some
similar requirements; the gpio-controller and #gpio-cells properties
must be present. The schema should simply say "I'm a GPIO controller",
and the schema tool should add some extra requirements to nodes of that
type.

Instancing of schemas:

Any binding that uses GPIOs should be able to say that a particular
property (e.g. "enable-gpios") is-a GPIO-specifier (with parameters
"enable" for the property name, min/max/expression length, etc.), and
then the schema validation tool would know to apply rules for a
specifier list to that property (and be able to check the property name).
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
