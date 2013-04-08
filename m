From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: PM: fix PM regression introduced by recent
 clock cleanup
Date: Mon, 8 Apr 2013 16:23:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304081617470.32105@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302122026530.29149@utopia.booyaka.com> <5162B019.6050407@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56966 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934833Ab3DHQXd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 12:23:33 -0400
In-Reply-To: <5162B019.6050407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, j-keerthy@ti.com, b-cousson@ti.com

Hi,

On Mon, 8 Apr 2013, Kishon Vijay Abraham I wrote:

> On Wednesday 13 February 2013 01:58 AM, Paul Walmsley wrote:
> > 
> > Commit 17b7e7d33530e2bbd3bdc90f4db09b91cfdde2bb ("ARM: OMAP4:
> > clock/hwmod data: start to remove some IP block control "clocks"")
> > introduced a regression preventing the L3INIT clockdomain of OMAP4
> > systems from entering idle.  This in turn prevented these systems from
> > entering full chip clock-stop.
> > 
> > The regression was caused by the incorrect removal of a so-called
> > "optional functional clock" from the OMAP4 clock data.  This wasn't
> > caught for two reasons.  First, I missed the retention entry failure
> > in the branch test logs:
> > 
> > http://www.pwsan.com/omap/testlogs/cleanup_a_3.9/20130126014242/pm/4460pandaes/4460pandaes_log.txt
> > 
> > Second, the integration data for the OCP2SCP PHY IP block, added by
> > commit 0c6688753f9912c6a7013549ec31c8844020bbc1 ("ARM: OMAP4: hwmod
> > data: add remaining USB-related IP blocks"), should have associated this
> > clock with the IP block, but did not.
> > 
> > Fix by adding back the so-called "optional" functional clock to the
> > clock data, and by linking that clock to the OCP2SCP PHY IP block
> > integration hwmod data.
> 
> This patch breaks MUSB in OMAP4 panda. The 48M clock is modeled as main clk
> [1] for ocp2scp so after doing get_sync, this optional clock gets enabled. But
> after this patch, the optional clock seems to be not enabled after get_sync.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September/118285.html
> (this patch is not directly merged but I guess the discussion here is taken
> care of)

The OMAP integration for the MUSB driver needs to clk_enable() and 
clk_disable() its optional clock.  It's not correct to work around a 
driver problem by changing the hardware description data - that data is 
intended to be driver-neutral.


- Paul
