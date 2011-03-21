From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [RFC 1/3] OMAP3: PRM: Add grpsel programming support
Date: Mon, 21 Mar 2011 18:38:08 +0530
Message-ID: <8d652600271cbddb947c472553b9d8cb@mail.gmail.com>
References: <1300705823-12784-1-git-send-email-rnayak@ti.com> <1300705823-12784-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:56954 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753068Ab1CUNIS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 09:08:18 -0400
Received: by yie30 with SMTP id 30so2904994yie.37
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 06:08:11 -0700 (PDT)
In-Reply-To: <1300705823-12784-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org
Cc: paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rajendra Nayak
>Sent: Monday, March 21, 2011 4:40 PM
>To: linux-omap@vger.kernel.org
>Cc: paul@pwsan.com; b-cousson@ti.com; Rajendra Nayak
>Subject: [RFC 1/3] OMAP3: PRM: Add grpsel programming support
>
>Add api's to support programming the
>PM_<processor>GRPSEL_<domain> registers which are
>needed for proper peripheral wakeup configuration.
>
>Also add unique identifiers for all initiators.
>
>Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>---
> arch/arm/mach-omap2/prcm-common.h            |    1 -
> arch/arm/mach-omap2/prm2xxx_3xxx.c           |   70
>++++++++++++++++++++++++++
> arch/arm/mach-omap2/prm2xxx_3xxx.h           |    4 ++
> arch/arm/plat-omap/include/plat/omap_hwmod.h |    7 +++
> 4 files changed, 81 insertions(+), 1 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/prcm-common.h
>b/arch/arm/mach-omap2/prcm-common.h
>index 0363dcb..be6b3c2 100644
>--- a/arch/arm/mach-omap2/prcm-common.h
>+++ b/arch/arm/mach-omap2/prcm-common.h
>@@ -397,7 +397,6 @@
> #define OMAP3430_EN_CORE_SHIFT				0
> #define OMAP3430_EN_CORE_MASK				(1 << 0)
>
>-
Stray change...

> /*
>  * MAX_MODULE_HARDRESET_WAIT: Maximum microseconds to wait for an OMAP
>  * submodule to exit hardreset
>diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c
>b/arch/arm/mach-omap2/prm2xxx_3xxx.c
>index 051213f..77aade2 100644
>--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
>+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
>@@ -19,11 +19,21 @@
> #include <plat/common.h>
> #include <plat/cpu.h>
> #include <plat/prcm.h>
>+#include <plat/omap_hwmod.h>
>
> #include "prm2xxx_3xxx.h"
> #include "cm2xxx_3xxx.h"
> #include "prm-regbits-24xx.h"
> #include "prm-regbits-34xx.h"
>+#include "prm2xxx_3xxx.h"
>+
>+static const u8 prm_mpugrpsel_offs[] = {
>+	OMAP3430_PM_MPUGRPSEL1, 0, OMAP3430ES2_PM_MPUGRPSEL3,
>+};
>+
>+static const u8 prm_ivagrpsel_offs[] = {
>+	OMAP3430_PM_IVAGRPSEL1, 0, OMAP3430ES2_PM_IVAGRPSEL3,
>+};
>
> u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
> {
>@@ -156,3 +166,63 @@ int omap2_prm_deassert_hardreset(s16
>prm_mod, u8 rst_shift, u8 st_shift)
>
> 	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
> }
>+
>+static int _get_initiator_grpsel(u8 grpsel_id, u8 initiator_id,
>+							u8
>*prm_grpsel_reg)
>+{
>+	switch (initiator_id) {
>+	case OMAP_INIT_MPU:
>+		if (grpsel_id > ARRAY_SIZE(prm_mpugrpsel_offs))
>+			return -EINVAL;
>+		*prm_grpsel_reg = prm_mpugrpsel_offs[grpsel_id - 1];
>+		break;
>+	case OMAP_INIT_IVA:
>+		if (grpsel_id > ARRAY_SIZE(prm_ivagrpsel_offs))
>+			return -EINVAL;
>+		*prm_grpsel_reg = prm_ivagrpsel_offs[grpsel_id - 1];
>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+	return 0;
>+}
>+
>+int omap2_prm_module_enable_initiator_wakeup(s16 prcm_mod, u8
>grpsel_id,
>+					 u8 grpsel_shift, u8
>initiator_id)
>+{
>+	u8 prm_grpsel_reg;
>+	u32 mask;
>+	int ret;
>+
>+	if (!grpsel_id || !cpu_is_omap34xx())
>+		return -EINVAL;
>+
>+	mask = 1 << grpsel_shift;
>+
>+	ret = _get_initiator_grpsel(grpsel_id, initiator_id,
>&prm_grpsel_reg);
>+	if (ret)
>+		return ret;
>+
>+	omap2_prm_set_mod_reg_bits(mask, prcm_mod, prm_grpsel_reg);
>+	return 0;
>+}
>+
>+int omap2_prm_module_disable_initiator_wakeup(s16 prcm_mod,
>u8 grpsel_id,
>+					u8 grpsel_shift, u8
>initiator_id)
>+{
>+	u8 prm_grpsel_reg;
>+	u32 mask;
>+	int ret;
>+
>+	if (!grpsel_id || !cpu_is_omap34xx())
>+		return -EINVAL;
>+
>+	mask = 1 << grpsel_shift;
>+
>+	ret = _get_initiator_grpsel(grpsel_id, initiator_id,
>&prm_grpsel_reg);
>+	if (ret)
>+		return ret;
>+
>+	omap2_prm_clear_mod_reg_bits(mask, prcm_mod, prm_grpsel_reg);
>+	return 0;
>+}
>diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h
>b/arch/arm/mach-omap2/prm2xxx_3xxx.h
>index a1fc62a..08ae2b9 100644
>--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
>+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
>@@ -302,6 +302,10 @@ extern u32
>omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
> extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
> extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
> extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8
>rst_shift, u8 st_shift);
>+extern int omap2_prm_module_enable_initiator_wakeup(s16
>module, u8 grpsel_id,
>+					u8 shift, u8 init_id);
>+extern int omap2_prm_module_disable_initiator_wakeup(s16
>module, u8 grpsel_id,
>+					u8 shift, u8 init_id);
>
> #endif	/* CONFIG_ARCH_OMAP4 */
> #endif
>diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>index 1adea9c..4bd7354 100644
>--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>@@ -431,6 +431,13 @@ struct omap_hwmod_omap4_prcm {
> #define _HWMOD_STATE_IDLE			5
> #define _HWMOD_STATE_DISABLED			6
>
>+/* Unique initiator identifiers */
>+#define OMAP_INIT_MPU				1
>+#define OMAP_INIT_IVA				2
>+#define OMAP_INIT_DSP				3
>+#define OMAP_INIT_MPU_M3			4
>+#define OMAP_INIT_SDMA				5
>+
> /**
>  * struct omap_hwmod_class - the type of an IP block
>  * @name: name of the hwmod_class
>--
>1.7.0.4
>
>--
>To unsubscribe from this list: send the line "unsubscribe
>linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
