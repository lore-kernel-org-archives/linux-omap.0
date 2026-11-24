Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.121
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505228;
	b=tdytHjLJIY0P8nInQX0H5cfE4nB+fN23oUD09NV7pX7JCXXh2Zm7Liay8lEoAzDx1ZpJ
	 XQN6WuNe9wkO1C4src5k+MEPoNvS9kxZkG6q0TC6k3t6rNzBfU5COeoNxSGjBNsK3Tgi4
	 zQNaN9PsPo/jQtkKPL4xNq3ACMRFF720V2t9n+cTxQTrZ2sgDzasQQhjq15p+z7aFMa6S
	 wfCDNoU3/k4o0Th8PXcjVVoKQEh+KlSEQtIAGBQ1F/XR145asjmzKGQ+zytrOuWLtPhlZ
	 yVwlRBpZiZWezF+GjakMW86i9KZp76U1RpKKmrolXpZBr/NMGdoyZ20ynAE7YfSA8hQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505228;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=ICzF0au7+zioXlv3o0PbRF5DUQ/dlcDYCA/hi2iZWyw=;
	b=aD+JXQBRDFYiEYquCC/IWCmKhGAsBb306oHTs3NwUjrNc5YZgjE01xn+wP74eImpdlYz
	 62efmH87bLLtFNkjdtZNb2Ov5ABcHHywSDCBxas/fPMQLUU/MIRlM0wVty/ThhCXl9FYG
	 KtLqpqaGQ4uHMvYkX7NR4IZiltK3VVFrVTagdmkik1ZDZr7jez0UQI0AmAduONbQD+IgV
	 6UnqrviuBocFsi1DJIOe93e+pl9IpG5buNKee+NYdYUzjIJwBBI2vMmsalSCf2Z05aRLw
	 ggwbgPmbYJtP1inuWPeQELdh3LApO4GBkKei3YGc+rRWCMv/t5MfvokfXn9uVjTuC8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MKebHGsW;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=F0hIcRQX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.121
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B260A2622;
	Tue, 24 Nov 2026 07:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA2B260A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MKebHGsW;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=F0hIcRQX
ARC-Seal: i=1; a=rsa-sha256; t=1795505187; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rXj33N5EJ4/upzUon20XjUHjbHzTZ3mB6sBsvZ29crnhq+XAfy2Vs3zfQSYIz4wKnt
    aKRXOFKeXasshGdtI6dL1r6kgTYMkzgnAfO4ZbPmvygrBZ6SHafK+2BMn8QfG3l0oMab
    zGGk8ItCc1+OgXgOlQpexihuebvGvpyyfa+kgw/aSFy51k8obYTsN1cyBuio2VbsalW3
    96B+CSNQe1wOIXpASqc3fGtIg42K6cZUm3VpTWTITrPAgSCumCjK3EMiNbp1tCTQN8pF
    CJGTFcS0Zyx3dxobXRGliCrGdHBcLJQHYmvjjblpbaXPSUaeotXcj7ixXVbgL9uB90l+
    +tFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505187;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ICzF0au7+zioXlv3o0PbRF5DUQ/dlcDYCA/hi2iZWyw=;
    b=R1sYPNk2RbpZLsD1g1R/2AmEX+lVCiWOXHvSH3dzhEzQOQoSttK0g/d+8S5GaVsiWg
    PH7QSruXpem6A3hE0yOL98HN02UXSYgg3dwbZZxdfOQfHNd7GJ/syDceCDfIfvU9cfIp
    lTcLqisSWJB2TJBdXxUhg/aWQyC7i6Xx7glfCtor9sck6PB4+fG2SNHaUxa1Jdj2AO82
    +b1SnFMam8geQsQ28kyw4tdVVRg671/i+I5KIJtVDrBnbegbjZLT+W+5N3MVzoh3UWb+
    hjEZweu1YYcLnioRN/vicIgL4ToNy7ph6k76iKUmmGUaUE4rdO2B53OOUQ7vqkzv1zwN
    lEsQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505187;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ICzF0au7+zioXlv3o0PbRF5DUQ/dlcDYCA/hi2iZWyw=;
    b=MKebHGsWd20CynMJtycAL1CWMMQPC3Q5ewZInE+iEP7mTgQQRANqLUPhQ87ysiK/wb
    DWY1sAg3VnGxml//nMgu/4z7YuEvfQaNRh+iVnKUeYckB4jPdENVapR8u4gbgeR6oayk
    87bKBsUtqf+exCs3W7Fg0O+AxrY/4cHYWrowvsYUvA8DD8GYeZcYZaASHAEcpBf2BcNh
    5+guMcwsXHojJyrVe2hgVr7QOZHeGaRN5x1KQQBO6f91CBx6WfA8CsFo6HivbYDs0d9G
    5OFRkQMmq1Tv4Q4J48jIpxn1r0woB7l9RwElIPP5HI7G55SDjf8hRfaARuiHQohbek6i
    EzsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505187;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ICzF0au7+zioXlv3o0PbRF5DUQ/dlcDYCA/hi2iZWyw=;
    b=F0hIcRQXfQdsW0YptLj7KSz7SCIza97TyYei6EsyAYtpiSSO8ZlJTtukC77omi6Nyk
    GMElw1yx0A6UY5wuXeBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7QQ1HY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:26 +0100 (CET)
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
Subject: [PATCH v2 20/20] ARM: OMAP2+: Remove Pandora platform-data quirks
Date: Tue, 24 Nov 2026 08:26:00 +0100
Message-ID: <1cb5bd7216b334e8c4eff21ff3463deeb6109595.1795505160.git.hns@goldelico.com>
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

The Pandora backlight is now described in the device tree and driven by
pwm-backlight. The sound card also uses device-tree descriptions for its
codec and amplifier GPIOs instead of legacy GPIO lookup tables.

Remove omap3_pandora_legacy_init(), its backlight platform device and
audio GPIO lookup table, and the associated board compatibility entries.
These platform-data quirks are no longer needed.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Andreas Kemnade raised bisectability and intermediate driver
      availability concerns for the V1 pdata-quirks removal.
    - Correct the legacy backlight name and explain removal of both backlight platform data and audio GPIO lookup tables.
    - Commit-message review assisted by ChatGPT.

 arch/arm/mach-omap2/pdata-quirks.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index b947bacf23a37..aca7097a692ed 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -268,27 +268,6 @@ static void __init omap3_logicpd_torpedo_init(void)
 	omap3_gpio126_127_129();
 }
 
-/* omap3pandora legacy devices */
-
-static struct platform_device pandora_backlight = {
-	.name	= "pandora-backlight",
-	.id	= -1,
-};
-
-static struct gpiod_lookup_table pandora_soc_audio_gpios = {
-	.dev_id = "soc-audio",
-	.table = {
-		GPIO_LOOKUP("gpio-112-127", 6, "dac", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("gpio-0-15", 14, "amp", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
-static void __init omap3_pandora_legacy_init(void)
-{
-	platform_device_register(&pandora_backlight);
-	gpiod_add_lookup_table(&pandora_soc_audio_gpios);
-}
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_SOC_DRA7XX
@@ -514,8 +493,6 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
 	{ "ti,am3517-evm", am3517_evm_legacy_init, },
 	{ "technexion,omap3-tao3530", omap3_tao3530_legacy_init, },
-	{ "openpandora,omap3-pandora-600mhz", omap3_pandora_legacy_init, },
-	{ "openpandora,omap3-pandora-1ghz", omap3_pandora_legacy_init, },
 #endif
 	{ /* sentinel */ },
 };
-- 
2.56.0

