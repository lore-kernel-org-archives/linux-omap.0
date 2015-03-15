From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] regulator: tps65910: Add missing #include <linux/of.h>
Date: Sun, 15 Mar 2015 14:03:50 +0100
Message-ID: <1426424630-9781-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-omap@vger.kernel.org

drivers/regulator/tps65910-regulator.c: In function =E2=80=98tps65910_p=
arse_dt_reg_data=E2=80=99:
drivers/regulator/tps65910-regulator.c:1018: error: implicit declaratio=
n of function =E2=80=98of_get_child_by_name=E2=80=99
drivers/regulator/tps65910-regulator.c:1018: warning: assignment makes =
pointer from integer without a cast
drivers/regulator/tps65910-regulator.c:1034: error: implicit declaratio=
n of function =E2=80=98of_node_put=E2=80=99
drivers/regulator/tps65910-regulator.c:1056: error: implicit declaratio=
n of function =E2=80=98of_property_read_u32=E2=80=99

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/regulator/tps65910-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator=
/tps65910-regulator.c
index e2cffe01b8072263..fb991ec764235d55 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
--=20
1.9.1
