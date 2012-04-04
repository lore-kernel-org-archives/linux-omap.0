From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: clock: fix DPLL4 CLKSEL masks
Date: Wed, 4 Apr 2012 08:40:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204040837510.8000@utopia.booyaka.com>
References: <1332709687-22846-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45859 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932142Ab2DDOkB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 10:40:01 -0400
In-Reply-To: <1332709687-22846-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

On Mon, 26 Mar 2012, Grazvydas Ignotas wrote:

> Commit 2a9f5a4d455 "OMAP3 clock: remove unnecessary duplicate of dpll4_m2_ck,
> added for 36xx" consolidated dpll4 clock structures between 34xx and 36xx,
> but left 34xx CLKSEL masks for most dpll4 related clocks, which causes
> clock code to not behave correctly when booting on DM3730 with higher
> (36xx only) divisors set:
> [    0.000000] WARNING: at arch/arm/mach-omap2/clkt_clksel.c:375 omap2_init_clksel_parent+0x104/0x114()
> [    0.000000] clock: dpll4_m3_ck: init parent: could not find regval 0
> [    0.000000] WARNING: at arch/arm/mach-omap2/clkt_clksel.c:194 omap2_clksel_recalc+0xd4/0xe4()
> [    0.000000] clock: Could not find fieldval 0 for clock dpll4_m3_ck parent dpll4_ck
> 
> Fix this by switching to 36xx masks, as valid divisors will be limited
> by clksel_rate lists.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Thanks, queued for 3.4-rc. 

(Looks like the lakml cc was accidentally dropped, so I went ahead and did 
that, but maybe you could do that for me next time :-) )


- Paul
