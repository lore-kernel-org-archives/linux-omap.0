From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH] I2C: OMAP: Include OMAP_I2C_SYSC_REG in save and restore
Date: Mon, 02 Feb 2009 15:08:07 +0200
Message-ID: <4986F037.3090604@nokia.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF069@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF0A6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31055 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbZBBNIf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 08:08:35 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF0A6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, ben-linux@fluff.org

Hello,

ext Pakaravoor, Jagadeesh wrote:
> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> 
> Save and restore should include OMAP_I2C_SYSC_REG.
> 
> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> CC: Jouni Hogander <jouni.hogander@nokia.com>
> ---
> Index: linux-omap-2.6/drivers/i2c/busses/i2c-omap.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/i2c/busses/i2c-omap.c   2009-01-22 12:11:12.000000000 +0530
> +++ linux-omap-2.6/drivers/i2c/busses/i2c-omap.c        2009-01-22 12:44:12.202367296 +0530
> @@ -182,6 +182,7 @@ struct omap_i2c_dev {
>         u16                     scllstate;
>         u16                     sclhstate;
>         u16                     bufstate;
> +       u16                     syscstate;
>  };
> 
>  static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
> @@ -240,6 +241,7 @@ static void omap_i2c_unidle(struct omap_
>                 omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
>                 omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
>                 omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
> +               omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
>         }
>         dev->idle = 0;
>         omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
> @@ -300,14 +302,15 @@ static int omap_i2c_init(struct omap_i2c
>                 } else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
>                         u32 v;

This local variable is left unused, so you will get a compiler warning.

> -                       v = SYSC_AUTOIDLE_MASK;
> -                       v |= SYSC_ENAWAKEUP_MASK;
> -                       v |= (SYSC_IDLEMODE_SMART <<
> +                       dev->syscstate = SYSC_AUTOIDLE_MASK;
> +                       dev->syscstate |= SYSC_ENAWAKEUP_MASK;
> +                       dev->syscstate |= (SYSC_IDLEMODE_SMART <<
>                               __ffs(SYSC_SIDLEMODE_MASK));
> -                       v |= (SYSC_CLOCKACTIVITY_FCLK <<
> +                       dev->syscstate |= (SYSC_CLOCKACTIVITY_FCLK <<
>                               __ffs(SYSC_CLOCKACTIVITY_MASK));
> 
> -                       omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, v);
> +                       omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
> +                                                       dev->syscstate);
>                         /*
>                          * Enabling all wakup sources to stop I2C freezing on
>                          * WFI instruction.
> 
> --
> With Regards,
> Jagadeesh Bhaskar P

A.
