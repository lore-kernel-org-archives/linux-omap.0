From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 1/5] DT: vendor prefix for Wi2Wi, Inc.
Date: Sun, 12 Nov 2017 21:59:54 +0100
Message-ID: <8fb996b8bd96e4a9205193ce712da9deff090771.1510520397.git.hns@goldelico.com>
References: <cover.1510520397.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510520397.git.hns@goldelico.com>
In-Reply-To: <cover.1510520397.git.hns@goldelico.com>
References: <cover.1510520397.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, "H. Nikolaus Schaller" <hns@goldelico.com>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Introduce vendor prefix for Wi2Wi, Inc. for W2SG00x4 GPS modules
and W2CBW003 Bluetooth/WiFi combo (CSR/Marvell).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 1afd298eddd7..ad4381738954 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -366,6 +366,7 @@ voipac	Voipac Technologies s.r.o.
 wd	Western Digital Corp.
 wetek	WeTek Electronics, limited.
 wexler	Wexler
+wi2wi	Wi2Wi, Inc.
 winbond Winbond Electronics corp.
 winstar	Winstar Display Corp.
 wlf	Wolfson Microelectronics
-- 
2.12.2
