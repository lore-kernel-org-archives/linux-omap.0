Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505224;
	b=LZ3UXw6RG64DQdQs8BmtYLPb8NyNgdzDRKYJzu03otN1o2hwtuHpjb9cpYSVHORzrv01
	 sJYDNe38QUuyycJbOBPi1u7tOUNU/imFewBTEL+aQhv0t+AV0K4bj/oUbKEVriQkwRK0M
	 3wZCNJn8YfnWjYcm7Xo3EtnEFzq294m/GQSmHBr4YjnVwpDWsyZVdelbgQ7kTCafzu0hF
	 /VyI7wiJtu/eUowqUTNzq/sOHRkLSDoN8+//ZElZmrP3j3Z4F05YC5FtRfHtAjZQ9cpo8
	 AhmUQY1M/kUB2upR/Hk/3na7QyYG+4evRrJLc6YYy8SCPhoZ+FvncjXfUAU2NfQTGyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505224;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=p0BaxKrIdE2HsN3Ja7HpWqJ+iLOyCo7/lryZMOk9Zds=;
	b=Lt3QB4KeVY92AY1Ta9HpNR+yDZz8m6/LRgri7sHx6SdlO2Om0MLqYWStXvsiqTw3YU9z
	 qUOSNRZ1SWv8ymgcZ9og6V8fHJqfal4n8oJikyFa1EfXZ+jkFdUUmws8Ijy0gtTxH7oap
	 JWGoKvU8OLT3XGc3krBHGmN0qVv+iS8XkyiAFecAXFNStee+QtUQFavM2g/Z/QrNMh7EL
	 81szHymdr6wl6oMxXb45fkVOy8nNDWyQXakx0z6089l27L/cmR2Gf/mjzbofJU5RCoDJG
	 +VGmye3U+cllQQpHjvph9b0vTekeB407cMOo0LZD298CBZCIP/3K8GPouW/HA2kH9jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=YbDEV8rc;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="Olm/BN28";
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.178
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18E606A327;
	Tue, 24 Nov 2026 07:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B18E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=YbDEV8rc;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Olm/BN28
ARC-Seal: i=1; a=rsa-sha256; t=1795505180; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ja65IwRzIVuZrf8aqvZo56OV98volCTNfpCwSFGwBevGqS/C1Okjxx1PWTnKnDI6fp
    iiq9sfjHOmWCMWxpa4KzuLivtUlXiA2wwat1E8Qd7ZhOfDCHAi+M+XAxUUm6jqxs34SJ
    EbKBtcZzN2HOXXyHOXcqZbZ+0aPCa7JRK9/ZDXz9/QistcP6aZjz0BahEgIUtRoI0gru
    DO2LC1IIRKBA/c1lyzmcw7mLaab+zXUruW1QNTKMxQXs28vsHeOxoIyAugV+zOSquJbm
    qJ+0gzMngSlqZhLNbqNmB1VgvMrfPRTbjCW9J3SoYSoeKejW6vl91GK64o++k+CBa0QG
    txyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505180;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=p0BaxKrIdE2HsN3Ja7HpWqJ+iLOyCo7/lryZMOk9Zds=;
    b=XgUBwUy6LIIqFF6wAnUHq25OFOXMWQmaee/3/s7/f2K1ZUhU4NN4iiy5OeZhY/PmwX
    39tQ9JQsxPLu87AnWJLfY9DbbaOxUyGj2fAimvZMIDjB1TJ58jACPLn4PDRti+iFBKg9
    fLwOprUhux0F8BsRcgiRIPeQnWAQVMm/gqgk0VoVwZrxKhLuFbTc00WdsCdM5p+53hOx
    uOkaz/rZYjlXGHgAqdMsKwIRsah3tH4DftxHgH/1/tIpedZ+4qh/KlsGW4gVbLm3bux3
    qM0g+4i+M7clDbNHSi3/xfaubDJ+lRQ/zzP/WEicBdmv+SO1I9hC5GiVUpwsHqV3UWbp
    b7Rw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505180;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=p0BaxKrIdE2HsN3Ja7HpWqJ+iLOyCo7/lryZMOk9Zds=;
    b=YbDEV8rcyaTTlGpwGfQuyX/feHNLVh+J6kA/vwaGBq/BvoXHmxYQj+S84EIapvLyU/
    vVUL28BDukDSTc/RXfc9KkWlB/Oc8oK9Zj6CjeoJoERQ26Ut5B9RXMoj+i5R86tXY0R8
    Gts46ZXE4vlQHZ8fg2Z/8ojKlx1/qIQ/SlMPZucq52TIfq0wJe3jf+VcDt+fNs4UiH2Z
    CHT09CfLYZt86nFRWet/Y5yLlupfJ9mt5O7YrKuE0JlU6P5ViJfUsQ4x9ted6VsibpqQ
    bF8DFK7zqY7oYk/BFWejqk9NyEvgrg8Rvj/HM+3hEW73w5JvJVMbjxKiMvH7Ci7caBNE
    s+Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505180;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=p0BaxKrIdE2HsN3Ja7HpWqJ+iLOyCo7/lryZMOk9Zds=;
    b=Olm/BN28nL/1yF/2F+ZTN3ts71zWndwr67/ibW8r8/KA/vFCzj+lwNY6zsGcFaUqpd
    bf5PUgwH7G9s2d/cplBA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7QJ1HS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:19 +0100 (CET)
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
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Grond <grond66@riseup.net>
Subject: [PATCH v2 14/20] ARM: dts: omap3-pandora: Model LCD power enable dependencies
Date: Tue, 24 Nov 2026 08:25:54 +0100
Message-ID: <0c0bc2049bad3e236bab5fd86b8cd0b11fd56d11.1795505160.git.hns@goldelico.com>
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

