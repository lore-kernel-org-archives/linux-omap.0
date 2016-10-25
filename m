From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 3/3] ASoC: omap-abe-twl6040: fix typo in bindings documentation
Date: Tue, 25 Oct 2016 19:29:47 +0200
Message-ID: <682ce2c7c9181d46f33c3c0bb6ecc9dd9097b8f2.1477416586.git.hns@goldelico.com>
References: <cover.1477416586.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1477416586.git.hns@goldelico.com>
In-Reply-To: <cover.1477416586.git.hns@goldelico.com>
References: <cover.1477416586.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Russell King <linux@armlinux.org.uk>
Cc: ldewangan@nvidia.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, kernel@pyra-handheld.com, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt b/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
index fd40c85..462b04e8 100644
--- a/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
+++ b/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
@@ -12,7 +12,7 @@ Required properties:
 
 Optional properties:
 - ti,dmic: phandle for the OMAP dmic node if the machine have it connected
-- ti,jack_detection: Need to be present if the board capable to detect jack
+- ti,jack-detection: Need to be present if the board capable to detect jack
   insertion, removal.
 
 Available audio endpoints for the audio-routing table:
-- 
2.7.3
