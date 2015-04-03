From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv6] media: i2c/adp1653: Documentation for devicetree support
 for adp1653
Date: Fri, 3 Apr 2015 22:26:24 +0200
Message-ID: <20150403202624.GA4308@amd>
References: <20150402143846.GA11687@amd>
 <20150402203417.GA6336@amd>
 <20150403083353.GA21070@amd>
 <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Andrew Morton <akpm@osdl.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, galak@codeaurora.org, bcousson@baylibre.com, m.chehab@samsung.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Documentation for adp1653 binding.

---

> Please split this as Javier suggested. I'd think both could go through
> the media-tree unless someone objects.

Please apply.

> > +  - power-gpios: Reference to the GPIO that controls the power for the chip.
> 
> You're using power-gpios in documentation only.

Which is ok, because generic code adds "-gpios" itself.

> The spec refers to this by "EN". How about "en-gpios" instead? This
> definitely isn't about power, but about resetting the chip. It gets the
> power through another pin.

It controls power of the chip. Noone gets _power_ through gpios,
hopefully. Yes, I can rename it. "en-gpios" is too ugly to
live. Sebastian suggested "enable". Hope that's okay with you.

									Pavel

new file mode 100644
index 0000000..da9934a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
@@ -0,0 +1,37 @@
+* Analog Devices ADP1653 flash LED driver
+
+Required Properties:
+
+  - compatible: Must contain be "adi,adp1653"
+
+  - reg: I2C slave address
+
+  - power-gpios: Reference to the GPIO that controls the power for the chip.
+
+There are two LED outputs available - flash and indicator. One LED is
+represented by one child node, nodes need to be named "flash" and "indicator".
+
+Required properties of the LED child node:
+- max-microamp : see Documentation/devicetree/bindings/leds/common.txt
+
+Required properties of the flash LED child node:
+
+- flash-max-microamp : see Documentation/devicetree/bindings/leds/common.txt
+- flash-timeout-us : see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+
+	adp1653: led-controller@30 {
+		compatible = "adi,adp1653";
+		reg = <0x30>;
+		power-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
+
+		flash {
+			flash-timeout-us = <500000>;
+			flash-max-microamp = <320000>;
+			max-microamp = <50000>;
+		};
+		indicator {
+			max-microamp = <17500>;
+		};
+	};

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
