From: Anton Vasilyev <vasilyev@ispras.ru>
Subject: [PATCH] regulator: tps65217: Fix NULL pointer dereference on probe
Date: Fri, 27 Jul 2018 16:59:29 +0300
Message-ID: <20180727135929.13406-1-vasilyev@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Anton Vasilyev <vasilyev@ispras.ru>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-omap@vger.kernel.org

There is no check that tps->strobes is allocated successfully in
tps65217_regulator_probe().
The patch adds corresponding check.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/regulator/tps65217-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index fc12badf3805..d84fab616abf 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -232,6 +232,8 @@ static int tps65217_regulator_probe(struct platform_device *pdev)
 	tps->strobes = devm_kcalloc(&pdev->dev,
 				    TPS65217_NUM_REGULATOR, sizeof(u8),
 				    GFP_KERNEL);
+	if (!tps->strobes)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, tps);
 
-- 
2.18.0
