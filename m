From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH] Documentation: dt: i2c: Update trivial-devices list
Date: Fri, 19 Oct 2012 12:28:56 +0530
Message-ID: <1350629936-13397-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49336 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754968Ab2JSG7T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Oct 2012 02:59:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Update i2c trivial-devices list by adding the description for
ti,tmp275 temperature sensor and taos,tsl2550 ambient light
sensor.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 .../devicetree/bindings/i2c/trivial-devices.txt    |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 2f5322b..446859f 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -55,5 +55,7 @@ st-micro,24c256		i2c serial eeprom  (24cxx)
 stm,m41t00		Serial Access TIMEKEEPER
 stm,m41t62		Serial real-time clock (RTC) with alarm
 stm,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
+taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
 ti,tsc2003		I2C Touch-Screen Controller
 ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
+ti,tmp275		Digital Temperature Sensor
-- 
1.7.9.5

