From: Colin King <colin.king@canonical.com>
Subject: [PATCH] pinctrl: single: make two arrays static const, reduces object code size
Date: Tue, 19 Sep 2017 15:42:18 +0100
Message-ID: <20170919144218.23607-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the read-only arrays prop2 and prop4 on the stack, instead
make them static const.  Makes the object code smaller by over 230 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  28235	   5820	    192	  34247	   85c7	drivers/pinctrl/pinctrl-single.o

After:
   text	   data	    bss	    dec	    hex	filename
  27839	   5980	    192	  34011	   84db	drivers/pinctrl/pinctrl-single.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/pinctrl-single.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index b8b3d932cd73..e6cd8de793e2 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -873,13 +873,13 @@ static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
 	int i = 0, nconfs = 0;
 	unsigned long *settings = NULL, *s = NULL;
 	struct pcs_conf_vals *conf = NULL;
-	struct pcs_conf_type prop2[] = {
+	static const struct pcs_conf_type prop2[] = {
 		{ "pinctrl-single,drive-strength", PIN_CONFIG_DRIVE_STRENGTH, },
 		{ "pinctrl-single,slew-rate", PIN_CONFIG_SLEW_RATE, },
 		{ "pinctrl-single,input-schmitt", PIN_CONFIG_INPUT_SCHMITT, },
 		{ "pinctrl-single,low-power-mode", PIN_CONFIG_LOW_POWER_MODE, },
 	};
-	struct pcs_conf_type prop4[] = {
+	static const struct pcs_conf_type prop4[] = {
 		{ "pinctrl-single,bias-pullup", PIN_CONFIG_BIAS_PULL_UP, },
 		{ "pinctrl-single,bias-pulldown", PIN_CONFIG_BIAS_PULL_DOWN, },
 		{ "pinctrl-single,input-schmitt-enable",
-- 
2.14.1

