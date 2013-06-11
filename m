From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 04/22] input/ti_am33x_tsc: Order of TSC wires, made
 configurable
Date: Tue, 11 Jun 2013 16:23:24 +0200
Message-ID: <20130611142324.GD29135@zurbaran>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
 <1370950268-7224-5-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370950268-7224-5-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

On Tue, Jun 11, 2013 at 01:30:50PM +0200, Sebastian Andrzej Siewior wrote:
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index eeead15..2d78af8 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -71,8 +71,6 @@
>  #define STEPCONFIG_INM_ADCREFM	STEPCONFIG_INM(8)
>  #define STEPCONFIG_INP_MASK	(0xF << 19)
>  #define STEPCONFIG_INP(val)	((val) << 19)
> -#define STEPCONFIG_INP_AN2	STEPCONFIG_INP(2)
> -#define STEPCONFIG_INP_AN3	STEPCONFIG_INP(3)
>  #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
>  #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
>  #define STEPCONFIG_FIFO1	BIT(26)
> @@ -94,7 +92,6 @@
>  #define STEPCHARGE_INM_AN1	STEPCHARGE_INM(1)
>  #define STEPCHARGE_INP_MASK	(0xF << 19)
>  #define STEPCHARGE_INP(val)	((val) << 19)
> -#define STEPCHARGE_INP_AN1	STEPCHARGE_INP(1)
>  #define STEPCHARGE_RFM_MASK	(3 << 23)
>  #define STEPCHARGE_RFM(val)	((val) << 23)
>  #define STEPCHARGE_RFM_XNUR	STEPCHARGE_RFM(1)
> @@ -116,6 +113,13 @@
>  #define CNTRLREG_8WIRE		CNTRLREG_AFE_CTRL(3)
>  #define CNTRLREG_TSCENB		BIT(7)
>  
> +#define XPP			STEPCONFIG_XPP
> +#define XNP			STEPCONFIG_XNP
> +#define XNN			STEPCONFIG_XNN
> +#define YPP			STEPCONFIG_YPP
> +#define YPN			STEPCONFIG_YPN
> +#define YNN			STEPCONFIG_YNN
What is that for ? Isn't STEPCONFIG_XPP explicit enough ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
