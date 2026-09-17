Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A724C4A2E32
	for <linux-omap@vger.kernel.org>; Thu, 17 Sep 2026 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635719; cv=none; b=iBrM0Wrt97tN0Q+nibFwHEFI3iPXWcyc5WM/Y7PBVYwijmVVDpkXet3uP+Pbs/6WWQI/xnznqhPh1yIM2vXXeKIub5R9ccLNg7RiyY6IWWTdVyyglA3SfYlML3snEN1jDmD5VLC8/748ekJM/XiGHAJh+5DwiCRGMubSwiEy16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635719; c=relaxed/simple;
	bh=lv4i38JX0MPSPwizFOnHmQ/33Dj376/NZ6pziKSZq4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=alDeyON/sT9podsnpzwNHxye/Q3/Xm928DYZi0UQp33khdYGR8NLJuPaFqF3m3bN+6HMYK1o5xJ9BcAtFM5vvZo0Kd2rd16zzUlqBIgVXgB8yY4/QQX0xCcFKXhLsKZDOLuwxu1xpI/tzGmx8zDmRnyMsCe7oM2IvLAnrvmaJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nIefJ/yP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nIefJ/yP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 02CD51A0923;
	Thu, 17 Sep 2026 09:01:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C99245FAA3;
	Thu, 17 Sep 2026 09:01:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FF5311C7B07A;
	Thu, 17 Sep 2026 11:01:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789635708; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=eHBcWKK2OCT4aC468J13A1lKQqBlusqG57MbldRj4DI=;
	b=nIefJ/yPjRhUmv7Mc0T7kgv5gugg2+oXtkuB3ag5fPS1WN2WC29Teq5zNPPlIXrWi11olH
	Rsgw4sfhFwlbbuWiCi1uPoBlia846xN4eq2mXCFBK/5Xii+Hxb85zq4IgK8d66xJ7XU1QL
	1eeI1crcrqeHtzzr2P+7OXzQbP0gcWnUZ0ev4FYG+YR01t3byvdIIGbM6C7O2xVXY6I93D
	f2rsmjYsNK1gp0kEJkeExAWlz6E/2Q+qEP8uWhH3Y7blxyywosm2ie87m3cxuyflmhwfO7
	j0sylzhJfNANo3y9C95w0BYDqvkBOFfcUhoRhvXd6Xr9xy0amIQ3GAErHaBB9A==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 17 Sep 2026 11:01:34 +0200
Subject: [PATCH v6] ARM: dts: am335x-bonegreen-eco: Enable 1GHz OPP by
 increasing vdd_mpu voltage
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260917-fix_tps65219-v6-1-0544b735edb8@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAG2sq2oC/33MywrCMBCF4VeRrI1kpknauvI9RCRXDWgjTSmK9
 N0d3XhDl2eG77+yEvoUClvOrqwPYyopdzT0fMbc3nS7wJOnzVCgAhCax3TeDqeiFULLvdcIEjy
 ii4zIqQ/0f+TWG9r7VIbcXx71Ee/XH6ERueCm9lo0TmKNcWVzHg6pW7h8ZPfUWL1wwA9eEQ+yt
 cZKJ8CFby7/cUlct9qIqJRXvvnm6skRmg+uiDfWUllCHSvzzqdpugFAi18CZwEAAA==
X-Change-ID: 20251106-fix_tps65219-dd62141d22cf
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Lee Jones <lee@kernel.org>, Shree Ramamoorthy <s-ramamoorthy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 "Kory Maincent (TI)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3

The vdd_mpu regulator maximum voltage was previously limited to 1.2985V,
which prevented the CPU from reaching the 1GHz operating point. This
limitation was put in place because voltage changes were not working
correctly, causing the board to stall when attempting higher frequencies.

With the recent TPS65219 PMIC driver fixes that properly implement the
LOCK register handling, voltage transitions now work reliably. Increase
the maximum voltage to 1.3515V to allow the full 1GHz OPP to be used.

Reviewed-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
---
I was pinged that the following series was not fully merged: the devicetree
change did not land upstream.
https://lore.kernel.org/r/20251218-fix_tps65219-v5-0-8bb511417f3a@bootlin.com
---
 arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts b/arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts
index d21118cdb6c2c..f00abfdd2cbd4 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts
@@ -63,7 +63,7 @@ regulators {
 			buck1: buck1 {
 				regulator-name = "vdd_mpu";
 				regulator-min-microvolt = <925000>;
-				regulator-max-microvolt = <1298500>;
+				regulator-max-microvolt = <1351500>;
 				regulator-boot-on;
 				regulator-always-on;
 			};

---
base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
change-id: 20251106-fix_tps65219-dd62141d22cf

Best regards,
--  
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

