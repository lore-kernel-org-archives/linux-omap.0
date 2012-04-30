From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 05/12] arm: omap3: am35x: Add PWROFF feature
Date: Mon, 30 Apr 2012 15:08:36 -0700
Message-ID: <20120430220836.GB19256@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-6-git-send-email-mgreer@animalcreek.com>
 <87iph5q43n.fsf@ti.com>
 <20120424043639.GA24317@animalcreek.com>
 <87r4v828am.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:46793 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2D3WIh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 18:08:37 -0400
Content-Disposition: inline
In-Reply-To: <87r4v828am.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

On Fri, Apr 27, 2012 at 02:07:13PM -0700, Kevin Hilman wrote:
> "Mark A. Greer" <mgreer@animalcreek.com> writes:
> 
> > On Wed, Apr 11, 2012 at 03:46:20PM -0700, Kevin Hilman wrote:
> >> Hi Mark,
> >
> > Hi Kevin.
> >
> >> "Mark A. Greer" <mgreer@animalcreek.com> writes:
> >> 
> >> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> >> >
> >> > Typical OMAP3 SoCs have four power domain states: ON,
> >> > INACTIVE, RETENTION, and OFF.  The am35x family of SoCs
> >> > has only two states: ON and INACTIVE.  To distinguish which
> >> > set of states the current device has, add the 'OMAP3_HAS_PWROFF'
> >> > feature.  When that feature/bit is set, the device supports the
> >> > RETENTION and OFF states; otherwise, it doesn't.
> >> >
> >> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> >> 
> >> Paul has mentioned this already, but the same applies here: We shouldn't
> >> be using SoC-global feature flag for this.   We already have per-pwrdm
> >> flags that indicate what states a given powerdomain suports (see .pwrsts
> >> field.)
> >> 
> >> Wherever we have blind writes to next powerstates that assume support
> >> for RET/OFF is present, those should probably use a helper function from
> >> the powerdomain code that checks if that state is even supported.
> >
> > How about something like the patch below?
> > Note: its not well tested; just RFC.
> 
> Yes, your proposed patch looks right to me.
> 
> I guess it's up to Paul & Jean to see if they'd rather see this build on
> top of the Jean's functional power state work, or take this as a
> standalone fix.
> 
> Kevin

FYI, I just submitted the patch,
	http://www.spinics.net/lists/linux-omap/msg69066.html

Mark
