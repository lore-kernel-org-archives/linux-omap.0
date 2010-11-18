From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Thu, 18 Nov 2010 10:13:41 -0800
Message-ID: <20101118181341.GH9264@atomide.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
 <1290091906-32539-2-git-send-email-j-pihet@ti.com>
 <d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com>
 <87tyjey6h3.fsf@deeprootsystems.com>
 <4CE55A88.6010300@ti.com>
 <20101118175215.GE9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38503 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760083Ab0KRSNt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 13:13:49 -0500
Content-Disposition: inline
In-Reply-To: <20101118175215.GE9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, Jean Pihet-XID <j-pihet@ti.com>

* Tony Lindgren <tony@atomide.com> [101118 09:42]:
> * Nishanth Menon <nm@ti.com> [101118 08:46]:
> > 
> > But after wfi in wait_sdrc_ok as part of the code executing in SRAM
> > today omap34xx_cpu_suspend -> we are waiting for DPLL3 lock prior to
> > accessing DDR -> how do we execute that logic in SDRAM?
> 
> I too am a bit concerned how this will all keep working. For light
> testing it may be running OK if it happens to run from cache..

This in the retention case, in off-idle those should be powered down..

Tony
