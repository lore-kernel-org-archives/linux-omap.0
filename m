From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/6] ARM: OMAP4: PM: Adds PRM register shift and mask
 bits
Date: Thu, 13 Aug 2009 07:33:22 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908130718380.28219@utopia.booyaka.com>
References: <1250087254-28653-1-git-send-email-rnayak@ti.com> <1250087254-28653-2-git-send-email-rnayak@ti.com> <1250087254-28653-3-git-send-email-rnayak@ti.com> <1250087254-28653-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48372 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391AbZHMNdV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 09:33:21 -0400
In-Reply-To: <1250087254-28653-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


Hello Rajendra,

(These comments apply to your patches 4 through 6.)

First, a couple of general comments:

1. These should be redone using a generator script and Benoit's
   hardware data.  This will reduce the maintainer load to review
   future versions of this file as the hardware is revised.

2. To continue on the topic of redundancy from our earlier messages:
   in these patches, there is quite a lot of it in both register
   addresses and bit definitions.  See for example the WKUPDEP
   register bits (SDMA, TESLA, MPU, etc).  The initiators are repeated
   over and over again.

   Same with some of the register addresses.  CLKCTRL, DYNAMICDEP,
   STATICDEP, for example, are often repeated.  At least for the
   register addresses, what is your opinion about using a multi-level
   macro to separate these out, and reduce the number of definitions,
   as is done in the output of experimental_gen_prm44xx_h.py, for
   example?  Then to use an addressing macro that would take multiple
   arguments, something like what is described in the autogen file
   kernel-templates/mach-omap2/cm_prefix.h ?


Then, a few specific comments:

1. Please add _MASK at the end of all single-bit defines.  This
   is so there is no ambiguity as to whether a macro is a shift
   count or a bitmask.  So, for example,

+#define OMAP4430_MEMIF_STATDEP                 (1 << 4)

should be
   
+#define OMAP4430_MEMIF_STATDEP_MASK            (1 << 4)

   This is something that should have been done with the earliest
   OMAP2/3 macros.  We are slowly converting the ones that don't
   follow this pattern.  


2. The register bit defines should be organized by register and
   each group should be separated with a blank line and comment
   with the register name.  This is the way it was done in the
   existing mach-omap2/*regbits*.h files.  This makes the files
   much more readable.  Here is an example from OMAP3:

/* PM_PWSTCTRL_CORE specific bits */
#define OMAP3430_MEM2ONSTATE_SHIFT                      18
#define OMAP3430_MEM2ONSTATE_MASK                       (0x3 << 18)
#define OMAP3430_MEM1ONSTATE_SHIFT                      16
#define OMAP3430_MEM1ONSTATE_MASK                       (0x3 << 16)
#define OMAP3430_MEM2RETSTATE                           (1 << 9)
#define OMAP3430_MEM1RETSTATE                           (1 << 8)

/* PM_PWSTST_CORE specific bits */
#define OMAP3430_MEM2STATEST_SHIFT                      6
#define OMAP3430_MEM2STATEST_MASK                       (0x3 << 6)
#define OMAP3430_MEM1STATEST_SHIFT                      4
#define OMAP3430_MEM1STATEST_MASK                       (0x3 << 4)

   etc.  Yes, those MEM2RETSTATE, MEM1RETSTATE defines should be
   suffixed with _MASK.


3. There are duplicate macros that should be removed.  If bits are
   shared among registers, they should be moved into a "shared"
   section and marked with a comment with the registers that share
   them.  Again this is done in the previous mach-omap2/*regbits*.h
   files for OMAP2/3.  Here are some examples of duplicate macros from
   the OMAP4 data you posted:

+#define OMAP4430_DPLL_SSC_TYPE                 (1 << 15)
+#define OMAP4430_DPLL_SSC_DOWNSPREAD           (1 << 14)
+#define OMAP4430_DPLL_SSC_ACK                  (1 << 13)
+#define OMAP4430_DPLL_SSC_EN                   (1 << 12)

and


+#define OMAP4430_LOSTMEM_NONRETAINED_BANK      (1 << 8)


4. Have you checked for macro name collisions with different values?
   I have not spotted any collisions yet, but I am curious to know if
   you are testing for these.  For example, on OMAP2/3, some macro
   names, like EN_DSS, are defined with different values for different
   registers.  These were disambiguated by adding the register names.
   For example,

#define OMAP3430_PM_WKDEP_MPU_EN_DSS_MASK		(1 << 5)

...

#define OMAP3430_PM_WKEN_DSS_EN_DSS			(1 << 0)

   (Of course, this latter define should be named
   OMAP3430_PM_WKEN_DSS_EN_DSS_MASK.)


5. There are some typos:

+#define OMAP4430_LOSTMEM_PERIHPMEM_MASK                BITFIELD(8, 8)



regards,

- Paul
