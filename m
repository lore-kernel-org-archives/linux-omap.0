From: David Cohen <david.cohen@indt.org.br>
Subject: [PATCH] McBSP dependence for DSP on ARCH_OMAP1 is missing
Date: Fri, 20 Oct 2006 16:29:58 -0400
Message-ID: <453931C6.9080209@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080102040809070507060209"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------080102040809070507060209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I've tried to compile an up-to-dated kernel tree configured for h3. I
got some errors due to the McBSP depends on OMAP_DSP if ARCH_OMAP1 is
set, as we can see at these lines from "arch/arm/plat-omap/mcbsp.c":

(...)
#ifdef CONFIG_ARCH_OMAP1
static void omap_mcbsp_dsp_request(void)
{
    if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
        omap_dsp_request_mem();

(...)
#endif
(...)

So, I've made this minimal patch to deal with this problem. It worked
well for me. But I put, also, CONFIG_OMAP_DSP=y as default on h3 config
file to keep the OMAP_MCBSP as default too.

BR,

David Cohen

--------------080102040809070507060209
Content-Type: text/plain;
 name="diff_kconfig_mcbsp_h3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff_kconfig_mcbsp_h3.patch"

Signed-off-by: David Cohen <david.cohen@indt.org.br>
---
diff --git a/arch/arm/configs/omap_h3_1710_defconfig b/arch/arm/configs/omap_h3_1710_defconfig
index bc9cb6b..6cbdbe1 100644
--- a/arch/arm/configs/omap_h3_1710_defconfig
+++ b/arch/arm/configs/omap_h3_1710_defconfig
@@ -136,7 +136,7 @@ CONFIG_OMAP_ARM_168MHZ=y
 # CONFIG_OMAP_ARM_120MHZ is not set
 # CONFIG_OMAP_ARM_60MHZ is not set
 # CONFIG_OMAP_ARM_30MHZ is not set
-# CONFIG_OMAP_DSP is not set
+CONFIG_OMAP_DSP=y
 
 #
 # Processor Type
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 2b56996..0ab87ff 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -103,7 +103,7 @@ config OMAP_STI_CONSOLE
 
 config OMAP_MCBSP
 	bool "McBSP support"
-	depends on ARCH_OMAP
+	depends on (ARCH_OMAP1 && OMAP_DSP) || ARCH_OMAP2
 	default y
 	help
 	  Say Y here if you want support for the OMAP Multichannel

--------------080102040809070507060209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080102040809070507060209--
