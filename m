From: "Elaidi, Djamil" <d-elaidi@ti.com>
Subject: RE: [PATCH 2/6] ARM: OMAP4 PM: Add IO Daisychain support
Date: Thu, 23 Feb 2012 15:58:44 +0000
Message-ID: <5672BD13E82B844A93BB4597F293F19A0B3F41AF@DNCE02.ent.ti.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
 <1330003320-17400-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60436 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab2BWP7B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 10:59:01 -0500
In-Reply-To: <1330003320-17400-3-git-send-email-t-kristo@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kristo, Tero" <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Hi Kristo,

I think you must also add a omap_test_timeout() check after the Trigger=
 WUCLKIN disable, to verify WUCLK_STATUS has come back to 0.
This is needed because the IO daisy chain will not be ready until the W=
UCLKIN falling edge has propagated.

+       /* Trigger WUCLKIN disable */
+       omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, 0x0,
+                       OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_O=
=46FSET);
+       return;
+       omap_test_timeout(
+               (((omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+                       OMAP4_PRM_IO_PMCTRL_OFFSET) &
+                       OMAP4430_WUCLK_STATUS_MASK) >>
+                       OMAP4430_WUCLK_STATUS_SHIFT) =3D=3D 0),
+               MAX_IOPAD_LATCH_TIME, i);


Best regards
Djamil ELA=CFDI
+33 4 97 27 50 97
Software Systems Engineer
OMAP Platform Business Unit - PSI Modem Integration
Texas Instruments


Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Lo=
ubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----
=46rom: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.=
kernel.org] On Behalf Of Kristo, Tero
Sent: jeudi 23 f=E9vrier 2012 14:22
To: linux-omap@vger.kernel.org; Hilman, Kevin
Cc: linux-arm-kernel@lists.infradead.org; Nayak, Rajendra; Sripathy, Vi=
shwanath
Subject: [PATCH 2/6] ARM: OMAP4 PM: Add IO Daisychain support

=46rom: Rajendra Nayak <rnayak@ti.com>

patch adds IO Daisychain support for OMAP4 as per section 3.9.4 in OMAP=
4430
Public TRM.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |   32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h |    1 +
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44x=
x.c
index 33dd655..1557647 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -230,6 +230,41 @@ void omap44xx_prm_restore_irqen(u32 *saved_mask)
                                 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
 }

+/**
+ * Maximum time(us) it takes to output the signal WUCLKOUT of the last=
 pad of
+ * the I/O ring after asserting WUCLKIN high
+ */
+#define MAX_IOPAD_LATCH_TIME 1000
+
+/* OMAP4 IO Daisychain trigger sequence */
+void omap4_trigger_wuclk_ctrl(void)
+{
+       int i =3D 0;
+
+       /* Enable GLOBAL_WUEN */
+       if (!(omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+               OMAP4_PRM_IO_PMCTRL_OFFSET) & OMAP4430_GLOBAL_WUEN_MASK=
))
+               omap4_prm_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
+                       OMAP4430_GLOBAL_WUEN_MASK, OMAP4430_PRM_DEVICE_=
INST,
+                       OMAP4_PRM_IO_PMCTRL_OFFSET);
+
+       /* Trigger WUCLKIN enable */
+       omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK,
+                       OMAP4430_WUCLK_CTRL_MASK, OMAP4430_PRM_DEVICE_I=
NST,
+                       OMAP4_PRM_IO_PMCTRL_OFFSET);
+       omap_test_timeout(
+               (((omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+                       OMAP4_PRM_IO_PMCTRL_OFFSET) &
+                       OMAP4430_WUCLK_STATUS_MASK) >>
+                       OMAP4430_WUCLK_STATUS_SHIFT) =3D=3D 1),
+               MAX_IOPAD_LATCH_TIME, i);
+
+       /* Trigger WUCLKIN disable */
+       omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, 0x0,
+                       OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_O=
=46FSET);
+       return;
+}
+
 static int __init omap4xxx_prcm_init(void)
 {
        if (cpu_is_omap44xx())
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44x=
x.h
index 7978092..a840f0f 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -762,6 +762,7 @@ void omap4_prm_vp_clear_txdone(u8 vp_id);
 extern u32 omap4_prm_vcvp_read(u8 offset);
 extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
+extern void omap4_trigger_wuclk_ctrl(void);

 /* PRM interrupt-related functions */
 extern void omap44xx_prm_read_pending_irqs(unsigned long *events);
--
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
