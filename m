Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4031F98D;
	Sat, 11 Jul 2026 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749770; cv=pass; b=XWAQ0yKH6AaWQY2G4RaghnM0uhTsIVen0jTAWy5F5Hio02Vyu50ehp8MYMH+wlgwz2J1HhuZFDdZPcD6Ne+esshQo7Uk1LM8ZXp4UQ5zFJjqNlM5z+/l+O2KEwnpexgMoUn7tVGaTum/VuSt43rDb2w6IKJET9U8WbB/hgRO+Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749770; c=relaxed/simple;
	bh=byxFi183F1E/GfsrzyzOEBkdcoXeAD4xHTu4rZaizYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y758KSrgWj5TxcgzhXYY26efAHSzK5pnKPq7duLG1VqTvzdOnAJNW/PieLDJ/1tU5FJoLPxhqJ3blviQR9icqoV4l5IwwIIKF22KeBHISJOoHKNF2WCbnA+MFHPWy9hWjS0g1fV3ecz+QOcNp6494gV9m/tLEX3GbCu+b3vVKMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=CcOxDknd; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=xicL0N4p; arc=pass smtp.client-ip=85.215.255.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="CcOxDknd";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="xicL0N4p"
ARC-Seal: i=1; a=rsa-sha256; t=1783749742; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TvICnOmawaAQ6qEGwLuu5J8KbqZq7R1NS+pDcPR6zGmqsK4v5pXy2s6hK8NRC4Otuu
    kF/p42VxYJmNJq4drofOCvc4vh9xSHD+mzAwhuq262M0sIlC/e7Ai0wmFRHMbDOodhCF
    m9lSb5/2rCKCXcvYEwjneFB2hrOpvW5wpFttDW5EIrK8uc6qVF6vz5lfLW/rGB9zv8Ti
    cHROHupgwRraAF1B39z8xR4iWRfd8I8JY9l3Oji1BD3KRxcVR1gLZd+WVZ13jdGg1UJM
    /fOsyrhHUtRmgGKgu2KnxRD7gGqMI+adwM5jXgh2yTw4cqwox9EbVlZkRJZNgSfJfatD
    atpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749742;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tTK+fNauRW/4gqqxGai+hoiJmwQwzk3dsJhL2tekNfU=;
    b=WIxSxTcYnF2kY0Weclg2MMkaL3A5T4S9ftUWd+gfl7Mc8hWxPVk4Y06Zmn9nmhVGHb
    eAqtDSO1xg8ooQvv8TxMSYEA+cQbeYLXhMla0PnCBQu0ct+sGBV0UkILmNdLYRB95+sn
    eZJFURIcURwO+4Xm43uhaXxUaNvR5O7kuvsQIVgWvzwNAdEfx50KjqDOYcTgN5S36Vcd
    UO4tq1g9sH3cc74BgAXtQSDAoHszd4MfIMewEICkJMDLtNS9JhmQvoLqmml5NRJVrdqE
    BbbUGbQRW2zm0iH3hnuRjM5JZTceQXJYkfqpWu6qAGcRq+VQdFwMnNP8mm8YF87P2lwg
    ttuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749742;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tTK+fNauRW/4gqqxGai+hoiJmwQwzk3dsJhL2tekNfU=;
    b=CcOxDkndXcy9PMb9HHQJsnU7aXgr2lrzwaTKLyqIlbgH7hgLgiZfsUZpvfp74KYs2l
    MIO+VX/Rg8Lu6lLrPTrIuyyCdHyPRJMH4xfHR1gTAx5GKS0aaaXjleAH8jvX3J8JmxwM
    wNfJTBd+hj3uYwrE7OX8RFzrRHHNoLjgx23/jfCQYxX3ZIGecN86fvE/egV6L67ALnwA
    8B8dhKzaig65tIPSbf8RReuLLrTObwHoMeNLq5foE4stqVnGmEmwLjtvQ//McW+RMzlu
    bq65677kvAXeBv1oX8F+Q+/5FycQQUXQY06K82ofYWsK/Koj2UshirFawMSYGe78yC26
    Ln4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749742;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tTK+fNauRW/4gqqxGai+hoiJmwQwzk3dsJhL2tekNfU=;
    b=xicL0N4pJboi0V/330GoUB+RrGDnoPYRZURj32SWZcAtJ+jrMpiDwKf+CYIadL8xDN
    DKdryULyMNUBgufmz4AQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426B62LGhx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Jul 2026 08:02:21 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Grond <grond66@riseup.net>,
	Stefan Leichter <sle85276@gmx.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Grazvydas Ignotas <notasas@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andreas Kemnade <andreas@kemnade.info>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sen Wang <sen@ti.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Niranjan H Y <niranjan.hy@ti.com>
Cc: letux-kernel@openphoenux.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	kernel@pyra-handheld.com,
	mfd@lists.linux.dev
Subject: [PATCH 12/16] arm: dts: omap3pandora: Add device node for PCM1773 codec
Date: Sat, 11 Jul 2026 08:01:59 +0200
Message-ID: <db90762f9df023299a8855ed60482a056544d591.1783749722.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Grond <grond66@riseup.net>

This will ensure that the new PCM1773 driver gets loaded automatically.

Signed-off-by: Grond <grond66@riseup.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
index 5907b2455f75b..de9860526b323 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
@@ -42,6 +42,13 @@ tv_connector_in: endpoint {
 		};
 	};
 
+	dac: pcm1773-codec {
+		compatible = "ti,pcm1773";
+		vcc-supply = <&vsim>;
+		enable-gpio = <&gpio4 22 GPIO_ACTIVE_HIGH>; /* GPIO 118 */
+		status = "okay";
+	};
+
 	gpio-leds {
 
 		compatible = "gpio-leds";
-- 
2.50.1 (Apple Git-155)

