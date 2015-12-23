From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 2/6] regulator: lp872x: Get rid of duplicate reference to DVS
 GPIO
Date: Wed, 23 Dec 2015 11:58:35 +0100
Message-ID: <1450868319-20513-3-git-send-email-contact@paulk.fr>
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

The lp872x structure holds a reference to the DVS GPIO, but it is never actually
used anywhere, since a first reference exists from the lp872x_dvs structure.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/regulator/lp872x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index 9412353..19d7584 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -108,7 +108,6 @@ struct lp872x {
 	struct lp872x_platform_data *pdata;
 	int num_regulators;
 	enum lp872x_dvs_state dvs_pin;
-	int dvs_gpio;
 };
 
 /* LP8720/LP8725 shared voltage table for LDOs */
@@ -752,7 +751,6 @@ static int lp872x_init_dvs(struct lp872x *lp)
 	}
 
 	lp->dvs_pin = pinstate;
-	lp->dvs_gpio = gpio;
 
 	return 0;
 
-- 
1.9.1
