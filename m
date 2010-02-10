From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap3evm: Doesn't boot at 4fa42e46
Date: Wed, 10 Feb 2010 15:24:43 -0800
Message-ID: <20100210232442.GX21755@atomide.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E263A697@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E26C53A7@dbde02.ent.ti.com>
 <20100210173401.GV21755@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC3560870300C4D03F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63208 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756240Ab0BJXYE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 18:24:04 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870300C4D03F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pandita, Vikram <vikram.pandita@ti.com> [100210 14:56]:

<snip>

> >> > The kernel panics during I2C init in function omap3_evm_i2c_init()
> >> > during this call:
> >> >
> >> >     omap_register_i2c_bus(2, 400, NULL, 0);
> 
> I see that Zoom2/3 also don't boot up and given that DEBUG_LL does not work for these boards,
> its very difficult to narrow down the problem.
> 
> After around 2 hours of narrowing down, this is what solves the issue probably:
> m0_entry seems to be null, causing strcmp() to crash.
> 
> Patch: (will not apply as TABS are not there :) )
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 986077f..d5a03f8 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -435,7 +435,7 @@ int __init omap_mux_init_signal(char *muxname, int val)
>                 char *m0_entry = m->muxnames[0];
>                 int i;
> 
> -               if (m0_name && strcmp(m0_name, m0_entry))
> +               if (m0_name && m0_entry && strcmp(m0_name, m0_entry))
>                         continue;
> 
>                 for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
> 
> 

Hmm is this only with CONFIG_OMAP_MUX and only on 3630?

In for-next we don't have yet the recent mux fix commit
9ecef433204f9b06550dd45cf84f14706f8fe4f0. Can you make sure
you have that applied and see if that solves the problem?

To me it seems that m0_entry should never be NULL after mux
init as that's the signal register name. The 3630 entries should
get populated by omap_mux_init_list.

If omap36xx_cbp_subset is missing some of the 3630 only entries
added by commit 9ecef433204f9b06550dd45cf84f14706f8fe4f0 into 
omap3_muxmodes, then that would explain why m0_entry would
be NULL..

Anyways, as I don't have a 3630 here I'm just guessing. Until
you get the DEBUG_LL working on zoom3, you can just increase
the CONFIG_LOG_BUF_SHIFT to something large enough and printk
m0_name and m0_entry without doing anything with them. Then
after the boot you can take a look at dmesg and see if it
provides any clues.

Regards,

Tony
