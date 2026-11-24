Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505226;
	b=GXuLTD+XcJ15nDexh6I26xr8YOZCGQaFoK1/VArQybZ6ZkQLFkrWGNEYKdMm6Tj42t/+
	 8UahoqyZxw5flG52MZ8LaiQS3YPCwGDRAk4Lq2aiGGUZJ+sR+SWQ3GgAZ81jc/qgY2FLE
	 ZJsL+bJmR78qdiC65rVXMZ173vsTKgpiGa28BY2VVpoz3MVtUlZD21VxpPoQgSS8Q51Cn
	 Kdt3c8qIGosiEvhHzIlTLXylOGDxalDjIGhSC1LXFIH+BT4rOo6YavHVAl9dGX1T9/rsG
	 5CknZq5blXcFQ0fO+byIZtz5ZE1WrnTuRUxd0VJwO/sSnDcmdiHsCWGW4Pu3vHzGHVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505226;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=SYzNkPbYvQQo7yNPwmd0sAr6WiPJx3HhprPOKza6D0E=;
	b=0nm2pl/1aZgS8Y8/4ch3toeaDBMq/08i4/DMA4NaIFTc1Blz/34Rh6ANgWM+orPHwBJn
	 pkQAlvSDJoEVb+ENsLUUCsZUXIVLsEJZKcQ8dCoOljCtWY5z47LJ2pwNLi772RpR+uNyG
	 iSnBzM5wSXdcm+mj12Stkd/J38xXwb3A4DaeMN+slLggjrvRqmnF3fD4JgI/0JvFYyibi
	 AvDV32qILd9sv5vey9tsBA+B3ib/uVynwUUVVw37q7VR1o1AyhdonhkUh6Oj+Vt97uP01
	 gj56A5SWLUxzC4sbYjPCakxGv9lD4etf1hIwOYsyuvFXf1+m2W3BsdbFVNDR0IhSX1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=DooFdn+J;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=MdT95aIP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.179
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350360A2616;
	Tue, 24 Nov 2026 07:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0350360A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=DooFdn+J;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=MdT95aIP
ARC-Seal: i=1; a=rsa-sha256; t=1795505175; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r0KnS64e12yAb+xUpv+VE1bMSfFh7RCI5+8eLK7Ve9lRovPaJAS/f7zj7uytKAQyOX
    vzRC5YOcB8jFm0pNL2BbccotYIlb/7pCWNuiEm/V3qmAfe2epG+0MVPIq97wxkXTxqsB
    sRUHvblqeQV13PLg1qK2T/uCs/3sh87CRoIC/8/wqfcaXPWR4OcStrZul01JqD4Erfek
    Q6Vf+pmtHjuv0IFi/BqIpXLmYjeWPNoChpFkOD1ZrmyQV64SV6FpW2yU6kj6AIwVahlu
    YUgdLAOXkWvnw2TBB4paLtZgNQcZ23TjzGJ1I/If/F/3CBOAeE5sdk+h0QSL1XpyW5Dg
    Z5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505175;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=SYzNkPbYvQQo7yNPwmd0sAr6WiPJx3HhprPOKza6D0E=;
    b=h5GS00KwcU+BciHtVw8Jl00OvbV0yN6RfwfJoaihtQBerZkmag2OWJwsQgjdJorUuF
    AljB512gCHD4NJZ0uV0NW3O2/F2Wzqs4IEobLAitFaGp1WZGrfmH0A+qShfIax6TNYOb
    Plz8gPJZ7cdBzKlEdI5tQbk0smsL+1E+Y2sWylDE3kqK8w61RFrhA9Au77eT6oY924MU
    OCHf+TYs6a6kxtNWQjY1F/DkmPbh6nazErTKLrrqOmUOCovZJmv2HDx3yFN7wjhPT5DV
    5xq8JAajr3fJ1FrWfQbNUTax2u6+af6wtU0UX5ifuDucfQaVDVepWeW8NCNlhAvupd+F
    PMGA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505175;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=SYzNkPbYvQQo7yNPwmd0sAr6WiPJx3HhprPOKza6D0E=;
    b=DooFdn+J7KPbRBYljAmwRxtO1M4emcMxxFR1+IbA+RWkDOQJhuCSoOf51sXjMer+So
    wVY8YYFIp3v6O39pvL6k2pWRBAdAfxdJLBwQFEnezmLo6CAUHwDk/G/wFgCE88vJZGRT
    0Tu9tDk5x5knsRXevVPCUYRto2GSjt0xeeS/ohR7jFjNouUsLSP7BJIsiAULQ+bsaIUp
    qCi9Sp/kXpsISyb8+eJ4Gwr2ZMlg5qbmCnfF0BKpTL96vNBpwIzIFFehi4UOyalStqxP
    HFrvlo2xHwRBL+C8HK5+qVxGkxBmchj1MA5XCPklEWEOL4iuFO2PRM4ne0LdqNgSHOik
    rPKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505175;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=SYzNkPbYvQQo7yNPwmd0sAr6WiPJx3HhprPOKza6D0E=;
    b=MdT95aIPcuSsAoSwcMsQ+0GOQUJyL2EwGrEVn/GrwZXBnkvhrKdakAsq+UYMUCyUMF
    KeDj6oktc3cd87BX8bAA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7QE1HL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:14 +0100 (CET)
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
Subject: [PATCH v2 09/20] pwm: twl: Support 64-cycle PWM frame
Date: Tue, 24 Nov 2026 08:25:49 +0100
Message-ID: <59fa3a5ee1a0d0bf13c85c08160c5acdaa95b7a4.1795505160.git.hns@goldelico.com>
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

