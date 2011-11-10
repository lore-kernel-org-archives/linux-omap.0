From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/4] dts/omap3: split omap3.dtsi
Date: Thu, 10 Nov 2011 19:07:23 +0100
Message-ID: <4EBC12DB.2040307@ti.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-4-git-send-email-yanok@emcraft.com> <4EBBC10B.6070206@compulab.co.il> <4EBC0534.4020306@ti.com> <4EBC094C.8060504@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60699 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101Ab1KJSHr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Nov 2011 13:07:47 -0500
In-Reply-To: <4EBC094C.8060504@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Ilya Yanok <yanok@emcraft.com>, linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

Hi Igor,

On 11/10/2011 6:26 PM, Igor Grinberg wrote:
> On 11/10/11 19:09, Cousson, Benoit wrote:
>> + devicetree ml
>>
>> On 11/10/2011 1:18 PM, Igor Grinberg wrote:
>>> Hi Ilya,
>>>
>>> On 11/09/11 02:12, Ilya Yanok wrote:
>>>> Split omap3.dtsi file into common part, OM3xxx specific part and
>>>> AM35xx specific part. For now the only difference is missing IVA node on
>>>> AM35xx.
>>>>
>>>> Signed-off-by: Ilya Yanok<yanok@emcraft.com>
>>>> ---
>>>>    arch/arm/boot/dts/am35xx.dtsi      |   15 +++++++++++++++
>>>>    arch/arm/boot/dts/om3xxx.dtsi      |   28 ++++++++++++++++++++++++++++
>>>>    arch/arm/boot/dts/omap3-beagle.dts |    2 +-
>>>>    arch/arm/boot/dts/omap3.dtsi       |    9 ---------
>>>>    4 files changed, 44 insertions(+), 10 deletions(-)
>>>>    create mode 100644 arch/arm/boot/dts/am35xx.dtsi
>>>>    create mode 100644 arch/arm/boot/dts/om3xxx.dtsi
>>>
>>> om3xxx name is confusing - I haven't seen this name
>>> in any documentation/code before...
>>> Am I missing something?
>>>
>>> What do you think of omap3-iva.dtsi or omap3-dsp.dtsi?
>>
>> Cannot we avoid at all hacking the original file and use instead the status = "disabled" field for any variant that will not have the functionality?
>
> This might be an option.
>
> What I thought of is splitting the original file into "atomic"
> (none splittable) parts and each OMAP variant will include
> the ones it has.
> This way you have all the features available and can make any
> mixture of them (which, probably will reflect the hardware best ;-))

Yeah, but it will be less readable for my point of view. You will add 
another level of include hierarchy. The point is that each time some new 
variants will come with less and less feature, we will keep 
de-populating the original file.

My other concern is that all these variants are handled by different 
people for different products. So by having dedicated file for each 
variant, each owner can handle its own stuff without messing up the 
original file.
Considering that this omap3.dtsi file is under construction, we can 
expect a bunch a dirty merge conflicts if different people from 
different organization start adding / removing nodes at the same time.

We already faced that kind of nightmare for our existing clock / hwmod 
static data files. So if we can avoid it with DT files, it will be cool.

>> It will be a nightmare for us to maintain a consistent OMAP3 file if every variants force us to change the original file.
>
> it will be a nightmare anyway ;-)

Indeed, the best is to avoid any variant :-)

> I don't really know what can make it a less scary nightmare.

For my point of view, since I will have to keep hacking on that 
omap3.dtsi, having some separate variant files that does not have to 
touch this file will be much better.

If all these variants were already there and well defined, we might have 
then decided to re-organized that by starting from a common subset.
But since everything is moving at the same time and with an unknown 
target, we should minimize hacking any common file under construction.

Regards,
Benoit





