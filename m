From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Add TWL4030 registers
Date: Fri, 27 Feb 2009 09:07:44 -0800
Message-ID: <20090227170743.GD11594@atomide.com>
References: <200902271555.00330.tuukka.o.toivonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56433 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbZB0RHs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 12:07:48 -0500
Content-Disposition: inline
In-Reply-To: <200902271555.00330.tuukka.o.toivonen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>
Cc: linux-omap@vger.kernel.org, sailus@maxwell.research.nokia.com

* Tuukka.O Toivonen <tuukka.o.toivonen@nokia.com> [090227 05:57]:
> Signed-off-by: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>
> ---
>  include/linux/i2c/twl4030.h |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
> index c89d33b..c4fe1b6 100644
> --- a/include/linux/i2c/twl4030.h
> +++ b/include/linux/i2c/twl4030.h
> @@ -379,11 +379,21 @@ int twl4030_sih_setup(int module);
>  #define TWL4030_VDAC_DEV_GRP		0x3B
>  #define TWL4030_VDAC_DEDICATED		0x3E
>  #define TWL4030_VAUX1_DEV_GRP		0x17
> +#define TWL4030_VAUX1_TYPE		0x18
> +#define TWL4030_VAUX1_REMAP		0x19
>  #define TWL4030_VAUX1_DEDICATED		0x1A
>  #define TWL4030_VAUX2_DEV_GRP		0x1B
> +#define TWL4030_VAUX2_TYPE		0x1C
> +#define TWL4030_VAUX2_REMAP		0x1D
>  #define TWL4030_VAUX2_DEDICATED		0x1E
>  #define TWL4030_VAUX3_DEV_GRP		0x1F
> +#define TWL4030_VAUX3_TYPE		0x20
> +#define TWL4030_VAUX3_REMAP		0x21
>  #define TWL4030_VAUX3_DEDICATED		0x22
> +#define TWL4030_VAUX4_DEV_GRP		0x23
> +#define TWL4030_VAUX4_TYPE		0x24
> +#define TWL4030_VAUX4_REMAP		0x25
> +#define TWL4030_VAUX4_DEDICATED		0x26
>  
>  #if defined(CONFIG_TWL4030_BCI_BATTERY) || \
>  	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)

Tuukka, please post this to the associated driver mailings lists to get
this integrated. Basically please send to Samuel Ortiz and Cc LKML and
l-o.

Regards,

Tony
