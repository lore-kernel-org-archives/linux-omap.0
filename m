From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 3/3] mfd: Add battery charger as subdevice to the tps65217.
Date: Tue,  8 Sep 2015 10:09:39 +0200
Message-ID: <1441699779-22189-4-git-send-email-enric.balletbo@collabora.com>
References: <1441699779-22189-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441699779-22189-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, tony@atomide.com, sameo@linux.intel.com, lee.jones@linaro.org, sjoerd.simons@collabora.co.uk, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

Add tps65217 battery charger subdevice.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/mfd/tps65217.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 55add04..d32b5442 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -39,6 +39,10 @@ static const struct mfd_cell tps65217s[] = {
 		.name = "tps65217-bl",
 		.of_compatible = "ti,tps65217-bl",
 	},
+	{
+		.name = "tps65217-charger",
+		.of_compatible = "ti,tps65217-charger",
+	},
 };
 
 /**
-- 
2.1.0
