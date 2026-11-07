Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794011345;
	b=rQOT3R/Jxk1U8g0xgtn3DjZHphEDgHoYdUe1C4LSeoyCm7rVP2yvuKdcps0/pbeYD/Qr
	 5++WYGplDFliengBU59V34Vc8hKUTk3VRtrRqqmS526KRYU9O42EUVm9Xh65xGem4FX8z
	 CdhaeB8uRmZKCEGlswrpz+aSZs0b0B2ctw5pn/F3ZMu+HeiNtNKms5Vc30mWPMlihU0CO
	 FOGSKqAkvdElnJGWWpSM9oJhpwYsNO4tjNU8UWsSVDbaTeS5Ulu0nJhn32QZHlfS/JegX
	 Rb4w4Si7dmRXGO8jUp2Cs1RQBCe+WCZBqKF4A0K1ICJ3JlnJeuCjJP3GLEdA+0fxpjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011345;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gaBG4tF2dtj1yCCjozoR+3yiqRMFZ6QaunJVXhUcrbM=;
	b=paPaa5uRTStWnriujUEbKry181unrg+yba0G1WDQBVrMGdngDzz/4reII6ZmhvGcRXiq
	 nzp5vLalJ2Ce87ePYj3O/gb5qczmWYCf//TqK7THmKNjw6cCzx4Q6xKu2RyLyqclP+vpm
	 eL2vCQ0dyu4FSojl01CEjP6E+GSY/1eRrn9SkpaGVgR6IcLd6f6VyvF+pXAC5v4LfQRKs
	 v9u0JALIAMBNajZg4ZLZCNQhEc/+qCSvYxEzSR3vDAJhgICB78m3qMEiUE8SKYYQmtQNj
	 6MakD62njPrwJdduuvj4FDIgX+Z0lxEpDe0BdG/QRiE/8Rht1PHi1iCtNATeqBqJxNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZmlIxgyG;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HrTTOLEB;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EECB606A32F
	for <linux-omap@vger.kernel.org>; Sat,  7 Nov 2026 00:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EECB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZmlIxgyG;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HrTTOLEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794011343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gaBG4tF2dtj1yCCjozoR+3yiqRMFZ6QaunJVXhUcrbM=;
	b=ZmlIxgyGhzpGluHg3sDlJRanGC2YY/QxQcc4G9a/ePuWznQ2IQGv6Z8HwCb0tZVGn0fD+3
	cagfg9ZpmPTOMdwFBhFQJGAmrMnVhgvjskN4g7i2I7/xkd46KxwIzpxO3WyTNW/FuynVCw
	AydspPD5tMNLd4q8R4lztMi9HYRdW/M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-HnsoRZxzMvCFLPE1Ob1fmg-1; Fri, 06 Nov 2026 19:29:00 -0500
X-MC-Unique: HnsoRZxzMvCFLPE1Ob1fmg-1
X-Mimecast-MFC-AGG-ID: HnsoRZxzMvCFLPE1Ob1fmg_1794011339
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5358515b4easo23366371cf.0
        for <linux-omap@vger.kernel.org>; Fri, 06 Nov 2026 16:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794011339; x=1794616139; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gaBG4tF2dtj1yCCjozoR+3yiqRMFZ6QaunJVXhUcrbM=;
        b=HrTTOLEBQxI3/p/SwDs5wGowCzDv3qap7BaDopPDW4QgVtV71FgQ5dxjSDq/r/KP/l
         X8vMbe8KofIG/6ej0/YNwUEaznXMDewYEVaiXwm8kdRE6Odwg66CZYGVYC4/SBgkVUjG
         /2aEucS6IyUBmp3L1tZyV2ZWrKqWTM6qiSC0KkhGHJ/ZLNYruUAzSh+as/XZlGmyHlc2
         TeVrIVOazRp9hoL92k6ygi3P28VuaMQcJtT0IRBofI/wIGTrzHj4ba3KvUiGIIOJNt8h
         ui2ZF7XgOLFbcfrepIt0jdT2J1dgICVzZKHGeOpfFgp1Qdye9ZIbPEPypjbEJmOZf5BY
         bpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794011339; x=1794616139;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gaBG4tF2dtj1yCCjozoR+3yiqRMFZ6QaunJVXhUcrbM=;
        b=YUpwOh+vulRxtPwDqmIRMlFbLwphfn2RYdyMW1cLg4ZXAxlB/eLOLyonfrD3es0p1d
         hyShBHRI7aAVOOVN5RHQPtT7ly33M0cKIF0xXAE0CMCSTcsr5+UWbj/jZRPGttJItpZy
         CaL16LRlqEFeXxb2oADZQwXTw5WDF5gdPiCoIKWh2JJ/C+/OBv5eETEajFInFXgiOxtb
         SAK5fu2/A5sIQCxxndGR/4FUA/8uNu32VMx/9dGIHeXrGaHGUykufkqYeg/tK6MMI7Nm
         hzP0yShezqPx9ylcwRtqKaOr7SJW5aKJGSZC6LSrYpPVbKelgpeyJ1i67USfhQn8pADZ
         dLfg==
