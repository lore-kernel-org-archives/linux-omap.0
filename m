From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] regulator: Fix return type of of_map_mode()
Date: Tue, 17 Apr 2018 10:12:04 -0700
Message-ID: <20180417171204.259146-1-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: David Collins <collinsd@codeaurora.org>, evgreen@chromium.org, swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In of_get_regulation_constraints() it can clearly be seen that the
return value of of_map_mode() is assigned to a signed integer.  This
is important because the first thing the regulator core does with this
value is to compare it to -EINVAL.

Let's fix the return type of all of the current of_map_mode()
functions.  While we're at it, we'll remove one pointless "inline".

Fixes: 5e5e3a42c653 ("regulator: of: Add support for parsing initial and suspend modes")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/cpcap-regulator.c     | 2 +-
 drivers/regulator/max77802-regulator.c  | 2 +-
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 drivers/regulator/twl-regulator.c       | 2 +-
 include/linux/regulator/driver.h        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index f541b80f1b54..46eba038f8e9 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -214,7 +214,7 @@ static int cpcap_regulator_disable(struct regulator_dev *rdev)
 	return error;
 }
 
-static unsigned int cpcap_map_mode(unsigned int mode)
+static int cpcap_map_mode(unsigned int mode)
 {
 	switch (mode) {
 	case CPCAP_BIT_AUDIO_NORMAL_MODE:
diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index b6261903818c..8c6b5d2aec86 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -75,7 +75,7 @@ struct max77802_regulator_prv {
 	unsigned int opmode[MAX77802_REG_MAX];
 };
 
-static inline unsigned int max77802_map_mode(unsigned int mode)
+static inline int max77802_map_mode(unsigned int mode)
 {
 	return mode == MAX77802_OPMODE_NORMAL ?
 		REGULATOR_MODE_NORMAL : REGULATOR_MODE_STANDBY;
diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 63c7a0c17777..c83124061632 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1432,7 +1432,7 @@ static void spmi_regulator_get_dt_config(struct spmi_regulator *vreg,
 		&data->vs_soft_start_strength);
 }
 
-static unsigned int spmi_regulator_of_map_mode(unsigned int mode)
+static int spmi_regulator_of_map_mode(unsigned int mode)
 {
 	if (mode == 1)
 		return REGULATOR_MODE_NORMAL;
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index a4456db5849d..496917bfad05 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -266,7 +266,7 @@ static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
 	return twl4030_send_pb_msg(message);
 }
 
-static inline unsigned int twl4030reg_map_mode(unsigned int mode)
+static int twl4030reg_map_mode(unsigned int mode)
 {
 	switch (mode) {
 	case RES_STATE_ACTIVE:
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4fc96cb8e5d7..c98da2500c9f 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -367,7 +367,7 @@ struct regulator_desc {
 
 	unsigned int off_on_delay;
 
-	unsigned int (*of_map_mode)(unsigned int mode);
+	int (*of_map_mode)(unsigned int mode);
 };
 
 /**
-- 
2.17.0.484.g0c8726318c-goog
