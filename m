Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505223;
	b=mEnlPUGY7uhS3xvecBWsqtM2qSbk3m+xd4ScFH//R6MNVr9mRJfJ3VF+eKhAGMWGTSu+
	 OslFlh3WQQc0GzCvd93heSRJCTO+0Wz/mCkGGHHkJyVi9rkwsLU02mXzUsLq2ENtloHfe
	 EP35H6+TwsAz/f46x3ByFxY349ypPKr2CjFxMYelExKsGSebkQQiik22ywRgv7HkZN+uh
	 cGWjQhVWiH6XdNuenrJ2Tuy5p4Rsx2Er/Awlrzka+lw9EFQG3fMO482L0sj0B94ze/b5X
	 5ZU5sYDUAKTUEipD3ibbfpy7xMsv7umcDWCDJ7eFOwNdJY7sVUUjTS29pmcdPsPvwwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505223;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=kFVKZWJnvTpv0CaRCWkf/scaJhz42VxpUYUALwApW74=;
	b=sMP+YB13SeQoaaO8BzQ916ZUWN5TH1ltZuyNj1A0iGfwllwSVIfHfDCNaMRQi8i3JCnF
	 gIx4/tt6ldt5r7QXWihbp/eNvhd+ADUiueVM85/3thQFkekYOjhKebVo8XzJJPkNfwQCp
	 qArfJ46ER4tuwdkejUqtFOgaawk89oYNTX0xEj7ASaWmEETBWfTKSZxZlSk8PZ2dOriZe
	 HJ8I0T52D/f0rBUL9cn4sIIEQ630xe3IFNSso8K0YeX6SJaN168Cj1vz/rhrcTn7z1pUU
	 bcFXp3yoa0JlfrtPKLfUOvS/JttGOxf6n+SOOdcYWL41J1jCjOnr1uDMWCTiBeKb1kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EiH3gmjF;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mQl7hvDm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.178
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3116606A682;
	Tue, 24 Nov 2026 07:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3116606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EiH3gmjF;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mQl7hvDm
ARC-Seal: i=1; a=rsa-sha256; t=1795505183; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z7xiYhSoH/3M3dxzPNQd829mpciJtOxysyasKAgIeGN/0NoMZayD4xO8Px7ueuwXpK
    id4fvevS/hx6O+u8jz3mxUKGLmqp9wmMivQfPdr4ZINlrd3rU+nijIQHZmB0fJ1qd7vv
    627DklFjMNkXSmvShdeDwDHg/naU4sevFcxlFgz7IQ6pjYWv7KHuWXjdkQ+Npv2a1OJP
    lCn5vuyZ84Y7Q2JEnOYxikBgjgMlON2/1ooZRBdJmmkekxoVfdHVNzNRxP6R31eD8QeS
    joLnofLRk4JAVhY1r+7UzV0dOvbb983RBMDOimDER9JySvkoZd4h8p/RxBWZIj4RSXju
    5BkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505183;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kFVKZWJnvTpv0CaRCWkf/scaJhz42VxpUYUALwApW74=;
    b=Meqqz7QDgIGR03VTCBRmFfkc/OTi2JI15h2Jsk68jL0kbTQgB8V0Bh6vPGIAJoxQ8Q
    efcIBWpN9hBY8B4YFLeEWM1VnL4zMZjFiZC5asgSxvYB6JiXefVr0RNSVSvnF2Oqu19c
    BlUYBmRNR8nDiZyk9CenuuCRpJp209UAoJD1ugrlBWaQ95zgt1B8wVNlLfj6ObbXKX+e
    nmN7PZhTdlB0b50VZ34/m/o8cnbmtaE2E0dzek3EVbQVouHyYDMUPOfZ5CH2JJwkP/y5
    /DplD8MVhKjPC9mzl5uo2tA43O51VSg5x+ENcKHp9LUWiSwZ+0IQvjbUwHo2Awi8fBMh
    JNoA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505183;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kFVKZWJnvTpv0CaRCWkf/scaJhz42VxpUYUALwApW74=;
    b=EiH3gmjFx9O9zE7ceCRcHfLIrQo4joTC1DAbmIRwKZcJQ1hSrF4zlRlhnxBIlqgFr2
    o8b9eTW43QKFNb59rA5r3feLIrSXEzhKlpruNsvXka1Qx/M8UQN+NHEW/odAkXNKb6ql
    qNFyHouiXXt4bUhpMqlhn9LU/NSwnWCIlblJFCqL2yQfYAGn8kTNyzRPbPa8DsuB4JC+
    GCA0VsqewoIdwfgM8eza8xwKzEz+0zD47dL1azWBjV+8+jVH3ibF4fcqpJuJTTqLutgx
    6V7J36/S2OpddBcdpFLH6rEZ8po+DBCFafKBMHmf2ut5iAQmioDam/y5rcgh3ZsB1cKZ
    2v3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505183;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kFVKZWJnvTpv0CaRCWkf/scaJhz42VxpUYUALwApW74=;
    b=mQl7hvDmB5McIZME11BEoDVNqoi0wfRn8QnKlUYBJexRm39G5BkDGqbfVnM2ZUNunR
    /dThEVIVeGg5rkSXSUAw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7QM1HV
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:22 +0100 (CET)
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
	Stefan Leichter <sle85276@gmx.de>,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 17/20] ARM: dts: omap3pandora: Describe sound card