X-Forwarded-Encrypted: i=1; AKwUvBxbeoqwC8I7chiK783C5JPwXOVBCb7DCctx9BRa4CzhOUunCqknV61gyuRM/IglvOXM0Erx2bnp/2qw@vger.kernel.org
X-Gm-Message-State: APuU4Z+uchVpiZkcW+0cyCrJ+f1d5mSStnl/dw84TAts5XZ9g6LhpSFi
	hSAk4iIXCM77tcKDRDK/MjvpjI4YNmouSwaBuGnBXORfZgVeNIzjQUu4UPDj2IV5cjbqnszj5q4
	TwwzSN/GiN5yQLBOAthto05N3I6dUUZi9wSNIyTjKJ31ThBHQZJi+jFxwdx0EGrY=
X-Gm-Gg: AYBFou3mF0Ry1KZCedz6iiqZ8wguQjMGAibkEZryKfckskIUE7Z2EhVfJsLubdh1CWS
	JtnyvThf0Vp8CvcGGJRjvZ6+wzR2MEoxXjhOWc8nHBFIAnlMIVfIA6FVRXeD+S/TWRtCXcWyvAF
	omyUr4AfiwhXRGL5W7msTWJeRp94Okkh48ub+h+EkbHsMWSwGDXPYidRrscz94vqIoG6ck4SECS
	BeD3Ip//wLgHuMZJ44Aq6AXWc8TdN3lWhRrBzb3DMEbEYsTUoXDTbd9sJPXUn0qgxXocnpxvfVB
	wpPCvoEl3e43PQ95JCurfOGMq0XDJ/LwneA+BDIf4gNuCuFt2UJH2a+8x1RML2XVxF2awv2Ewjl
	YvP1IKEECXYx51HhsErVfshLbz+4Hk8Fv3X6LecyJp1jyqwTDiNqXe6dHDLNwy3kI4JclIUoSIF
	UgqDS2UfafY8691tr3
X-Received: by 2002:ac8:59d4:0:b0:536:458d:525e with SMTP id d75a77b69052e-54e14372689mr65272181cf.37.1794011339374;
        Fri, 06 Nov 2026 16:28:59 -0800 (PST)
X-Received: by 2002:ac8:59d4:0:b0:536:458d:525e with SMTP id d75a77b69052e-54e14372689mr65271841cf.37.1794011338715;
        Fri, 06 Nov 2026 16:28:58 -0800 (PST)
Received: from bmasney-x1.rmtuswv.csb ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e2625abafsm32950211cf.16.2026.11.06.16.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:28:57 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 06 Nov 2026 19:28:46 -0500
Subject: [PATCH] regulator: convert to subsys_platform_driver()
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-regulator-subsys-v1-1-1f91f4204bf5@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAyF4auUrKfQuMjCq4iLamONiEqiwwzi3
 aeOyw/e+08wVmGD2p2g/BaTdSnAl4N+jEtmL6kYqlARYiCvnI857qt6Ozr7mqcBiVLAFCJDuW3
 Kg3z+yaZ9XJYT9/vdgev6Ae7ZxCF0AAAA
X-Change-ID: 20261106-regulator-subsys-6f166d01d0ae
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, patches@opensource.cirrus.com, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.17-dev-d96cb
X-Developer-Signature: v=1; a=openpgp-sha256; l=28541; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=3BSZKVbX3zqJ0laX782klMVHOEsD6TNxuFJpqSfyqZQ=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLeFRydfTqg8erBbat+GOytdls66YZb3bazwZNXJTbZH
 Z4p8ZTTuKOUhUGMi0FWTJFlSa5RQUTqKtt7dzRZYOawMoEMYeDiFICJeDMxMiwOWqBbsW/LI3X5
 cumt7/3sJk7s5dGOv5uz9b3r/+JmzjxGhmsXG85t9VTI6pRZ8FiwcHpBgPwJrfuPl2hmLDZ6uMi
 ohwkA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Reduce boilerplate code in these drivers and convert them over to use
