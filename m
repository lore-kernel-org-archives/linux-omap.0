Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033072;
	b=gP6dMugi2r663lLuhuxqgDb71C2qH70DYRhdQPy4aqaHT4oDGHDlHOZa3pZ84PH801ll
	 sMbHrjvOS2NPrGFta58EOJoO/D/L+rhG8IDzz8KyJafIMWG6ECQ18O7euNIgDcrZCcBo8
	 XJewJ89jFN18OVu6SznYWBdd6630Uu3yh6OEyPuyKnY29TdgR5VmqJxb7gr7RIYSBoMCH
	 7sOBGlRZuIEnQjO0azw5yaWeNxjcd80p1vqufYcd+PtfpeVk/qYw7dgC52BLiJNk6+xjF
	 gchVH3BDjJhnBGeue4rIZsNRrY6lkcJNNb8HKiwdAeUPa3NabU8CjzUXO1379H+inpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OcclpOoyR9VbzHL5lXvcmBGzh1lq20n1nrPwq5+OX9o=;
	b=D/GuKFlmYaXsAQgANNLyLu1eYx/6L2LUCmKT5MF8xhe+/W0vhvu1MkZLQJXpRp3P8dUU
	 qCuWhutJCaV8rBeigsZHAmVLH42CPFuvtfX7VawM2UAcT0zaTLh3KMczytoVq7LDMy3sy
	 DlevDXLyeQO69CPEGHqCuNDj1i/FXva2uUYZNxmW//v8e3JElpbCEZlBrr6lwOHuVJhwF
	 HiM3k4mfePulwhFYoQcaTgX0Q3IZN4QIPzIOdYgf4f7+vug/+Rx3UvKoeR7by6RzVDC9x
	 uBQQtcQNYuDb/CaJ6sC1kajkCuFTqXXfd50NZlM6Earhj8p+WnlgraDj7fTDRpDrs9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZYI+R8wK;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A8606A32D
	for <linux-omap@vger.kernel.org>; Sat,  7 Nov 2026 06:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E0A8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZYI+R8wK
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2211853eec.0
        for <linux-omap@vger.kernel.org>; Fri, 06 Nov 2026 22:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794033071; x=1794637871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OcclpOoyR9VbzHL5lXvcmBGzh1lq20n1nrPwq5+OX9o=;
        b=ZYI+R8wK5I1Y3OH9QuK415gbEyaFx5Z8BY5+x5BSZeL82bX19jJR6vtzgwmKF2xc4/
         OuIeOmziZ3r8oVwuSdsCzXiI3CXVW8jfWU0lHT1fxEfjKWSwxp8f2kBqDjTu+l5FnL2Q
         kq5t2A/BWCGD3/h8qJZCuqbtiZ8kFUK3x6f15VqRVK0JoPCLzZOL4NIlrCNVCqBaE8v5
         VyArRGf9EuyzLn2a+PinCdNbWy85Ul79UeUBe0Xh56TC4RXVoaqs92G77WfD4574mJYi
         8dpPydxCpgD/CigqjvIFn4j2HDvMwrZIUAEE75KyOBWrnfvvlOQDDJsQkYO8W2GGN8Tb
         zIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794033071; x=1794637871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OcclpOoyR9VbzHL5lXvcmBGzh1lq20n1nrPwq5+OX9o=;
        b=SC+shl2ekSvWSRKp0kCK/hhNPoZoVjfzwveLVFdY/Xp07ZrdV9W7CRBAVDItVIUNnM
         JnRAGy1rv/Iofzb4bcHtvARbgHD/ig7Twgq3yjVB6k33S9UAkXaPB5U0i8QmujmpSdM/
         tZw64yRIatEKJhpoeeIvQIy//1tC7SOWo8wtAJNoIlsSLfjAeWzb9ah5Tec8DkJPX4Ev
         BjBPWfQcSMm9vncaxfYZnaxJBiMwGWI9QRyaGLhdWRtwTEr5ryOan1GY56LPLfcBBRpx
         h+Nt2soZCDZyNGe26P/Wtwne/D6ZrxRAbmc+jRqvPwCudIkgYDT8dhvJ4Y3CQUrrkSd7
         llNQ==
X-Forwarded-Encrypted: i=1; AL+hErEglGNqfZJ3530RvSnamI2/3lhhq8h8PgcawSiGoB7XQMlkr+EyfVgMJWwMshlEdZsNKqk4sNG0pRw6@vger.kernel.org
X-Gm-Message-State: APuU4Z95zEUigzqaYpg+451Zp4IyhjvXA+ezob5XG6Hv7Du7txKMfoOQ
	DcIB7DVieB6IfZ7S2J7YZssEZYVnfzbZ4RvvH0EYI6ZudKYAXJ4ay4lH
