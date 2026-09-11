Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E72457E7F;
	Fri, 11 Sep 2026 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118321; cv=none; b=Va3NAxzo6eXiUHjxZrAuB/BcK8hvbts6jWFfOqm8dLHV3/RxP6xmprONIjgFw+Uq4YPC45UpMHJiV+d198OJIldsuPcvNBt5OgLA14dUzAiuh24rSJrK5jMQrSIr9pQSxRKnMyYK9q+tCqjIHehEciEvZ/bLdShs1tPXVbPde+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118321; c=relaxed/simple;
	bh=ApdEgoZH1dgBxHvIv+0e7MfgGb6pDSn42A6a4+n2tz0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qmxcE0hST4U2QEVZZngoWo5QY3Ql17xyeXXreYucKMQHzy7Kgu7wOP7iAfQ9NxRvldUCqs1Y6g4VN2WkMlcMGSrEJupxJROIf6sy015jhNBXcm2lf5U7hQBqIZQGQQx3IEqkdASnxLQr/41ospABpuXhea1qiI3DG2UEZSHS8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tJAqiiC7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tJAqiiC7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8D1471A0184;
	Fri, 11 Sep 2026 09:18:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F40E601DE;
	Fri, 11 Sep 2026 09:18:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0483711C7AF8E;
	Fri, 11 Sep 2026 11:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789118315; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Pi280aKscbZWtx48WyA/m+mm+bipGQarzbh3f/AoSCY=;
	b=tJAqiiC7UNjrDRMgLCZsSYbHVMBAjq5SaRJ6I6dE8/dR7pYB6vG02xo2/MTUFoPO12ASP5
	cLbTby4cInOablVtGmu5bBM4wpgtB2L23bzd9wIZA2fYeYigiV5+7x/v3gOAJvBZIZvpIE
	nrqymhyIPHa2F8X19SfR9nhZRDQ85Klc2V03gvJ2Gxkg1QM32WnnYyNxaoAky/dVWVHYF8
	pM3JAXhXfTHudrDPefwvTc0fatcgjD945MXYwXjMe3J2dVDlHjaiHsd62Kw3wBgxmaR31h
	dZEzcf0AW0r68wqGCP5/ddWDfsfsw4MDrZQE9+aY0JWO2Dwzc/i2lNy/SAvcdg==
From: Diogo Ivo <diogo.ivo@bootlin.com>
Subject: [PATCH 0/3] watchdog: omap: Preserve OMAP watchdog across boot to
 detect faulty boots
Date: Fri, 11 Sep 2026 11:17:33 +0200
Message-Id: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3QqEIBBA4VeJuU4wk6J9lSVCc6wJylD7gejdc
 7fL7+KcCwJ6wgCf7AKPOwVyS0KRZ9CPahmQkUkGwUXFm4IzN6tVssPETjsXmayFrksjla0spGj
 1aOn8D7/t67DpCfv4u8B9P6t+dJtyAAAA
X-Change-ID: 20260910-omap4-wdt_boot-472b73d4af6f
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Diogo Ivo <diogo.ivo@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=ApdEgoZH1dgBxHvIv+0e7MfgGb6pDSn42A6a4+n2tz0=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqo8dnRm6skagbXWmI0/WA7BWeuDoOPhLGJ0dwb
 CAinST/NKyJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCaqPHZwAKCRAGvnxbVl7J
 RZUND/0UdFaJ2q8Y7He7OZGBOHYESlBSOYSRmpw+qEdyY1UclZ09E5BMc03QnuV9zaYwmiY4uwk
 E+pYr0lasTKdm082gd5Std4zPCayYWmNiYV6NBiaQNVb2EYuwLjnLR0qzsPojICpXwon66uq0UE
 W1p15WKtyb3lFZGdDkp4OhH0sipTiny6R+f6/zZqGQBs6xgmGCgANOYPMtGMpy3rfymRelRvafo
 YOWmVF8JW55o0knKSM70+6LlC/pW8vXcXxfUaTfbMhxLKnuJyEV7E/Md/sMWEk60zpj3bYCF5m7
 XLJXrrtSwSP27cXPZFz9oadZnSNxnFFmroldWMr0oimYXHI9oXnrkP7BpCk/nsMSsjE6F9tVvfJ
 db4Pq42YJHZf8tMwp+ZFvUPY24WZbk6cYOSmTAzN2vkTZ4bPDW4MnKdNCICxhd+Un6jVMTP3cBn
 1xWarpujhlXQI6Asf++woTuPkMaEBjwKiNBGMbDNMY75ZPWrwwqeGK0tte2xOZ3PYA9rHkw1Gyf
 op2kcWHULTBzrcaWWy49YThd4zayzXPeyFH3h1ermuAUF/1J+oHZtKnVffc/46xZz0Z+8F8byi5
 owjlytp1XraNIMHN+ySSA6ypfjtbaKy0Ef/8viO+L/imnkBDXhZf82BkX5a0QI7FG+TWve+ZP9l
 oOsAeIokS1GZGdA==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

Allow the OMAP watchdog to survive being stopped on kernel initialization
so it can detect a faulty boot in cases where the bootloader leaves it
running and the watchdog driver picks it up during kernel init.

- Patch 1 removes a duplicate omap_wdt_start() call left behind by
cd004d8299f1 ("watchdog: Fix OMAP watchdog early handling"). This is
unrelated to the main goal of the series and can be picked up
independently.

- Patch 2 adds support for reading the watchdog boot status. Probe now
checks whether the watchdog is already running and takes it over instead
of blindly stopping it based on early_enable alone. This introduces a
regression possibility, explained in detail in the patch's message.

- Patch 3 marks the OMAP4 watchdog node ti,no-reset-on-init so the
ti-sysc driver stops resetting it. A detailed explaination of why is
also provided in the commit message of the patch.

This series has been tested on a platform based on the VAR-SOM-OM44 from
Variscite, running a TI OMAP4460 SoC.

Signed-off-by: Diogo Ivo <diogo.ivo@bootlin.com>
---
Diogo Ivo (3):
      watchdog: omap: Remove duplicate start() with early_init
      watchdog: omap: Add support for reading boot status
      arm: dts: ti: omap: Prevent watchdog from being reset on kernel boot

 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi |  1 +
 drivers/watchdog/omap_wdt.c             | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)
---
base-commit: 83d343e6246c83e694548fec49856819124d32c0
change-id: 20260910-omap4-wdt_boot-472b73d4af6f

Best regards,
--  
Diogo Ivo <diogo.ivo@bootlin.com>