Implement the ti,twl4030-pwm-frame-64 device tree option in
the TWL4030 PWM driver. When enabled, program bit 7 of PWMx_ON to
select a 64-clock-cycle frame and clamp the OFF counter to 63.

The shorter frame doubles the output frequency at the expense of
duty-cycle resolution. With ON = 1 and OFF = 63, a full-duty request
is approximated rather than producing a constant HIGH level; the
remaining LOW interval is short enough for the intended LED driver
startup mode detection.

Keep the existing 128-cycle behaviour when the property is absent.
As before, the driver does not implement arbitrary consumer-requested
PWM periods.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Add optional selection of the TWL4030 64-cycle PWM frame through
      ti,twl4030-pwm-frame-64; retain the default 128-cycle mode.
    - Set the frame-selection bit in PWMx_ON and limit the OFF counter
      to 63 in 64-cycle mode, including for full-duty requests.
    - Retain the duty-cycle calculation and register encoding of the
      hardware-tested working series rather than the later review
      proposal using ON = OFF = 1 for full duty.
    - Document that ON = 1, OFF = 63 does not produce constant HIGH;
      the resulting short LOW intervals are relevant for TPS61160/61.
    - Revised commit message to distinguish driver implementation
      from the preceding binding documentation.
    - PWM encoding and commit-message review assisted by ChatGPT.

 drivers/pwm/pwm-twl.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index 99c1caf4f19c8..70567d5805f43 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -25,6 +25,9 @@
 #define TWL4030_GPBR1_REG	0x0c
 #define TWL4030_PMBR1_REG	0x0d
 
+/* Bit 7 of the PWMx_ON register selects the short (64 cycles) frame */
+#define TWL4030_PWM_ON_FRAME_64	BIT(7)
+
 /* GPBR1 register bits */
 #define TWL4030_PWMXCLK_ENABLE	(1 << 0)
 #define TWL4030_PWMX_ENABLE	(1 << 2)
@@ -49,6 +52,7 @@ struct twl_pwm_chip {
 	struct mutex mutex;
 	u8 twl6030_toggle3;
 	u8 twl4030_pwm_mux;
+	bool twl4030_frame_64;
 };
 
 static inline struct twl_pwm_chip *to_twl(struct pwm_chip *chip)
@@ -56,13 +60,35 @@ static inline struct twl_pwm_chip *to_twl(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
+/*
+ * Note: this hardware (and driver) does not honor arbitrary periods.
+ * Only the duty ratio is implemented; the frame length is either
+ * 128 clock cycles (default) or - if selected through device tree -
+ * 64 clock cycles. Consumers requiring an accurate period must verify
+ * the actually provided period.
+ */
 static int twl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			  u64 duty_ns, u64 period_ns)
 {
+	struct twl_pwm_chip *twl = to_twl(chip);
 	int duty_cycle = DIV64_U64_ROUND_UP(duty_ns * TWL_PWM_MAX, period_ns) + 1;
+	bool frame_64 = twl_class_is_4030() && twl->twl4030_frame_64;
 	u8 pwm_config[2] = { 1, 0 };
 	int base, ret;
 
+	if (frame_64)
+		pwm_config[0] |= TWL4030_PWM_ON_FRAME_64;
+
+	/*
+	 * In the 64-cycle frame the OFF counter wraps at 64. A requested
+	 * duty_cycle of 64 (full duty) would therefore wrap to a constant
+	 * high output. Saturate to the largest value that still produces
+	 * a low pulse (OFF = 63, approximately 62/64 high) instead.
+	 * This also applies to full-duty requests from PWM consumers.
+	 */
+	if (frame_64 && duty_cycle > TWL_PWM_MAX)
+		duty_cycle = TWL_PWM_MAX;
+
 	/*
 	 * To configure the duty period:
 	 * On-cycle is set to 1 (the minimum allowed value)
@@ -353,6 +379,17 @@ static int twl_pwm_probe(struct platform_device *pdev)
 	else
 		chip->ops = &twl6030_pwm_ops;
 
+	/*
+	 * Optional short PWM frame (64 instead of 128 clock cycles).
+	 * Doubles the output frequency; useful for LED dimming
+	 * inputs requiring short low intervals during startup
+	 * mode detection (e.g. TI TPS61160/61).
+	 */
+	twl->twl4030_frame_64 =
+		twl_class_is_4030() &&
+		device_property_read_bool(&pdev->dev,
+					  "ti,twl4030-pwm-frame-64");
+
 	mutex_init(&twl->mutex);
 
 	return devm_pwmchip_add(&pdev->dev, chip);
-- 
2.56.0

