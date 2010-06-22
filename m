From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: Make VFPv3 usable on ARMv6
Date: Tue, 22 Jun 2010 16:20:38 +0300
Message-ID: <20100622132037.GV12255@atomide.com>
References: <20100621135125.24299.91290.stgit@baageli.muru.com>
 <1277211592.29532.20.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55270 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab0FVNUg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 09:20:36 -0400
Content-Disposition: inline
In-Reply-To: <1277211592.29532.20.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Catalin Marinas <catalin.marinas@arm.com> [100622 15:53]:
> On Mon, 2010-06-21 at 14:51 +0100, Tony Lindgren wrote:
> > diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> > index 315a540..19ba626 100644
> > --- a/arch/arm/vfp/vfpmodule.c
> > +++ b/arch/arm/vfp/vfpmodule.c
> > @@ -549,10 +549,14 @@ static int __init vfp_init(void)
> >                 /*
> >                  * Check for the presence of the Advanced SIMD
> >                  * load/store instructions, integer and single
> > -                * precision floating point operations.
> > +                * precision floating point operations. Only check
> > +                * for NEON if the hardware has TLS register as the
> > +                * MVFR registers got added in ARM1136 r1p0 with TLS.
> >                  */
> > -               if ((fmrx(MVFR1) & 0x000fff00) == 0x00011100)
> > -                       elf_hwcap |= HWCAP_NEON;
> > +               if (elf_hwcap & HWCAP_TLS) {
> > +                       if ((fmrx(MVFR1) & 0x000fff00) == 0x00011100)
> > +                               elf_hwcap |= HWCAP_NEON;
> > +               }
> 
> MVFR should be available with the new CPU id format:
> 
> 	((read_cpuid_id() & 0x000f0000) == 0x000f0000)
> 
> I think that would be a cleaner test than relying on the TLS presence.

OK, thanks that's better. Will update accordingly and repost.

Tony
