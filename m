Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.103
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505234;
	b=06A1FMZSzjL6ckZi3wbg/d1fjb3xThCGTxfORbuZO7WJHAB6SlG92adtFe0KIonCsYAJ
	 NUp2XBp8UKsmfVs1mcUle/oSp4Vw7hVd6YXJJuhopcrMi0ivmzm9m88B08Y4oW1/wY0xB
	 U78mfTACSNUcJuIgMHbOkVOr0KZ5YaV47hRazho38lp4H3vA4VF1qvJH3PkELACfMtBLO
	 uIK+piDDwiY1Z/GazRgega7nH0hW7JQewIDJ3wi6TFqc+ZjER0HaD71lJmfxBN7B7mLa0
	 4MuiTQQGEAamBRla6SxQIpOF94j66EymNAfoVjqCRW7GMe2ond3GbEHLWwt+Uh5DkFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505234;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=gAIN7iE4u/BQ8emUvIO6sNS6XCYcMUaeapeftYIyo6s=;
	b=ov8aQhf7Epb2rLNmNhyRQksZTXuLL8mc/wUi0kebZdwsp+HTQhUzu2fG8gCMPCKDutZl
	 4CCIGZli5ENH+xdxnN7RILiYW4G1BWPQQBEEs4brh83/yEoKUtOytQ2b81MWhxMKj6rdX
	 XSVAdhTbATO03A2CoeOfJhHB9h9CLhCoMe4pLWL55Fe/2AJAp7zs1og6xufmZn29d1bqB
	 o9LP4YDB/MZZzCArL6Yvzp3QghjnhqqcO5eypILJTboVsmVpycHboHyOYb9DgBPfFa30n
	 yxm273kfehnT0v6DunPVMcz17FV5grSbdUjFAlrjASM1DRBvgq+0SFEgWGieYmKLsDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=a3KaLGJt;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=h3aJvplq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.103
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B77560A6F62;
	Tue, 24 Nov 2026 07:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B77560A6F62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=a3KaLGJt;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=h3aJvplq
ARC-Seal: i=1; a=rsa-sha256; t=1795505166; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Jw1B75AZR9r37pV72wMrabDcm66aq2L5065KPSA7+H3MAYiJokwL8WkpOc9nz+yebw
    R52KxSfyLCxevdO0Vh8pWaopgVt/J02yGiDaBIB6s78KG8Cw2ECT9wwXtQy/Cs6YFWBP
    52n6H5Tmf3gt/V4h9LdxzvISaAR3h5L0YUZrrykv4jFZTsERFEVmePoddeefHXt3x8Qi
    Q6vfLOD7VIcAX+wmBGJ03w2GTeQI7X7EWk4X0hZ1TjO8IIA9us1kXkQ9wJ+sDLZet9v1
    /fr9JZG3lUVFuwOFPdrTWsPfGYBo97jxKTpKajsmHyBbA62ig030qEZYxeUInLca+gva
    ghTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505166;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=gAIN7iE4u/BQ8emUvIO6sNS6XCYcMUaeapeftYIyo6s=;
    b=jaC9A0CwwPT26qXZECMleSSd86xcXk5Mftx5phl5RznaJES9XY4Oqdo5LBu/C0RFhe
    rWTsfelWx9RZx9/mXcw1MEII7a8U+91QH9/PgjLwgawrjUooBBBgfVyEExMgSCbMlArI
    lMg+XWZs3fEyJ4NJeAl0iwqMsaxRnaSc1WA4Qd6g5+cVE3ZZw5affwnQWPx8liomLWHd
    XIuTDJjF4VCjY1m7deqIvYEtb5alALG/dLXWpsgRlZMeeS93qumVRRadmZwvCVbtlKyr
    /ikXjkqlBmfRFsI/TMtODweKq6fVI1XrojjSB00/JUfhc8x5SVBu9Sq3JOLlvuyBK3g6
    0bHQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505166;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=gAIN7iE4u/BQ8emUvIO6sNS6XCYcMUaeapeftYIyo6s=;
    b=a3KaLGJtVvMLsOwdQZUYs+7gK4y5yMMC88fm09lTN7l6NG9gu8eI8W2icosjN3MpA2
    bj6C07vlxiYwLcPYf5IkR78Iqaoz41qwEoq8WUwjURKL22gWnOuuuLOfP+HjN9KNrTaE
    Lei5ojY3O7JlF8Hc1MihqnTEvrTrPZzGN5IoK7krNf4CFQvSh+R5yxJUvoaRqaz1Yz9y
    3xagrdTDB3n0mDS1sZE14Sn+jRVds2NJ3y1yPheBCRhVQt2KRPv+oFiMFrMj/s+zUYTF
    LHIAzqKyk2qD+bUdyyGEfw1Wkhjx+3NfNr4ib/LP/UazcxgirFOK+s1ooMG1J/EIxaXo
    BulA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505166;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=gAIN7iE4u/BQ8emUvIO6sNS6XCYcMUaeapeftYIyo6s=;
    b=h3aJvplqETdwNO8kY5RutWsO9gupBKll+2yH2AoQUGLuJZB0vkQ0wtDTAaen7gHL8k
    5hFyXlXfUyNF6mSyn3Cg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7Q51HC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:05 +0100 (CET)
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
Subject: [PATCH v2 01/20] dt-bindings: gpio: twl4030: Document REGEN GPIO
Date: Tue, 24 Nov 2026 08:25:41 +0100
Message-ID: <21030cf6957c49c8114829970cf64c2638050220.1795505160.git.hns@goldelico.com>
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

Document the optional ti,use-regen property for the TWL4030 GPIO
controller. It exposes the REGEN power-management output through the
GPIO controller so that device tree consumers can control it using a
GPIO specifier.

The property is opt-in to preserve the existing GPIO numbering for
systems that do not use REGEN as a GPIO.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Replaces the former REGEN regulator binding following Mark Brown's
      recommendation to model the control signal as a GPIO and
      Krzysztof Kozlowski's binding review.
    - Expand the binding commit message to explain why REGEN exposure is
      opt-in and how consumers use it.
    - Commit-message review assisted by ChatGPT.

 Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml b/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml
index 96d50d14c0710..25ba4328ac2d0 100644
--- a/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml
@@ -47,6 +47,10 @@ properties:
     type: boolean
     description: Enables LEDA and LEDB outputs if set
 
+  ti,use-regen:
+    type: boolean
+    description: Enables the REGEN output as a GPIO if set
+
 additionalProperties: false
 
 examples:
-- 
2.56.0

