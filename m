From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2] regulator: Don't return or expect -errno from of_map_mode()
Date: Tue, 17 Apr 2018 20:31:43 -0700
Message-ID: <20180418033143.208986-1-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: David Collins <collinsd@codeaurora.org>, Javier Martinez Canillas <javier@dowhile0.org>, evgreen@chromium.org, swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In of_get_regulation_constraints() we were taking the result of
of_map_mode() (an unsigned int) and assigning it to an int.  We were
then checking whether this value was -EINVAL.  Some implementers of
of_map_mode() were returning -EINVAL (even though the return type of
their function needed to be unsigned int) because they needed to to
signal an error back to of_get_regulation_constraints().

In general in the regulator framework the mode is always referred to
as an unsigned int.  While we could fix this to be a signed int (the
highest value we store in there right now is 0x8), it's actually
pretty clean to just define the regulator mode 0x0 (the lack of any
bits set) as an invalid mode.  Let's do that.

Suggested-by: Javier Martinez Canillas <javier@dowhile0.org>
Fixes: 5e5e3a42c653 ("regulator: of: Add support for parsing initial and suspend modes")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Use Javier's suggestion of defining 0x0 as invalid

 drivers/regulator/cpcap-regulator.c |  2 +-
 drivers/regulator/of_regulator.c    | 15 +++++++++------
 drivers/regulator/twl-regulator.c   |  2 +-
 include/linux/regulator/consumer.h  |  1 +
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index f541b80f1b54..bd910fe123d9 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -222,7 +222,7 @@ static unsigned int cpcap_map_mode(unsigned int mode)
 	case CPCAP_BIT_AUDIO_LOW_PWR:
 		return REGULATOR_MODE_STANDBY;
 	default:
-		return -EINVAL;
+		return REGULATOR_MODE_INVALID;
 	}
 }
 
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index f47264fa1940..22c02b7a338b 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -124,11 +124,12 @@ static void of_get_regulation_constraints(struct device_node *np,
 
 	if (!of_property_read_u32(np, "regulator-initial-mode", &pval)) {
 		if (desc && desc->of_map_mode) {
-			ret = desc->of_map_mode(pval);
-			if (ret == -EINVAL)
+			unsigned int mode = desc->of_map_mode(pval);
+
+			if (mode == REGULATOR_MODE_INVALID)
 				pr_err("%s: invalid mode %u\n", np->name, pval);
 			else
-				constraints->initial_mode = ret;
+				constraints->initial_mode = mode;
 		} else {
 			pr_warn("%s: mapping for mode %d not defined\n",
 				np->name, pval);
@@ -163,12 +164,14 @@ static void of_get_regulation_constraints(struct device_node *np,
 		if (!of_property_read_u32(suspend_np, "regulator-mode",
 					  &pval)) {
 			if (desc && desc->of_map_mode) {
-				ret = desc->of_map_mode(pval);
-				if (ret == -EINVAL)
+				unsigned int mode = desc->of_map_mode(pval);
+
+				mode = desc->of_map_mode(pval);
+				if (mode == REGULATOR_MODE_INVALID)
 					pr_err("%s: invalid mode %u\n",
 					       np->name, pval);
 				else
-					suspend_state->mode = ret;
+					suspend_state->mode = mode;
 			} else {
 				pr_warn("%s: mapping for mode %d not defined\n",
 					np->name, pval);
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index a4456db5849d..884c7505ed91 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -274,7 +274,7 @@ static inline unsigned int twl4030reg_map_mode(unsigned int mode)
 	case RES_STATE_SLEEP:
 		return REGULATOR_MODE_STANDBY;
 	default:
-		return -EINVAL;
+		return REGULATOR_MODE_INVALID;
 	}
 }
 
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index df176d7c2b87..25602afd4844 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -80,6 +80,7 @@ struct regmap;
  * These modes can be OR'ed together to make up a mask of valid register modes.
  */
 
+#define REGULATOR_MODE_INVALID			0x0
 #define REGULATOR_MODE_FAST			0x1
 #define REGULATOR_MODE_NORMAL			0x2
 #define REGULATOR_MODE_IDLE			0x4
-- 
2.17.0.484.g0c8726318c-goog
