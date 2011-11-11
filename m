From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 3/4] dts/omap3: split omap3.dtsi
Date: Fri, 11 Nov 2011 09:32:53 +0200
Message-ID: <4EBCCFA5.9010107@compulab.co.il>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-4-git-send-email-yanok@emcraft.com> <4EBBC10B.6070206@compulab.co.il> <4EBC0534.4020306@ti.com> <4EBC094C.8060504@compulab.co.il> <4EBC12DB.2040307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:57032
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752616Ab1KKHdH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Nov 2011 02:33:07 -0500
In-Reply-To: <4EBC12DB.2040307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Ilya Yanok <yanok@emcraft.com>, linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On 11/10/11 20:07, Cousson, Benoit wrote:
> Hi Igor,
> 
> On 11/10/2011 6:26 PM, Igor Grinberg wrote:
>> On 11/10/11 19:09, Cousson, Benoit wrote:
>>> + devicetree ml
>>>
>>> On 11/10/2011 1:18 PM, Igor Grinberg wrote:
>>>> Hi Ilya,
>>>>
>>>> On 11/09/11 02:12, Ilya Yanok wrote:
>>>>> Split omap3.dtsi file into common part, OM3xxx specific part and
>>>>> AM35xx specific part. For now the only difference is missing IVA node on
>>>>> AM35xx.
>>>>>
>>>>> Signed-off-by: Ilya Yanok<yanok@emcraft.com>
>>>>> ---
>>>>>    arch/arm/boot/dts/am35xx.dtsi      |   15 +++++++++++++++
>>>>>    arch/arm/boot/dts/om3xxx.dtsi      |   28 ++++++++++++++++++++++++++++
>>>>>    arch/arm/boot/dts/omap3-beagle.dts |    2 +-
>>>>>    arch/arm/boot/dts/omap3.dtsi       |    9 ---------
>>>>>    4 files changed, 44 insertions(+), 10 deletions(-)
>>>>>    create mode 100644 arch/arm/boot/dts/am35xx.dtsi
>>>>>    create mode 100644 arch/arm/boot/dts/om3xxx.dtsi
>>>>
>>>> om3xxx name is confusing - I haven't seen this name
>>>> in any documentation/code before...
>>>> Am I missing something?
>>>>
>>>> What do you think of omap3-iva.dtsi or omap3-dsp.dtsi?
>>>
>>> Cannot we avoid at all hacking the original file and use instead the status = "disabled" field for any variant that will not have the functionality?
>>
>> This might be an option.
>>
>> What I thought of is splitting the original file into "atomic"
>> (none splittable) parts and each OMAP variant will include
>> the ones it has.
>> This way you have all the features available and can make any
>> mixture of them (which, probably will reflect the hardware best ;-))
> 
> Yeah, but it will be less readable for my point of view.

Agreed, it will be less readable, because it will be spread among several files.

> You will add another level of include hierarchy.

Why is adding another level of include hierarchy is a problem?

> The point is that each time some new variants will come with less and less feature,
> we will keep de-populating the original file.

Here you assume that it will be always *less* features and never *more*?
Also, that is the reason, why I think splitting it right now to smaller pieces
will do a good job for the future.

> 
> My other concern is that all these variants are handled by different people for different products.
> So by having dedicated file for each variant, each owner can handle its own stuff without messing up the original file.

I'm not saying that we should not have a dedicated file for each variant.
What I'm saying is that the dedicated file for each variant can include
the "pieces" the hardware has, instead of duplicating them or disabling
what it does not have.

> Considering that this omap3.dtsi file is under construction, we can expect a bunch a dirty merge conflicts if different people from different organization start adding / removing nodes at the same time.

IMO, that problem can also be avoided by splitting it to smaller pieces.
Don't you think so?

> 
> We already faced that kind of nightmare for our existing clock / hwmod static data files. So if we can avoid it with DT files, it will be cool.

I don't think it falls in the same problem category,
but may be I'm missing something...

> 
>>> It will be a nightmare for us to maintain a consistent OMAP3 file if every variants force us to change the original file.
>>
>> it will be a nightmare anyway ;-)
> 
> Indeed, the best is to avoid any variant :-)
> 
>> I don't really know what can make it a less scary nightmare.
> 
> For my point of view, since I will have to keep hacking on that omap3.dtsi, having some separate variant files that does not have to touch this file will be much better.

Or split it to pieces right now, so no one will have to hack on it...

> 
> If all these variants were already there and well defined, we might have then decided to re-organized that by starting from a common subset.

Yeah, it would be perfect, but it is never been this way and will never be...

> But since everything is moving at the same time and with an unknown target, we should minimize hacking any common file under construction.

I think the design of having a common file with data does not scale.

Again, having multiple files, each with data per subsystem or
per an ip block, does scale and IMO will do a better job,
now and in the future.
This will mean that common file will only do the includes to
assemble all the *right* data together.


-- 
Regards,
Igor.
