From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 3/4] dts/omap3: split omap3.dtsi
Date: Thu, 10 Nov 2011 19:26:36 +0200
Message-ID: <4EBC094C.8060504@compulab.co.il>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-4-git-send-email-yanok@emcraft.com> <4EBBC10B.6070206@compulab.co.il> <4EBC0534.4020306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:53317
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751437Ab1KJR0y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Nov 2011 12:26:54 -0500
In-Reply-To: <4EBC0534.4020306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Ilya Yanok <yanok@emcraft.com>, linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On 11/10/11 19:09, Cousson, Benoit wrote:
> + devicetree ml
> 
> On 11/10/2011 1:18 PM, Igor Grinberg wrote:
>> Hi Ilya,
>>
>> On 11/09/11 02:12, Ilya Yanok wrote:
>>> Split omap3.dtsi file into common part, OM3xxx specific part and
>>> AM35xx specific part. For now the only difference is missing IVA node on
>>> AM35xx.
>>>
>>> Signed-off-by: Ilya Yanok<yanok@emcraft.com>
>>> ---
>>>   arch/arm/boot/dts/am35xx.dtsi      |   15 +++++++++++++++
>>>   arch/arm/boot/dts/om3xxx.dtsi      |   28 ++++++++++++++++++++++++++++
>>>   arch/arm/boot/dts/omap3-beagle.dts |    2 +-
>>>   arch/arm/boot/dts/omap3.dtsi       |    9 ---------
>>>   4 files changed, 44 insertions(+), 10 deletions(-)
>>>   create mode 100644 arch/arm/boot/dts/am35xx.dtsi
>>>   create mode 100644 arch/arm/boot/dts/om3xxx.dtsi
>>
>> om3xxx name is confusing - I haven't seen this name
>> in any documentation/code before...
>> Am I missing something?
>>
>> What do you think of omap3-iva.dtsi or omap3-dsp.dtsi?
> 
> Cannot we avoid at all hacking the original file and use instead the status = "disabled" field for any variant that will not have the functionality?

This might be an option.

What I thought of is splitting the original file into "atomic"
(none splittable) parts and each OMAP variant will include
the ones it has.
This way you have all the features available and can make any
mixture of them (which, probably will reflect the hardware best ;-))

> 
> It will be a nightmare for us to maintain a consistent OMAP3 file if every variants force us to change the original file.

it will be a nightmare anyway ;-)
I don't really know what can make it a less scary nightmare.


-- 
Regards,
Igor.