Date: Tue, 24 Nov 2026 08:25:57 +0100
Message-ID: <0269f30c3f766431c0c20a36fd6e2b2dce1b3f2f.1795505160.git.hns@goldelico.com>
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

From: Stefan Leichter <sle85276@gmx.de>

Describe the OpenPandora sound card and its connections to the external
PCM1773 playback DAC and TWL4030 capture codec in the device tree.

Provide the amplifier GPIO and power supply, the DAPM widgets and
routing, and the McBSP audio links needed by the DT-based sound card
driver.

Signed-off-by: Stefan Leichter <sle85276@gmx.de>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Historical origin: 570cb6f3073f (Stefan Leichter, 2020-06-29).
    - The original history also contains a Signed-off-by from Grond; this has not been carried forward without renewed confirmation.
    - The sound-card routing, codec phandles and amplifier supply have been reviewed in the V2 series.
    - Code and commit-message review assisted by ChatGPT.

 .../dts/ti/omap/omap3-pandora-common.dtsi     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
index 6e349f7ae6936..a5633d93547a3 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
@@ -69,6 +69,41 @@ dac: pcm1773-codec {
 		vcc-supply = <&vsim>;
 		enable-gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>; /* GPIO 118 */
 		status = "okay";
+		#sound-dai-cells = <0>;
+	};
+
+	sound: sound {
+		compatible = "openpandora,omap3pandora-sound";
+		status = "okay";
+
+		label = "OpenPandora";
+
+		amp-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		amp-supply = <&aux_5v>;
+
+		widgets =
+			"Line", "Line Out",
+			"Line", "Line In",
+			"Headphone", "Headphone Jack",
+			"Microphone", "Mic (internal)",
+			"Microphone", "Mic (external)";
+
+		routing =
+			"DAC1", "APLL Enable",
+			"DAC2", "APLL Enable",
+			"Headphone Amplifier", "VOUTL",
+			"Headphone Amplifier", "VOUTR",
+			"Line Out", "VOUTL",
+			"Line Out", "VOUTR",
+			"Headphone Jack", "Headphone Amplifier",
+			"AUXL", "Line In",
+			"AUXR", "Line In",
+			"MAINMIC", "Mic (internal)",
+			"Mic (internal)", "Mic Bias 1",
+			"SUBMIC", "Mic (external)",
+			"Mic (external)", "Mic Bias 2";
+
+		sound-dai = <&mcbsp2>, <&dac>;
 	};
 
 	gpio-leds {
@@ -736,6 +771,9 @@ &mcbsp1 {
 /* audio DAC */
 &mcbsp2 {
 	status = "okay";
+	#sound-dai-cells = <0>;
+	clocks = <&mcbsp2_fck>, <&mcbsp2_ick>;
+	clock-names = "fck", "ick";
 };
 
 /* bluetooth */
-- 
2.56.0

