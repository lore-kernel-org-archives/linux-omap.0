From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP2: gptimer min_delta_ns should be rounded up
Date: Sun, 4 Jan 2009 21:57:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0901042110390.14756@utopia.booyaka.com>
References: <> <1230570868-25078-1-git-send-email-Aaro.Koskinen@nokia.com> <13B9B4C6EF24D648824FF11BE8967162036D3BCB12@dlee02.ent.ti.com> <495A5165.1040105@nokia.com> <13B9B4C6EF24D648824FF11BE8967162036D3BCD0B@dlee02.ent.ti.com> <495B8E1B.9050302@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162036D3BCF0A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54834 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbZAEE5t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2009 23:57:49 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036D3BCF0A@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

a few quick comments, possibly nit-picking...

On Wed, 31 Dec 2008, Woodruff, Richard wrote:

> Actually, the functional spec for timer says max re-sync time is:
>         3 OCP clock + 2.5 TIMER clock
>         3(1/83MHz) + 76uS = ~76uS

The OCP clock rate is dependent on the timer's interface clock 
clockdomain.  On OMAP3, GPTIMER1 uses sys_clk as the OCP interface clock, 
so the interface portion of this delay could be as slow as 3 periods/12MHz 
periods = 250 ns.

For GPTIMERs in CORE_L4 or PER_L4, the choice of CORE OPP will also change 
the OCP delay portion.  The L4 bus clock rate could be as low as 20.75MHz 
in 34xx VDD2 OPP1; resulting in a 145 ns delay for that portion.

These factors are noise with the 32KiHz timer source, but we are overusing 
it.  In the case of Beagle, the HF clk source can't be disabled, so we 
should be able to use sys_ck.  Same for other boards when AUTOEXTCLKMODE 
is disabled.  In those situations we should probably take the OCP-related 
delay into account.


- Paul
