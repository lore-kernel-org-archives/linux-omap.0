From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [RFC 00/15] Device Tree schemas and validation
Date: Thu, 03 Oct 2013 15:17:57 +0200
Message-ID: <524D6E85.4000002@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com> <524B4B20.4020002@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:64449 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab3JCNSB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Oct 2013 09:18:01 -0400
Received: by mail-wi0-f177.google.com with SMTP id cb5so2563354wib.16
        for <linux-omap@vger.kernel.org>; Thu, 03 Oct 2013 06:17:59 -0700 (PDT)
In-Reply-To: <524B4B20.4020002@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: olof@lixom.net, devicetree@vger.kernel.org, tomasz.figa@gmail.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fparent@baylibre.com

Hi Stephen,

On 02/10/2013 00:22, Stephen Warren wrote:
> On 09/24/2013 10:52 AM, Benoit Cousson wrote:
>> Hi All,
>>
>> Following the discussion that happened during LCE-2013 and the email
>> thread started by Tomasz few months ago [1], here is a first attempt
>> to introduce:
>> - a schema language to define the bindings accurately
>> - DTS validation during device tree compilation in DTC itself
>
> Sorry, this is probably going to sound a bit negative. Hopefully you
> find it constructive though.

Well, I hope so too, let's see at the end of the email :-)

>> The syntax for a schema is the same as the one for dts. This choice has
>> been made to simplify its development, to maximize the code reuse and
>> finally because the format is human-readable.
>
> I'm not convinced that's a good decision.

Me neither :-), but I gave the current rational...

> DT is a language for representing data.
>
> The validation checks described by schemas are rules, or code, and not
> static data.

I will not be that strict with what DTS is supposed to do. In that 
aspect DTS is just a way to represent information in a structured 
hierarchical way.
It is for my point of view no different than XML. I know that everybody 
hate XML, including me, but that shows at least what is doable with such 
language. The fact that we like it or not is a different topic.

> So, while I'm sure it's possible to shoe-horn at least some reasonable
> subset of DT validation into DT syntax itself, I feel it's unlikely to
> yield something that's scalable enough.

I don't think we have any limit with such representation. My concern 
will be more the readability.
To be honest, a language choice is by nature completely subjective, and 
nobody will have the same taste. So we can spend weeks arguing about 
that :-)

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

Sure, but how many complex cases like that do we have? I guess, we can 
handle all the use-cases required by Rob with the current syntax.
Let's assume we cover 99% of the use-cases with such language, do we 
really want to have a super complex language just for the corner cases?

Potentially, writing a C extension to DTC is still possible for that 
specific case.

Not ideal, I do agree, but we have to be pragmatic as well.

We really need to understand how scalable we have to be before deciding 
that the current representation is not good enough.

