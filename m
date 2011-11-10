From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/4] dts/omap3: split omap3.dtsi
Date: Thu, 10 Nov 2011 18:09:08 +0100
Message-ID: <4EBC0534.4020306@ti.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-4-git-send-email-yanok@emcraft.com> <4EBBC10B.6070206@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36858 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806Ab1KJRJh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Nov 2011 12:09:37 -0500
In-Reply-To: <4EBBC10B.6070206@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Ilya Yanok <yanok@emcraft.com>, linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

+ devicetree ml

On 11/10/2011 1:18 PM, Igor Grinberg wrote:
> Hi Ilya,
>
> On 11/09/11 02:12, Ilya Yanok wrote:
>> Split omap3.dtsi file into common part, OM3xxx specific part and
>> AM35xx specific part. For now the only difference is missing IVA node on
>> AM35xx.
>>
>> Signed-off-by: Ilya Yanok<yanok@emcraft.com>
>> ---
>>   arch/arm/boot/dts/am35xx.dtsi      |   15 +++++++++++++++
>>   arch/arm/boot/dts/om3xxx.dtsi      |   28 ++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/omap3-beagle.dts |    2 +-
>>   arch/arm/boot/dts/omap3.dtsi       |    9 ---------
>>   4 files changed, 44 insertions(+), 10 deletions(-)
>>   create mode 100644 arch/arm/boot/dts/am35xx.dtsi
>>   create mode 100644 arch/arm/boot/dts/om3xxx.dtsi
>
> om3xxx name is confusing - I haven't seen this name
> in any documentation/code before...
> Am I missing something?
>
> What do you think of omap3-iva.dtsi or omap3-dsp.dtsi?

Cannot we avoid at all hacking the original file and use instead the 
status = "disabled" field for any variant that will not have the 
functionality?

It will be a nightmare for us to maintain a consistent OMAP3 file if 
every variants force us to change the original file.

Regards,
Benoit
