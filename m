From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 6/9] mfd: palmas: shift the palmas_sleep_requestor_info structure definition to the header file
Date: Wed, 18 Jun 2014 15:28:57 +0530
Message-ID: <1403085540-20014-7-git-send-email-j-keerthy@ti.com>
References: <1403085540-20014-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403085540-20014-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

shift the palmas_sleep_requestor_info structure definition to the header file.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/mfd/palmas.c       |   10 ----------
 include/linux/mfd/palmas.h |   10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 6e17861..c12759d 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -25,16 +25,6 @@
 #include <linux/mfd/palmas.h>
 #include <linux/of_device.h>
 
-#define PALMAS_EXT_REQ (PALMAS_EXT_CONTROL_ENABLE1 |	\
-			PALMAS_EXT_CONTROL_ENABLE2 |	\
-			PALMAS_EXT_CONTROL_NSLEEP)
-
-struct palmas_sleep_requestor_info {
-	int id;
-	int reg_offset;
-	int bit_pos;
-};
-
 #define EXTERNAL_REQUESTOR(_id, _offset, _pos)		\
 	[PALMAS_EXTERNAL_REQSTR_ID_##_id] = {		\
 		.id = PALMAS_EXTERNAL_REQSTR_ID_##_id,	\
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index c123666..0136e58 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -88,6 +88,16 @@ struct palmas {
 	u8 pwm_muxed;
 };
 
+#define PALMAS_EXT_REQ (PALMAS_EXT_CONTROL_ENABLE1 |	\
+			PALMAS_EXT_CONTROL_ENABLE2 |	\
+			PALMAS_EXT_CONTROL_NSLEEP)
+
+struct palmas_sleep_requestor_info {
+	int id;
+	int reg_offset;
+	int bit_pos;
+};
+
 struct regs_info {
 	char	*name;
 	char	*sname;
-- 
1.7.9.5
