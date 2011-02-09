From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Wed, 9 Feb 2011 16:44:41 +0000
Message-ID: <20110209164441.GA18994@n2100.arm.linux.org.uk>
References: <0557426516de482c1769a50fa0b5f17a@mail.gmail.com> <20110208164747.GD6188@n2100.arm.linux.org.uk> <78d0134576ace6be5874871076cf0c10@mail.gmail.com> <alpine.LFD.2.00.1102081537010.14920@xanadu.home> <20110209003537.GQ20795@atomide.com> <54f225541194205f01fe9f03b5110d16@mail.gmail.com> <AANLkTin2zB32YVPZkr48gSOjm0N-WDnZFScysKC8ZTiv@mail.gmail.com> <80a27c86473cf29a9fa5e68aa29eef46@mail.gmail.com> <20110209162421.GU20795@atomide.com> <20110209163204.GB11460@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34901 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab1BIQo7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 11:44:59 -0500
Content-Disposition: inline
In-Reply-To: <20110209163204.GB11460@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Dave Martin <dave.martin@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 09, 2011 at 04:32:04PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 09, 2011 at 08:24:21AM -0800, Tony Lindgren wrote:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [110209 01:59]:
> > > > From: Dave Martin [mailto:dave.martin@linaro.org]
> > > >
> > > > You could also have a "v7+" unified kernel -- i.e., supporting
> > > > OMAP3+4+SMP.
> > > > This is what we currently do in Linaro, since we're focusing on v7
> > > > and above.
> > > >
> > > This sounds good way forward considering future OMAP architectures
> > > as well.
> > > 
> > > But I let Tony comment on this idea.
> > 
> > AFAIK these issues will be hopefully sorted out by the time the
> > next merge window opens. For the -rc cycle, disabling SMP in
> > config if ARMv6 is selected should do the trick.
> 
> That's not soo easy - as we don't know in the Kconfig whether we include
> ARMv6 rather than ARMv6K.  It's exactly the same problem I ran into which
> inflated the v6v7 patchset.
> 
> Maybe the best thing to do is:
> 
> config CPU_32v6K
>         bool "Support ARM V6K processor extensions" if !SMP
>         depends on CPU_V6 || CPU_V7
>         default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
> 
> drop the ' && !(ARCH_MX3 || ARCH_OMAP2)' and just let people run into the
> resulting undefined instruction traps if they try to run the kernel on
> V6 non-K hardware.  Not ideal, but I don't see any other 'simple' solution
> to this.

Right, this is what I propose.  Merging this will cause conflicts with
the v6v7 patchset.

8<-----
Subject: [PATCH] ARM: Avoid building unsafe kernels on OMAP2 and MX3

OMAP2 (armv6) and MX3 turn off support for the V6K instructions, which
when they include support for SMP kernels means that the resulting
kernel is unsafe on SMP and can result in corrupted filesystems as we
end up using unsafe bitops.

Re-enable the use of V6K instructions on such kernels, and let such
kernels running on V6 CPUs eat undefined instruction faults which will
be much safer than filesystem corruption.  Next merge window we can fix
this properly (as it requires a much bigger set of changes.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9d30c6f..c9d2d56 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -405,7 +405,7 @@ config CPU_V6
 config CPU_32v6K
 	bool "Support ARM V6K processor extensions" if !SMP
 	depends on CPU_V6 || CPU_V7
-	default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
+	default y if SMP
 	help
 	  Say Y here if your ARMv6 processor supports the 'K' extension.
 	  This enables the kernel to use some instructions not present
@@ -416,7 +416,7 @@ config CPU_32v6K
 # ARMv7
 config CPU_V7
 	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
-	select CPU_32v6K if !ARCH_OMAP2
+	select CPU_32v6K
 	select CPU_32v7
 	select CPU_ABRT_EV7
 	select CPU_PABRT_V7
-- 
1.6.2.5


