From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: [PATCH 1/4] PalmZ71 - OMAP310 Clocks
Date: Tue, 24 Oct 2006 17:19:59 +0200
Message-ID: <200610241719.59561.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_f8iPF7vPh8LptHZ"
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

--Boundary-00=_f8iPF7vPh8LptHZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
this patch enables some clock on omap310.

--Boundary-00=_f8iPF7vPh8LptHZ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="clock-omap310.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="clock-omap310.patch"

diff -Naur linux-omap/arch/arm/mach-omap1/clock.h linux-omap-z71/arch/arm/mach-omap1/clock.h
--- linux-omap/arch/arm/mach-omap1/clock.h	2006-10-15 16:09:10.000000000 +0200
+++ linux-omap-z71/arch/arm/mach-omap1/clock.h	2006-10-20 21:56:49.000000000 +0200
@@ -282,7 +282,7 @@
 static struct clk dsp_ck = {
 	.name		= "dsp_ck",
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL,
 	.enable_reg	= (void __iomem *)ARM_CKCTL,
 	.enable_bit	= EN_DSPCK,
@@ -295,7 +295,7 @@
 static struct clk dspmmu_ck = {
 	.name		= "dspmmu_ck",
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL | ALWAYS_ENABLED,
 	.rate_offset	= CKCTL_DSPMMUDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
@@ -306,7 +306,7 @@
 static struct clk dspper_ck = {
 	.name		= "dspper_ck",
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL | VIRTUAL_IO_ADDRESS,
 	.enable_reg	= (void __iomem *)DSP_IDLECT2,
 	.enable_bit	= EN_PERCK,
@@ -320,7 +320,7 @@
 static struct clk dspxor_ck = {
 	.name		= "dspxor_ck",
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  VIRTUAL_IO_ADDRESS,
 	.enable_reg	= (void __iomem *)DSP_IDLECT2,
 	.enable_bit	= EN_XORPCK,
@@ -332,7 +332,7 @@
 static struct clk dsptim_ck = {
 	.name		= "dsptim_ck",
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  VIRTUAL_IO_ADDRESS,
 	.enable_reg	= (void __iomem *)DSP_IDLECT2,
 	.enable_bit	= EN_DSPTIMCK,
@@ -374,7 +374,7 @@
 
 static struct clk tipb_ck = {
 	/* No-idle controlled by "tc_ck" */
-	.name		= "tibp_ck",
+	.name		= "tipb_ck",
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 			  ALWAYS_ENABLED,
@@ -733,7 +733,7 @@
 static struct clk i2c_fck = {
 	.name		= "i2c_fck",
 	.id		= 1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  VIRTUAL_CLOCK | CLOCK_NO_IDLE_PARENT |
 			  ALWAYS_ENABLED,
 	.parent		= &armxor_ck.clk,

--Boundary-00=_f8iPF7vPh8LptHZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_f8iPF7vPh8LptHZ--