>> How to:
>>   * Associate a schema to one or several nodes
>>
>> As said earlier a schema can be used to validate one or several nodes
>> from a dts. To do this the "compatible" properties from the nodes which
>> should be validated must be present in the schema.
>>
>> 	timer1: timer@4a318000 {
>> 		compatible = "ti,omap3430-timer";
> ...
>> To write a schema which will validate OMAP Timers like the one above,
>> one may write the following schema:
>>
>> 	/dts-v1/;
>> 	/ {
>> 		compatible = "ti,omap[0-9]+-timer";
>
> What about DT nodes that don't have a compatible value? We certainly
> have some of those already like /memory and /chosen. We should be able
> to validate their schema too. This probably doesn't invalidate being
> able to look things up by compatible value though; it just means we need
> some additional mechanisms too.

Yes, that's a good point and easy to add as well.

>>   * Define constraints on properties
>>
>> To define constraints on a property one has to create a node in a schema
>> which has as name the name of the property that one want to validate.
>>
>> To specify constraints on the property "ti,hwmods" of OMAP Timers one
>> can write this schema:
>>
>> 	/dts-v1/;
>> 	/ {
>> 		compatible = "ti,omap[0-9]+-timer";
>> 		ti,hwmods {
>> 			...
>> 		};
>
> compatible and ti,hwmods are both properties in the DT file. However, in
> the schema above, one appears as a property, and one as a node. I don't
> like that inconsistency. It'd be better if compatible was a node too.

That's already possible, you can check the timer.schema. The point is to 
simplify the representation for simple case and use a attribute instead 
of a node. But that will make 2 different representation for the same 
case, which might not be that good.

>> If one want to use a regular as property name one can write this schema:
>>
>> 	/dts-v1/;
>> 	/ {
>> 		compatible = "abc";
>> 		def {
>> 			name = "def[0-9]";
>
> Isn't it valid to have a property named "name" within the node itself?
> How do you differentiate between specifying the node name and the name
> property?

You don't have to. In this case the attributes inside the node are 
strictly the schema language keywords.
That being said, it might happen for some other casea, so maybe a prefix 
like "schema,XXX" should be use to create a proper namespace.

> What if the node name needs more validation than just a regex. For
> example, suppose we want to validate the
> unit-name-must-match-reg-address rule. We need to write some complex
> expression using data extracted from reg to calculate the unit address.
> Equally, the node name perhaps has to exist in some global list of
> acceptable node names. It would be extremely tricky if not impossible to
> do that with a regex.

Sure, but again, do we have such cases already? How far do we want to go 
in term of complexity for corner cases.

>> 			...
>> 		};
>> 	};
>>
>> Above one can see that the "name" property override the node name.
>
> Override implies that dtc would change the node name during compilation.
> I think s/override/validate/ or s/override/overrides the validation
> rules for/?

OK

>>   * Require the presence of a property inside a node or inside one of its
>> parents
> ...
>> /dts-v1/;
>> / {
>>      compatible = "ti,twl[0-9]+-rtc";
>>      interrupt-controller {
>>          is-required;
>>          can-be-inherited;
>
> interrupt-controller isn't a good example here, since it isn't a
> property that would typically be inherited. Why not use interrupt-parent
> instead?

Yeah, that's a mistake, it should have been interrupt-parent. It was 
done for that attribute mainly.

>> One can check if 'node' has the following subnode 'subnode1', 'subnode2',
>> and 'abc' with the schema below:
>>
>> /dts-v1/;
>> / {
>>      compatible = "comp";
>>      children = "abc", "subnode[0-9]";
>> };
>
> How is the schema for each sub-node specified?

sub-node are handled like any other regular node. If needed you can set 
constraints on parent node using the parents keyword.

> What if some nodes are optional and some required? The conditions where
> a sub-node is required might be complex, and I think we'd always want to
> be able to represent them in whatever schema language we chose.
>
> The most obvious way would be to make each sub-node's schema appear as a
> sub-node within the main node's schema, but then how do you tell if a
> schema node describes a property or a node?

I'm not sure about that. That was my first impression as well when we 
started, but in fact I don't think this is really needed.

By doing that, you end up creating a schema that looks like your final 
dts. So this become some kind of template more than a schema.

> Note that the following DT file is currently accepted by dtc even if it
> may not be the best choice of property and node names:
>
> ==========
> /dts-v1/;
>
> / {
> 	foo = <1>;
> 	foo {};
> };
> ==========
>
>>   * Constraints on array size
>>
>> One can specify the following constraints on array size:
>>   - length: specify the exact length that an array must have.
>>   - min-length: specify the minimum number of elements an array must have.
>>   - max-length: specify the maximum number of elements an array must have.
>
> This seems rather inflexible; it'll cover a lot of the simple cases, but
> hit a wall pretty soon. For example, how would it validate a property
> that is supposed to include 3 GPIO specifiers, where the GPIO specifiers
> are going to have DT-specific lengths, since the length of each
> specifier is defined by the node that the phandles reference?

sure, but that kind of check can be added.

> Overall, I believe perhaps the single most important aspect of any DT
> schema is schema inheritance or instancing, and this proposal doesn't
> appear to address that issue at all.

It does not handle inheritance completely, but that's not necessarily 
needed for the cases you describe below.

> Inheritance of schemas:
>
> For example, any node that is addressed must contain a reg property. The
> constraints on that property are identical in all bindings; it must
> consist of #address-cells + #size-cells integer values (cells). We don't
> want to have to cut/paste that rule into every single binding
> definition. Rather, we should simply say something like "this binding
> uses the reg property", and the schema validation tool will look up the
> definition of "reg property", and hence know how to validate it.

That's almost doable with the current mechanism and part of the plan. 
You can already add a generic rule that will apply to every nodes thanks 
to a wildcard RE. Then later you can add a more specific rule that will 
apply to few nodes only.
But I realized, we did not even used that in the example we did :-(

> Similarly, any binding that describes a GPIO controller will have some
> similar requirements; the gpio-controller and #gpio-cells properties
> must be present. The schema should simply say "I'm a GPIO controller",
> and the schema tool should add some extra requirements to nodes of that
> type.

Yes, agreed. Should be doable using previous mechanism. But will need 
some improvement.

> Instancing of schemas:
>
> Any binding that uses GPIOs should be able to say that a particular
> property (e.g. "enable-gpios") is-a GPIO-specifier (with parameters
> "enable" for the property name, min/max/expression length, etc.), and
> then the schema validation tool would know to apply rules for a
> specifier list to that property (and be able to check the property name).
>

Thanks for your comments, that are indeed really good and constructive.

Benoit

