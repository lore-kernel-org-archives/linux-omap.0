From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/24] omap4: clocks: Remove clock hacks from timer-gp.c
Date: Wed, 17 Feb 2010 09:21:51 -0800
Message-ID: <20100217172150.GY21755@atomide.com>
References: <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com>
 <20100216184137.GL21755@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF826F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54985 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab0BQRVB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 12:21:01 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF826F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben@fluff.org.uk" <ben@fluff.org.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "paul@pwsan.com" <paul@pwsan.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100216 20:59]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Wednesday, February 17, 2010 12:12 AM
> > To: Shilimkar, Santosh
> > Cc: linux-omap@vger.kernel.org; ben@fluff.org.uk; sameo@linux.intel.com; lrg@slimlogic.co.uk;
> > paul@pwsan.com
> > Subject: Re: [PATCH 13/24] omap4: clocks: Remove clock hacks from timer-gp.c
> > 
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [100216 07:55]:
> > > Now the omap4 clock framework is mainline and clk_get_rate()
> > > is functional. Hence reomve the hardcoded clock hacks.
> > 
> > Should we send this as a fix for 2.6.33, or does this depend
> > on other patches not yet in 2.6.33?
>
> This needs the gptimer clocks updates in dmtimer.

OK, so can't send it as a fix then.

Tony

