From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v7 5/6] gnss: add w2sg0004 to Makefile
Date: Thu,  3 May 2018 11:35:50 +0200
Message-ID: <5eed31aa4617b100f1e8687a90f044ef873c0ab0.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1525340143.git.hns@goldelico.com>
In-Reply-To: <cover.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, afd@ti.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Kevin Hilman <khilman@baylibre.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add the w2sg0004 driver to the gnss framework.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gnss/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
index 5cf0ebe0330a..c3c0b5548c94 100644
--- a/drivers/gnss/Makefile
+++ b/drivers/gnss/Makefile
@@ -14,3 +14,6 @@ gnss-sirf-y := sirf.o
 
 obj-$(CONFIG_GNSS_UBX_SERIAL)		+= gnss-ubx.o
 gnss-ubx-y := ubx.o
+
+obj-$(CONFIG_GNSS_W2SG0004)		+= gnss-w2sg0004.o
+gnss-w2sg0004-y := w2sg0004.o
-- 
2.12.2
