From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Thu, 10 Feb 2011 13:04:30 +0000
Message-ID: <20110210130430.GB3652@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <0557426516de482c1769a50fa0b5f17a@mail.gmail.com> <20110208164747.GD6188@n2100.arm.linux.org.uk> <AANLkTimGa-Y6ddHknGe9Gar7+mWPuA_T2+6VL6ecfgxD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37490 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab1BJNEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 08:04:50 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimGa-Y6ddHknGe9Gar7+mWPuA_T2+6VL6ecfgxD@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 09, 2011 at 10:01:33AM +0000, Catalin Marinas wrote:
> Could we make the domains usage a run-time feature based on the
> architecture version? For ARMv7, we need to have the vectors page
> read-only anyway if the SWP emulation is enabled (and I posted a
> simple patch in a reply to your email).
> 
> The issue I see is that ARM11MPCore is reported as v7 though we still
> use domains on this processor (we could always remove the domains if
> TLS register is available or use some more precise architecture
> version identification).

We could also do the below, which I think is more logical - SWP emulation
requires that CPU domains aren't enabled, so let's make that explicit
in the Kconfig.

 arch/arm/mm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c9d2d56..7ea482b 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -644,7 +644,7 @@ config ARM_THUMBEE
 
 config SWP_EMULATE
 	bool "Emulate SWP/SWPB instructions"
-	depends on CPU_V7 && !CPU_V6
+	depends on !CPU_USE_DOMAINS && CPU_V7 && !CPU_V6
 	select HAVE_PROC_CPU if PROC_FS
 	default y if SMP
 	help

