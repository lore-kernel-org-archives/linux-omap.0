From: Paul Walmsley <paul@pwsan.com>
Subject: RE: tidspbridge compilation broken
Date: Mon, 11 Oct 2010 14:36:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010111418450.16871@utopia.booyaka.com>
References: <1286621397.10205.25.camel@atlantis.mindbit.ro> <496565EC904933469F292DDA3F1663E602F47B2BA0@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40266 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756082Ab0JKUgg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 16:36:36 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602F47B2BA0@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: Ionut Nicu <ionut.nicu@mindbit.ro>, tony@atomide.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, bshah@ti.com, ohad@wizery.com

On Mon, 11 Oct 2010, Guzman Lugo, Fernando wrote:

> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ionut Nicu
> > Sent: Saturday, October 09, 2010 5:50 AM
> > 
> > 2. The second one is related to the missing header 
> > plat/control.h which was moved by a recent commit (81bb9b6) 
> > from plat to mach-omap2. The dspbridge driver requires a few 
> > defines from that header but as far as I understand, that 
> > header file is no longer supposed to be accessible by 
> > drivers. Any suggestion on how to fix that in dspbridge?
> 
> This will be fixed soon, we are looking for the best solution.

Tony mentioned that you all needed some help with this.  I would have 
converted DSPBridge as part of the original SCM patch, but since DSPBridge 
used __raw_writel() to write to the SCM rather than omap_ctrl_writel(), it 
didn't show up on my original grep.

Anyway, following is a patch series to help you deal with this problem in 
the short term.  It is unlikely to work as-is, since there doesn't appear 
to be any code in arch/arm/mach-omap2/* to populate the function pointers.  
You guys need to fix this - this is a defect in the original code.  I 
suggest that you move your OMAP3430 hardware adaptation layer out of your 
core/tiomap3430.c into arch/arm/mach-omap2/, after rewriting it 
appropriately.  For example, there shouldn't be any need to do any CM or 
PRM accesses.  That should all be doable with 
clock/clockdomain/powerdomain/omap_device/omap_hwmod functions.

Also, I hope you all are planning to do whatever it takes to move that 
driver out of staging as soon as possible.  If further resources aren't 
invested on this driver to get it mainline-ready, then it's likely that 
someone will kick it out of staging at some point.  Staging isn't really 
mainline.


- Paul


Paul Walmsley (3):
      OMAP: control: add functions for DSP boot address/mode control
      OMAP3: PM: update DSP reset code to use new SCM DSP boot control 
functions
      DSPBridge: convert OMAP3430 adaptation layer to use new SCM DSP boot 
control fns

 arch/arm/mach-omap2/control.c                      |   51 ++++++++++++++++++
 arch/arm/mach-omap2/control.h                      |   16 +++---
 arch/arm/mach-omap2/pm34xx.c                       |    6 +-
 arch/arm/plat-omap/include/plat/iva2_dsp.h         |   56 ++++++++++++++++++++
 drivers/staging/tidspbridge/core/tiomap3430.c      |   13 ++---
 .../tidspbridge/include/dspbridge/host_os.h        |    4 ++
 6 files changed, 129 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/iva2_dsp.h

