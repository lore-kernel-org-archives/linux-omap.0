From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-retu-wdt: Store all data in device struct
Date: Mon, 7 Mar 2011 09:43:24 +0200
Message-ID: <20110307074324.GE2522@legolas.emea.dhcp.ti.com>
References: <1299252779.21644.11.camel@marge>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:40106 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752894Ab1CGHna (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 02:43:30 -0500
Received: by bwj24 with SMTP id 24so5243618bwj.11
        for <linux-omap@vger.kernel.org>; Sun, 06 Mar 2011 23:43:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299252779.21644.11.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Mar 04, 2011 at 04:32:59PM +0100, Michael Buesch wrote:
> Get rid of all static global variables and store all
> information in the device structure. This cleans up
> the random mixup of information storage (struct vs static).
> 
> Signed-off-by: Michael Buesch <mb@bu3sch.de>
> 
> ---
> 
> Index: linux-2.6.38-rc6/drivers/cbus/retu-wdt.c
> ===================================================================
> --- linux-2.6.38-rc6.orig/drivers/cbus/retu-wdt.c	2011-03-04 16:22:03.524019824 +0100
> +++ linux-2.6.38-rc6/drivers/cbus/retu-wdt.c	2011-03-04 16:22:31.186357952 +0100
> @@ -7,6 +7,8 @@
>   *
>   * Written by Amit Kucheria <amit.kucheria@nokia.com>
>   *
> + * Cleanups by Michael Buesch <mb@bu3sch.de> (C) 2011
> + *
>   * This file is subject to the terms and conditions of the GNU General
>   * Public License. See the file "COPYING" in the main directory of this
>   * archive for more details.
> @@ -48,37 +50,31 @@
>  #define RETU_WDT_DEFAULT_TIMER 32
>  #define RETU_WDT_MAX_TIMER 63
>  
> -static DEFINE_MUTEX(retu_wdt_mutex);
> -
> -/* Current period of watchdog */
> -static unsigned int period_val = RETU_WDT_DEFAULT_TIMER;
> -
>  struct retu_wdt_dev {
>  	struct device		*dev;
> +	unsigned int		period_val;	/* Current period of watchdog */
>  	unsigned long		users;
> -	struct miscdevice	retu_wdt_miscdev;
> +	struct miscdevice	miscdev;

this rename is not part of $SUBJECT

>  	struct delayed_work	ping_work;
> +	struct mutex		mutex;

checkpatch.pl --strict will complain about this mutex not having a
comment explaining it. Can you add something ?

>  };
>  
> -static struct retu_wdt_dev *retu_wdt;
>  
> -static int _retu_modify_counter(unsigned int new)
> +static inline void _retu_modify_counter(struct retu_wdt_dev *wdev,
> +					unsigned int new)

let the compiler inline it, maybe ?!?

-- 
balbi
