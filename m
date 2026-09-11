Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2894A46A5EE;
	Fri, 11 Sep 2026 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118326; cv=none; b=m+aiYUk69icYlnv+bwklSzEYIIex4KoOBAn+Kc2Sn8G46Ct2nAY5w0G7PB4ur8i7wCZ4kYq/1ne6QG3RfH6YKTpwv2i9my022XmtHlAVww8G7LxGqC/6S66Vlqc0dmJvYFvbTIoHzqNiT8ajKE5d0TcUzMPCQ0f9b8QRX4JGuJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118326; c=relaxed/simple;
	bh=838xy0F9X/VK0YPmnRqJ+ttIkFXS4oj9OMQoLICoUYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4TCJjEq/BE0Axg+9aaVR/zXBlG2gSfAmvCW16uEyYVOvg46uj3r3nZh7TrcpNsKoHp0JZ+X7jAw356KXN2lDSzQEK/kRZS/0CJ6QRyYk6N8iRIch3la5nPcA/oKV/f1YFpaQx5cOnDs+dVzrJnjAYpZ5RVvSmjjyHvTQmGflM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=exXL670F; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="exXL670F"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0AE29C653FC;
	Fri, 11 Sep 2026 09:19:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 533E0601DE;
	Fri, 11 Sep 2026 09:18:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96E6311C7AFA4;
	Fri, 11 Sep 2026 11:18:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789118321; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SYKJIY5q36jvMFs7Bja6orjyHSd3a65WX0v3LRrG3QQ=;
	b=exXL670FStLtHC7wvEfCGbEqHk8pdsjczKeUjV+37rX7w8dM/mPTTjURxXVdxxJicX3xtu
	BBNPbjhvcvH6HhVvROIQT0CnZLi9u8gTpCsbY4HW0tsCQzMIRKIYm0WsnjAsxS4/mSFrQG
	sffq6AVHuHt1of4l+oA33xFK8y3LimGukY4bz3R0vc1vyrKubyiOAY0uvWBBIr96G6n0RL
	RDzBh/h4FlJDY3KgWPiiJXAZlbQ7DE3hH9JJTEi6SOoJI3MXzRYvv6Cq8MT1bCh+Uo9tNT
	SNpTRbAWaHn2HEyB0b9ZH4QOqsyK4lyQ8OdZp/Hjuwic2/yRo/0akTnyXmslMw==
From: Diogo Ivo <diogo.ivo@bootlin.com>
Date: Fri, 11 Sep 2026 11:17:36 +0200
Subject: [PATCH 3/3] arm: dts: ti: omap: Prevent watchdog from being reset
 on kernel boot
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-omap4-wdt_boot-v1-3-637d778a4a1e@bootlin.com>
References: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
In-Reply-To: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=838xy0F9X/VK0YPmnRqJ+ttIkFXS4oj9OMQoLICoUYc=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqo8dndI7vfthcnQipmbIstb83LclhanENvnfro
 prDo2aPB0mJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCaqPHZwAKCRAGvnxbVl7J
 RackEACEHwGC55Gljg8w26w3wryBYrIegzP+TCiAG2IyUr6biVl1gCJS7+kxKBc/bo8nvOKhOQ1
 RvsrShDI1FDbvBBNLO7A2UsVfYmN4n62VYdQmazu7GP7BIsefV6IjjJK3cPj8Helhlk4u1hYclQ
 nrYwBXgpR/h0+3gcRXH2h4mVT6bzqpXB4DV8oQ6R7QRjylyPJ0O9Gg2yTT1dIgxBwa/tXRgFaPa
 nlvlNMswneWunZj1CuE7DO+j/7vWjex+WfTrM5XDfOfGxaxUcG2Xyt3Qp7BVqEyxpERfPrLtDnS
 qVtDa31id1f39cPgTqfdM90Ss0tSiz9nd/DMakW3ev/xE/1+RtQcEGxfj1a3Ywl3MZm2GFDrNxm
 KThXHCRebvFN2EzCDKqzwfRThMHxbAoZGkYj/ebUmYVom/bLUVbqtMBzlvRSj1GH/ATfVB7bEEz
 3haeDtxhTFjIAStWbOg19rVIxeFVwFYISYm0h6L6oKzYcZz7NHFcwAAPWyDmIhnoyWQahsSCrpC
 QF/rJzQofofxr1kviF4GEQhdf1K5MGNn6teZiZYvXuxOFLpYorgucXObPXnOK5aTI0R5Rg7xaiH
 X2c6Fu3oJ+urfgKtqvHChuqz4TaCiOIwuPXFt6VOWngvekVtglejxuHWhae24HoZV1MP04wSiEP
 ZUs+sQqJ0CYNspA==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

Currently the ti-sysc driver resets and idles the watchdog when it probes
its target-module node. In a system where the watchdog is being used to
detect a faulty boot this makes it impossible for the watchdog to do its
function, in an unexpected and time-consuming manner to debug.

Explicitly mark the watchdog node with ti,no-reset-on-init to prevent
the reset portion from happening. This allows the watchdog driver proper
to maintain the watchdog running.

Signed-off-by: Diogo Ivo <diogo.ivo@bootlin.com>
---
The ti,no-idle property is deliberately not added to minimize the
possibility of a regression on systems that were relying on the ti-sysc
driver disabling the watchdog and did not service it. With just
ti,no-reset-on-init we get a 3 second window for the watchdog driver to
probe and maintain the watchdog alive, otherwise the system will behave
almost in the same way as before. The only difference comes from introducing
the small 3 second window that could lead to a watchdog expiration on systems
where the watchdog was being stopped right next to its expiration, but
that risk is much smaller regression-wise than always keeping its boot
status. If this approach is deemed appropriate this patch should be
mimicked in other TI SoC's with this watchdog.
---
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
index c1afc49f456c..eb0e10e51ba4 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
@@ -1126,6 +1126,7 @@ target-module@4000 {			/* 0x4a314000, ap 7 18.0 */
 					<SYSC_IDLE_SMART>,
 					<SYSC_IDLE_SMART_WKUP>;
 			ti,syss-mask = <1>;
+			ti,no-reset-on-init;
 			/* Domains (V, P, C): wakeup, wkup_pwrdm, l4_wkup_clkdm */
 			clocks = <&l4_wkup_clkctrl OMAP4_WD_TIMER2_CLKCTRL 0>;
 			clock-names = "fck";

-- 
2.55.0