The OpenPandora LCD power supply differs between mainboard revisions.

On revision 5a, LCD_5V is derived from the shared 5V supply and
switched by circuitry controlled through VAUX1. Both VAUX1 and the
REGEN-controlled 5V supply must therefore be enabled for the LCD.
On revision 6d, LCD_5V is generated independently from the battery
supply, with its enable input controlled through VAUX1.

Both revisions must use the same device tree. There is no
software-readable board revision identifier that allows the bootloader
or kernel to distinguish them. Nor is manual selection of a board-
specific DTB practical: the revision is not externally visible, and
users would have to open their devices and inspect the mainboard to
find out which revision they own. The original Pandora platform code
also supported both revisions without such a configuration choice.
Preserve that property in the device tree conversion.

Model the enable dependencies as a fixed-regulator chain:

    LCD -> lcd_5v -> aux_5v -> vaux1

This enables both required controls on revision 5a, while also working
on revision 6d. It does not describe the physical supply topology:
VAUX1 is not the electrical input of the shared 5V regulator, so
other aux_5v consumers, including audio and USB, also enable VAUX1.

A fixed regulator can express only one vin-supply dependency, whereas
the LCD requires two independent power controls. No suitable existing
DT representation was found that expresses both dependencies without
this artificial relationship. Use the chain as a pragmatic solution
with the existing regulator framework and a common DTB.

Unlike the old platform configuration, the shared 5V rail and USB host
VBUS are no longer forced always on; the regulator consumers manage
their enable state. Keep USB host VBUS enabled at boot.

The sound card node is introduced in patch 17, which must reference
aux_5v for its amp-supply property.

The 5 ms startup delay originates from the older Pandora kernel and
was originally an estimate.

Suggested-by: Grond <grond66@riseup.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Historical origin: 55b8da9ea16f (Grond, 2021-12-30),
      which described REGEN and the original 5 ms startup estimate.
      The revised DT models logical power-enable dependencies for both
      Pandora board revisions; it does not describe physical supply topology.
      The original contributor is credited with Suggested-by rather than
      an unverified current DCO sign-off.
      Code and commit-message review assisted by ChatGPT.

 .../dts/ti/omap/omap3-pandora-common.dtsi     | 34 ++++++++++++++++---
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
index 2097ec15c6513..f25fc4f8ad042 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
@@ -31,6 +31,28 @@ hfclk_26m: oscillator {
 		clock-frequency = <26000000>;
 	};
 
+	/* Shared 5V rail for headphone amplifier, early LCD and USB */
+	aux_5v: fixed-regulator-5v {
+		compatible = "regulator-fixed"; /* TPS61029DRC */
+		regulator-name = "aux_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <5000>;
+		enable-active-high;
+		gpio = <&twl_gpio 20 GPIO_ACTIVE_HIGH>; /* REGEN */
+		vin-supply = <&vaux1>; /* logical enable dependency */
+	};
+
+	/* LCD_5V: switched shared 5V on rev 5a, separate supply on rev 6d */
+	lcd_5v: fixed-regulator-lcd-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <5000>;
+		vin-supply = <&aux_5v>; /* logical enable dependency */
+	};
+
 	tv: connector {
 		compatible = "connector-analog-tv";
 		label = "tv";
@@ -212,15 +234,13 @@ hsusb2_phy: hsusb2-phy-pins {
 		#phy-cells = <0>;
 	};
 
-	/* HS USB Host VBUS supply
-	 * disabling this regulator causes current leakage, and LCD flicker
-	 * on earlier (CC) board revisions, so keep it always on */
+	/* HS USB Host VBUS supply */
 	usb_host_5v: fixed-regulator-usb_host_5v {
+		vin-supply = <&aux_5v>;
 		compatible = "regulator-fixed";
 		regulator-name = "usb_host_5v";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
 		regulator-boot-on;
 		enable-active-high;
 		gpio = <&gpio6 4 GPIO_ACTIVE_HIGH>;	/* GPIO_164 */
@@ -673,7 +693,7 @@ lcd: lcd@1 {
 
 		label = "lcd";
 		reset-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;	/* GPIO_157 */
-		vcc-supply = <&vaux1>;
+		vcc-supply = <&lcd_5v>;
 
 		port {
 			lcd_in: endpoint {
@@ -711,6 +731,10 @@ &mcbsp2 {
 };
 
 /* bluetooth */
+&twl_gpio {
+	ti,use-regen;
+};
+
 &mcbsp3 {
 };
 
-- 
2.56.0

