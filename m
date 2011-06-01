From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 1/2] omap3: iovmm: Work around sg_alloc_table size
	limitation in IOMMU
Date: Wed, 1 Jun 2011 14:43:38 +0100
Message-ID: <20110601134338.GB6700@n2100.arm.linux.org.uk>
References: <20110601131744.GH11352@atomide.com> <1306935012-12406-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45158 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756877Ab1FANnq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 09:43:46 -0400
Content-Disposition: inline
In-Reply-To: <1306935012-12406-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jun 01, 2011 at 03:30:11PM +0200, Laurent Pinchart wrote:
> sg_alloc_table can only allocate multi-page scatter-gather list tables
> if the architecture supports scatter-gather lists chaining. ARM doesn't
> fit in that category.

Let's fix this properly, as I've said countless times and so far no one
has bothered to sort this out:

8<----
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: ARM: Allow SoCs to enable scatterlist chaining

Allow SoCs to enable the scatterlist chaining support, which allows
scatterlist tables to be broken up into smaller allocations.

As support for this feature depends on the implementation details of
the users of the scatterlists, we can't enable this globally without
auditing all the users, which is a very big task.  Instead, let SoCs
progressively switch over to using this.

SoC drivers using scatterlists and SoC DMA implementations need
auditing before this option can be enabled for the SoC.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                   |    3 +++
 arch/arm/include/asm/scatterlist.h |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..cc0dcbf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -37,6 +37,9 @@ config ARM
 	  Europe.  There is an ARM Linux project with a web page at
 	  <http://www.arm.linux.org.uk/>.
 
+config ARM_HAS_SG_CHAIN
+	bool
+
 config HAVE_PWM
 	bool
 
diff --git a/arch/arm/include/asm/scatterlist.h b/arch/arm/include/asm/scatterlist.h
index 2f87870..cefdb8f 100644
--- a/arch/arm/include/asm/scatterlist.h
+++ b/arch/arm/include/asm/scatterlist.h
@@ -1,6 +1,10 @@
 #ifndef _ASMARM_SCATTERLIST_H
 #define _ASMARM_SCATTERLIST_H
 
+#ifdef CONFIG_ARM_HAS_SG_CHAIN
+#define ARCH_HAS_SG_CHAIN
+#endif
+
 #include <asm/memory.h>
 #include <asm/types.h>
 #include <asm-generic/scatterlist.h>

