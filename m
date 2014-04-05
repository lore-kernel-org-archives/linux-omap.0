From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 2/5] Input: tsc2005: use dev_err for error messages
Date: Sun,  6 Apr 2014 00:26:58 +0200
Message-ID: <1396736821-14395-3-git-send-email-sre@kernel.org>
References: <1396736821-14395-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396736821-14395-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Change some dev_dbg() invocations to dev_err() ones, because they
are supposed to output error messages.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/input/touchscreen/tsc2005.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 550adcb..520e673 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -579,7 +579,7 @@ static int tsc2005_probe(struct spi_device *spi)
 	int error;
 
 	if (!pdata) {
-		dev_dbg(&spi->dev, "no platform data\n");
+		dev_err(&spi->dev, "no platform data\n");
 		return -ENODEV;
 	}
 
@@ -591,7 +591,7 @@ static int tsc2005_probe(struct spi_device *spi)
 	max_p	= pdata->ts_pressure_max   ? : MAX_12BIT;
 
 	if (spi->irq <= 0) {
-		dev_dbg(&spi->dev, "no irq\n");
+		dev_err(&spi->dev, "no irq\n");
 		return -ENODEV;
 	}
 
-- 
1.9.1