the macro subsys_platform_driver().

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/regulator/88pm8607.c           | 12 +-----------
 drivers/regulator/aat2870-regulator.c  | 12 +-----------
 drivers/regulator/as3711-regulator.c   | 12 +-----------
 drivers/regulator/da903x-regulator.c   | 12 +-----------
 drivers/regulator/da9052-regulator.c   | 12 +-----------
 drivers/regulator/da9055-regulator.c   | 12 +-----------
 drivers/regulator/da9062-regulator.c   | 12 +-----------
 drivers/regulator/da9063-regulator.c   | 12 +-----------
 drivers/regulator/fixed.c              | 12 +-----------
 drivers/regulator/gpio-regulator.c     | 12 +-----------
 drivers/regulator/lp8788-buck.c        | 12 +-----------
 drivers/regulator/max77693-regulator.c | 12 +-----------
 drivers/regulator/max8907-regulator.c  | 14 +-------------
 drivers/regulator/max8925-regulator.c  | 12 +-----------
 drivers/regulator/max8997-regulator.c  | 12 +-----------
 drivers/regulator/max8998.c            | 12 +-----------
 drivers/regulator/mc13783-regulator.c  | 12 +-----------
 drivers/regulator/mc13892-regulator.c  | 12 +-----------
 drivers/regulator/palmas-regulator.c   | 12 +-----------
 drivers/regulator/qcom_rpm-regulator.c | 12 +-----------
 drivers/regulator/qcom_smd-regulator.c | 12 +-----------
 drivers/regulator/rc5t583-regulator.c  | 12 +-----------
 drivers/regulator/tps6105x-regulator.c | 12 +-----------
 drivers/regulator/tps6507x-regulator.c | 12 +-----------
 drivers/regulator/tps65090-regulator.c | 12 +-----------
 drivers/regulator/tps65217-regulator.c | 12 +-----------
 drivers/regulator/tps6586x-regulator.c | 12 +-----------
 drivers/regulator/tps65910-regulator.c | 12 +-----------
 drivers/regulator/tps68470-regulator.c | 12 +-----------
 drivers/regulator/twl-regulator.c      | 12 +-----------
 drivers/regulator/twl6030-regulator.c  | 12 +-----------
 drivers/regulator/wm8350-regulator.c   | 12 +-----------
 drivers/regulator/wm8400-regulator.c   | 12 +-----------
 33 files changed, 33 insertions(+), 365 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 969554725a67..a02c21d7f9af 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -387,17 +387,7 @@ static struct platform_driver pm8607_regulator_driver = {
 	.id_table	= pm8607_regulator_driver_ids,
 };
 
-static int __init pm8607_regulator_init(void)
-{
-	return platform_driver_register(&pm8607_regulator_driver);
-}
-subsys_initcall(pm8607_regulator_init);
-
-static void __exit pm8607_regulator_exit(void)
-{
-	platform_driver_unregister(&pm8607_regulator_driver);
-}
-module_exit(pm8607_regulator_exit);
+subsys_platform_driver(pm8607_regulator_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aat2870-regulator.c
index 970d86f2bbb8..5f5ac84c6668 100644
--- a/drivers/regulator/aat2870-regulator.c
+++ b/drivers/regulator/aat2870-regulator.c
@@ -183,17 +183,7 @@ static struct platform_driver aat2870_regulator_driver = {
 	.probe	= aat2870_regulator_probe,
 };
 
-static int __init aat2870_regulator_init(void)
-{
-	return platform_driver_register(&aat2870_regulator_driver);
-}
-subsys_initcall(aat2870_regulator_init);
-
-static void __exit aat2870_regulator_exit(void)
-{
-	platform_driver_unregister(&aat2870_regulator_driver);
-}
-module_exit(aat2870_regulator_exit);
+subsys_platform_driver(aat2870_regulator_driver);
 
 MODULE_DESCRIPTION("AnalogicTech AAT2870 Regulator");
 MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/as3711-regulator.c b/drivers/regulator/as3711-regulator.c
index 0431a732cd78..510c4d5c0935 100644
--- a/drivers/regulator/as3711-regulator.c
+++ b/drivers/regulator/as3711-regulator.c
@@ -248,17 +248,7 @@ static struct platform_driver as3711_regulator_driver = {
 	.probe		= as3711_regulator_probe,
 };
 
-static int __init as3711_regulator_init(void)
-{
-	return platform_driver_register(&as3711_regulator_driver);
-}
-subsys_initcall(as3711_regulator_init);
-
-static void __exit as3711_regulator_exit(void)
-{
-	platform_driver_unregister(&as3711_regulator_driver);
-}
-module_exit(as3711_regulator_exit);
+subsys_platform_driver(as3711_regulator_driver);
 
 MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
 MODULE_DESCRIPTION("AS3711 regulator driver");
diff --git a/drivers/regulator/da903x-regulator.c b/drivers/regulator/da903x-regulator.c
index 2f85897183b3..084868adbff8 100644
--- a/drivers/regulator/da903x-regulator.c
+++ b/drivers/regulator/da903x-regulator.c
@@ -476,17 +476,7 @@ static struct platform_driver da903x_regulator_driver = {
 	.probe		= da903x_regulator_probe,
 };
 
-static int __init da903x_regulator_init(void)
-{
-	return platform_driver_register(&da903x_regulator_driver);
-}
-subsys_initcall(da903x_regulator_init);
-
-static void __exit da903x_regulator_exit(void)
-{
-	platform_driver_unregister(&da903x_regulator_driver);
-}
-module_exit(da903x_regulator_exit);
+subsys_platform_driver(da903x_regulator_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>"
diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index fbebe538a648..289711143d76 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -442,17 +442,7 @@ static struct platform_driver da9052_regulator_driver = {
 	},
 };
 
-static int __init da9052_regulator_init(void)
-{
-	return platform_driver_register(&da9052_regulator_driver);
-}
-subsys_initcall(da9052_regulator_init);
-
-static void __exit da9052_regulator_exit(void)
-{
-	platform_driver_unregister(&da9052_regulator_driver);
-}
-module_exit(da9052_regulator_exit);
+subsys_platform_driver(da9052_regulator_driver);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("Power Regulator driver for Dialog DA9052 PMIC");
diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index a0d3414aa79e..aadc4d762d3f 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -580,17 +580,7 @@ static struct platform_driver da9055_regulator_driver = {
 	},
 };
 
