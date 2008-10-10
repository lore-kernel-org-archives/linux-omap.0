From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/05] ARM: OMAP3: Add minimal Beagle board support
Date: Fri, 10 Oct 2008 11:51:41 +0300
Message-ID: <20081010085140.GH3044@atomide.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com> <1223035779-26306-2-git-send-email-tony@atomide.com> <1223035779-26306-3-git-send-email-tony@atomide.com> <20081009145125.GH435@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52160 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbYJJIv6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 04:51:58 -0400
Content-Disposition: inline
In-Reply-To: <20081009145125.GH435@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, "Syed Mohammed, Khasim" <khasim@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [081009 17:52]:
> On Fri, Oct 03, 2008 at 03:09:36PM +0300, Tony Lindgren wrote:
> > diff --git a/arch/arm/plat-omap/include/mach/board-omap3beagle.h b/arch/arm/plat-omap/include/mach/board-omap3beagle.h
> > new file mode 100644
> > index 0000000..3080d52
> > --- /dev/null
> > +++ b/arch/arm/plat-omap/include/mach/board-omap3beagle.h
> > @@ -0,0 +1,33 @@
> > +/*
> > + * arch/arm/plat-omap/include/mach/board-omap3beagle.h
> > + *
> > + * Hardware definitions for TI OMAP3 BEAGLE.
> > + *
> > + * Initial creation by Syed Mohammed Khasim <khasim@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the
> > + * Free Software Foundation; either version 2 of the License, or (at your
> > + * option) any later version.
> > + *
> > + * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> > + * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> > + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
> > + * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> > + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> > + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> > + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> > + * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> > + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + *
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, write to the Free Software Foundation, Inc.,
> > + * 675 Mass Ave, Cambridge, MA 02139, USA.
> > + */
> > +
> > +#ifndef __ASM_ARCH_OMAP3_BEAGLE_H
> > +#define __ASM_ARCH_OMAP3_BEAGLE_H
> > +
> > +#endif /* __ASM_ARCH_OMAP3_BEAGLE_H */
> > +
> > diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
> > index 29c849f..80f6d7e 100644
> > --- a/arch/arm/plat-omap/include/mach/hardware.h
> > +++ b/arch/arm/plat-omap/include/mach/hardware.h
> > @@ -322,6 +322,10 @@
> >  #include "board-2430sdp.h"
> >  #endif
> >  
> > +#ifdef CONFIG_MACH_OMAP3_BEAGLE
> > +#include "board-omap3beagle.h"
> > +#endif
> > +
> >  #ifdef CONFIG_MACH_OMAP_APOLLON
> >  #include "board-apollon.h"
> >  #endif
> 
> I really think you need to reconsider whether including board specific
> support files into mach/hardware.h is a good idea, or whether having
> all the machine specifics in the relevent board.c file should be the
> way to go.
> 
> That's certainly possible, and is done by others like PXA very
> successfully, and avoids any chance of board specific definitions
> ever clashing with each other.  It also cuts down on the dependencies,
> and the number of files that need to be rebuilt when one of these
> header files are touched.

Yeah, let's try to get rid of this dependency during next development
cycle.

Tony
