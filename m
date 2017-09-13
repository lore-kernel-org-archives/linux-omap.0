From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/2] mfd: tps65218: Correct the config description
Date: Wed, 13 Sep 2017 17:47:09 +0530
Message-ID: <1505305030-13263-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

When the initial support was added for this PMIC was added
only regulator support was present. Now we have GPIO and Powerbutton
support as well. Hence correct the description of MFD_TPS65218 config
option.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/mfd/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b478768..44c529e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1408,8 +1408,7 @@ config MFD_TPS65218
 	  If you say yes here you get support for the TPS65218 series of
 	  Power Management chips.
 	  These include voltage regulators, gpio and other features
-	  that are often used in portable devices. Only regulator
-	  component is currently supported.
+	  that are often used in portable devices.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps65218.
-- 
1.9.1
