From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCHV2] OMAP3 PM: Fix for DSP Crash at OPP 1 and 2 under
 DVFS+SR operation
Date: Tue, 30 Mar 2010 03:31:22 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1003300329530.14474@utopia.booyaka.com>
References: <1268313365-18495-1-git-send-email-vishwanath.bs@ti.com> <87pr32q12r.fsf@deeprootsystems.com> <FCCFB4CDC6E5564B9182F639FC35608703047FFD56@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34819 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031Ab0C3JbX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 05:31:23 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703047FFD56@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gulati, Shweta" <shweta.gulati@ti.com>

On Mon, 29 Mar 2010, Sripathy, Vishwanath wrote:

> > -----Original Message-----
> > From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> > 
> > Please add this support by modifying/extending the existing clock/DPLL
> > management code instead of manually writing registers.
> > 
> Min/max dividers in clock framework are for dpll lock frequency, where 
> as in the patch, we configure dpll bypass frequency. Shall I add a new 
> API in dpll.c to configure bypass clock dividers?

That API is called clk_set_rate() and is already present as you can see by 
grep'ping clock3xxx_data.c for OMAP3430_MPU_CLK_SRC_MASK (as one example).


- Paul
