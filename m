From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: More randconfig fixes for reconfigure_io_chain
Date: Mon, 18 Nov 2013 11:03:23 -0800
Message-ID: <20131118190322.GT10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Commit 26273e02a0cf (ARM: OMAP2+: Fix build for dra7xx without
omap4 and 5) attempted to fix randconfig found errors for
redefinition of omap44xx_prm_reconfigure_io_chain, but was
not enough.

We need to check for AM43XX without any omap4 or 5 related
SoCs as well. And looks like we have prm44xx.o built always
anyways with omap-4-5-prcm-common because of the calls to
omap4_prm_vp_clear_txdone, so we can remove the duplicate
entries in the Makefile.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -19,11 +19,11 @@ secure-common				= omap-smc.o omap-secure.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
-obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
+obj-$(CONFIG_ARCH_OMAP4) += $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_AM33XX) += irq.o $(hwmod-common)
-obj-$(CONFIG_SOC_OMAP5)	 += prm44xx.o $(hwmod-common) $(secure-common)
+obj-$(CONFIG_SOC_OMAP5)	 += $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_AM43XX) += $(hwmod-common) $(secure-common)
-obj-$(CONFIG_SOC_DRA7XX) += prm44xx.o $(hwmod-common) $(secure-common)
+obj-$(CONFIG_SOC_DRA7XX) += $(hwmod-common) $(secure-common)
 
 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y += mcbsp.o
--- a/arch/arm/mach-omap2/prm44xx_54xx.h
+++ b/arch/arm/mach-omap2/prm44xx_54xx.h
@@ -43,7 +43,7 @@ extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
-	defined(CONFIG_SOC_DRA7XX)
+	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
 void omap44xx_prm_reconfigure_io_chain(void);
 #else
 static inline void omap44xx_prm_reconfigure_io_chain(void)
