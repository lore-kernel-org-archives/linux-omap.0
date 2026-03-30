Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B393A16A4
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906549; cv=none; b=PM39GIAsy+kX5Wc4LelqHqSU7wJHvQkm58Pnu8YmKUzPTXS76RiD6DsNFiVCRSSQnn+BYVTtGxOHCYdL43Yoc59T31dlwzFw469eFZ3x5Jop5UB0bY708nmpzgZ1oeIzvd1ORCbUvhctqxZJRZMP2bI9J1U5HV3Y8RND35bspSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906549; c=relaxed/simple;
	bh=FBG264/as4xr5hoTu9a5yO1BMLPpFQRBi0Esu2p/Djo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meruUKorKdfHjFi20yzrHfwTQ6v+5/OH6XafS+DlUI6C5xi0VhlwtQ7AxiF+WjL6l8srx5ReXdfXlIvVV9yLdYSvW/wrBjU0VWf44enbMcEDAiyB3jtaTsFYl+yKTQui2Et9FYtHDm5TkZCkUNo23WMpkcHF/PT9PqiOYCaAVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qy7hVKPZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qy7hVKPZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3591cc98871so2135467a91.3
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774906547; x=1775511347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uL4VcJmIWiPMelM8MkKEBxP0uSyKH0wJwktcMh1N2Xk=;
        b=qy7hVKPZdv6OH7HWHOhV86/+AcZu86Qgva/XEDQlUVOK4uQCqYbcrlsibrFh64Sj8k
         Qec8g9a+I6gYaVPWLDs+/ft34phRaC8n2nxN6VO5/fmI/t3tpWhInr82nh/mCI/x2+2n
         5cpwMfaJbHchFV9AGMI30pqmvGMf1A/OO5W6Bz61Fta+otCOeIzroi671i+T/lYhkfOL
         AT9PdxkNP0tCBSSU27lv/jL1bjjqEhqv4ZofV+kUhEY/Z7eIE0HjVzSifHe4SXsCvdmH
         MLtwZD7rN+WJj9dQccauzg6yW+vx2kKBJBPQKx0okM5X7lxMf3tz50wVRlufLQa8Uy76
         EGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774906547; x=1775511347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL4VcJmIWiPMelM8MkKEBxP0uSyKH0wJwktcMh1N2Xk=;
        b=iO/KLOrmDEmA+qoaCfAbnvietG432JAowvDKRNd9UCXG6Dq8Ma1n1cvnxxD5Zk9UXX
         2CiYoyhww80Hyo00HgW7qgk2ng9wSPGX9AaJ/bZ6oyBRJtx9IM04xZL1basYceM840bL
         YDAW5vJ9450UPARRQqewCnygAEzJywqt21JJUU71VNG09f0LWtzvuYRVd6Q/3apwzCCi
         Kh3l4aXguYWtdhWZe8dku+lXA+Sg14hJLA+Zp2bNdz15aulf6etAP4sJ4e7zMF2KM7wM
         hoyIERwB22nBz2XHp3b/fDeKy0B2CvUmD18AjhE2ex+6E+VtYYq/8Dk7G+CC2Qu0BVV1
         BYdA==
X-Gm-Message-State: AOJu0YzMPGhx6LzG4tx3TraDOBpTVh1cdlCb6Gi3CrQsPBvIJ/783/Qc
	jdvMOmoJZ5PAN24PriHJtDmJjwJp/MXt5sDsGTahC7GpBh+4OL2xltgtPndAVBvp
X-Gm-Gg: ATEYQzxMV5KtGlHyt8xPZpZWAGJGGT8ZoCSYIsJQinjfljrTc7aav9hQ9rki6hSXEQ9
	b3fVBCsAX7zY5LWV9jpPQwUqoJ4Wtgi8UMOzuqY/4f3LL1aEmsYFezLKYvIRWLplvfzfkeA0K53
	JQffuwHGG2OlkaIILgzK3ExjhEL9PKHRJuD4VXrkzHXSSzQfmTEkrylWSUMpwhLY3d7i3hCrVkf
	zzN3/Z9J5RofmD9aTQbeY4xhIfoaSGOG3PRqCAKzhaxF6Tpofz0Sn1D8y4ZgPQ9PqI/oAvyep1g
	bOFcaXg2nBL3PRV3Eo7HHWOPQ/tt0fFvCyofJO1RRlTaLoJpNyk5DkrZ3AkFvUvWfAtDFSOB9vL
	5qRsncqQ4jI7BqUU0TV6wbpBvygxKQJ8GbsUYqOZEjhyHmwJcnITwZxFYMCr9Ld6LenS7dbXvyv
	yoJhRd2oKxRgX7ljNu+9FFOPTZqOE6E7KMYu7Ts/MQOw5bDjVE6DE5kzY=
