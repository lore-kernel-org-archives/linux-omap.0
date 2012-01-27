From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: [RFC 1/1] omap3: PM: MPU and CORE should stay awake if there is CAM domain ACTIVE
Date: Fri, 27 Jan 2012 12:00:01 +0200
Message-ID: <1327658401-28441-1-git-send-email-sakari.ailus@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:16580 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403Ab2A0KAK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jan 2012 05:00:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com, khilman@ti.com

MPU and CORE should stay awake if there is CAM domain ACTIVE. This is
because that module doesn't have wake-up capability.

The original patch was written by Jouni H=F6gander in 2008 and this is =
the
last part left of it which is not in upstream yet.

I wonder if the approach taken in the patch is valid these days;
nevertheless it seems to do the job...

Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
---
 arch/arm/mach-omap2/pm34xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index fc69875..4ef682d 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -295,6 +295,9 @@ void omap_sram_idle(void)
 	pwrdm_clear_all_prev_pwrst(core_pwrdm);
 	pwrdm_clear_all_prev_pwrst(per_pwrdm);
=20
+	if (pwrdm_read_pwrst(cam_pwrdm) =3D=3D PWRDM_POWER_ON)
+		clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
+
 	mpu_next_state =3D pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
 	case PWRDM_POWER_ON:
--=20
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
