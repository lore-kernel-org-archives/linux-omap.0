From: Tony Lindgren <tony@atomide.com>
Subject: Re: DSS errors in linux next when booted with DTB append
Date: Tue, 5 Feb 2013 11:06:19 -0800
Message-ID: <20130205190619.GN25185@atomide.com>
References: <20130116190803.GG14149@atomide.com>
 <5110FD01.7010605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21717 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754984Ab3BETGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 14:06:21 -0500
Content-Disposition: inline
In-Reply-To: <5110FD01.7010605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130205 04:40]:
> Hi,
> 
> On 2013-01-16 21:08, Tony Lindgren wrote:
> > Hi Tomi,
> > 
> > Looks like omap_dss_init() goes crazy on panda es when booted with 
> > PANEL_TAAL and DTB append enabled, see below. Does not seem to happen when
> > booted on blaze. Noticed this after enabling all the panels, my modified
> > omap2plus_defconfig attached.
> 
> Hmm, looks odd. The log shows it's trying to use Taal panel, even if
> Panda doesn't have such a panel. Who's adding the Taal device? Are you
> booting Panda with Blaze's dtb?

Hmm yeah I might have had Blaze's dtb there, need to check. That
certainly would explain it.
 
> That said, I have seen similar circular locking warnings related to
> omapfb/omapdss, but I haven't been able to resolve them, or even to
> really find out why the warning happens. I haven't seen any problems
> though, it's just a warning.
> 
> So my guess is that you're seeing two unrelated problems, one related to
> dtbs or such, and the other related to locks.

Yeah the locks related one could be caused by spurious interrupts
by some other device if I had Blaze's .dtb in use.

Regards,

Tony
