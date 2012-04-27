From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 03/12] arm: omap3: Only sleep in cpuidle driver if I/O
 wake-ups work
Date: Fri, 27 Apr 2012 14:55:27 -0700
Message-ID: <20120427215527.GD19196@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-4-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204111532280.29473@utopia.booyaka.com>
 <20120424205105.GA26749@animalcreek.com>
 <20120424232506.GA8850@animalcreek.com>
 <87haw4282b.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:58081 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab2D0Vz3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 17:55:29 -0400
Content-Disposition: inline
In-Reply-To: <87haw4282b.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 27, 2012 at 02:12:12PM -0700, Kevin Hilman wrote:
> "Mark A. Greer" <mgreer@animalcreek.com> writes:
> 
> > On Tue, Apr 24, 2012 at 01:51:05PM -0700, Mark A. Greer wrote:

> > We could chose whether pm_idle & cpuidle issue a wfi based on
> > whether there is a davinci-emac present.  The issue with that is
> > that someday there may be another SoC that has a davinci-emac that
> > can wake up the system.  I know cpu_is_xxx() is frowned upon but
> > this does seem like a proper usage of it--the deciding factor
> > really is whether its an am35x or not (and CONFIG_TI_DAVINCI_EMAC
> > is enabled).
> 
> The presence of the davinci_emac is probably overkill, avoiding WFI
> should really only be done when the davinci_emac is *active*.
> e.g. using an am35x with an EMAC *present*, but not in use because
> there's an MMC rootfs for example.
> 
> If there's a good way to detect an in-use davinci_emac, then
> disable_hlt() can be used to avoid WFI.  When the davinci_emac is not in
> use (e.g. module unloaded etc.) then enable_hlt() can be used to
> (re)allow WFI.

Good idea.  I'll see what I can do.

Mark
