From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] Input: palmas-pwrbutton: Fix typo in License
Date: Mon, 15 Sep 2014 12:58:57 -0500
Message-ID: <1410803937-27022-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-omap@vger.kernel.org

Follow the license string convention indicated in include/linux/module.h
(don't capitalize v).

This fixes following randconfig warning:
FATAL: modpost: GPL-incompatible module palmas-pwrbutton.ko uses GPL-only symbol 'platform_driver_unregister'

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Jim Davis <jim.epost@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Reported thread http://marc.info/?l=linux-input&m=141080223209150&w=2

 drivers/input/misc/palmas-pwrbutton.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
index 3f90211..4ed6f78 100644
--- a/drivers/input/misc/palmas-pwrbutton.c
+++ b/drivers/input/misc/palmas-pwrbutton.c
@@ -326,5 +326,5 @@ module_platform_driver(palmas_pwron_driver);
 
 MODULE_ALIAS("platform:palmas-pwrbutton");
 MODULE_DESCRIPTION("Palmas Power Button");
-MODULE_LICENSE("GPL V2");
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Texas Instruments Inc.");
-- 
1.7.9.5

