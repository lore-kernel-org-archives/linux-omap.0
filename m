From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 02/13] OMAP3: PM: Errata i581 suppport: dll kick
	strategy
Date: Thu, 25 Nov 2010 14:22:28 +0200
Message-ID: <20101125122228.GT26003@nokia.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com> <1290131698-6194-3-git-send-email-nm@ti.com> <AANLkTi=cb1LDS0nJr+gS47qc2qpw_kRz8+ZxV_x2gSJ0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:57392 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695Ab0KYMXQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 07:23:16 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=cb1LDS0nJr+gS47qc2qpw_kRz8+ZxV_x2gSJ0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>

On Wed, Nov 24, 2010 at 05:51:50PM +0100, ext Sripathy, Vishwanath wrote:
> Nishant,
> 
> On Fri, Nov 19, 2010 at 7:24 AM, Nishanth Menon <nm@ti.com> wrote:
> > From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> >
> > Errata i581 impacts OMAP3 platforms.
> > PRCM DPLL control FSM removes SDRC_IDLEREQ before DPLL3 locks causing
> > the DPLL not to be locked at times.
> >
> > IMPORTANT: this is not a complete workaround implementation as recommended
> > by the silicon errata. this is a support logic for detecting lockups and
> > attempting to recover where possible and is known to provide stability
> > in multiple platforms.
> 
> How does this WA work when Core enters off mode? SRAM contents are
> lost when Core enters off. So how this code is copied to SRAM upon
> wakeup? Where is this code placed when Core entered off mode?
> 

This code is mostly important for inactive and retention. The ROM code
waits for the maximum dll lock time when resuming from off mode. So for
off mode this code isn't really needed.

Cheers,

Peter.