X-Received: by 2002:a17:902:f54d:b0:2b0:5cb4:d894 with SMTP id d9443c01a7336-2b0cdc215ddmr134897835ad.13.1774906546605;
        Mon, 30 Mar 2026 14:35:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24278501esm93975165ad.58.2026.03.30.14.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:35:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv3] ARM: omap2: simplify allocation for omap_device
Date: Mon, 30 Mar 2026 14:35:28 -0700
Message-ID: <20260330213528.18187-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member (FAM) to combine hwmods array allocation
with the omap_device structure. This reduces the number of allocations
from two separate calls (one for the device, one for the array) to a
single allocation, improving efficiency and reducing memory fragmentation.

The FAM approach also enables bounds checking through __counted_by(),
which provides runtime verification that array accesses stay within
the allocated size. This improves security and helps catch bugs during
development.

Simplify error handling by removing the unnecessary multi-label goto
pattern. The new code is more straightforward: allocate, verify, copy
data, and either return success or error immediately.

Also removes the now-redundant kfree(od->hwmods) in omap_device_delete()
since the hwmods array is now embedded in the structure rather than
separately allocated.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: add a verbose description explaining why. Powered by Claude Sonnet
 4.5.
 v2: remove kfree and fix compilation.
 arch/arm/mach-omap2/omap_device.c | 29 ++++++++++-------------------
 arch/arm/mach-omap2/omap_device.h |  4 ++--
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 79db4c49ffc9..77a75b0b9ae6 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -307,35 +307,27 @@ static struct omap_device *omap_device_alloc(struct platform_device *pdev,
 	int ret = -ENOMEM;
 	struct omap_device *od;
 	int i;
-	struct omap_hwmod **hwmods;
+	struct omap_hwmod *hwmod;

-	od = kzalloc_obj(struct omap_device);
-	if (!od)
-		goto oda_exit1;
+	od = kzalloc_flex(*od, hwmods, oh_cnt);
+	if (!od) {
+		dev_err(&pdev->dev, "omap_device: build failed (%d)\n", ret);
+		return ERR_PTR(ret);
+	}

 	od->hwmods_cnt = oh_cnt;
+	memcpy(od->hwmods, ohs, oh_cnt * sizeof(*od->hwmods));

-	hwmods = kmemdup_array(ohs, oh_cnt, sizeof(*hwmods), GFP_KERNEL);
-	if (!hwmods)
-		goto oda_exit2;
-
-	od->hwmods = hwmods;
 	od->pdev = pdev;
 	pdev->archdata.od = od;

 	for (i = 0; i < oh_cnt; i++) {
-		hwmods[i]->od = od;
-		_add_hwmod_clocks_clkdev(od, hwmods[i]);
+		hwmod = od->hwmods[i];
+		hwmod->od = od;
+		_add_hwmod_clocks_clkdev(od, hwmod);
 	}

 	return od;
-
-oda_exit2:
-	kfree(od);
-oda_exit1:
-	dev_err(&pdev->dev, "omap_device: build failed (%d)\n", ret);
-
-	return ERR_PTR(ret);
 }

 static void omap_device_delete(struct omap_device *od)
@@ -344,7 +336,6 @@ static void omap_device_delete(struct omap_device *od)
 		return;

 	od->pdev->archdata.od = NULL;
-	kfree(od->hwmods);
 	kfree(od);
 }

diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
index aa8096ecb23c..fae09cfce137 100644
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -37,11 +37,11 @@
 /**
  * struct omap_device - omap_device wrapper for platform_devices
  * @pdev: platform_device
- * @hwmods: (one .. many per omap_device)
  * @hwmods_cnt: ARRAY_SIZE() of @hwmods
  * @_state: one of OMAP_DEVICE_STATE_* (see above)
  * @flags: device flags
  * @_driver_status: one of BUS_NOTIFY_*_DRIVER from <linux/device.h>
+ * @hwmods: (one .. many per omap_device)
  *
  * Integrates omap_hwmod data into Linux platform_device.
  *
@@ -51,11 +51,11 @@
  */
 struct omap_device {
 	struct platform_device		*pdev;
-	struct omap_hwmod		**hwmods;
 	unsigned long			_driver_status;
 	u8				hwmods_cnt;
 	u8				_state;
 	u8                              flags;
+	struct omap_hwmod		*hwmods[] __counted_by(hwmods_cnt);
 };

 /* Device driver interface (call via platform_data fn ptrs) */
--
2.53.0

