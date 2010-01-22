From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code
 generic, v2
Date: Fri, 22 Jan 2010 12:55:11 -0800
Message-ID: <20100122205511.GB11835@atomide.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
 <20100116013515.10065.30649.stgit@baageli.muru.com>
 <20100116093555.GA13596@n2100.arm.linux.org.uk>
 <20100116191820.GI10318@atomide.com>
 <20100116193313.GA23092@n2100.arm.linux.org.uk>
 <20100116200003.GL10318@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC356087030070F296@dbde02.ent.ti.com>
 <20100122030711.GP23467@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608703007F2289@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58290 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308Ab0AVUzJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 15:55:09 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703007F2289@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pandita, Vikram <vikram.pandita@ti.com> [100122 06:46]:
> >
> >OK, I've added that too, but for mach-omap2 only. I've also
> >added an experimental zoom2/3 support.
> >
> >Care to take try it out and see what happens on a zoom?
> 
> Test on zoom3 failed with multi-omap branch.
> Debugging the same, should have a zoom correction patch out today.

Heh OK. I just pushed more updates into the multi-omap branch
if you want to try to boot zoom2/zoom3 using the same .config.

There are still issues with booting 2420 though..

Tony
