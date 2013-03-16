From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 6/8] memory: emif: Fix the incorrect 'size' parameter in memcpy
Date: Sat, 16 Mar 2013 11:46:46 +0530
Message-ID: <1363414608-7448-7-git-send-email-lokeshvutla@ti.com>
References: <1363414608-7448-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363414608-7448-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lokeshvutla@ti.com, Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>

The issue was that only the first timings table was added to the
emif platform data at the emif driver registration. All other
timings tables was filled with zeros. Now all emif timings table
are added to the platform data.

Signed-off-by: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Changes since V1: Updated $subject

 drivers/memory/emif.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 8db74e4..d27111e 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1468,7 +1468,7 @@ static struct emif_data *__init_or_module get_device_details(
 	if (pd->timings) {
 		temp = devm_kzalloc(dev, size, GFP_KERNEL);
 		if (temp) {
-			memcpy(temp, pd->timings, sizeof(*pd->timings));
+			memcpy(temp, pd->timings, size);
 			pd->timings = temp;
 		} else {
 			dev_warn(dev, "%s:%d: allocation error\n", __func__,
-- 
1.7.9.5
