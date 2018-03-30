From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 04/10] mfd: ti-lmu: drop of_compatible for backlight driver
Date: Fri, 30 Mar 2018 19:24:08 +0200
Message-ID: <20180330172414.26575-5-sebastian.reichel@collabora.co.uk>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

This removes the of_compatible for the backlight sub-device. There
will be no extra sub-node for the backlight.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/mfd/ti-lmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index 2ee09d099832..de76298cf3a8 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -58,7 +58,6 @@ static const struct mfd_cell lm3532_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3532,
-		.of_compatible = "ti,lm3532-backlight",
 	},
 };
 
@@ -78,7 +77,6 @@ static const struct mfd_cell lm3631_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3631,
-		.of_compatible = "ti,lm3631-backlight",
 	},
 };
 
@@ -89,7 +87,6 @@ static const struct mfd_cell lm3632_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3632,
-		.of_compatible = "ti,lm3632-backlight",
 	},
 };
 
@@ -97,7 +94,6 @@ static const struct mfd_cell lm3633_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3633,
-		.of_compatible = "ti,lm3633-backlight",
 	},
 	{
 		.name          = "lm3633-leds",
@@ -115,7 +111,6 @@ static const struct mfd_cell lm3695_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3695,
-		.of_compatible = "ti,lm3695-backlight",
 	},
 };
 
@@ -123,7 +118,6 @@ static const struct mfd_cell lm3697_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3697,
-		.of_compatible = "ti,lm3697-backlight",
 	},
 	/* Monitoring driver for open/short circuit detection */
 	{
-- 
2.16.2
