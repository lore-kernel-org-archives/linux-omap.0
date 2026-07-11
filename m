Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B561FD4;
	Sat, 11 Jul 2026 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749765; cv=pass; b=BaEsK6/CIs/rauwEkdkb4kifGb+eOjMp+FkNKiv1JzhiXyhS7bW8B5Q3NHTgV08v2X5MMd8gzp3TrCvSxQYE15G9aKhFdubHXC+vWWpL9A55mthjzE36GGt146ERiRrXN3ISt0BrYPdb/xLs2k//ujBi3lQj/UoszDo+n1y4Pes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749765; c=relaxed/simple;
	bh=gVLH3Gll/lrNoxOu6XuDqu7piiCuHfi0FO3rxwyky1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gg1EtC/6TEXhHVAaEFZsEAiVCDGyfdrKOjZl4EIa1ILU1k7tn8xKd6kiw4GbmCmsDJnaCOhMTB1yjgZMHcRb7tc7P4lTMroTsj/5GmRIY7ayZEu+esj4hF6ZMXPoemwhhI+kf2kyvdQzV15XjWFsKIBJbD4Wyll/E9EZzzy//2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=ODAdJdCE; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=WlvwVONf; arc=pass smtp.client-ip=85.215.255.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ODAdJdCE";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="WlvwVONf"
ARC-Seal: i=1; a=rsa-sha256; t=1783749732; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AxOWz8SVP1S6FOK1V10S8ZhkMMYVS2OCMbs43ygVVAZ8CKNTz01G+E3cIfvQLEayR6
    jqyYAvoq2G+wAzR3Y9G2O6B3vpvqzN7aWO5PeobQF/x4Qg/4UqngcKGHDZz1iAUWQSZK
    2FKFXSduwAjPkkH3efcWc3DC7W4DUiCw4vDoHTrplsQJQQ0s9hBhwZj5kD70BtXIx4yX
    8LI631cCp4Y9We/AlbQATRmQJBg2lgpwj/v/ZfPUjiuKZzSJSZWkW+B7GHZXDD5jw2Od
    IsV5QOIecP+lMoIdQQkgriOw7q9E/5T9Gn+VJnSwrq0RuTfzc4di9SiGICN0dz32q2z4
    f55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749732;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZB4drwZeCzFntaUbA8UcFyakx9+hGBaPBgbS+EjwmC4=;
    b=l4WFSASvq/2zX/sPgvqRYr3ZmbRO0tbYaWlwn3hAPdh5QAMzl5Bip0rZ6L/TFNBp0l
    TaUCmVp7x5ZGPbWZ0rYDrNP15p8CE8CplFPplOb6GZ3UzvCAGit4ib3smILsxNtRdH6c
    3vT/P2UFJqj3MjHisc/o3b1qmT+GjhTzHONnYELCNQrTh3Jh0d3UBM0wKFy7ZSYn5cdi
    eY4b+2WFoYQDlV8ug/6EagyXBB5GbUET+T0lsB/3PluXtEYIfhu8ES1f7a5uRFq8JiW/
    R+o2At4b65nilUOCHtC+NyPD5b3GmnbMtLPXMuGTyVIRU4xwb70gpa0i7Bc0Pjlyt4OI
    ybzQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749732;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZB4drwZeCzFntaUbA8UcFyakx9+hGBaPBgbS+EjwmC4=;
    b=ODAdJdCE+yCfnSBSmGovKKmGSNhHP8ROyYNBa7qHxAeLe4Ooqbr6zwQ7rK7ATdSRks
    MWFBNA53+Jmcv190NNht1gEYaUcx1W95J3OKKfagSGVyu8bNwkgJLLLjNGEZxZWFB70g
    Uo+GUi1We4MHyZB4s143zxxkm2bd7gtoMEdiqtVSpfRx8LIhKNrs3RUqdPJ4X5eUzRrR
    65BeDX1BHjfgpPU3LXI8va8kFDUcSEMbKK3gp2PnhXTBvnDO34J8zDKqMSVu3WSrm66K
    FNQRj9XTqM2cKPvZ/hNLKbCGTB16GfwLT8Vin6pbrGXxXRFy+jf3OjuLpKWsKkY1Czdy
    JJ2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749732;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZB4drwZeCzFntaUbA8UcFyakx9+hGBaPBgbS+EjwmC4=;
    b=WlvwVONf4WYr92wgA8G3MKGSSueqLjRrbW6fKtwcUtkCLnHy0dflC3i5XWSwwIh9MT
    onJo+t8VZVmM0oApg7Bw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426B62AGhp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Jul 2026 08:02:10 +0200 (CEST)
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
Subject: [PATCH 04/16] arm: dts: omap3pandora: Populate DT data for the TWL4030's REGEN regulator
Date: Sat, 11 Jul 2026 08:01:51 +0200
Message-ID: <d0b2a73c7c208f33784eae4219ff3981800ae6f9.1783749722.git.hns@goldelico.com>
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

On the Pandora, REGEN is used to enable TPS61029DRC external regulator
which runs a 5V power rail. The 5ms startup delay is taken from Pandora's
3.2 kernel, where it is labeled as a "guess". So it may be possible to
activate the regulator faster.

On Pandora CC units, this regulator is used as the input to the LCD power
supply. Therefore, problems are likely to arise if the regulator is ever
disabled, so we add the regulator-always-on property to compensate.

Signed-off-by: Grond <grond66@riseup.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
index 06c5b23589991..a0116823ffdef 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
@@ -486,6 +486,14 @@ &vsim {
 	regulator-always-on;
 };
 
+&regen {
+	regulator-min-microvolt = <5000000>;
+	regulator-max-microvolt = <5000000>;
+	startup-delay-us = <5000>;
+	regulator-always-on;
+	status = "okay";
+};
+
 &i2c2 {
 	clock-frequency = <100000>;
 	/* no clients so we should disable clock */
-- 
2.50.1 (Apple Git-155)

