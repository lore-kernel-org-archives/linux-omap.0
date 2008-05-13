From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/3] N810: Don't export camera orientation
Date: Tue, 13 May 2008 15:01:05 -0500
Message-ID: <20147cff763adbdb887ad31373040efc@felipebalbi.com>
References: <12106946631016-git-send-email-sakari.ailus@nokia.com> <1210694663310-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:45084 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757966AbYEMUBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 16:01:08 -0400
In-Reply-To: <1210694663310-git-send-email-sakari.ailus@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: linux-omap@vger.kernel.org



On Tue, 13 May 2008 19:04:22 +0300, Sakari Ailus <sakari.ailus@nokia.com>
wrote:
> On Nokia N810 the camera module is mounted upside down. This affects
> the mirroring controls. This patch inverts the controls for N810.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  arch/arm/mach-omap2/board-n800-camera.c |   65
> +++++++++++++++++++++++++++---
>  1 files changed, 58 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800-camera.c
> b/arch/arm/mach-omap2/board-n800-camera.c
> index 19be30d..9c2bead 100644
> --- a/arch/arm/mach-omap2/board-n800-camera.c
> +++ b/arch/arm/mach-omap2/board-n800-camera.c
> @@ -28,6 +28,8 @@
> 
>  #include <media/v4l2-int-device.h>
> 
> +#include <asm/mach-types.h>
> +
>  #include <asm/arch/menelaus.h>
>  #include <asm/arch/gpio.h>
>  #include <asm/arch/board.h>
> @@ -71,7 +73,8 @@ static int frames_after_reset;
>  static int saturated_count;
>  #endif
> 
> -const static struct tcm825x_reg tcm825x_default_regs_[] = {
> +#ifdef CONFIG_MACH_NOKIA_N800
> +const static struct tcm825x_reg tcm825x_regs_n800[] = {
>  	/* initial settings for 2.5 V */
>  	{0x00, 0x03}, {0x03, 0x29}, {0xaa, 0x2a}, {0xc0, 0x2b},
>  	{0x10, 0x2c}, {0x4c, 0x2d}, {0x9c, 0x3f},
> @@ -103,6 +106,42 @@ const static struct tcm825x_reg
> tcm825x_default_regs_[] = {
>  	{0x08, 0x5c}, {0x08, 0x5d}, {0x08, 0x5e}, {0x08, 0x5f},
>  	{TCM825X_VAL_TERM, TCM825X_REG_TERM}
>  };
> +#endif
> +
> +#ifdef CONFIG_MACH_NOKIA_N810
> +const static struct tcm825x_reg tcm825x_regs_n810[] = {
> +	/* initial settings for 2.5 V */
> +	{0x00, 0x03}, {0x03, 0x29}, {0xaa, 0x2a}, {0xc0, 0x2b},
> +	{0x10, 0x2c}, {0x4c, 0x2d}, {0x9c, 0x3f},
> +
> +	/* main settings */
> +	{0x00, 0x00}, {0x30, 0x01}, {0x0e, 0x02}, /* initial */
> +	{0xcf, 0x04}, {0x02, 0x05}, {0x0d, 0x06}, {0xc0, 0x07},
> +	{0x38, 0x08}, {0x50, 0x09}, {0x80, 0x0a}, {0x40, 0x0b},
> +	{0x40, 0x0c}, {0x00, 0x0d}, {0x04, 0x0e}, {0x04, 0x0f},
> +	{0x22, 0x10}, {0x96, 0x11}, {0xf0, 0x12}, {0x08, 0x13},
> +	{0x08, 0x14}, {0x30, 0x15}, {0x30, 0x16}, {0x01, 0x17},
> +	{0x40, 0x18}, {0x87, 0x19}, {0x2b, 0x1a}, {0x84, 0x1b},
> +	{0x52, 0x1c}, {0x44, 0x1d}, {0x68, 0x1e}, {0x00, 0x1f},
> +	{0x00, 0x20}, {0x01, 0x21}, {0x27, 0x22}, {0x40, 0x23},
> +	{0x27, 0x24}, {0x5f, 0x25}, {0x00, 0x26}, {0x16, 0x27},
> +	{0x23, 0x28}, /* initial */ /* initial */ /* initial */
> +	/* initial */ /* initial */ {0x00, 0x2e}, {0x00, 0x2f},
> +	{0x00, 0x30}, {0x00, 0x31}, {0x00, 0x32}, {0x00, 0x33},
> +	{0x00, 0x34}, {0x00, 0x35}, {0x00, 0x36}, {0x00, 0x37},
> +	{0x00, 0x38}, {0x8c, 0x39}, {0xc8, 0x3A}, {0x80, 0x3b},
> +	{0x00, 0x3c}, {0x17, 0x3d}, {0x85, 0x3e}, /* initial */
> +	{0xa0, 0x40}, {0x00, 0x41}, {0x00, 0x42}, {0x00, 0x43},
> +	{0x08, 0x44}, {0x12, 0x45}, {0x00, 0x46}, {0x20, 0x47},
> +	{0x30, 0x48}, {0x18, 0x49}, {0x20, 0x4a}, {0x4d, 0x4b},
> +	{0x0c, 0x4c}, {0xe0, 0x4d}, {0x20, 0x4e}, {0x89, 0x4f},
> +	{0x21, 0x50}, {0x80, 0x51}, {0x02, 0x52}, {0x00, 0x53},
> +	{0x30, 0x54}, {0x90, 0x55}, {0x40, 0x56}, {0x06, 0x57},
> +	{0x0f, 0x58}, {0x23, 0x59}, {0x08, 0x5A}, {0x04, 0x5b},
> +	{0x08, 0x5c}, {0x08, 0x5d}, {0x08, 0x5e}, {0x08, 0x5f},
> +	{TCM825X_VAL_TERM, TCM825X_REG_TERM}
> +};
> +#endif
> 
>  static int tcm825x_is_okay(void)
>  {
> @@ -182,7 +221,10 @@ static int tcm825x_power_set(int power)
> 
>  static const struct tcm825x_reg *tcm825x_default_regs(void)
>  {
> -	return tcm825x_default_regs_;
> +	if (machine_is_nokia_n810())
> +		return tcm825x_regs_n810;
> +
> +	return tcm825x_regs_n800;
>  }
> 
>  #ifdef OMAP24XX_CAMERA_JAM_HACK
> @@ -298,12 +340,21 @@ static int tcm825x_ifparm(struct v4l2_ifparm *p)
>  	return 0;
>  }
> 
> +static int tcm825x_is_upside_down(void)
> +{
> +	if (machine_is_nokia_n810())
> +		return 1;
> +
> +	return 0;
> +}
> +
>  const struct tcm825x_platform_data n800_tcm825x_platform_data = {
> -	.is_okay      = tcm825x_is_okay,
> -	.power_set    = tcm825x_power_set,
> -	.default_regs = tcm825x_default_regs,
> -	.needs_reset  = tcm825x_needs_reset,
> -	.ifparm	      = tcm825x_ifparm,
> +	.is_okay	= tcm825x_is_okay,
> +	.power_set	= tcm825x_power_set,
> +	.default_regs	= tcm825x_default_regs,
> +	.needs_reset	= tcm825x_needs_reset,
> +	.ifparm		= tcm825x_ifparm,
> +	.is_upside_down	= tcm825x_is_upside_down,

ok, now i got your point but this could be:
.is_upside_down = machine_is_nokia_n810() ? 1 : 0,

>  };
> 
>  void __init n800_cam_init(void)
> --
> 1.5.0.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

