From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 5/7] drm/i2c: tda998x: Add support of a DT graph of ports DO NOT MERGE
Date: Tue, 26 May 2015 21:59:09 +0300
Message-ID: <1432666751-24794-6-git-send-email-jsarha@ti.com>
References: <1432666751-24794-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51947 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbbEZTAD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 May 2015 15:00:03 -0400
In-Reply-To: <1432666751-24794-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, moinejf@free.fr, rmk+kernel@arm.linux.org.uk, Jyri Sarha <jsarha@ti.com>

From: Jean-Francois Moine <moinejf@free.fr>

Two kinds of ports may be declared in a DT graph of ports: video and audio.
This patch accepts the port value from a video port as an alternative
to the video-ports property.
It also accepts audio ports in the case the transmitter is not used as
a slave encoder.
The new file include/sound/tda998x.h prepares to the definition of
a tda998x CODEC.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/drm/i2c/tda998x.txt        | 51 ++++++++++++
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 90 +++++++++++++++++++---
 include/sound/tda998x.h                            |  8 ++
 3 files changed, 140 insertions(+), 9 deletions(-)
 create mode 100644 include/sound/tda998x.h

diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
index e9e4bce..386b6c3 100644
--- a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
+++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
@@ -16,6 +16,35 @@ Optional properties:
 
   - video-ports: 24 bits value which defines how the video controller
 	output is wired to the TDA998x input - default: <0x230145>
+	This property is not used when ports are defined.
+
+Optional nodes:
+
+  - port: up to three ports.
+	The ports are defined according to [1].
+
+    Video port.
+	There may be only one video port.
+	This one must contain the following property:
+
+	- port-type: must be "rgb"
+
+	and may contain the optional property:
+
+	- reg: 24 bits value which defines how the video controller
+		output is wired to the TDA998x input (video pins)
+		When absent, the default value is <0x230145>.
+
+    Audio ports.
+	There may be one or two audio ports.
+	These ones must contain the following properties:
+
+	- port-type: must be "i2s" or "spdif"
+
+	- reg: 8 bits value which defines how the audio controller
+		output is wired to the TDA998x input (audio pins)
+
+[1] Documentation/devicetree/bindings/graph.txt
 
 Example:
 
@@ -26,4 +55,26 @@ Example:
 		interrupts = <27 2>;		/* falling edge */
 		pinctrl-0 = <&pmx_camera>;
 		pinctrl-names = "default";
+
+		port at 230145 {
+			port-type = "rgb";
+			reg = <0x230145>;
+			hdmi_0: endpoint {
+				remote-endpoint = <&lcd0_0>;
+			};
+		};
+		port at 3 {			/* AP1 = I2S */
+			port-type = "i2s";
+			reg = <0x03>;
+			tda998x_i2s: endpoint {
+				remote-endpoint = <&audio1_i2s>;
+			};
+		};
+		port at 4 {			 /* AP2 = S/PDIF */
+			port-type = "spdif";
+			reg = <0x04>;
+			tda998x_spdif: endpoint {
+				remote-endpoint = <&audio1_spdif1>;
+			};
+		};
 	};
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 5febffd..bcf96f7 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -27,6 +27,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/i2c/tda998x.h>
+#include <sound/tda998x.h>
 
 #define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
 
@@ -47,6 +48,8 @@ struct tda998x_priv {
 	wait_queue_head_t wq_edid;
 	volatile int wq_edid_wait;
 	struct drm_encoder *encoder;
+
+	struct tda998x_audio_s audio;
 };
 
 #define to_tda998x_priv(x)  ((struct tda998x_priv *)to_encoder_slave(x)->slave_priv)
@@ -771,6 +774,8 @@ static void tda998x_encoder_set_config(struct tda998x_priv *priv,
 			    (p->mirr_f ? VIP_CNTRL_2_MIRR_F : 0);
 
 	priv->params = *p;
+	priv->audio.port_types[0] = p->audio_format;
+	priv->audio.ports[0] = p->audio_cfg;
 }
 
 static void tda998x_encoder_dpms(struct tda998x_priv *priv, int mode)
