From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 6/7] OMAP4: DSS: Adding a picodlp in OMAP4430 SDP board
 file
Date: Tue, 19 Apr 2011 14:54:25 +0300
Message-ID: <1303214065.32281.47.camel@deskari>
References: <1303107350-22747-1-git-send-email-mayur@ti.com>
	 <1303107350-22747-7-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:41745 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751407Ab1DSLya (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 07:54:30 -0400
Received: by mail-ww0-f42.google.com with SMTP id 4so3184489wwk.3
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 04:54:29 -0700 (PDT)
In-Reply-To: <1303107350-22747-7-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mayuresh Janorkar <mayur@ti.com>
Cc: linux-omap@vger.kernel.org, Mythri P K <mythripk@ti.com>

On Mon, 2011-04-18 at 11:45 +0530, Mayuresh Janorkar wrote:
> An on-board panel named picodlp projector is available for OMAP4430 SDP.
> 
> Entry for this panel is being added in dss_devices in the board file.
> It also needs 4 GPIO pins and are defined and used in board file.
> picodlp also needs an i2c client over i2c controller-2 at address 0x1b.
> 
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |   40 +++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 1503f0b..6827612
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -38,6 +38,7 @@
>  #include <plat/omap4-keypad.h>
>  #include <plat/display.h>
>  #include <plat/nokia-dsi-panel.h>
> +#include <plat/panel-picodlp.h>
>  
>  #include "mux.h"
>  #include "hsmmc.h"
> @@ -585,6 +586,7 @@ static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
>  		.platform_data = &sdp4430_twldata,
>  	},
>  };
> +

Unneeded change.

>  static struct i2c_board_info __initdata sdp4430_i2c_3_boardinfo[] = {
>  	{
>  		I2C_BOARD_INFO("tmp105", 0x48),
> @@ -598,6 +600,7 @@ static struct i2c_board_info __initdata sdp4430_i2c_4_boardinfo[] = {
>  		I2C_BOARD_INFO("hmc5843", 0x1e),
>  	},
>  };
> +

Unneeded change.

 Tomi