-static int __init da9055_regulator_init(void)
-{
-	return platform_driver_register(&da9055_regulator_driver);
-}
-subsys_initcall(da9055_regulator_init);
-
-static void __exit da9055_regulator_exit(void)
-{
-	platform_driver_unregister(&da9055_regulator_driver);
-}
-module_exit(da9055_regulator_exit);
+subsys_platform_driver(da9055_regulator_driver);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("Power Regulator driver for Dialog DA9055 PMIC");
diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index e0c96f10e570..fd7f57991175 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1037,17 +1037,7 @@ static struct platform_driver da9062_regulator_driver = {
 	.probe = da9062_regulator_probe,
 };
 
-static int __init da9062_regulator_init(void)
-{
-	return platform_driver_register(&da9062_regulator_driver);
-}
-subsys_initcall(da9062_regulator_init);
-
-static void __exit da9062_regulator_cleanup(void)
-{
-	platform_driver_unregister(&da9062_regulator_driver);
-}
-module_exit(da9062_regulator_cleanup);
+subsys_platform_driver(da9062_regulator_driver);
 
 /* Module information */
 MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index bf34ea440d77..6df44d60c927 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -1065,17 +1065,7 @@ static struct platform_driver da9063_regulator_driver = {
 	.probe = da9063_regulator_probe,
 };
 
-static int __init da9063_regulator_init(void)
-{
-	return platform_driver_register(&da9063_regulator_driver);
-}
-subsys_initcall(da9063_regulator_init);
-
-static void __exit da9063_regulator_cleanup(void)
-{
-	platform_driver_unregister(&da9063_regulator_driver);
-}
-module_exit(da9063_regulator_cleanup);
+subsys_platform_driver(da9063_regulator_driver);
 
 
 /* Module information */
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index f797cb504b9a..9d0c0513acfd 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -389,17 +389,7 @@ static struct platform_driver regulator_fixed_voltage_driver = {
 	},
 };
 
-static int __init regulator_fixed_voltage_init(void)
-{
-	return platform_driver_register(&regulator_fixed_voltage_driver);
-}
-subsys_initcall(regulator_fixed_voltage_init);
-
-static void __exit regulator_fixed_voltage_exit(void)
-{
-	platform_driver_unregister(&regulator_fixed_voltage_driver);
-}
-module_exit(regulator_fixed_voltage_exit);
+subsys_platform_driver(regulator_fixed_voltage_driver);
 
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_DESCRIPTION("Fixed voltage regulator");
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 6351ceefdb3e..53e65ae576df 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -371,17 +371,7 @@ static struct platform_driver gpio_regulator_driver = {
 	},
 };
 
-static int __init gpio_regulator_init(void)
-{
-	return platform_driver_register(&gpio_regulator_driver);
-}
-subsys_initcall(gpio_regulator_init);
-
-static void __exit gpio_regulator_exit(void)
-{
-	platform_driver_unregister(&gpio_regulator_driver);
-}
-module_exit(gpio_regulator_exit);
+subsys_platform_driver(gpio_regulator_driver);
 
 MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
 MODULE_DESCRIPTION("gpio voltage regulator");
