Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505223;
	b=KNL3UnKpJ0Bmt3D+DCyk1IBpGfkAu2pgJ0uZgkyo0tJ970z1vGf45TnOstW0216eav4q
	 lQD/hngHHotsdJX6RoMgW6Yt0mUXTypKsz08zd+MXIoAEqSaNkfIC8dgYjxbY8iHw6qKT
	 M0xsfwYX3q9BkdMezUxvGkHlh9lTKEqCQ5Oavr42sLO/hMyGIkz6eCnA0x+yXJUVXa6Bx
	 +eTh8ADysTWg5a29N6J/RNrUFHJc0Z6IE7+ssRFT8ofNCLO+yzUi3B5SD/ngeU9yKIPMi
	 2CrL2liewyKhI5NQmuVeqf30qW2H/lfx4Mbs+XckWeBKzqWU2ztjPeDzWHhddzNWkRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505223;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=Ot92D5MoHTIRkYUwhd3d4KUBwDJQHCkfAJL/CWKuxWM=;
	b=M6Y4VS5kUhOtJkCezWd3WiQjlVXZOL/dGiR/ozSi8Z39AynNWx0crK2+X0KSaIPCyCsr
	 v5FBnElipVGRsDt/Pn5uN1XeawSyDKxvOGojitG4zpGCXJptCCPmT5YC1/pBK6ap9j0t0
	 eRTM6RwDIAEOhDjaXTXzPT/hG2QQcosGUyQk1h3LNGBBfDkXyHUUh0MxuW5khbHbLR3Xf
	 9x00UJ0hKoayfA3+rsj/ipdsRlyDWWwTEEg5r/0zxzQwrKvhpjl6WGP1W+FrFDPgq6vSe
	 8GfHceFDxf+Cc/ZU1itcBF1IEyAMbW/UuLTsIflqYWtm4YvWZwAm4/JPzGsXBNYjIMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="Q/GgECb/";
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=CFkLt1iY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.124
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BA606A33F;
	Tue, 24 Nov 2026 07:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A95BA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Q/GgECb/;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=CFkLt1iY
ARC-Seal: i=1; a=rsa-sha256; t=1795505184; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CJIxscNam66olrJ/AaAQZ1O8YhFitO9TT2ljpy/sXfZPTch1cD3AfFf0WxYSUCqZnU
    FwN+sHXQOQ51N4RGNsycAYnvcdAogg1jJhZE7gvCk8AIYRhJLFLA06llegG9glbElZFU
    kA4kLU9Bp/f2DXo0GqV+NezWyx4AX+/mQpYUYbphFshKjKzsPP0COsHi2zzcIJmyXvrm
    J64SGwFyzpfUSzElQ4xVxcT7KlCVQrTbVxxd+TIoydCFYx53bG7T+5hWQfPXRLdQaSkK
    c1c0mLX4yBrJK4gmQBV7XT/UZzAFVRK+s17ELnNQyTOQRpuuY6xrLfB4M3XwZoCJZXEO
    7UUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505184;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ot92D5MoHTIRkYUwhd3d4KUBwDJQHCkfAJL/CWKuxWM=;
    b=TWyW/tNPVK7vlrSnoxT9nHuoDx3GcJqgrFSGaRG4JiDqaEElUPUgeTiYWWNTfSzwq0
    LB5NFY2KBpXB3UPF4KFsNgplrfM3MvwrR9Va+zLQCsRTQeOS8lFhJY9gv+/zkJjZfmJp
    7xwKAXwLMpUcLCrt/HD232+H85GEnAVLn0t7qWAZkJD0Gjbn4C1QQjh4iQp7p64FP0eX
    ZfvnOfl8amPyseK/7XOZB6rI2w4/9Eg/G60M3Smg84HMdwbrhRoPcYLNDi3si3m/niFl
    EFrv4iK9XU9OuB4ASeZj3ECo/HYuzjytgW0ZURUOEL6MiCywB/JHGAf2cM67OkTAdOIw
    zoLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505184;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ot92D5MoHTIRkYUwhd3d4KUBwDJQHCkfAJL/CWKuxWM=;
    b=Q/GgECb/Jt9opnm8iAGQaiyDog/+KIMozneFyCYr8WoHhAf/+AZIeyMV80fa54u9oq
    FJDrTOMKu2NXfHHnrMAhhIw4JEGIbqgMlC9+MW018vtupk/D0LQrGMytl999FODByxmB
    hP7T6jMGgOgB1UwGA1DS3UkVBEgKG9FPARVCzdDvJZx43KGKT4gQVDiDS3bHrA3cyvzf
    ChKZYvQucBpupLmoxLuU9zROQlXF01Fm7Q5ewjeQZJBv/yF4L1lvVen0a7wtFrBkmHEh
    6uuz9lV80o4S5loxyJGtklOFSHOs89u81AKJ0P/sHLr3uGNQzRnLmfSVT1aPD/j0kbjq
    LMSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505184;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ot92D5MoHTIRkYUwhd3d4KUBwDJQHCkfAJL/CWKuxWM=;
    b=CFkLt1iYWD0LCR2302eGIJe2rOj81bNZlfQjh7vrmBTgCorrItqEi3AM0UfGsUqDNi
    YNcEW0Lvuy0Z3qgW/kAQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7QN1HW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:23 +0100 (CET)
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
Subject: [PATCH v2 18/20] ARM: dts: omap3pandora: Switch backlight to PWM
Date: Tue, 24 Nov 2026 08:25:58 +0100
Message-ID: <40321eb9223453f39536092d7095d3eff9901188.1795505160.git.hns@goldelico.com>
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

