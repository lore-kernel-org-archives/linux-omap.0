From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch] kill compile warning on twl4030-power.c
Date: Mon, 15 Sep 2008 19:23:30 +0300
Message-ID: <20080915162328.GC17076@frodo>
References: <20080915151208.GA17076@frodo> <20080915155512.GF4712@codecarver.research.nokia.com> <20080915162122.GB17076@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:45082 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbYIOQXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2008 12:23:53 -0400
Content-Disposition: inline
In-Reply-To: <20080915162122.GB17076@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Sep 15, 2008 at 07:21:25PM +0300, Felipe Balbi wrote:
> On Mon, Sep 15, 2008 at 06:55:12PM +0300, Peter 'p2' De Schrijver wrote:
> > On Mon, Sep 15, 2008 at 06:12:11PM +0300, ext Felipe Balbi wrote:
> > > From: Felipe Balbi <felipe.balbi@nokia.com>
> > > 
> > > This part of the patch was left out on previous merge. Here's a
> > > fix for that.
> > > 
> > 
> > I doubt this works if you compile for SDP or labrador. OTOH the code for
> > that bit looks suspicious :)
> 
> Hmmm... that's true. That variable is only used on 3430sdp and 3430
> labrador. How about this version:

and I missed the #include <asm/mach-types.h>

> diff --git a/drivers/i2c/chips/twl4030-power.c b/drivers/i2c/chips/twl4030-power.c
> index 04a13aa..b8723e8 100644
> --- a/drivers/i2c/chips/twl4030-power.c
> +++ b/drivers/i2c/chips/twl4030-power.c
> @@ -245,14 +245,15 @@ static int __init config_sleep_wake_sequence(void)
>         err |= twl4030_write_script(0x2F, sleep_off_seq,
>                                         ARRAY_SIZE(sleep_off_seq));
>  
> -#if defined(CONFIG_MACH_OMAP_3430SDP) || defined(CONFIG_MACH_OMAP_3430LABRADOR)
> -       /* Disabling AC charger effect on sleep-active transitions */
> -       err |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
> -                                       R_CFG_P1_TRANSITION);
> -       data &= 0x0;
> -       err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data ,
> -                                       R_CFG_P1_TRANSITION);
> -#endif
> +       if (machine_is_omap_3430sdp()) {
> +               /* Disabling AC charger effect on sleep-active transitions */
> +               err |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
> +                               R_CFG_P1_TRANSITION);
> +               data &= 0x0;
> +               err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data ,
> +                               R_CFG_P1_TRANSITION);
> +       }
> +
>         /* P1/P2/P3 LVL_WAKEUP should be on LEVEL */
>         err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, LVL_WAKEUP,
>                                         R_P1_SW_EVENTS);
-- 
balbi