diff --git a/drivers/regulator/lp8788-buck.c b/drivers/regulator/lp8788-buck.c
index 2ade249ab6df..d11b8dfb2656 100644
--- a/drivers/regulator/lp8788-buck.c
+++ b/drivers/regulator/lp8788-buck.c
@@ -523,17 +523,7 @@ static struct platform_driver lp8788_buck_driver = {
 	},
 };
 
-static int __init lp8788_buck_init(void)
-{
-	return platform_driver_register(&lp8788_buck_driver);
-}
-subsys_initcall(lp8788_buck_init);
-
-static void __exit lp8788_buck_exit(void)
-{
-	platform_driver_unregister(&lp8788_buck_driver);
-}
-module_exit(lp8788_buck_exit);
+subsys_platform_driver(lp8788_buck_driver);
 
 MODULE_DESCRIPTION("TI LP8788 BUCK Driver");
 MODULE_AUTHOR("Milo Kim");
diff --git a/drivers/regulator/max77693-regulator.c b/drivers/regulator/max77693-regulator.c
index a8b3a2058d34..71c03c5db8c3 100644
--- a/drivers/regulator/max77693-regulator.c
+++ b/drivers/regulator/max77693-regulator.c
@@ -287,17 +287,7 @@ static struct platform_driver max77693_pmic_driver = {
 	.id_table = max77693_pmic_id,
 };
 
-static int __init max77693_pmic_init(void)
-{
-	return platform_driver_register(&max77693_pmic_driver);
-}
-subsys_initcall(max77693_pmic_init);
-
-static void __exit max77693_pmic_cleanup(void)
-{
-	platform_driver_unregister(&max77693_pmic_driver);
-}
-module_exit(max77693_pmic_cleanup);
+subsys_platform_driver(max77693_pmic_driver);
 
 MODULE_DESCRIPTION("MAXIM 77693/77843 regulator driver");
 MODULE_AUTHOR("Jonghwa Lee <jonghwa3.lee@samsung.com>");
diff --git a/drivers/regulator/max8907-regulator.c b/drivers/regulator/max8907-regulator.c
index e59aa7a3ee54..f8f0a50161c6 100644
--- a/drivers/regulator/max8907-regulator.c
+++ b/drivers/regulator/max8907-regulator.c
@@ -377,19 +377,7 @@ static struct platform_driver max8907_regulator_driver = {
 	.probe = max8907_regulator_probe,
 };
 
-static int __init max8907_regulator_init(void)
-{
-	return platform_driver_register(&max8907_regulator_driver);
-}
-
-subsys_initcall(max8907_regulator_init);
-
-static void __exit max8907_reg_exit(void)
-{
-	platform_driver_unregister(&max8907_regulator_driver);
-}
-
-module_exit(max8907_reg_exit);
+subsys_platform_driver(max8907_regulator_driver);
 
 MODULE_DESCRIPTION("MAX8907 regulator driver");
 MODULE_AUTHOR("Gyungoh Yoo <jack.yoo@maxim-ic.com>");
diff --git a/drivers/regulator/max8925-regulator.c b/drivers/regulator/max8925-regulator.c
index c1532db0a4ee..348ab150603b 100644
--- a/drivers/regulator/max8925-regulator.c
+++ b/drivers/regulator/max8925-regulator.c
@@ -268,17 +268,7 @@ static struct platform_driver max8925_regulator_driver = {
 	.probe		= max8925_regulator_probe,
 };
 
