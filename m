From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4] OMAP2/3: hwmod: fix the i2c-reset timeout during
 bootup
Date: Mon, 30 May 2011 09:38:10 +0300
Message-ID: <1306737490.2117.24.camel@deskari>
References: <1305906384-22061-1-git-send-email-avinashhm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:36098 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490Ab1E3GiR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 02:38:17 -0400
Received: by mail-ey0-f182.google.com with SMTP id 7so1648347eyg.13
        for <linux-omap@vger.kernel.org>; Sun, 29 May 2011 23:38:14 -0700 (PDT)
In-Reply-To: <1305906384-22061-1-git-send-email-avinashhm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Avinash.H.M" <avinashhm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

On Fri, 2011-05-20 at 21:16 +0530, Avinash.H.M wrote:
> The sequence of _ocp_softreset doesn't work for i2c. The i2c module has a
> special sequence to reset the module. The sequence is
>  - Disable the I2C.
>  - Write to SOFTRESET bit.
>  - Enable the I2C.
>  - Poll on the RESETDONE bit.
> The sequence is implemented as a function and the i2c_class is updated with
> the correct 'reset' pointer.  omap_hwmod_softreset function is implemented
> which triggers the softreset by writing into sysconfig register. On following
> this sequence, i2c module resets properly and timeouts are not seen.
> 
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> ---

<snip>

> diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
> index 878d632..3ffb94e 100644
> --- a/arch/arm/plat-omap/include/plat/i2c.h
> +++ b/arch/arm/plat-omap/include/plat/i2c.h
> @@ -23,6 +23,8 @@
>  
>  #include <linux/i2c.h>
>  
> +#include <plat/omap_hwmod.h>
> +
>  #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
>  extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
>  				 struct i2c_board_info const *info,
> @@ -52,4 +54,6 @@ struct omap_i2c_dev_attr {
>  void __init omap1_i2c_mux_pins(int bus_id);
>  void __init omap2_i2c_mux_pins(int bus_id);
>  
> +int omap_i2c_reset(struct omap_hwmod *oh);
> +

It's not necessary to include omap_hwmod.h, just declare

struct omap_hwmod;

 Tomi


