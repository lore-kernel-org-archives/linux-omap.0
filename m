From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: enable support for GPIO connected LEDs
Date: Mon, 26 Nov 2012 09:31:24 +0100
Message-ID: <50B328DC.9060002@collabora.co.uk>
References: <1353749642-30255-1-git-send-email-javier.martinez@collabora.co.uk> <331ABD5ECB02734CA317220B2BBEABC13EA7A476@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:44868 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab2KZIb1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 03:31:27 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA7A476@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 11/26/2012 06:45 AM, AnilKumar, Chimata wrote:
> On Sat, Nov 24, 2012 at 15:04:02, Javier Martinez Canillas wrote:
>> Many OMAP boards use GPIO LEDs to notify status to the user
>> on boot. So, it is good to have by default support for GPIO
>> connected LEDs as well as some commonly used triggers.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  arch/arm/configs/omap2plus_defconfig |    8 ++++++++
>>  1 files changed, 8 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
>> index 6333e96..7c6cbdf 100644
>> --- a/arch/arm/configs/omap2plus_defconfig
>> +++ b/arch/arm/configs/omap2plus_defconfig
>> @@ -193,6 +193,14 @@ CONFIG_MMC_UNSAFE_RESUME=y
>>  CONFIG_SDIO_UART=y
>>  CONFIG_MMC_OMAP=y
>>  CONFIG_MMC_OMAP_HS=y
>> +CONFIG_NEW_LEDS=y
>> +CONFIG_LEDS_CLASS=y
>> +CONFIG_LEDS_GPIO=y
>> +CONFIG_LEDS_TRIGGERS=y
>> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>> +CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>> +CONFIG_LEDS_TRIGGER_GPIO=y
>> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> 
> Hi Javier,
> 
> Similar patch sent few days back
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/133760.html
> 
> Let me know do you have any comments
> 
> Thanks
> AnilKumar
> 

Hi AnilKumar,

I haven't seen your patch before sorry.

I've answered on your original patch thread.

Thanks a lot and best regards,
Javier
