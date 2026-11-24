Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505223;
	b=K4/0PyZj25G7LOVKiu81CzxRbdXp/jwXNPJcMpXtwoqwOxakz/JjNWuo9iqnXFEXah7C
	 R2vELUfJljWYr6B2I4NbykMcBcSdOzVElNBGK6CsITlMdmgbd2x7ry974iQ4FpIdzx1fh
	 w0V5oRrPMHgdAk6ffyNjOjYwKoKbZcMYAUXOC2NgZLBj1c4MHduOa1wb4ZSwuIuy0/Jti
	 AFMiqYcuoUJs0S2QkDPRTd3fBm5T2d7mZ4qHU4cyq+JJfwoNrumllBqTEDzzYQ7HFkCt4
	 ErHbIm/KkwVKi7ATGhWipCl5/qYH95KukDbDdSmvXfY73IJFticy4lCgHGsHWngB/PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505223;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=adbm0DzSO3mJYHLc7cJuWzX3GDM1m8RObj3Et4x+Weo=;
	b=y8Axe42DmegpNv9EPvWwG+9BQguUwCaR7EGELeeEpLgEg8d4GDml5b2TMT/soskKbg6I
	 Pwx2qH69COYLj3kNQ3MJWMRs2cogDIGT07SXjfZ60ZA1KGDmpqk5AP+7THwuipndpgEP2
	 +dk08Q0kMRqolD5KRaLcRiTqA71ooFRU1psXzO6SQT5LarxYBtUXj3BcEy0PZr+nNk7CS
	 VGnyzsj/hxMhSbwvgn53xI4xSZZnO93SNJrdq8apFH1r/GnLfB7OSqp2/ltqKjNGDd6PX
	 /sFD7VRNGAlc4iW1xZGq68PlVu8FQ12uTEAZHGG2Csa3KqBX5W9yanCkaceIvLYbKwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=sjoeRwWy;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ARc606Vv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.124
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D8606A681;
	Tue, 24 Nov 2026 07:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A95D8606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=sjoeRwWy;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ARc606Vv
ARC-Seal: i=1; a=rsa-sha256; t=1795505182; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DucnJM3AhZn6SkPAKsBpAX/bZCQstTVhXrdEvPqOwpS9ZRbh3Asw/scuKJGQjQXJuH
    2rPil4Z2fSYZOI4WqrEijyipqAcsBjKxWmEQaUb7wQbt+j2II4z/LxfnLAyyIOikDDFm
    5knubW7nL99GXTD1wUztNm8bTWBnA9wlEXTSjJBHz1OuWQDhU9lyCeqchYggGYsiNQlH
    xVycQ94hs1JEcGFku7l7JT5yNc5T+58EXKJXLevQFKXOIiXUJ5roT3kesdCvMif8YvPu
    EMl663kbocbzH0BDL6jS71HKIxh6I0bFYMGiyEtcZx2RhjM/TCAc2hasdmYlkFfpuATY
    PHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505182;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=adbm0DzSO3mJYHLc7cJuWzX3GDM1m8RObj3Et4x+Weo=;
    b=XLQmyxQZsnUAqqRpeSuYpwVbaEf64X5pXFVaRiss2CULJpGSBoXU8qSMPRmJegY54n
    jonOh9PyL31mWIv65ljH2Sfn+pXIMdBjmwAstqTGrdaYJ24sqjMMPM6q0ZN4hyWkiKU2
    yX7qPJLM+l2j60cXesRVda9ZPB3T10yZ5QDdqhfy7OO6kr5nvOektqQZTOun6s8CmYPs
    q+03hOkIiVMJUCV06N/xrJMni7v+Pa8UM0RW715XZwcbsoXl6Oly4B+Nl/VPp7vIVslA
    AfpYlFPdgz0hA5I3FrherlNYWbN3T07vk8rayzhaLganKYwN5E4DX7Qf1FkHyh0cDiqV
    uYdQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505182;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=adbm0DzSO3mJYHLc7cJuWzX3GDM1m8RObj3Et4x+Weo=;
    b=sjoeRwWy32ESLe/xZiz6JbxIHsZoP/Aae7i5NH+rygVjLYpOSOjHofkXLNTcD5NvNr
    i87/Ddf5vp+8IO0rq+XPx/vkBqC7cBenAxJh7ZTxuIYsbZBj1BMbz84Wy0LUNmZIUzWr
    b8fsNHQFLSzm6aRT42UIwjG9IT1TyvJ0PDlnjVGPCkqtUGhXVTQBF2H8r/yok6flZQJQ
    TshtUeiB59W3A9C0hTLXBx+h5QJLUre2diVjl6PgpiCg/1y6qDyC+WKUOzASrn/Tg3S+
    nu7HPSuwzIYDVpERe0CPiFdtDtkCQuK4m9YwPRzmQ2MFWIHqxa0d8Rp3wdT6n461DoOW
    hCig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505182;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=adbm0DzSO3mJYHLc7cJuWzX3GDM1m8RObj3Et4x+Weo=;
    b=ARc606VvAJi/E1vAOJ//WCiLmxlauC8TnSvthekUEYyNZNIdEuFvL/I1iU8Kalv1It
    3bIsatUM5Xm7yF8wYFCA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7QL1HU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:21 +0100 (CET)
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
Subject: [PATCH v2 16/20] ARM: dts: omap3pandora: Describe PCM1773
Date: Tue, 24 Nov 2026 08:25:56 +0100
Message-ID: <770a015f333c1927fccee2663eb76a7de923dffb.1795505160.git.hns@goldelico.com>
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

Describe the PCM1773 playback DAC in the common OpenPandora device tree.
The DAC is supplied by VSIM and enabled through GPIO118. This allows
the PCM1773 codec driver to bind without platform-data registration.

Suggested-by: Grond <grond66@riseup.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Historical origin: 13b32c8cd102 (Grond, 2021-12-15).
    - The current DTS node has been reviewed for the PCM1773 binding and GPIO/supply properties.
    - Code and commit-message review assisted by ChatGPT.

 arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
index 2a5e8ba5714da..6e349f7ae6936 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
@@ -64,6 +64,13 @@ tv_connector_in: endpoint {
 		};
 	};
 
+	dac: pcm1773-codec {
+		compatible = "ti,pcm1773";
+		vcc-supply = <&vsim>;
+		enable-gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>; /* GPIO 118 */
+		status = "okay";
+	};
+
 	gpio-leds {
 
 		compatible = "gpio-leds";
-- 
2.56.0

