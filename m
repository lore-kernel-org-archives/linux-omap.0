Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3023264F5;
	Sat, 11 Jul 2026 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749771; cv=pass; b=O1nzfj6X9IOrHHznlxNqFy/r8EAKzdpYHuSnoREG2Xv1dgd/Hfo8PAbgxS/Bht6GLZqtjfYLY+HsRmIss8xajjXPHd0CYY2zkvwFK22wZ27RR9bVleg9CiQvClHiUhiKC+/RWEmAB2MwhgJipl0+ySIQIPu0BN4IwS09FO/NfQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749771; c=relaxed/simple;
	bh=gHzNRjwSJjbcr37jplQYfs//w3Z8goDW1tdy/3cSNZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Welyz72w4Q/GkrR6+7XU1UdRPVshJ7Z95YzVvyt7+35q2lZiUgEu4CfEfrjZQVtkNBdoUjBDPpl6WyQrMYwwFT6cx9S9QX2/cMiLNZPVx2oUta3yB8Cn1cbGd/IURP120CQJ8v1wUTxyhtsNdn3QSwK+0my88zXO4VVfPYwemnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=DsjtJ+yW; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=rAEbVbwN; arc=pass smtp.client-ip=81.169.146.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="DsjtJ+yW";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="rAEbVbwN"
ARC-Seal: i=1; a=rsa-sha256; t=1783749745; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rEKQcvgPuzF3DSEKNCIEmjFwHWJl8G4DFCL+RzQNbiCZUamh6K4Kx2BIMqLZwf0FdS
    2IooEYvGMEghIaLo8iXNUXHE6rSEr2HBPGpot7PsYW6d89ubt84pkVC4X9EfjlFbdD1q
    /Am2zmTbYa8uIuFjilbQlonx64ueydadG6IHHs/Nw4oDDX0zeqk7THXpeXVlvSpchPIx
    mS6EjzwgsMX9Qhzrf9nP+qnCa380DmxEbZKHcbHv7OXgM0uQJAYz9sYsQWw44U8FJPEM
    kr/Ip6KN/sOHSY/NIBwebtMhw5KFmTOVldhFhL5NN9ohnDnE9NFQgS9kbZbQ9ZGYzQ4/
    6K4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749745;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=SWpm4yra0YVt5/zp7rN7HY5VEk+YLEulFULLYXtLgbQ=;
    b=BrXc0GJPyiNyVMdcMgLreB6sPP2tqdS7nck1elLTZ0TQ4U4a+zN/5ztDV+foO6T7yA
    bvMJDlQM2xwSu7s6TAJrEeAGSEqjhP2jiywW2UoGoNBKY7Mu/JOxUvhpdVjbO/pJFMp+
    ArGHnPJ6OSDt2OlYlRGv+sZBzc+HgiO7HGMrYEZOqwel+ap9Ljl+X23ABAHo56acIOuV
    MbSFcO+pNwtDoQWOP3dOumJXo1rg37R69CR+N6RAonUakTXMKbc4uffNM4YpgfH0+TW1
    1jEQ1H+QKhcJEcafe9owptr5Nxyd2oOW30j4Lunp2KLLndsfzWmB5czNkrC35aWKoJ1c
    305Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749745;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=SWpm4yra0YVt5/zp7rN7HY5VEk+YLEulFULLYXtLgbQ=;
    b=DsjtJ+yWeQXeGXSXqayzMJFv7mIvd3himmCZ8aVwJqI7AJ6vYiFdDFp7pxEsoNbOD4
    B/+NhjSFGn3w/MohgisZorBTHTlAD2rUAmEPKzuL6G3HrV/h7DDN9bBvJhvFV7XZ0OK8
    Jqp7rUhyw8YvSl0OfVqP55prKr8SaFXoTFz9drv7wF9I53GJnUOu5NIdD2R06/VSwcF4
    sXN8EvBPPE823SJ8yOf1huBAVNXpbVfwmkLAERxGau77u5rDt3Xw2mDnfU8/fn4cwn0b
    rBKfJechv3HX4Vpakvvyd9c3xtuFZH3IeO+vGIp0nczvcCTSGP/EzJvzne6sOF5wqV5M
    JJcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749745;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=SWpm4yra0YVt5/zp7rN7HY5VEk+YLEulFULLYXtLgbQ=;
    b=rAEbVbwNm8gmkWWJ4kg92pEQvoOB/LZXTOFifk6HWsHiLmQ6vGhRcSnzE2IUnCIesb
    iWhaItEvuBz+aWs9j6Cw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426B62OGhz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Jul 2026 08:02:24 +0200 (CEST)
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
Subject: [PATCH 14/16] arm: dts: omap3-pandora-common: backlight: switch to twl4030 pwm and pwm_bl
Date: Sat, 11 Jul 2026 08:02:01 +0200
Message-ID: <e528e00899fb93f67e8480874fc114b21ae3e520.1783749722.git.hns@goldelico.com>
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

This allows to remove the pandora_bl driver and pdata-quirks.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
index 13821d926afb0..fea7132ce7c5e 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
@@ -31,6 +31,14 @@ hfclk_26m: oscillator {
 		clock-frequency = <26000000>;
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&twl_pwm 0 1922710>;
+
+		brightness-levels = <0 150 158 166 174 185 205 230 255>;
+		default-brightness-level = <6>;
+	};
+
 	tv: connector {
 		compatible = "connector-analog-tv";
 		label = "tv";
-- 
2.50.1 (Apple Git-155)

