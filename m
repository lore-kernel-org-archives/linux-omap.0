From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/5] HSI: nokia-modem: add n950 and n9 support
Date: Sun, 17 Jan 2016 16:49:07 +0100
Message-ID: <1453045749-22642-4-git-send-email-sre@kernel.org>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453045749-22642-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The Nokia N950 and Nokia N9 also have a SSI connected
modem, which use the same protocols as the Nokia N900,
but with slightly other GPIO setup and increased link
speed (96000 kbps instead of 55000 kbps).

Since it's unclear, if the N950 and the N9 use exactly
the same modem, each of them gets their own compatible
string.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/hsi/nokia-modem.txt | 12 +++++++-----
 drivers/hsi/clients/nokia-modem.c                     |  2 ++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/hsi/nokia-modem.txt b/Documentation/devicetree/bindings/hsi/nokia-modem.txt
index 8a979780452b..53de1d9d0b95 100644
--- a/Documentation/devicetree/bindings/hsi/nokia-modem.txt
+++ b/Documentation/devicetree/bindings/hsi/nokia-modem.txt
@@ -7,6 +7,8 @@ properties are needed by the Nokia modem HSI client:
 Required properties:
 - compatible:		Should be one of
       "nokia,n900-modem"
+      "nokia,n950-modem"
+      "nokia,n9-modem"
 - hsi-channel-names:	Should contain the following strings
       "mcsaab-control"
       "speech-control"
@@ -15,11 +17,11 @@ Required properties:
 - gpios:		Should provide a GPIO handler for each GPIO listed in
                         gpio-names
 - gpio-names:		Should contain the following strings
-      "cmt_apeslpx"
-      "cmt_rst_rq"
-      "cmt_en"
-      "cmt_rst"
-      "cmt_bsi"
+      "cmt_apeslpx" (for n900, n950, n9)
+      "cmt_rst_rq"  (for n900, n950, n9)
+      "cmt_en"      (for n900, n950, n9)
+      "cmt_rst"     (for n900)
+      "cmt_bsi"     (for n900)
 - interrupts:		Should be IRQ handle for modem's reset indication
 
 Example:
diff --git a/drivers/hsi/clients/nokia-modem.c b/drivers/hsi/clients/nokia-modem.c
index 7f82c911ad74..c000780d931f 100644
--- a/drivers/hsi/clients/nokia-modem.c
+++ b/drivers/hsi/clients/nokia-modem.c
@@ -281,6 +281,8 @@ static int nokia_modem_remove(struct device *dev)
 #ifdef CONFIG_OF
 static const struct of_device_id nokia_modem_of_match[] = {
 	{ .compatible = "nokia,n900-modem", },
+	{ .compatible = "nokia,n950-modem", },
+	{ .compatible = "nokia,n9-modem", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, nokia_modem_of_match);
-- 
2.7.0.rc3
