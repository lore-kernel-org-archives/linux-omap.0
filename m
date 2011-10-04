From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v16 00/12] OMAP: dmtimer: adaptation to platform_driver
Date: Mon, 3 Oct 2011 17:36:39 -0700
Message-ID: <20111004003638.GQ6324@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
 <4E89C7CD.8040505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19286 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab1JDAgm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 20:36:42 -0400
Content-Disposition: inline
In-Reply-To: <4E89C7CD.8040505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, arnd Bergmann <arnd@arndb.de>

* Cousson, Benoit <b-cousson@ti.com> [111003 07:00]:
> + Arnd
> 
> Hi Tony,
> 
> After rebasing by DT series on top of your dt-base, I noticed two
> minor issues from this timer series.
> 
> First some new warnings:
> 
> [    0.260009]  omap_timer.1: alias fck already exists
> [    0.260345]  omap_timer.2: alias fck already exists
> [    0.260650]  omap_timer.3: alias fck already exists
> [    0.260955]  omap_timer.4: alias fck already exists
> [    0.261260]  omap_timer.5: alias fck already exists
> [    0.261566]  omap_timer.6: alias fck already exists
> [    0.261871]  omap_timer.7: alias fck already exists
> [    0.262207]  omap_timer.8: alias fck already exists
> [    0.262512]  omap_timer.9: alias fck already exists
> [    0.262847]  omap_timer.10: alias fck already exists
> [    0.263153]  omap_timer.11: alias fck already exists
> 
> These warnings are due to the commit
> 318c3e15cd55c73a26ae22a65a8183655b3003f9  ARM: OMAP2+: dmtimer: add
> device names to flck nodes

Yes I noticed those too, but too late :(
 
> Since 3.1, the fck clock nodes are added automatically based on
> hwmod main_clk attribute.
> 
> +       CLK("omap_timer.1",     "fck",         &timer1_fck,    CK_443X),
> +       CLK("omap_timer.2",     "fck",         &timer2_fck,    CK_443X),
> +       CLK("omap_timer.3",     "fck",         &timer3_fck,    CK_443X),
> +       CLK("omap_timer.4",     "fck",         &timer4_fck,    CK_443X),
> +       CLK("omap_timer.5",     "fck",         &timer5_fck,    CK_443X),
> +       CLK("omap_timer.6",     "fck",         &timer6_fck,    CK_443X),
> +       CLK("omap_timer.7",     "fck",         &timer7_fck,    CK_443X),
> +       CLK("omap_timer.8",     "fck",         &timer8_fck,    CK_443X),
> +       CLK("omap_timer.9",     "fck",         &timer9_fck,    CK_443X),
> +       CLK("omap_timer.10",    "fck",         &timer10_fck,   CK_443X),
> +       CLK("omap_timer.11",    "fck",         &timer11_fck,   CK_443X),
> 
> So they should not exist in this patch.
> 
> Moreover, all the legacy clockdev should be removed at the same time.
> 
> CLK(NULL,	"gpt1_fck",		&timer1_fck,	CK_443X),
> CLK(NULL,	"gpt10_fck",		&timer10_fck,	CK_443X),
> CLK(NULL,	"gpt11_fck",		&timer11_fck,	CK_443X),
> CLK(NULL,	"gpt2_fck",		&timer2_fck,	CK_443X),
> CLK(NULL,	"gpt3_fck",		&timer3_fck,	CK_443X),
> CLK(NULL,	"gpt4_fck",		&timer4_fck,	CK_443X),
> CLK(NULL,	"gpt5_fck",		&timer5_fck,	CK_443X),
> CLK(NULL,	"gpt6_fck",		&timer6_fck,	CK_443X),
> CLK(NULL,	"gpt7_fck",		&timer7_fck,	CK_443X),
> CLK(NULL,	"gpt8_fck",		&timer8_fck,	CK_443X),
> CLK(NULL,	"gpt9_fck",		&timer9_fck,	CK_443X),
> CLK(NULL,	"gpt1_ick",		&dummy_ck,	CK_443X),
> CLK(NULL,	"gpt2_ick",		&dummy_ck,	CK_443X),
> CLK(NULL,	"gpt3_ick",		&dummy_ck,	CK_443X),
> CLK(NULL,	"gpt4_ick",		&dummy_ck,	CK_443X),
> CLK(NULL,	"gpt5_ick",		&dummy_ck,	CK_443X),
> CLK(NULL,	"gpt6_ick",		&dummy_ck,	CK_443X),
> CLK(NULL,	"gpt7_ick",		&dummy_ck,	CK_443X),
> CLK(NULL,	"gpt8_ick",		&dummy_ck,	CK_443X),
> CLK(NULL,	"gpt9_ick",		&dummy_ck,	CK_443X),
> CLK(NULL,	"gpt10_ick",		&dummy_ck,	CK_443X),
> CLK(NULL,	"gpt11_ick",		&dummy_ck,	CK_443X),
> 
> That will reduce a little bit the size of these static data files.
 
OK 
 
> Secondly, in commit c345c8b09d7a131f3571af55341038054a79efbd ARM:
> OMAP2+: dmtimer: convert to platform devices
> 
> +struct omap_device_pm_latency omap2_dmtimer_latency[] = {
> +       {
> +               .deactivate_func = omap_device_idle_hwmods,
> +               .activate_func   = omap_device_enable_hwmods,
> +               .flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +       },
> +};
> +
> 
> That structure should be removed, since I added a default one in the
> omap_device cleanup series for 3.2. Assuming that the cleanup is
> pulled before the new feature, the timer series could avoid adding
> that.

OK
 
> How do you want to handle that, using some cleanup patch on top of
> your current branch or by resubmitting the series?
> The point is that this branch was already pulled by Arnd in
> arm-soc/next/dmtimer feature branch.

Can you please just do a fix on either the dmtimer branch or
on cleanup branch?

Regards,

Tony
