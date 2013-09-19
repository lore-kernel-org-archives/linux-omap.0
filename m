From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 05/11] ASoC: davinci-mcasp: Interrupts property to optional and add interrupt-names
Date: Thu, 19 Sep 2013 14:29:38 +0300
Message-ID: <0140013bd747832968ccd7dce8f9270e1459d018.1379590036.git.jsarha@ti.com>
References: <cover.1379590035.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1379590035.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Makes interrupts property optional as the interrupts are not currently
used by the driver and adds interrupt-names property to name listed
interrupts. Currently know interrupt names are "tx" and "rx".

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 .../bindings/sound/davinci-mcasp-audio.txt         |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index 68e0f47..2fd0bf2 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -11,7 +11,6 @@ Required properties:
 - reg-names : The mandatory reg-range must be named "mpu" and the optional DMA
 	      reg-range must be named "dma". For backward compatibility it is
 	      good to keep "mpu" first in the list.
-- interrupts : Interrupt number for McASP
 - op-mode : I2S/DIT ops mode.
 - tdm-slots : Slots for TDM operation.
 - num-serializer : Serializers used by McASP.
@@ -31,6 +30,8 @@ Optional properties:
 - rx-num-evt : FIFO levels.
 - sram-size-playback : size of sram to be allocated during playback
 - sram-size-capture  : size of sram to be allocated during capture
+- interrupts : Interrupt numbers for McASP, currently not used by the driver
+- interrupt-names : Known interrupt names are "tx" and "rx"
 
 Example:
 
@@ -41,6 +42,7 @@ mcasp0: mcasp0@1d00000 {
 	reg = <0x100000 0x3000>;
 	reg-names "mpu";
 	interrupts = <82 83>;
+	interrupts-names = "tx", "rx";
 	op-mode = <0>;		/* MCASP_IIS_MODE */
 	tdm-slots = <2>;
 	num-serializer = <16>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
