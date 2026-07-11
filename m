Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8B2DA76C;
	Sat, 11 Jul 2026 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749768; cv=pass; b=qwqEQIJTUMi8a26brpwtB+riciQ+cTqFXeKILQH/uRKJWnM+hUYdD6Ae7A2N9reQF2Xt/FEVJ29koTMjJZaMR4Ywvz/vAtng9Io73ZglvbM/xZk6046Xmrgo0Hyqwg6vIzCQeEcVW2Nb2rgZy5gh/I//oANnP0ew1u1JEYznjNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749768; c=relaxed/simple;
	bh=ei8tTzxx2NWR0dqgcfVWSy/9nOD7csfapjKERc1nNY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9tx57HG8HZkPajlyXqQ+vaX7I49xrXLK64W1ReZn/L5T2JvHoJArOfTzrD92U+oOLO7QNMEVUOjCz2dEpIT/T1CayCdfHG8K/nwvApt6CBheE1PL2VftCFdL0q774e4X+BQs/pIIfWU3vMtj9Vxc8SzedkPAV3G8znuYXakIu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=kCyPgNlE; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=iEfMC90x; arc=pass smtp.client-ip=85.215.255.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="kCyPgNlE";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="iEfMC90x"
ARC-Seal: i=1; a=rsa-sha256; t=1783749741; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cbHhs1G/UB8S4rKpy+eTavrMAOsuDePdX6s96nPH2HHTTPdY0K5V7VMRv2YltrLVoN
    sae4VTf9/3We3uaCL81xymPMAEy3gUDZaFhZZSxOCl0ZXWYSSoiSnDC9JxoeaD6rQFPS
    enVYxcwemHQxj59LUXohlY3jaB+6R6B4SR96khHLocwZ3DEGG39mMI9Xpnm6Rg1pg50C
    5mVjQH2pZGJ1Tf+yrOa2+H9GBN0yyFNci76bPcjsPt7aM4K9Da0nZfo7ZbTqRIjWGfio
    cOd0+dfMUqdlNhyrxNirroMC2kEOPUPSyDQb6MwF5yYf0sUgm6CGOmwEDv5dgVmyFnnE
    6GGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749741;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HENgLEtB9pue7a+OzTC29B2VMtoMvD6SFjJxTuZhfas=;
    b=p/pEPqImHou+Mlwh+eAFeS0DZK5pnqKcoNMimQVpJw3SvlVwT9jmZQcJ7AJs+ZJLnp
    Vt6XHfDEREsyWvMIXCXD3cqUMgoLZAiWCPBy6K+zTIaKd7Hq8rI85JMA9uH/8ZrIaOW1
    0KQOW3s099HgsShU8rlBTsNbHv+3FRXGzN/KHfxOchLJVCdmG+NVtzbu0tkHQfv0zHVi
    rp0mmqUlack9CnXpOlja/VTAiYscGx71l2ne/YtYxikQUcxKVpX1BHzpOEZqNrgPdW8E
    teS0p8NZH09q5XBrJPnKfuS/otgzI78ccJzsKBMt8Gui5Gm8IGMyEc4VMRIEdClEUHHf
    yXWQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749741;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HENgLEtB9pue7a+OzTC29B2VMtoMvD6SFjJxTuZhfas=;
    b=kCyPgNlEM4WxjjWOyGgAWA0z8pH8EXo4zD3PLR4gCoHpQUxskyHxbRfxwSnBZ5PfnN
    i2EKNtSit5uobsCV2mOs3V+ZdkXkxaQqh5MZLMlSvaqqIBg/vqaPMLlYp/nk14eUOnhX
    tKw3hrjG6ciaYgOwMpyMleFu2Pqd6y4jb9KjIoEkI0DvbqLqQ6H6PKhqgPxU7XHPjX6t
    ci2HjVu9xo3nDuPzHhPfW45G1xTzgxZJ1JqiuYdXgeXJD0Tk4ECwVmQjo+LZIyeknYiE
    orZG0RFseD3G5ZfzviqbdxLrF8BDy8a4ulOxScM2j3m2dN7/hYoqJ8B3oaxnGSndxma0
    puqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749741;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HENgLEtB9pue7a+OzTC29B2VMtoMvD6SFjJxTuZhfas=;
    b=iEfMC90x31GwXTvNm+0LH5NqByU4WTMnLsdbXDP+vKKABTETSi+XsdwbCwVM3GWC0d
    FIlCftVoxFOwv2STJqDA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426B62KGhw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Jul 2026 08:02:20 +0200 (CEST)
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
Subject: [PATCH 11/16] ARM: dts: omap3-pandora-common: Enable audio in/out (mcbsp4/2)
Date: Sat, 11 Jul 2026 08:01:58 +0200
Message-ID: <88d0a95b354b27aff5ba548d3829ae7c31838119.1783749722.git.hns@goldelico.com>
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

From: Stefan Leichter <sle85276@gmx.de>

enable mcbsp2 and mcbsp4.

Signed-off-by: Stefan Leichter <sle85276@gmx.de>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
index b4acab1625212..5907b2455f75b 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
@@ -716,6 +716,7 @@ &mcbsp1 {
 
 /* audio DAC */
 &mcbsp2 {
+	status = "okay";
 };
 
 /* bluetooth */
@@ -724,6 +725,7 @@ &mcbsp3 {
 
 /* to twl4030*/
 &mcbsp4 {
+	status = "okay";
 };
 
 &venc {
-- 
2.50.1 (Apple Git-155)

