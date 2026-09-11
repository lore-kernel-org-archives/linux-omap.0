Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D735E1CC;
	Fri, 11 Sep 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119104; cv=none; b=EYJpwY24PqJhTPoUfuD0u45BdN1a7JfclbWv7oVEZhkZvRn3my+bHVo0Msyfrh/gQsfqKiqhDhF+WPZEoBTtiEcokWv5BGgc3FVgpYQ4iYZT3ak1FRnOCt4opei/eYZTt5GKGF1o0O97veg4CxwOzEOlzXB5arAyge25VuIdTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119104; c=relaxed/simple;
	bh=EArwqju02I7Xzo5ITZJTsizIUFjx7Agcd6i6FF4JwD4=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=cTlMLZEieoAOKS/eQoVfh55lkFLDw+iW9vNHLx4eIUtP+iUbBcDwzAVT1hdmHEPBUHFCQsWo6gWV5L9abzRAsbOsoFHDbfwzjaoSFfHerS/4yAJ8osP2+9FB4uHPvHWYAzhBux1+uz38vj1fOvvoOr7oZ+z11e2zNv5vMraQvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=XHMOTKdI; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="XHMOTKdI"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1789119096; h=from:to:date:message-id:subject;
	bh=bZV4WNmYM3+Grp//mW6iYzrxlqH3yVKntecCVlgazV0=;
	b=XHMOTKdIIM9aniRpm4ykRlnZBh5NaA0lLWuWvMOa9lqDpxv8S+59XOLQCjN2jERsyPdDqCyhOTi
	VrqatJib1osTq8YMrw93alkQFwydClJoMt9YMIKTHx740mlBhVChk+adGcjFfPBe1TlDjc/TaZFCl
	mRfjxAGiNLWQ85JvAZg4nZElQIoZ/1MqqwXE/4p5I7DUKQ8FcZIE76pMKF1cZQZd/LycIhF9Dad22
	TWl0Zsqg3sH7GfSfZnWOrlfXCn0JpPgKAVoZFpa46B0cts4wXspXJkmmlVNcw0YDSpw5Yzoo/0stw
	oqYwFKIhFyWm60HXyKhaLGenR2xJQSuS6CcA==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 11 Sep
 2026 14:31:36 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 11 Sep 2026 14:31:36 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Fri, 11 Sep
 2026 14:31:36 +0500
From: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>
To: Eduardo Valentin <edubezval@gmail.com>
CC: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>, Keerthy <j-keerthy@ti.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH] thermal: ti-soc-thermal: Check return value of
 clk_prepare_enable()
Thread-Topic: [PATCH] thermal: ti-soc-thermal: Check return value of
 clk_prepare_enable()
Thread-Index: AQHdQdBXybVgwHSdD06fJ70Al9uVrw==
Date: Fri, 11 Sep 2026 09:31:36 +0000
Message-ID: <20260911093110.105635-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

On SoCs with the CLK_CTRL feature the bandgap fclk is enabled in
ti_bandgap_probe(), but the return value of clk_prepare_enable() is
ignored. If the clock cannot be enabled, probe continues and all
subsequent register accesses fail or return stale values.

Check the return value and abort probe with the proper error code,
using the existing put_clks cleanup path, which releases both clocks
and the TSHUT IRQ that have been acquired at that point.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8feaf0ce1a04 ("staging: OMAP4+: thermal: introduce bandgap temperatu=
re sensor")
Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/=
ti-soc-thermal/ti-bandgap.c
index ba43399d0b38..de9ad65d854a 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -953,9 +953,13 @@ int ti_bandgap_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Cannot re-set clock rate. Continuing\n");
=20
 	bgp->clk_rate =3D clk_rate;
-	if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
-		clk_prepare_enable(bgp->fclock);
-
+	if (TI_BANDGAP_HAS(bgp, CLK_CTRL)) {
+		ret =3D clk_prepare_enable(bgp->fclock);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to enable fclock\n");
+			goto put_clks;
+		}
+	}
=20
 	spin_lock_init(&bgp->lock);
 	bgp->dev =3D &pdev->dev;
--=20
2.53.0
