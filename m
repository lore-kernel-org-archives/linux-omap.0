Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.121
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505231;
	b=JxLNXxgQfFEy2LytXCYX/iMIriJ2iodcmMtyjn2t6rFCm/TmaqFnp8/lXC8M6EjPAGSL
	 4CbRiGgp+rh6hC5xM6T2rfKGUnbCJE5wCANfATn3WB7s2PnCUgEEyaVpg7xAZLlSeosgN
	 5EmW5shh/RE8ParIDQoF5o3h45nF0w+umhvhbzenxdTbCcbIIy0vghFgsVCllT8EQZiSB
	 YzzwRb4VAab4E5WBCy1WToXXGGwKm26ZjOmqOkZaGsZjONW8ewccrepo1j7dlpggOGmSf
	 iAkGLVkdW2DktNqutMGDUPRXdkMRaivEQEt/jPWHBoXFCcAjdG30B2WxRhYYjx7WSlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505231;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=qOWnDIUirnp7niKKgcme9VVUTThomhs09luZ9kZoQDA=;
	b=MA2rkMhsT/6b73HgE14FfB2rJ0BbU+aXtaKjYbYNAHRZXrv7B6gvskCuR6cPhafOUdoA
	 2UmzozstvI+1MXX3QkFcQ4jdJFHJpLLmotNAsbh0XhcA1PiPO7Ni2yEYc+R5Cn2n9qG+k
	 7ecR9pHMxQU2qVIoYBsnRjHpIu8IfYKPtN5RTEjCp0LFaSfmflh1WiZsMxBveiiKaBanb
	 c6GI5nQKBW01fBEWeSliMOHXdny3wMtLjyA02R3in8PR+68GMBbbQYfTNn6gHfEyNPhho
	 a++2vfms3HVO/GTxNhTsYReKQF0EBHjnj1wOtCCQkm/oGjF7DVOEw+UAPUi03Ict1+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Ppz3CK7G;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=q3lqT7jd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.121
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BA60A3821;
	Tue, 24 Nov 2026 07:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 677BA60A3821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Ppz3CK7G;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=q3lqT7jd
ARC-Seal: i=1; a=rsa-sha256; t=1795505172; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rnfMq0NIP64ben5wNgoxFUkpWi/QCqJTUvbvxmcALWU186r+XM1A8Jx70X4Q7naPlV
    895nrgY6UdcnRTP/xtRpEbj0Tn+yP3xix3zTMF++sS0nmcUXyBDVn5TLiBP7zH1hKUcx
    aGUkahLH9YH0oGj6OdXDklRDzwvDAVuPXXW0tESU+XB0m+kZBw+VgNzhqN2w1slY63ag
    xmegAHB5gxQS3GrZzfzff4qhWg8PlsGC/pkg/ggiiwUQqNFAnFbINbY4tq0TlMH5Swec
    DRi+N5IZV2jg49lgDVu3tuUwTF2Mj4XBX0XeMsn5XURyQcLNUn+uOgEAoCnHiqHWutYO
    TYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505172;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=qOWnDIUirnp7niKKgcme9VVUTThomhs09luZ9kZoQDA=;
    b=ctg1tfJhMBCY0UxGqdBv+lUs6wbDc1wXAA6SYcnxfz6oep7U0m4+6INj8onFO18gcs
    WxWoySjSEtdrtmPBU0QcXCGFENFvAWlCdnmWnquGKkrUaplH91H1HK3m1d4kgQ08gKpA
    yaY5T+SxNksdbrf1+6NMwl5xcXm83x5j+wQUTEJQeNUOeAIbczuEkjn8KTJl1u/1ZVe1
    5s4s0yzCPwQEgLW1Y2EN6VmbKgI2rRDD/7jpyl0VxK/ou4a3x06be7tgt/vJ6sxXT3MC
    Oicf2zPuHhdWk+9/gYG0h7LjgltTExfC94bwflDVVZel0H+QJ/wtNOMkC+anMEl4hBrw
    sBLQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505172;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=qOWnDIUirnp7niKKgcme9VVUTThomhs09luZ9kZoQDA=;
    b=Ppz3CK7G8KlukLX4l8Ri8vE/AOw4vXQvrTCQLH+d/EmYXaoMgxgJdK7GgUeBrDfWtM
    Fz7f/bIPbK88J7RPGnZN4ZBwf07qRHBCg/rkwv5/+xD0tgnS8XMddaa3kioHYAJ62/0O
    2dcHbeABOa2zcfwpGQHPd7pPKSEb6MiICHzlnyqNOKcFpojASAmB9wUID36AmorYislc
    MfbR4tC9aZeTcdvcoTvygIZ+GN76O9weUkNpc8B4rOndtsZHLbMjP7WJSOnW4qwC66nC
    QzJsf69yGH6JOQ1XytRSfl4nmTnXadm/puZZemyrgHVdt6Q0HcqH1qdnFWkUyHrLZyJt
    zsYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505172;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=qOWnDIUirnp7niKKgcme9VVUTThomhs09luZ9kZoQDA=;
    b=q3lqT7jd2ldNGdU8vf6Y1FKiK09q6fAjJTR1HLJ5/iM+RUkB855FkMN/44SLueamXS
    Qj9HYsK9Dt4M+OHHCGDQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7QB1HI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:11 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	letux-kernel@openphoenux.org,
	kernel@pyra-handheld.com,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 06/20] dt-bindings: sound: Document OpenPandora sound card
