From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Thu, 14 Jun 2012 04:49:06 -0700
Message-ID: <20120614114905.GK12766@atomide.com>
References: <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com>
 <20120613115445.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28556 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479Ab2FNLtI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 07:49:08 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120614 03:43]:
> Hi Tony,
> 
> On Thu, Jun 14, 2012 at 15:49:02, Tony Lindgren wrote:
> 
> > Well I took a look at the values, and it seems the only difference is the
> > static GPMC_CONFIG1_CLKACTIVATIONTIME(1) that your patch now overwrites 0.
> 
> It seems change below should be part of $subject.
> 
> Please let me know your comments

Well I could not get this to apply either on top of the $subject nor all your
patches for some reason, but I manually applied the tusb6010 part with the
following change..

> --- a/arch/arm/mach-omap2/usb-tusb6010.c
> +++ b/arch/arm/mach-omap2/usb-tusb6010.c
> @@ -174,6 +174,8 @@ static int tusb_set_sync_mode(unsigned sysclk_ps, unsigned fclk_ps)
>         tmp = t.cs_wr_off * 1000 + 7000 /* t_scsn_rdy_z */;
>         t.wr_cycle = next_clk(t.cs_wr_off, tmp, fclk_ps);
> 
> +       t.clk_activation = gpmc_ticks_to_ns(1);
> +

..this should be just 1 as it's one tick, not ns.

>         return gpmc_cs_set_timings(sync_cs, &t);
>  }
> 
> @@ -283,7 +285,6 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
>                         | GPMC_CONFIG1_READTYPE_SYNC
>                         | GPMC_CONFIG1_WRITEMULTIPLE_SUPP
>                         | GPMC_CONFIG1_WRITETYPE_SYNC
> -                       | GPMC_CONFIG1_CLKACTIVATIONTIME(1)
>                         | GPMC_CONFIG1_PAGE_LEN(2)
>                         | GPMC_CONFIG1_WAIT_READ_MON
>                         | GPMC_CONFIG1_WAIT_WRITE_MON

And that makes tusb6010 work as earlier with your patches.

For onenand I'm getting the following error:

omap2-onenand omap2-onenand: Cannot request GPMC CS 

Regards,

Tony

