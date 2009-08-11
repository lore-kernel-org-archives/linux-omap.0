From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
Date: Tue, 11 Aug 2009 12:16:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908111200560.17390@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0306050246@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50571 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbZHKSQ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 14:16:57 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0306050246@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>

Hi Rajendra,

On Tue, 11 Aug 2009, Nayak, Rajendra wrote:

> >On Mon, 10 Aug 2009, Rajendra Nayak wrote:
> >
> >> This patch adds the offsets for new modules in PRM
> >> and CM for OMAP4
> >> 
> >> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/prcm-common.h |   22 ++++++++++++++++++++++
> >>  1 files changed, 22 insertions(+), 0 deletions(-)
> >> 
> >> diff --git a/arch/arm/mach-omap2/prcm-common.h 
> >b/arch/arm/mach-omap2/prcm-common.h
> >> index cb1ae84..ab0dd8e 100644
> >> --- a/arch/arm/mach-omap2/prcm-common.h
> >> +++ b/arch/arm/mach-omap2/prcm-common.h
> >> @@ -49,6 +49,28 @@
> >>  #define OMAP3430_NEON_MOD				0xb00
> >>  #define OMAP3430ES2_USBHOST_MOD				0xc00
> >>  
> >> +/* OMAP44XX specific module offsets */
> >> +#define OMAP4430_OCP_SOCKET_MOD				0x0000
> >> +#define OMAP4430_CKGEN_MOD				0x0100
> >> +#define OMAP4430_MPU_MOD				0x0300
> >> +#define OMAP4430_DSP_MOD				0x0400
> >> +#define OMAP4430_ABE_MOD				0x0500
> >> +#define OMAP4430_ALWAYS_ON_MOD				0x0600
> >> +#define OMAP4430_CORE_MOD				0x0700
> >> +#define OMAP4430_IVAHD_MOD				0x0F00
> >> +#define OMAP4430_CAM_MOD				0x1000
> >> +#define OMAP4430_DSS_MOD				0x1100
> >> +#define OMAP4430_GFX_MOD				0x1200
> >> +#define OMAP4430_L3INIT_MOD				0x1300
> >> +#define OMAP4430_L4PER_MOD				0x1400
> >> +#define OMAP4430_CEFUSE_MOD				0x1600
> >> +#define OMAP4430_WKUP_MOD				0x1700
> >> +#define OMAP4430_WKUP_CM_MOD				0x1800
> >> +#define OMAP4430_EMU_MOD				0x1900
> >> +#define OMAP4430_EMU_CM_MOD				0x1A00
> >> +#define OMAP4430_DEVICE_MOD				0x1B00
> >> +#define OMAP4430_RESTORE_MOD				0x1E00
> >> +#define OMAP4430_INSTR_MOD				0x1F00
> >
> >
> >1. In the data above, some PRCM submodules, e.g., CM1.INSTR_CM1 and 
> >   CM2.RESTORE_CM2, are either at the wrong address or are not listed, 
> >   depending on one's perspective.
> 
> I still see these are correct based on the TRM I have. Can you clarify more on what you
> see wrong here?

If you run gen_prcm44xx_h.py, you'll see that CM1.INSTR_CM1 is at a 
different offset than CM2.INSTR_CM2 and PRM.INSTR_PRM.

> >2. It would be better to infix the module name in these, e.g., 
> >   OMAP4430_CM2_INSTR_MOD (and add PRM, CM1 variants) rather than 
> >   just OMAP4430_INSTR_MOD.  This will increase the number of 
> >defines but 
> >   will decrease 
> 
> Does it really make sense in case all those are the same?
> Instead of having one define something like
> #define OMAP4430_RESTORE_MOD				0x1E00
> There would be 3 defines
> #define OMAP4430_PRM_RESTORE_MOD				0x1E00
> #define OMAP4430_CM1_RESTORE_MOD				0x1E00
> #define OMAP4430_CM2_RESTORE_MOD				0x1E00

The problem is that for some of them, like RESTORE_* and INSTR_*, the 
offsets aren't the same, and the exceptions are hard to remember.  So I 
would prefer a separate set of macros for PRM, CM1, and CM2 submodule 
offsets.  That way we don't have to remember the exceptions :-)

I'd also like to see the full names of the PRCM submodules, e.g., 

OMAP4430_CM2_RESTORE_CM2_MOD

rather than just 

OMAP4430_CM2_RESTORE_MOD

It might seem redundant, but this notation will handle those oddball PRM 
WKUP* and EMU* cases nicely.  It will be clear to whomever is reading the 
code that WKUP_CM is actually in the PRM, for example.

> >3. The autoprcm repo has a script, gen_prcm44xx.py, that 
> >auto-generates 
> >   almost all of these, without the errors described above, 
> >from Benoit's
> >   data.  Is there some reason why we can't use the output from that 
> >   script? 
> 
> I am not quite sure of Benoit's data but it most likely points to a superset
> of all OMAP4 architectures and not just whats supported/present on  OMAP4430.
> These patches are to support just 4430 and hence mostly data from whats
> mentioned in the TRM.

In this specific case, if you look at the output from the gen_prcm44xx.py 
tool, you'll see that it doesn't appear to be a problem here.  It is not a 
problem to change the script to generate "4430" rather than "44XX" also.

If there is a superset issue with the data, we should ping Benoit on that 
and maybe he can help.

>  It seems far superior to using manually-entered data.  The 
> >   source data comes directly from the hardware database, so the
> >   possibility of manual error seems lessened, and the same 
> >script should
> >   work with future OMAP4 revision.


- Paul
