From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/4] ARM: AM33XX: clock: SET_RATE_PARENT in lcd path
Date: Thu, 31 Jan 2013 16:26:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301311625290.32145@utopia.booyaka.com>
References: <cover.1358871018.git.afzal@ti.com> <24c9e4241b2988e66abd053508991d96cac964b7.1358871018.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52762 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab3AaQ0K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 11:26:10 -0500
In-Reply-To: <24c9e4241b2988e66abd053508991d96cac964b7.1358871018.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>

On Tue, 22 Jan 2013, Afzal Mohammed wrote:

> LCDC clock node is a one that does not have set rate capability. It
> just passes on the rate that is sent downstream by it's parent. While
> lcdc clock parent and it's grand parent - dpll_disp_m2_ck and
> dpll_disp_ck has the capability to configure rate.
> 
> And the default rates provided by LCDC clock's ancestors are not
> sufficient to obtain pixel clock for current LCDC use cases, hence
> currently display would not work on AM335x SoC's (with driver
> modifications in platfrom independent way).
> 
> Hence inform clock framework to propogate set rate for LCDC clock as
> well as it's parent - dpll_disp_m2_ck. With this change, set rate on
> LCDC clock would get propogated till dpll_disp_ck via dpll_disp_m2_ck,
> hence allowing the driver (same driver is used in DaVinci too) to set
> rates using LCDC clock without worrying about platform dependent clock
> details.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

This one doesn't apply for me on v3.8-rc5 + your patches 2 and 3.  Could 
you please update it and re-send?


- Paul
