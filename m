From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 00/11]: add remaining support for IGEP boards
Date: Sat, 16 Nov 2013 15:41:09 +0100
Message-ID: <52878405.6000109@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk> <20131116141622.GE10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60435 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab3KPOmH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 09:42:07 -0500
In-Reply-To: <20131116141622.GE10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 11/16/2013 03:16 PM, Tony Lindgren wrote:
> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131116 05:25]:
>> In order to make mach-omap2 Device Tree only the board file for
>> IGEP boards was removed even when support for wifi and display
>> was still not supported by its DTS.
>> 
>> This patch-set adds support for these remaining peripherals and
>> also adds support for USB, HDMI and user LED for the am33xx SoC
>> based IGEP Aquila board.
>> 
>> The patch-set is composed of the following patches:
>> 
>> Enric Balletbo i Serra (7):
>>       ARM: dts: omap3-igep: Fix bus-width for mmc1.
>>       ARM: dts: omap3-igep: Add support for LBEE1USJYC WiFi connected to SDIO.
>>       ARM: dts: omap3-igep: Update to use the TI AM/DM37x processor.
>>       ARM: dts: AM33XX BASE0033: add pinmux and hdmi node to enable display
>>       ARM: dts: AM33XX BASE0033: add pinmux and user led support.
>>       ARM: dts: AM33XX BASE0033: add 32KBit EEPROM support.
>>       ARM: dts: AM33XX IGEP0033: add USB support.
>> 
>> Javier Martinez Canillas (4):
>>       ARM: dts: omap3-igep0020: Add pinmux setup for i2c devices
>>       ARM: dts: omap3-igep0020: Add pinmuxing for DVI output
>>       ARM: OMAP: dss-common: change IGEP's DVI DDC i2c bus
>>       OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is not found
>> 
>> Tony,
>> 
>> Most of these patches are just DTS changes so they have to be picked
>> by Benoit although there are patches that should go to different trees.
>> 
>> [PATCH 10/11] ARM: OMAP: dss-common: change IGEP's DVI DDC i2c bus
>> 
>> have to go through your tree and
> 
> OK
>  
>> [PATCH 11/11] OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is not found
>> 
>> should be picked by Tomi Valkeinen.
> 
> That may not be needed as it can be set in the .dts file, I'll comment
> on that patch.
>  

A similar hack is made for OMAP4 on dsi_regulator_init() to use the twl6030
VCXIO regulator if vdds_dsi is not found so I thought it makes sense to do
something similar for DPI and OMAP3.

But if you prefer I can add a regulator-name = "vdds_dsi" property to vpll2 like
you did for omap3-ldp.dts

>> Since we have removed the board file for IGEP boards I think these
>> can be considered as regression fixes for 3.13 although I don't mind
>> if you prefer to wait for 3.14.
> 
> Yes I agree, let's try to fix these issues during the -rc cycle
> so the earlier functionality is maintained.
> 
> Regards,
> 
> Tony
> 

Great, so you can drop [PATCH 11/11] and I'll send a follow up patch doing the
required regulator change in omap3-igep0020.dts.

Thanks a lot and best regards,
Javier
