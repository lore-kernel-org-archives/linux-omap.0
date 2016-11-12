From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH] mfd: twl-core: export twl_get_regmap
Date: Sat, 12 Nov 2016 13:38:13 +0200
Message-ID: <1478950693-13959-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We want to get rid of global twl_i2c_{write/read}.
As a first step, allow clients to get the regmap and write directly

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 drivers/mfd/twl-core.c  | 3 ++-
 include/linux/i2c/twl.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index c64615d..49e6a4b 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -421,7 +421,7 @@ EXPORT_SYMBOL(twl_rev);
  *
  * Returns the regmap pointer or NULL in case of failure.
  */
-static struct regmap *twl_get_regmap(u8 mod_no)
+struct regmap *twl_get_regmap(u8 mod_no)
 {
 	int sid;
 	struct twl_client *twl;
@@ -440,6 +440,7 @@ static struct regmap *twl_get_regmap(u8 mod_no)
 
 	return twl->regmap;
 }
+EXPORT_SYMBOL(twl_get_regmap);
 
 /**
  * twl_i2c_write - Writes a n bit register in TWL4030/TWL5030/TWL60X0
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 9ad7828..4c43cdb3 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -174,6 +174,8 @@ static inline int twl_class_is_ ##class(void)	\
 TWL_CLASS_IS(4030, TWL4030_CLASS_ID)
 TWL_CLASS_IS(6030, TWL6030_CLASS_ID)
 
+struct regmap *twl_get_regmap(u8 mod_no);
+
 /* Set the regcache bypass for the regmap associated with the nodule */
 int twl_set_regcache_bypass(u8 mod_no, bool enable);
 
-- 
2.5.5
