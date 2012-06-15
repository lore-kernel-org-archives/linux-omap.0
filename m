From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: OMAP2: twl-common: Fix compiler warning
Date: Fri, 15 Jun 2012 16:33:54 +0300
Message-ID: <1339767234-25323-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:47550 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750751Ab2FONdp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jun 2012 09:33:45 -0400
Received: by lahg1 with SMTP id g1so2090525lah.2
        for <linux-omap@vger.kernel.org>; Fri, 15 Jun 2012 06:33:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

If the kernel is built only for OMAP2 the following warning will show u=
p:

arch/arm/mach-omap2/twl-common.c:52: warning: =E2=80=98twl_set_voltage=E2=
=80=99 defined but not used
arch/arm/mach-omap2/twl-common.c:58: warning: =E2=80=98twl_get_voltage=E2=
=80=99 defined but not used

The twl_set/get_voltage callbacks only used when OMAP3/4 is selected.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl=
-common.c
index 119d5a9..5447c13 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -48,6 +48,7 @@ static struct i2c_board_info __initdata omap4_i2c1_bo=
ard_info[] =3D {
 	},
 };
=20
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static int twl_set_voltage(void *data, int target_uV)
 {
 	struct voltagedomain *voltdm =3D (struct voltagedomain *)data;
@@ -59,6 +60,7 @@ static int twl_get_voltage(void *data)
 	struct voltagedomain *voltdm =3D (struct voltagedomain *)data;
 	return voltdm_get_voltage(voltdm);
 }
+#endif
=20
 void __init omap_pmic_init(int bus, u32 clkrate,
 			   const char *pmic_type, int pmic_irq,
--=20
1.7.8.6

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
