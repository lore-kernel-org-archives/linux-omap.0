From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 06/11] regulator: core: Limit regulators coupling to a single couple
Date: Fri,  5 Oct 2018 18:36:33 +0300
Message-ID: <20181005153638.1886-7-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Maciej Purski <m.purski@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Device tree binding was changed in a way that now max-spread values must
be defied per regulator pair. Limit number of pairs in order to adapt to
the new binding without changing regulators code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/regulator/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index a9c030192147..a05d37d0efa1 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -15,7 +15,7 @@
 #ifndef __LINUX_REGULATOR_DRIVER_H_
 #define __LINUX_REGULATOR_DRIVER_H_
 
-#define MAX_COUPLED		4
+#define MAX_COUPLED		2
 
 #include <linux/device.h>
 #include <linux/notifier.h>
-- 
2.19.0
