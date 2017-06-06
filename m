From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] regulator: lp87565: Fix the GPL header
Date: Tue, 6 Jun 2017 14:35:02 +0530
Message-ID: <1496739902-9393-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Fix the GPL header to reflect GPL v2

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/regulator/lp87565-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 71e7622..6d92c3f 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -5,8 +5,7 @@
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
+ *  Free Software Foundation version 2. 
  */
 
 #include <linux/module.h>
-- 
1.9.1
