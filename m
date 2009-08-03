From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to
 create twl6030 regulators
Date: Mon, 3 Aug 2009 15:23:56 +0100
Message-ID: <20090803142356.GA4265@rakim.wolfsonmicro.main>
References: <1248842173-21821-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1248842173-21821-1-git-send-email-balajitk-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balajitk-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 29, 2009 at 10:06:13AM +0530, balajitk-l0cyMroinI0@public.gmane.org wrote:

> -	if (twl_has_regulator()) {
> +	if (twl_has_regulator() && is_class_twl4030()) {

is_class_twl4030() feels like it should have better namespacing, though
having the part name in there means it's not actually an issue.

> @@ -306,6 +306,7 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
>  #define TWL4030_INT_PWR_EDR2		0x6
>  #define TWL4030_INT_PWR_SIH_CTRL	0x7
>  
> +
>  /*----------------------------------------------------------------------*/
>  
>  /* Power bus message definitions */

Random unrelated indentation change?
