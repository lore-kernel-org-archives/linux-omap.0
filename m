From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 14/17 4/4] mfd: tps65910: Move an assignment in
 tps65910_sleepinit()
Date: Fri, 9 Mar 2018 17:42:20 +0100
Message-ID: <eb3c38d5-23c3-dcf0-3772-66b917326f0a@users.sourceforge.net>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 9 Mar 2018 09:19:42 +0100

Move the assignment for the local variable "dev" so that its setting
will be performed after a configuration check by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/tps65910.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 7e7d3d1642c6..bf16cbe6fd88 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -315,11 +315,11 @@ static int tps65910_sleepinit(struct tps65910 *tps65910,
 	struct device *dev;
 	int ret;
 
-	dev = tps65910->dev;
-
 	if (!pmic_pdata->en_dev_slp)
 		return 0;
 
+	dev = tps65910->dev;
+
 	/* enabling SLEEP device state */
 	ret = tps65910_reg_set_bits(tps65910, TPS65910_DEVCTRL,
 				DEVCTRL_DEV_SLP_MASK);
-- 
2.16.2
