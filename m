From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP: LCD LS037V7DW01: By default select backlight
 driver in Kconfig
Date: Fri, 16 Apr 2010 16:19:11 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E1371BA@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1271414188-20492-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45015 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331Ab0DPKtT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 06:49:19 -0400
In-Reply-To: <1271414188-20492-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Friday, April 16, 2010 4:06 PM
> To: tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org; Hiremath, Vaibhav
> Subject: [PATCH] OMAP: LCD LS037V7DW01: By default select backlight driver
> in Kconfig
> 
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  drivers/video/omap2/displays/Kconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/Kconfig
> b/drivers/video/omap2/displays/Kconfig
> index dfb57ee..44a6d63 100644
> --- a/drivers/video/omap2/displays/Kconfig
> +++ b/drivers/video/omap2/displays/Kconfig
> @@ -10,6 +10,8 @@ config PANEL_GENERIC
>  config PANEL_SHARP_LS037V7DW01
>          tristate "Sharp LS037V7DW01 LCD Panel"
>          depends on OMAP2_DSS
> +	select BACKLIGHT_LCD_SUPPORT
> +	select BACKLIGHT_CLASS_DEVICE
>          help
>            LCD Panel used in TI's SDP3430 and EVM boards
> 
[Hiremath, Vaibhav] Tomi,

Here is the patch which fixes the issue, I have tested it on OMAP3EVM.

Thanks,
Vaibhav

> --
> 1.6.2.4

