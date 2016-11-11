From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v7 7/9] dt-bindings: input: move ads7846 bindings to touchscreen subdirectory
Date: Fri, 11 Nov 2016 20:02:04 +0100
Message-ID: <3a0b4f67ae4a40b6fea2f61089ef03cc88f29294.1478890925.git.hns@goldelico.com>
References: <cover.1478890925.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1478890925.git.hns@goldelico.com>
In-Reply-To: <cover.1478890925.git.hns@goldelico.com>
References: <cover.1478890925.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 Documentation/devicetree/bindings/input/{ => touchscreen}/ads7846.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/input/{ => touchscreen}/ads7846.txt (100%)

diff --git a/Documentation/devicetree/bindings/input/ads7846.txt b/Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
similarity index 100%
rename from Documentation/devicetree/bindings/input/ads7846.txt
rename to Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
-- 
2.7.3
