From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 1/6] regulator: lp872x: Add missing of_match in regulators
 descriptions
Date: Wed, 23 Dec 2015 11:58:34 +0100
Message-ID: <1450868319-20513-2-git-send-email-contact@paulk.fr>
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

In order to select the regulators via of_find_regulator_by_node (and thus use
them in devicetree), defining of_match for each regulator is required.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/regulator/lp872x.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index e5af072..9412353 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -520,6 +520,7 @@ static struct regulator_ops lp8725_buck_ops = {
 static struct regulator_desc lp8720_regulator_desc[] = {
 	{
 		.name = "ldo1",
+		.of_match = of_match_ptr("ldo1"),
 		.id = LP8720_ID_LDO1,
 		.ops = &lp872x_ldo_ops,
 		.n_voltages = ARRAY_SIZE(lp872x_ldo_vtbl),
@@ -533,6 +534,7 @@ static struct regulator_desc lp8720_regulator_desc[] = {
 	},
 	{
 		.name = "ldo2",
+		.of_match = of_match_ptr("ldo2"),
 		.id = LP8720_ID_LDO2,
 		.ops = &lp872x_ldo_ops,
 		.n_voltages = ARRAY_SIZE(lp872x_ldo_vtbl),
@@ -546,6 +548,7 @@ static struct regulator_desc lp8720_regulator_desc[] = {
 	},
 	{
 		.name = "ldo3",
+		.of_match = of_match_ptr("ldo3"),
 		.id = LP8720_ID_LDO3,
 		.ops = &lp872x_ldo_ops,
 		.n_voltages = ARRAY_SIZE(lp872x_ldo_vtbl),
@@ -559,6 +562,7 @@ static struct regulator_desc lp8720_regulator_desc[] = {
 	},
 	{
 		.name = "ldo4",
+		.of_match = of_match_ptr("ldo4"),
 		.id = LP8720_ID_LDO4,
 		.ops = &lp872x_ldo_ops,
 		.n_voltages = ARRAY_SIZE(lp8720_ldo4_vtbl),
@@ -572,6 +576,7 @@ static struct regulator_desc lp8720_regulator_desc[] = {
 	},
 	{
 		.name = "ldo5",
+		.of_match = of_match_ptr("ldo5"),
 		.id = LP8720_ID_LDO5,
 		.ops = &lp872x_ldo_ops,
 		.n_voltages = ARRAY_SIZE(lp872x_ldo_vtbl),
@@ -585,6 +590,7 @@ static struct regulator_desc lp8720_regulator_desc[] = {
 	},
 	{
 		.name = "buck",
+		.of_match = of_match_ptr("buck"),
 		.id = LP8720_ID_BUCK,
 		.ops = &lp8720_buck_ops,
 		.n_voltages = ARRAY_SIZE(lp8720_buck_vtbl),
@@ -599,6 +605,7 @@ static struct regulator_desc lp8720_regulator_desc[] = {
 static struct regulator_desc lp8725_regulator_desc[] = {
 	{
 		.name = "ldo1",
+		.of_match = of_match_ptr("ldo1"),
 		.id = LP8725_ID_LDO1,
 		.ops = &lp872x_ldo_ops,
 		.n_voltages = ARRAY_SIZE(lp872x_ldo_vtbl),
@@ -612,6 +619,7 @@ static struct regulator_desc lp8725_regulator_desc[] = {
 	},
 	{
 		.name = "ldo2",
+		.of_match = of_match_ptr("ldo2"),
 		.id = LP8725_ID_LDO2,
 		.ops = &lp872x_ldo_ops,
 		.n_voltages = ARRAY_SIZE(lp872x_ldo_vtbl),
@@ -625,6 +633,7 @@ static struct regulator_desc lp8725_regulator_desc[] = {
 	},
 	{
 		.name = "ldo3",
+		.of_match = of_match_ptr("ldo3"),
 		.id = LP8725_ID_LDO3,
 		.ops = &lp872x_ldo_ops,
 		.n_voltages = ARRAY_SIZE(lp872x_ldo_vtbl),
@@ -638,6 +647,7 @@ static struct regulator_desc lp8725_regulator_desc[] = {
 	},
 	{
 		.name = "ldo4",
+		.of_match = of_match_ptr("ldo4"),
 		.id = LP8725_ID_LDO4,
 		.ops = &lp872x_ldo_ops,
 		.n_voltages = ARRAY_SIZE(lp872x_ldo_vtbl),
@@ -651,6 +661,7 @@ static struct regulator_desc lp8725_regulator_desc[] = {
 	},
 	{
 		.name = "ldo5",
+		.of_match = of_match_ptr("ldo5"),
 		.id = LP8725_ID_LDO5,
 		.ops = &lp872x_ldo_ops,
 		.n_voltages = ARRAY_SIZE(lp872x_ldo_vtbl),
@@ -664,6 +675,7 @@ static struct regulator_desc lp8725_regulator_desc[] = {
 	},
 	{
 		.name = "lilo1",
+		.of_match = of_match_ptr("lilo1"),
 		.id = LP8725_ID_LILO1,
 		.ops = &lp872x_ldo_ops,
 		.n_voltages = ARRAY_SIZE(lp8725_lilo_vtbl),
@@ -677,6 +689,7 @@ static struct regulator_desc lp8725_regulator_desc[] = {
 	},
 	{
 		.name = "lilo2",
+		.of_match = of_match_ptr("lilo2"),
 		.id = LP8725_ID_LILO2,
 		.ops = &lp872x_ldo_ops,
 		.n_voltages = ARRAY_SIZE(lp8725_lilo_vtbl),
@@ -690,6 +703,7 @@ static struct regulator_desc lp8725_regulator_desc[] = {
 	},
 	{
 		.name = "buck1",
+		.of_match = of_match_ptr("buck1"),
 		.id = LP8725_ID_BUCK1,
 		.ops = &lp8725_buck_ops,
 		.n_voltages = ARRAY_SIZE(lp8725_buck_vtbl),
@@ -701,6 +715,7 @@ static struct regulator_desc lp8725_regulator_desc[] = {
 	},
 	{
 		.name = "buck2",
+		.of_match = of_match_ptr("buck2"),
 		.id = LP8725_ID_BUCK2,
 		.ops = &lp8725_buck_ops,
 		.n_voltages = ARRAY_SIZE(lp8725_buck_vtbl),
-- 
1.9.1
