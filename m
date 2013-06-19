From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/4] ARM: dts: OMAP3: Updates for Overo
Date: Wed, 19 Jun 2013 04:34:32 -0500
Message-ID: <51C17B28.6060802@ti.com>
References: <1370962189-9689-1-git-send-email-florian.vaussard@epfl.ch> <51C179DC.9040605@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55698 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933993Ab3FSJfg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jun 2013 05:35:36 -0400
In-Reply-To: <51C179DC.9040605@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 06/19/2013 04:29 AM, Florian Vaussard wrote:
> Hello Benoit,
>
> Any comments on this series?

That series looks good to me. I've just applied it.

Thanks,
Benoit

>
> Regards,
> Florian
>
> On 06/11/2013 04:49 PM, Florian Vaussard wrote:
>> Hello,
>>
>> This series performs several updates to omap3-overo and omap3-tobi.
>> Patch 1 is necessary to patch 2 for the IRQ constant. The SMSC911X is
>> largely taken from omap3-igep.
>>
>> Regards,
>>
>> Florian
>>
>> Florian Vaussard (4):
>>    ARM: dts: OMAP3: Include IRQ header
>>    ARM: dts: omap3-tobi: Add SMSC911X node
>>    ARM: dts: omap3-tobi: Correct polarity for GPIO LED
>>    ARM: dts: omap3-overo: Add default trigger for TWL4030 LED
>>
>>   arch/arm/boot/dts/omap3-overo.dtsi |    1 +
>>   arch/arm/boot/dts/omap3-tobi.dts   |   50
>> +++++++++++++++++++++++++++++++++++-
>>   arch/arm/boot/dts/omap3.dtsi       |    1 +
>>   3 files changed, 51 insertions(+), 1 deletions(-)
>>

