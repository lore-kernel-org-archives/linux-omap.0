From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC][PATCH 2/4] OMAP4: PMIC: Add support for twl6030 RTC
Date: Mon, 20 Jul 2009 22:08:53 +0300
Message-ID: <20090720190852.GF7984@gandalf>
References: <1248097007-14699-1-git-send-email-balajitk@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753862AbZGTTJB@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1248097007-14699-1-git-send-email-balajitk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balajitk@ti.com
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com, david-b@pacbell.net, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, sameo@openedhand.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

hi,

On Mon, Jul 20, 2009 at 07:06:47PM +0530, balajitk@ti.com wrote:
> @@ -257,15 +257,15 @@ config RTC_DRV_TWL92330
>  	  platforms. The support is integrated with the rest of
>  	  the Menelaus driver; it's not separate module.
>  
> -config RTC_DRV_TWL4030
> -	tristate "TI TWL4030/TWL5030/TPS659x0"
> -	depends on RTC_CLASS && TWL4030_CORE
> +config RTC_DRV_TWL
> +	tristate "TI TWL4030/TWL5030/TWL6030/TPS659x0"
> +	depends on RTC_CLASS && (TWL4030_CORE || TWL6030_CORE)
>  	help
>  	  If you say yes here you get support for the RTC on the
>  	  TWL4030 family chips, used mostly with OMAP3 platforms.
>  
>  	  This driver can also be built as a module. If so, the module
> -	  will be called rtc-twl4030.
> +	  will be called twl-rtc.

no renaming and still wrong, the driver will be called rtc-twl, not
twl-rtc.

anyways, keep the old name

-- 
balbi
