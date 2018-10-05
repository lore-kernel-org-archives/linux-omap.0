From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 04/11] regulator: core: Don't allow to get regulator until all couples resolved
Date: Fri,  5 Oct 2018 18:36:31 +0300
Message-ID: <20181005153638.1886-5-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Maciej Purski <m.purski@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Don't allow to get regulator until all of its couples resolved because
consumer will get EPERM and coupling shall be transparent for the drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 925df9e6f1e3..089e8ad8ef57 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1747,6 +1747,16 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		return regulator;
 	}
 
+	mutex_lock(&regulator_list_mutex);
+	ret = (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled);
+	mutex_unlock(&regulator_list_mutex);
+
+	if (ret != 0) {
+		regulator = ERR_PTR(-EPROBE_DEFER);
+		put_device(&rdev->dev);
+		return regulator;
+	}
+
 	ret = regulator_resolve_supply(rdev);
 	if (ret < 0) {
 		regulator = ERR_PTR(ret);
-- 
2.19.0