X-Gm-Gg: AYBFou2Yrnz3ebe6hO3JAG7QG7fHf2EPpxbLrHAWSeG8v96mwTUFCabh1rLnkHwRFUe
	yPP7Cn5ey0K5eHNtE5VsETLlSt8op5mD5ZkIQrmi0mQly9MaDBO9R+oDkeb/IK4+Y6jrCyzBUZR
	6gDjBoLwrYCw9cyXayRWpgc1iDeJvDBq7enJbMhaXSfcIsrHCjHVLmqADT32a6NCacV4EJRvq/F
	+Fcx6zTKTGaM+p0o26LC1sUkaEdH8twcvipcZEFkW9BwLukhUFB2cHDgVaQpQxTitFxM/tsHw/W
	X7QRZgbHQnVMjSsL1v8OPtQzw0NoE8rsgdjZkez4mZ4dEFbxlY1n+Q3RhhYKst0ITbt/RWJ5aqZ
	aaoFsGKU/jQ+UarM5zwAMfnjv6Zl3LfT7cDo4W/AN2/Y19WuMb6L6PiOntJjFQl0ZneZCJFzjuA
	i4qvquElfa8oDeR/FplPmwVAAiHrX26gcWEEw9sRNXZMvAiqN228H1YapKV12IwmpXqd1IwfrSq
	sumsFyTnYmHRz4RgMyveK/1DlZvSLC7yT3MUnZMnap+1r6yjDmXVUdkMCQf9H48Gp9VEwVRZx9o
	VdYngyZIuYvIZYMZKXQS/ZXfBtab+c9sfF+P3uhNRcxuQRd0+ttSGQ==
X-Received: by 2002:a05:7301:fc0c:b0:369:9af5:7bc9 with SMTP id 5a478bee46e88-36f75f25cecmr6718753eec.23.1794033070720;
        Fri, 06 Nov 2026 22:31:10 -0800 (PST)
Received: from LAPTOP-LJ15R92N.localdomain ([49.43.7.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm12405728eec.26.2026.11.06.22.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:31:10 -0800 (PST)
From: Akshat Rawat <akshatrawat095@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akshat Rawat <akshatrawat095@gmail.com>
Subject: [PATCH] watchdog: omap_wdt: use guard(mutex) to simplify locking
Date: Sat,  7 Nov 2026 06:31:50 +0000
Message-ID: <20261107063151.441-1-akshatrawat095@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock() and mutex_unlock() calls with the modern
guard(mutex) constructor from <linux/cleanup.h>.

In each function, the mutex is held across the entire function scope.
Using guard(mutex) eliminates manual unlock boilerplate and guarantees
that the lock is released upon function exit.

Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>
---
 drivers/watchdog/omap_wdt.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 2a6de73e6f0b..956d9513a81c 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -27,6 +27,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/cleanup.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -133,7 +134,7 @@ static int omap_wdt_start(struct watchdog_device *wdog)
 	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 	void __iomem *base = wdev->base;
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 
 	wdev->omap_wdt_users = true;
 
@@ -158,8 +159,6 @@ static int omap_wdt_start(struct watchdog_device *wdog)
 	omap_wdt_reload(wdev); /* trigger loading of new timeout value */
 	omap_wdt_enable(wdev);
 
-	mutex_unlock(&wdev->lock);
-
 	return 0;
 }
 
@@ -167,11 +166,11 @@ static int omap_wdt_stop(struct watchdog_device *wdog)
 {
 	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 	omap_wdt_disable(wdev);
 	pm_runtime_put_sync(wdev->dev);
 	wdev->omap_wdt_users = false;
-	mutex_unlock(&wdev->lock);
+
 	return 0;
 }
 
@@ -179,9 +178,8 @@ static int omap_wdt_ping(struct watchdog_device *wdog)
 {
 	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 	omap_wdt_reload(wdev);
-	mutex_unlock(&wdev->lock);
 
 	return 0;
 }
@@ -191,13 +189,12 @@ static int omap_wdt_set_timeout(struct watchdog_device *wdog,
 {
 	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 	omap_wdt_disable(wdev);
 	omap_wdt_set_timer(wdev, timeout);
 	omap_wdt_enable(wdev);
 	omap_wdt_reload(wdev);
 	wdog->timeout = timeout;
-	mutex_unlock(&wdev->lock);
 
 	return 0;
 }
@@ -298,12 +295,11 @@ static void omap_wdt_shutdown(struct platform_device *pdev)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 	if (wdev->omap_wdt_users) {
 		omap_wdt_disable(wdev);
 		pm_runtime_put_sync(wdev->dev);
 	}
-	mutex_unlock(&wdev->lock);
 }
 
 static void omap_wdt_remove(struct platform_device *pdev)
@@ -324,12 +320,11 @@ static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 	if (wdev->omap_wdt_users) {
 		omap_wdt_disable(wdev);
 		pm_runtime_put_sync(wdev->dev);
 	}
-	mutex_unlock(&wdev->lock);
 
 	return 0;
 }
@@ -338,13 +333,12 @@ static int omap_wdt_resume(struct platform_device *pdev)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 	if (wdev->omap_wdt_users) {
 		pm_runtime_get_sync(wdev->dev);
 		omap_wdt_enable(wdev);
 		omap_wdt_reload(wdev);
 	}
-	mutex_unlock(&wdev->lock);
 
 	return 0;
 }
-- 
2.56.0.windows.4

