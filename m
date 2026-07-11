Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FD31BCAE;
	Sat, 11 Jul 2026 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783750098; cv=pass; b=spaLiqcPCYTlhL6Y9wtcCuAYk2zI4WJZFZz5w+O9ESsqfcUY2SVCUDFEGHYxcSkGl7BM8DktDmjqR2kKgN3RrB4R+nAOGRpZ9tQ2NYq1xSZgeo5Za+3dbW8gXODpclCB3SpYKwa+oxoKj+SqU/VwsQyaKWC5es7YoWWoEmvavdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783750098; c=relaxed/simple;
	bh=dPmFEXPLHnRYfoZJD/I6aluZXKbNp8YLlXFCVB6SM3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1YHUu27CP1uqV8EFT9bXPGZFaoWsL57R+Fzt/dhjMIDKVOR3PHe/3f076eL8UKBsdfjZovqhbIPkxqLT9m7312tcirJ7Vcem+XnAqytJ3cFFgWHwUPBcyimztOrMkszPAZXC4VCvEg/mLwsYb71Y3VRPKmaHnd+2F+NgaJVg2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=W1Ae092n; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=DtMnNYBN; arc=pass smtp.client-ip=81.169.146.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="W1Ae092n";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="DtMnNYBN"
ARC-Seal: i=1; a=rsa-sha256; t=1783749730; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BbY7B4vaCGiOVfo8vBc77M70XHz9IGfhm8sXY5E1C90pMni4bdample4iB0RflMbOQ
    6N5mxN+uU17fC264F9i5rUIcl4NxQitAhZ/nbGMGOUYYlO/f4KUkFmbMV6DhAT2ON+un
    fEbYvnn7wb/KmNm/zRJR1y2Vk1l6a60K8KEkNEBnOhvlT+alLanspRTXX5zm5ttGoTa+
    ndxjf15TA7kFt6+vqHryEI7QxrQDXpBf5JoKLylRuGQNXt6gq2xnVkv80MSJbAHgQZRL
    8wHOOInfVjy6asmkfEkuUfbyXlOg5VTr9vi3486XNN7eTcVNkodnXHg2NVOgcCJqUHwR
    mEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749730;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7tiROIViVkULix+8N5uu/OdfiKd0ir+RKoC0z/PkkN4=;
    b=EE+olW3dQrCKi/Uys+SgAPhw5TFHHdY3n86Ih1NClrouAeHXujJoM+ovhWvEY0ANUD
    /CoTuOsbxUMsDkUx3aIzBVzrdi80mpoSF+D+2/jRcUZU1lZRrZtYn0j1c51yve1AJ2iL
    wWANvZPe9psDVGA+Yll2M7GffGMOrgBpHcDWjTFqhgR0sgzxSu8tB3mgfv2cMOgS4xSx
    DKcNm4gRd17AyO7l8vrVnkdVoMoId0oPKPAtHIsqSGooL58dZHDABVKIT+rz2Cw5NCEX
    lpV0EUuWcg+qPzqlOswT6PjKpb4ntSuU+/x0sdALNFbqF5IVsQm6dVr9lcgQ0tkBGFKy
    0bAw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749730;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7tiROIViVkULix+8N5uu/OdfiKd0ir+RKoC0z/PkkN4=;
    b=W1Ae092nFtKFWlOFhN43fYdetRQnkPVHcs8uVXzvbgFa7i4ZlwpBsCIV/jIKOrrJ6i
    nlB6tApUSIka+/QVxypBmfIHoq6lYLULc+GUu8j0gvjkk+E/+kKlJIgJpelieLakNhod
    AkXrjs25JulRxPa2UXyDrXc9BXxvmSKYm3FTQEAQQwaMNxcC2S5yRPQ+v8KBsV/19uyM
    PiDsfzfzsLNVf5paWTSRMvv4anIzQNjRQlnd3ycJhD1bwCpu9t2MO/3bP4TOJH34pEeJ
    jxIAmCckXWiy/1tAGq4gyWE/zy3TnlfBLYAwn/IQQ4bQp543URQqIZPANZkP6k20ju/O
    2HFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749730;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7tiROIViVkULix+8N5uu/OdfiKd0ir+RKoC0z/PkkN4=;
    b=DtMnNYBNF/gsV5P1J0NnLK++ooZfquiYReodGVFhPEKpWaCNfZt1prtneK/uVV25m5
    wE/qOc48RXn1z4pziVDg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426B629Ghn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Jul 2026 08:02:09 +0200 (CEST)
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
Subject: [PATCH 03/16] arm: dts: twl4030: add twl4030-regen child
Date: Sat, 11 Jul 2026 08:01:50 +0200
Message-ID: <ca467f11b708be8529de5e25b0863dce0d7edbb6.1783749722.git.hns@goldelico.com>
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

This is needed on some boards (for example, the Pandora), where REGEN is
used to drive external regulators.

Signed-off-by: Grond <grond66@riseup.net>
---
 arch/arm/boot/dts/ti/omap/twl4030.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/twl4030.dtsi b/arch/arm/boot/dts/ti/omap/twl4030.dtsi
index 07b9ca942e78d..e6f80b8f0a731 100644
--- a/arch/arm/boot/dts/ti/omap/twl4030.dtsi
+++ b/arch/arm/boot/dts/ti/omap/twl4030.dtsi
@@ -112,6 +112,20 @@ vsim: regulator-vsim {
 		regulator-max-microvolt = <3000000>;
 	};
 
+	regen: regulator-regen {
+		compatible = "ti,twl4030-regen";
+		/*
+		 * Since REGEN is technically just a signal that actuates an
+		 * external regulator, we do not know what voltage it will
+		 * eventually have, or what it's on/off timing should be.
+		 * Therefore, disable it here; boards that use it can override
+		 * the status to "okay" once they have set the
+		 * regulator-{min,max}-microvolt and startup-delay-us
+		 * attributes.
+		 */
+		status = "disabled";
+	};
+
 	twl_gpio: gpio {
 		compatible = "ti,twl4030-gpio";
 		gpio-controller;
-- 
2.50.1 (Apple Git-155)