Date: Tue, 24 Nov 2026 08:25:46 +0100
Message-ID: <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The OpenPandora audio subsystem describes the routing links between the
OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 audio
codec, alongside amplifiers and power supplies.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Address Krzysztof Kozlowski's V1 request to run the documented
      DT schema checks and fix the errors reported by Rob Herring's
      automated DT validation.
    - Update the binding example and schema during DT consistency review.
    - Binding and commit-message review assisted by ChatGPT.

 .../sound/openpandora,omap3pandora-sound.yaml | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml

diff --git a/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml b/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml
new file mode 100644
index 0000000000000..6c4d69ffc1c50
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/openpandora,omap3pandora-sound.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OpenPandora OMAP3 Audio Complex
+
+maintainers:
+  - H. Nikolaus Schaller <hns@goldelico.com>
+
+description:
+  The OpenPandora audio subsystem describes the routing links between the
+  OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 audio codec,
+  alongside amplifiers and power supplies.
+
+properties:
+  compatible:
+    const: openpandora,omap3pandora-sound
+
+  label:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User-visible name for this sound card.
+
+  amp-gpios:
+    maxItems: 1
+    description: GPIO pin controlling the amplifier power state.
+
+  amp-supply:
+    description: Regulator supplying power to the amplifier.
+
+  sound-dai:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 2
+    maxItems: 2
+    description:
+      Phandles to the audio CPU DAI (OMAP3 McBSP) and the codec DAI.
+
+  routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components.
+      Each entry is a pair of strings, the first being the connection's sink,
+      the second being the connection's source.
+
+  widgets:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      User-specified audio sound widgets.
+      Each entry is a pair of strings, the first being the widget type
+      (e.g., "Speaker", "Headphone", "Microphone", "Line") and the second being its name.
+
+required:
+  - compatible
+  - sound-dai
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    sound {
+        compatible = "openpandora,omap3pandora-sound";
+        status = "okay";
+
+        label = "OpenPandora";
+
+        amp-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+        amp-supply = <&aux_5v>;
+
+        widgets =
+            "Line", "Line Out",
+            "Line", "Line In",
+            "Headphone", "Headphone Jack",
+            "Microphone", "Mic (internal)",
+            "Microphone", "Mic (external)";
+
+        routing =
+            "DAC1", "APLL Enable",
+            "DAC2", "APLL Enable",
+            "Headphone Amplifier", "VOUTL",
+            "Headphone Amplifier", "VOUTR",
+            "Line Out", "VOUTL",
+            "Line Out", "VOUTR",
+            "Headphone Jack", "Headphone Amplifier",
+            "AUXL", "Line In",
+            "AUXR", "Line In",
+            "MAINMIC", "Mic (internal)",
+            "Mic (internal)", "Mic Bias 1",
+            "SUBMIC", "Mic (external)",
+            "Mic (external)", "Mic Bias 2";
+
+        sound-dai = <&mcbsp2>, <&dac>;
+    };
-- 
2.56.0

