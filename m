From: =?UTF-8?q?Andreas=20M=C3=BCller?= <schnitzeltony@googlemail.com>
Subject: [PATCH] board-overo.c: enable TWL4030 power off
Date: Thu, 28 Feb 2013 13:44:21 +0100
Message-ID: <1362055461-27154-1-git-send-email-schnitzeltony@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:42937 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab3B1MqY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Feb 2013 07:46:24 -0500
Received: by mail-ee0-f53.google.com with SMTP id e53so1401925eek.26
        for <linux-omap@vger.kernel.org>; Thu, 28 Feb 2013 04:46:23 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: steve@sakoman.com

Signed-off-by: Andreas M=C3=BCller <schnitzeltony@googlemail.com>
---
 arch/arm/mach-omap2/board-overo.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/bo=
ard-overo.c
index 86bab51..b975c72 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -418,9 +418,14 @@ static struct regulator_init_data overo_vmmc1 =3D =
{
 	.consumer_supplies	=3D overo_vmmc1_supply,
 };
=20
+static struct twl4030_power_data overo_power_data =3D {
+	.use_poweroff	=3D true,
+};
+
 static struct twl4030_platform_data overo_twldata =3D {
 	.gpio		=3D &overo_gpio_data,
 	.vmmc1		=3D &overo_vmmc1,
+	.power		=3D &overo_power_data,
 };
=20
 static int __init overo_i2c_init(void)
--=20
1.7.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