-static int __init max8925_regulator_init(void)
-{
-	return platform_driver_register(&max8925_regulator_driver);
-}
-subsys_initcall(max8925_regulator_init);
-
-static void __exit max8925_regulator_exit(void)
-{
-	platform_driver_unregister(&max8925_regulator_driver);
-}
-module_exit(max8925_regulator_exit);
+subsys_platform_driver(max8925_regulator_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index e48ba694a906..a16c54162153 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -1166,17 +1166,7 @@ static struct platform_driver max8997_pmic_driver = {
 	.id_table = max8997_pmic_id,
 };
 
-static int __init max8997_pmic_init(void)
-{
-	return platform_driver_register(&max8997_pmic_driver);
-}
-subsys_initcall(max8997_pmic_init);
-
-static void __exit max8997_pmic_cleanup(void)
-{
-	platform_driver_unregister(&max8997_pmic_driver);
-}
-module_exit(max8997_pmic_cleanup);
+subsys_platform_driver(max8997_pmic_driver);
 
 MODULE_DESCRIPTION("MAXIM 8997/8966 Regulator Driver");
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 90651f4d1828..a29b19fbaf64 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -766,17 +766,7 @@ static struct platform_driver max8998_pmic_driver = {
 	.id_table = max8998_pmic_id,
 };
 
-static int __init max8998_pmic_init(void)
-{
-	return platform_driver_register(&max8998_pmic_driver);
-}
-subsys_initcall(max8998_pmic_init);
-
-static void __exit max8998_pmic_cleanup(void)
-{
-	platform_driver_unregister(&max8998_pmic_driver);
-}
-module_exit(max8998_pmic_cleanup);
+subsys_platform_driver(max8998_pmic_driver);
 
 MODULE_DESCRIPTION("MAXIM 8998 voltage regulator driver");
 MODULE_AUTHOR("Kyungmin Park <kyungmin.park@samsung.com>");
diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index fb3aa1cec1f2..1b634c334c30 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -460,17 +460,7 @@ static struct platform_driver mc13783_regulator_driver = {
 	.probe		= mc13783_regulator_probe,
 };
 
-static int __init mc13783_regulator_init(void)
-{
-	return platform_driver_register(&mc13783_regulator_driver);
-}
-subsys_initcall(mc13783_regulator_init);
-
-static void __exit mc13783_regulator_exit(void)
-{
-	platform_driver_unregister(&mc13783_regulator_driver);
-}
-module_exit(mc13783_regulator_exit);
+subsys_platform_driver(mc13783_regulator_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index b29cf6ba6f12..803db41b7363 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -634,17 +634,7 @@ static struct platform_driver mc13892_regulator_driver = {
 	.probe	= mc13892_regulator_probe,
 };
 
-static int __init mc13892_regulator_init(void)
-{
-	return platform_driver_register(&mc13892_regulator_driver);
-}
-subsys_initcall(mc13892_regulator_init);
-
-static void __exit mc13892_regulator_exit(void)
-{
-	platform_driver_unregister(&mc13892_regulator_driver);
-}
-module_exit(mc13892_regulator_exit);
+subsys_platform_driver(mc13892_regulator_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Yong Shen <yong.shen@linaro.org>");
diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index f82618a70106..3d8ee8587f66 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1669,17 +1669,7 @@ static struct platform_driver palmas_driver = {
 	.probe = palmas_regulators_probe,
 };
 
-static int __init palmas_init(void)
-{
-	return platform_driver_register(&palmas_driver);
-}
-subsys_initcall(palmas_init);
-
-static void __exit palmas_exit(void)
-{
-	platform_driver_unregister(&palmas_driver);
-}
-module_exit(palmas_exit);
+subsys_platform_driver(palmas_driver);
 
 MODULE_AUTHOR("Graeme Gregory <gg@slimlogic.co.uk>");
 MODULE_DESCRIPTION("Palmas voltage regulator driver");
diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
index 2d5fec1457d1..6a15dcc4fe4f 100644
--- a/drivers/regulator/qcom_rpm-regulator.c
+++ b/drivers/regulator/qcom_rpm-regulator.c
@@ -994,17 +994,7 @@ static struct platform_driver rpm_reg_driver = {
 	},
 };
 
-static int __init rpm_reg_init(void)
-{
-	return platform_driver_register(&rpm_reg_driver);
-}
-subsys_initcall(rpm_reg_init);
-
-static void __exit rpm_reg_exit(void)
-{
-	platform_driver_unregister(&rpm_reg_driver);
-}
-module_exit(rpm_reg_exit)
+subsys_platform_driver(rpm_reg_driver);
 
 MODULE_DESCRIPTION("Qualcomm RPM regulator driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 23ed594b574e..6242f7237836 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -1532,17 +1532,7 @@ static struct platform_driver rpm_reg_driver = {
 	},
 };
 
-static int __init rpm_reg_init(void)
-{
-	return platform_driver_register(&rpm_reg_driver);
-}
-subsys_initcall(rpm_reg_init);
-
-static void __exit rpm_reg_exit(void)
-{
-	platform_driver_unregister(&rpm_reg_driver);
-}
-module_exit(rpm_reg_exit)
+subsys_platform_driver(rpm_reg_driver);
 
 MODULE_DESCRIPTION("Qualcomm RPM regulator driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/regulator/rc5t583-regulator.c b/drivers/regulator/rc5t583-regulator.c
index a25a141e86c4..4633f996e6dc 100644
--- a/drivers/regulator/rc5t583-regulator.c
+++ b/drivers/regulator/rc5t583-regulator.c
@@ -153,17 +153,7 @@ static struct platform_driver rc5t583_regulator_driver = {
 	.probe		= rc5t583_regulator_probe,
 };
 
-static int __init rc5t583_regulator_init(void)
-{
-	return platform_driver_register(&rc5t583_regulator_driver);
-}
-subsys_initcall(rc5t583_regulator_init);
-
-static void __exit rc5t583_regulator_exit(void)
-{
-	platform_driver_unregister(&rc5t583_regulator_driver);
-}
-module_exit(rc5t583_regulator_exit);
+subsys_platform_driver(rc5t583_regulator_driver);
 
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_DESCRIPTION("RC5T583 regulator driver");
diff --git a/drivers/regulator/tps6105x-regulator.c b/drivers/regulator/tps6105x-regulator.c
index 7f99f3e90bec..e5a053e0ad06 100644
--- a/drivers/regulator/tps6105x-regulator.c
+++ b/drivers/regulator/tps6105x-regulator.c
@@ -98,17 +98,7 @@ static struct platform_driver tps6105x_regulator_driver = {
 	.probe = tps6105x_regulator_probe,
 };
 
-static __init int tps6105x_regulator_init(void)
-{
-	return platform_driver_register(&tps6105x_regulator_driver);
-}
-subsys_initcall(tps6105x_regulator_init);
-
-static __exit void tps6105x_regulator_exit(void)
-{
-	platform_driver_unregister(&tps6105x_regulator_driver);
-}
-module_exit(tps6105x_regulator_exit);
+subsys_platform_driver(tps6105x_regulator_driver);
 
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("TPS6105x regulator driver");
diff --git a/drivers/regulator/tps6507x-regulator.c b/drivers/regulator/tps6507x-regulator.c
index 6655d9c31187..aba2b41da549 100644
--- a/drivers/regulator/tps6507x-regulator.c
+++ b/drivers/regulator/tps6507x-regulator.c
@@ -443,17 +443,7 @@ static struct platform_driver tps6507x_pmic_driver = {
 	.probe = tps6507x_pmic_probe,
 };
 
-static int __init tps6507x_pmic_init(void)
-{
-	return platform_driver_register(&tps6507x_pmic_driver);
-}
-subsys_initcall(tps6507x_pmic_init);
-
-static void __exit tps6507x_pmic_cleanup(void)
-{
-	platform_driver_unregister(&tps6507x_pmic_driver);
-}
-module_exit(tps6507x_pmic_cleanup);
+subsys_platform_driver(tps6507x_pmic_driver);
 
 MODULE_AUTHOR("Texas Instruments");
 MODULE_DESCRIPTION("TPS6507x voltage regulator driver");
diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index 8f916ee366e5..329af2f878b7 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -516,17 +516,7 @@ static struct platform_driver tps65090_regulator_driver = {
 	.probe		= tps65090_regulator_probe,
 };
 
-static int __init tps65090_regulator_init(void)
-{
-	return platform_driver_register(&tps65090_regulator_driver);
-}
-subsys_initcall(tps65090_regulator_init);
-
-static void __exit tps65090_regulator_exit(void)
-{
-	platform_driver_unregister(&tps65090_regulator_driver);
-}
-module_exit(tps65090_regulator_exit);
+subsys_platform_driver(tps65090_regulator_driver);
 
 MODULE_DESCRIPTION("tps65090 regulator driver");
 MODULE_AUTHOR("Venu Byravarasu <vbyravarasu@nvidia.com>");
diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index b167ba22fe16..c30b0a330bba 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -263,17 +263,7 @@ static struct platform_driver tps65217_regulator_driver = {
 	.probe = tps65217_regulator_probe,
 };
 
-static int __init tps65217_regulator_init(void)
-{
-	return platform_driver_register(&tps65217_regulator_driver);
-}
-subsys_initcall(tps65217_regulator_init);
-
-static void __exit tps65217_regulator_exit(void)
-{
-	platform_driver_unregister(&tps65217_regulator_driver);
-}
-module_exit(tps65217_regulator_exit);
+subsys_platform_driver(tps65217_regulator_driver);
 
 MODULE_AUTHOR("AnilKumar Ch <anilkumar@ti.com>");
 MODULE_DESCRIPTION("TPS65217 voltage regulator driver");
diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index 1ab5767590f3..93fde5f81cc9 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -525,17 +525,7 @@ static struct platform_driver tps6586x_regulator_driver = {
 	.probe		= tps6586x_regulator_probe,
 };
 
-static int __init tps6586x_regulator_init(void)
-{
-	return platform_driver_register(&tps6586x_regulator_driver);
-}
-subsys_initcall(tps6586x_regulator_init);
-
-static void __exit tps6586x_regulator_exit(void)
-{
-	platform_driver_unregister(&tps6586x_regulator_driver);
-}
-module_exit(tps6586x_regulator_exit);
+subsys_platform_driver(tps6586x_regulator_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 3a3027e0b94e..84fba40263d2 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1260,17 +1260,7 @@ static struct platform_driver tps65910_driver = {
 	.shutdown = tps65910_shutdown,
 };
 
-static int __init tps65910_init(void)
-{
-	return platform_driver_register(&tps65910_driver);
-}
-subsys_initcall(tps65910_init);
-
-static void __exit tps65910_cleanup(void)
-{
-	platform_driver_unregister(&tps65910_driver);
-}
-module_exit(tps65910_cleanup);
+subsys_platform_driver(tps65910_driver);
 
 MODULE_AUTHOR("Graeme Gregory <gg@slimlogic.co.uk>");
 MODULE_DESCRIPTION("TPS65910/TPS65911 voltage regulator driver");
diff --git a/drivers/regulator/tps68470-regulator.c b/drivers/regulator/tps68470-regulator.c
index de7db7690f6b..7aef0c12fbcc 100644
--- a/drivers/regulator/tps68470-regulator.c
+++ b/drivers/regulator/tps68470-regulator.c
@@ -185,17 +185,7 @@ static struct platform_driver tps68470_regulator_driver = {
  * registering before the drivers for the camera-sensors which use them bind.
  * subsys_initcall() ensures this when the drivers are builtin.
  */
-static int __init tps68470_regulator_init(void)
-{
-	return platform_driver_register(&tps68470_regulator_driver);
-}
-subsys_initcall(tps68470_regulator_init);
-
-static void __exit tps68470_regulator_exit(void)
-{
-	platform_driver_unregister(&tps68470_regulator_driver);
-}
-module_exit(tps68470_regulator_exit);
+subsys_platform_driver(tps68470_regulator_driver);
 
 MODULE_ALIAS("platform:tps68470-regulator");
 MODULE_DESCRIPTION("TPS68470 voltage regulator driver");
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 5bacfcebf59a..05579f2ee0e2 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -660,17 +660,7 @@ static struct platform_driver twlreg_driver = {
 	},
 };
 
-static int __init twlreg_init(void)
-{
-	return platform_driver_register(&twlreg_driver);
-}
-subsys_initcall(twlreg_init);
-
-static void __exit twlreg_exit(void)
-{
-	platform_driver_unregister(&twlreg_driver);
-}
-module_exit(twlreg_exit)
+subsys_platform_driver(twlreg_driver);
 
 MODULE_DESCRIPTION("TWL4030 regulator driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 6eed0f6e0adb..5a7c6e2a5e0b 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -769,17 +769,7 @@ static struct platform_driver twlreg_driver = {
 	},
 };
 
-static int __init twlreg_init(void)
-{
-	return platform_driver_register(&twlreg_driver);
-}
-subsys_initcall(twlreg_init);
-
-static void __exit twlreg_exit(void)
-{
-	platform_driver_unregister(&twlreg_driver);
-}
-module_exit(twlreg_exit)
+subsys_platform_driver(twlreg_driver);
 
 MODULE_DESCRIPTION("TWL6030 regulator driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index d09864bae5ef..90942d0f439c 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -1311,17 +1311,7 @@ static struct platform_driver wm8350_regulator_driver = {
 	},
 };
 
-static int __init wm8350_regulator_init(void)
-{
-	return platform_driver_register(&wm8350_regulator_driver);
-}
-subsys_initcall(wm8350_regulator_init);
-
-static void __exit wm8350_regulator_exit(void)
-{
-	platform_driver_unregister(&wm8350_regulator_driver);
-}
-module_exit(wm8350_regulator_exit);
+subsys_platform_driver(wm8350_regulator_driver);
 
 /* Module information */
 MODULE_AUTHOR("Liam Girdwood");
diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index fb3ca7956d00..61627892224e 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -258,17 +258,7 @@ int wm8400_register_regulator(struct device *dev, int reg,
 }
 EXPORT_SYMBOL_GPL(wm8400_register_regulator);
 
-static int __init wm8400_regulator_init(void)
-{
-	return platform_driver_register(&wm8400_regulator_driver);
-}
-subsys_initcall(wm8400_regulator_init);
-
-static void __exit wm8400_regulator_exit(void)
-{
-	platform_driver_unregister(&wm8400_regulator_driver);
-}
-module_exit(wm8400_regulator_exit);
+subsys_platform_driver(wm8400_regulator_driver);
 
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_DESCRIPTION("WM8400 regulator driver");

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261106-regulator-subsys-6f166d01d0ae

Best regards,
--  
Brian Masney <bmasney@redhat.com>