Replace the legacy Pandora backlight platform device with a
pwm-backlight device-tree node using TWL4030 PWM0.

Use the 64-cycle PWM frame and retain the experimentally determined
brightness table. Request full duty for a 10 ms startup guard before
normal PWM dimming begins. The TWL4030 64-cycle encoding limits the
actual duty to approximately 62/64, retaining short low intervals
during the TPS61161 mode-detection window.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Describe the 10 ms full-duty request and the actual TWL4030 output.
    - Brightness levels remain unchanged; duty is capped by the TWL4030
      PWM provider in 64-cycle mode (patch 09), not by patch 11.
    - Code and commit-message review assisted by ChatGPT.

 .../dts/ti/omap/omap3-pandora-common.dtsi     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
index a5633d93547a3..6bdfbd80b9fcd 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
@@ -53,6 +53,25 @@ lcd_5v: fixed-regulator-lcd-5v {
 		vin-supply = <&aux_5v>; /* logical enable dependency */
 	};
 
+	backlight: pwm-backlight {
+		compatible = "pwm-backlight";
+		pwms = <&twl_pwm 0 1922710>;
+		/*
+		 * TPS61161 analog dimming window: duty must stay above
+		 * ~20-25 % (below that the regulator drops out, LED off)
+		 * and the startup waveform must avoid long low intervals
+		 * that could trigger EasyScale detection. The enable guard
+		 * requests full duty; TWL4030 limits it to about 62/64.
+		 * These levels were determined experimentally.
+		 */
+		brightness-levels = <
+			  0 24 30 36 42 49 58 68 80 94 110 129 255
+		>;
+		default-brightness-level = <11>;
+		/* TPS61161: cover startup mode-detection window (10 ms) */
+		pwm-enable-guard-period-us = <10000>;
+	};
+
 	tv: connector {
 		compatible = "connector-analog-tv";
 		label = "tv";
@@ -505,6 +524,10 @@ MATRIX_KEY(7, 4, KEY_LEFTBRACE )
 	 >;
 };
 
+&twl_pwm {
+	ti,twl4030-pwm-frame-64;
+};
+
 /* backup battery charger */
 &charger {
 	ti,bb-uvolt = <3200000>;
@@ -737,6 +760,8 @@ lcd: lcd@1 {
 		reset-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;	/* GPIO_157 */
 		vcc-supply = <&lcd_5v>;
 
+		backlight = <&backlight>;
+
 		port {
 			lcd_in: endpoint {
 				remote-endpoint = <&dpi_out>;
-- 
2.56.0

