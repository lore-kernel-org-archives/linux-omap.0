From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 3/6] regulator: lp872x: Remove warning about invalid DVS GPIO
Date: Wed, 23 Dec 2015 11:58:36 +0100
Message-ID: <1450868319-20513-4-git-send-email-contact@paulk.fr>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1450868319-20513-1-git-send-email-contact@paulk.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Kocialkowski <contact@paulk.fr>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Some devices don't hook the DVS pin to a GPIO but to ground or VCC.
In those cases, it is not a problem to have no DVS GPIO.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/regulator/lp872x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index 19d7584..21c49d8 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -738,10 +738,8 @@ static int lp872x_init_dvs(struct lp872x *lp)
 		goto set_default_dvs_mode;
 
 	gpio = dvs->gpio;
-	if (!gpio_is_valid(gpio)) {
-		dev_warn(lp->dev, "invalid gpio: %d\n", gpio);
+	if (!gpio_is_valid(gpio))
 		goto set_default_dvs_mode;
-	}
 
 	pinstate = dvs->init_state;
 	ret = devm_gpio_request_one(lp->dev, gpio, pinstate, "LP872X DVS");
-- 
1.9.1
