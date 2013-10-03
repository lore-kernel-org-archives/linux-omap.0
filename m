From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [RFC 00/15] Device Tree schemas and validation
Date: Thu, 03 Oct 2013 08:52:13 +0200
Message-ID: <524D141D.3020807@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com> <524A8289.3050107@baylibre.com> <524ACB76.1010001@gmail.com> <524AE4FB.4080906@baylibre.com> <CAL_JsqJ31TGFJCSeSOqgee=OLVfSUTAYdF4nSn7X2DiCequVAw@mail.gmail.com> <20131002135450.GH6506@voom.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36091 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab3JCGwS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Oct 2013 02:52:18 -0400
Received: by mail-wg0-f44.google.com with SMTP id b13so1929172wgh.11
        for <linux-omap@vger.kernel.org>; Wed, 02 Oct 2013 23:52:17 -0700 (PDT)
In-Reply-To: <20131002135450.GH6506@voom.fritz.box>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Rob Herring <robherring2@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Olof Johansson <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, fparent@baylibre.com

On 02/10/2013 15:54, David Gibson wrote:
> On Tue, Oct 01, 2013 at 03:54:20PM -0500, Rob Herring wrote:
>> On Tue, Oct 1, 2013 at 10:06 AM, Benoit Cousson <bcousson@baylibre.com> wrote:
>>> Hi Rob,
>>>
>>>
>>> On 01/10/2013 15:17, Rob Herring wrote:
>>>>
>>>> On 10/01/2013 03:06 AM, Benoit Cousson wrote:
>>>>>
>>>>> + more DT maintainers folks
>>>>>
>>>>> Hi all,
>>>>>
>>>>> I know this is mostly boring user space code, but I was expecting a
>>>>> little bit of comments about at least the bindings syntax:-(
>>>>>
>>>>> I'd like to know if this is the right direction and if it worth pursuing
>>>>> in that direction.
>>>>>
>>>>> The idea was to have at least some base for further discussion during
>>>>> ARM KS 2013.
>>>>>
>>>>> I feel alone :-(
>>>>>
>>>>> If you have any comment, go ahead!
>>>>
>>>>
>>>> Thanks for taking this on!
>>>>
>>>> This is interesting approach using the dts syntax,
>>>
>>>
>>> Well, this was discussed a little bit on the list, and it has the big
>>> advantage of re-using the parser already included in DTC for free.
>>> In term or readability, it avoids to re-defining a brand new syntax for
>>> people who are already familiar with the DTS one.
>>>
>>>
>>>> but I worry that the
>>>> validation will only be as good as the schema written and the review of
>>>> the schema.
>>>
>>>
>>> Well, sure, but unfortunately, that will always be the case :-(
>>> The bindings definition being quite open, there is no easy way to ensure
>>> proper schema / bindings without careful review of the schema. There is no
>>> such thing as a free beer... Unfortunately :-)
>>>
>>>
>>>> I think the schema needs to define the binding rather than
>>>> define the checks. Then the schema can feed the validation checks.
>>>
>>>
>>>> This format does not seem to me as easily being able to generate
>>>> documentation from the schema which I believe is one of the goals.
>>>
>>>
>>> Indeed, but I think is it easy to generate any kind of readable format for
>>> the documentation purpose if needed from the actual format.
>>> Otherwise, we should consider a schema format based on kerneldoc type of
>>> syntax to improve readability. I'm just afraid it will become harder then to
>>> define complex schema.
>>>
>>> BTW, what kind of documentation are you expecting here? Is is a text that
>>> can be added on top of each schema?
>>
>> I would expect the schema to replace
>> Documentation/devicetree/bindings/* over time. I think the thing that
>> needs to be worked out here is how to add free form multi-line text.
>
> I'm not convinced that's a realistic goal.  As I see it, the
> fundamental difference between a binding document and a formal schema
> is that a binding defines both the syntax required of a node, and its
> semantics, whereas a schema defines only syntax - the semantics still
> need to be defined somewhere.
>

Mmm, I do not really understand what is missing in the following schema 
in term of semantic compared to the original interrupt-controller bindings?

     interrupt-controller {
         description = "Identifies the node as an interrupt controller";
         is-required;
         type = "bool";
     };

     #interrupt-cells {
         description = "Specifies the number of cells needed to encode an
                        interrupt source. The type shall be a <u32>
                        and the value shall be 1.
                        The cell contains the interrupt number
                        in the range [0-128].";
         is-required;
         type = "integer";
         value = <1>;
     };

As soon as you have a description you can keep the content of the 
original binding. But on top of that, you do have the schema validation 
information.

I'm not sure to understand your point. Could you elaborate?

Regards,
Benoit