@@ -1227,9 +1232,57 @@ static struct drm_encoder_slave_funcs tda998x_encoder_slave_funcs = {
 
 /* I2C driver functions */
 
+static int tda998x_parse_ports(struct tda998x_priv *priv,
+				struct device_node *np)
+{
+	struct device_node *of_port;
+	const char *port_type;
+	int ret, audio_index, reg, afmt;
+
+	audio_index = 0;
+	for_each_child_of_node(np, of_port) {
+		if (!of_port->name
+		 || of_node_cmp(of_port->name, "port") != 0)
+			continue;
+		ret = of_property_read_string(of_port, "port-type",
+					&port_type);
+		if (ret < 0)
+			continue;
+		ret = of_property_read_u32(of_port, "reg", &reg);
+		if (strcmp(port_type, "rgb") == 0) {
+			if (!ret) {		/* video reg is optional */
+				priv->vip_cntrl_0 = reg >> 16;
+				priv->vip_cntrl_1 = reg >> 8;
+				priv->vip_cntrl_2 = reg;
+			}
+			continue;
+		}
+		if (strcmp(port_type, "i2s") == 0)
+			afmt = AFMT_I2S;
+		else if (strcmp(port_type, "spdif") == 0)
+			afmt = AFMT_SPDIF;
+		else
+			continue;
+		if (ret < 0) {
+			dev_err(&priv->hdmi->dev, "missing reg for %s\n",
+				port_type);
+			return ret;
+		}
+		if (audio_index >= ARRAY_SIZE(priv->audio.ports)) {
+			dev_err(&priv->hdmi->dev, "too many audio ports\n");
+			break;
+		}
+		priv->audio.ports[audio_index] = reg;
+		priv->audio.port_types[audio_index] = afmt;
+		audio_index++;
+	}
+	return 0;
+}
+
 static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 {
 	struct device_node *np = client->dev.of_node;
+	struct device_node *of_port;
 	u32 video;
 	int rev_lo, rev_hi, ret;
 	unsigned short cec_addr;
@@ -1334,15 +1387,34 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	/* enable EDID read irq: */
 	reg_set(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
 
-	if (!np)
-		return 0;		/* non-DT */
-
-	/* get the optional video properties */
-	ret = of_property_read_u32(np, "video-ports", &video);
-	if (ret == 0) {
-		priv->vip_cntrl_0 = video >> 16;
-		priv->vip_cntrl_1 = video >> 8;
-		priv->vip_cntrl_2 = video;
+	/* get the device tree parameters */
+	if (np) {
+		of_port = of_get_child_by_name(np, "port");
+		if (of_port) {				/* graph of ports */
+			of_node_put(of_port);
+			ret = tda998x_parse_ports(priv, np);
+			if (ret < 0)
+				goto fail;
+
+			/* initialize the default audio configuration */
+			if (priv->audio.ports[0]) {
+				priv->params.audio_cfg = priv->audio.ports[0];
+				priv->params.audio_format =
+						priv->audio.port_types[0];
+				priv->params.audio_clk_cfg =
+					priv->params.audio_format ==
+							AFMT_SPDIF ? 0 : 1;
+			}
+		} else {
+
+			/* optional video properties */
+			ret = of_property_read_u32(np, "video-ports", &video);
+			if (ret == 0) {
+				priv->vip_cntrl_0 = video >> 16;
+				priv->vip_cntrl_1 = video >> 8;
+				priv->vip_cntrl_2 = video;
+			}
+		}
 	}
 
 	return 0;
diff --git a/include/sound/tda998x.h b/include/sound/tda998x.h
new file mode 100644
index 0000000..487a809
--- /dev/null
+++ b/include/sound/tda998x.h
@@ -0,0 +1,8 @@
+#ifndef SND_TDA998X_H
+#define SND_TDA998X_H
+
+struct tda998x_audio_s {
+	u8 ports[2];			/* AP value */
+	u8 port_types[2];		/* AFMT_xxx */
+};
+#endif
-- 
1.9.1

