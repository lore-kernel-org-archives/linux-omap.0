From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v7 1/6] dt-bindings: define vendor prefix for Wi2Wi, Inc.
Date: Thu,  3 May 2018 11:35:46 +0200
Message-ID: <7c03df30ceec8b171ab88787c1ef9556c96b30f6.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1525340143.git.hns@goldelico.com>
In-Reply-To: <cover.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, afd@ti.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Kevin Hilman <khilman@baylibre.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Introduce vendor prefix for Wi2Wi, Inc. for W2SG0004 GPS module
and W2CBW003 Bluetooth/WiFi combo (CSR/Marvell).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ddd81c82082d..9b3af098b99d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -396,6 +396,7 @@ wi2wi	Wi2Wi
 wd	Western Digital Corp.
 wetek	WeTek Electronics, limited.
 wexler	Wexler
+wi2wi	Wi2Wi, Inc.
 winbond Winbond Electronics corp.
 winstar	Winstar Display Corp.
 wlf	Wolfson Microelectronics
-- 
2.12.2
