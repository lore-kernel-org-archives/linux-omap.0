From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 1/4] dt-bindings: sound: add motorola,
	cpcap-audio-codec
Date: Wed, 14 Feb 2018 23:07:38 +0100
Message-ID: <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Motorola CPCAP is a PMIC with audio functionality, that can be
found on Motorola Droid 4 and probably a few other phones from
Motorola's Droid series.

This adds the DT binding for the codec sub-module found inside
the PMIC.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 .../bindings/sound/motorola,cpcap-audio-codec.txt       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt b/Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt
new file mode 100644
index 000000000000..a6b64132b545
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt
@@ -0,0 +1,17 @@
+Motorola CPCAP audio CODEC
+--------------------------
+
+This module is part of the CPCAP. For more details about the whole
+chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
+
+Required properties:
+
+  - compatible : "motorola,cpcap-audio-codec"
+
+Example:
+
+&cpcap {
+	audio-codec {
+		compatible = "motorola,cpcap-audio-codec";
+	};
+};
-- 
2.15.1
