Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712263;
	b=SdZVFZc4v9JJCA7/buumnLsD5iruK7XLt4xY0ERmePcMHD5DjyK1Y8qOR00hp75oBD2c
	 KMakx4Duh2liuNu+qyVx7cnVerGjP0Vu7rhGqxykyn8gvasrfaegX0e5lxqeOpPAGekna
	 P9fQkm03Knyq0a9R8h6Jz/bWo88RmFdqxGJ/IjJ3iH8d20FCCo+zi83VMREtrww9xFySg
	 PNsO+Bpq1LmMWm51TO30pzi412lQFQqoLJnBZlJV6qsuS2i7ssGCA5buwroFWyOeshI0M
	 KFxgsagNFM9+Sx6i02Qe6cKf8sYpWXyjddrBhT6bvnRzHTSW0KGvfXiHeaHLNuUpj9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=2j0GMs1294BoS0QgCrjSsNNwFi17Dnm1SAfspQeLyKw=;
	b=0P28cxc6Nj8YVlvPLxwIvY7h+YVWHtUXyZKaSe4ivkBctUQhn6H7s9W51RWLjrjd9WS/
	 qL6y7da9Ir2PS6Gm9EB5/RDzal1VJLswP/76IxyP5i9pDBKjVDukuTIdsxAPgp+x8+W2P
	 Ru+/3n1m9gyjnHTeJRvrRioBboGZVsjnTI8MLjZlMWi+0aUx2/y8tk3J0GnONKdATIX06
	 Ao02u5nc75kqLH6UUf+DaKuSblVhOFkPz3r0U4KdxbykrZEw532iTK7/bSTzo2y9btfuk
	 ZbRJfvXUzSDQcCdMbhgaTu9CpmXJme0Dj2kxjyaEbDd4NYbvaSs30QZViRWIaqeJ7KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ftOEIgad;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA1606A329
	for <linux-omap@vger.kernel.org>; Tue,  3 Nov 2026 13:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38CA1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ftOEIgad
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso33242165e9.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Nov 2026 05:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793712261; x=1794317061; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2j0GMs1294BoS0QgCrjSsNNwFi17Dnm1SAfspQeLyKw=;
        b=ftOEIgadY8W0LAJnkXXgN0QtEq3/FP+QPVbndYenNNSBW9T1qhi8kSL3zwCjBwffS/
         a5aQGC/hg7bNcK/3BQh47VdySgCybacc032j9tUvbAGA8w9I9jN9qaMqjvIXgtVeaUpf
         yw0zXUu3X6yc4my7Ltu54Yde+oSBvHwUIAhp7ehOavw4DQZwgrj5l9KT7Atg/SwrAZq5
         Eah8hgcrQeFbzk6RK7x6mHX9Fk+Q6L6UNNOsGZgqN1t1HwWAGzVVuAVYd4QxBqgd5ru9
         1WBT9BL8kLOtpOrlWljRUr/59Wc5gztLPIcSORMVove8sgs7ete+Y9jrcCFPIqhBuKrQ
         dPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793712261; x=1794317061;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2j0GMs1294BoS0QgCrjSsNNwFi17Dnm1SAfspQeLyKw=;
        b=fzHzJHF5Qj8KMcTMMcA4mi0EWUgvMZOaIrDJrOLP4sKJN/vFanzwOB44gnKY48BaW0
         ED8+ZDCUOsgv72Zp/qx0jpfA4BFkfVwcRa8qBxqwfNmVkJAJVRJyoZe/vzF923V3kc6n
         jcQgeKAtKXuQ4iXuvCWkuA7uf7v83kGE9RCzGijC7CO7sta0gvf49ohSPKV/bpChmVLU
         vZF+IamYScQOYqqNjj7fCh6wsfoTSRutBcxcsOFM0bfnF3CgxUeHLdBUTof/vLmV7ip+
         AzoW68WH3V4m8Tbr6ROPQoywu4HQtt1khdd46TvGdjiWbgBSwYE0wxkWx8Y1EuQy6rAW
         REcg==
X-Gm-Message-State: APuU4Z9FrOogpvEuXIoB1TAKQUUyRMhyT8N+Vb6VRYzcOATjSdOOfyMc
	KwU2jTBWRwUj4/QTUxr8UGdQPl1yZVYi5uHXwZ4MX4gIqWrUg2lykI0nh221YA73XdU=
X-Gm-Gg: AYBFou0sM7ZubcRw0x7kh4wkxct73eBtIEE2owajDZ+rOMbdTmZYqviPV777jUOtUMG
	8QlaUsYvns6WEm9fOL0QM41DcCQ/BVqbYVg4iSszC3dXJXEkDA734/DsCbAhr5tlYBRKne1TYKg
	nhK580CzeMNoMTeyhkFQzgGrqWn4kBtASwSDuTEMgd4QyB3oqCLHOo4ib2BUCV2iSfm+86qOZqM
	Fh1PUz+62IEtyAEU4Ma6AtLbwbvXMsmb/4nrRrDuMXtb9QDNTPAHsoIvxYshEGE1H2xvPw1Kcc2
	zaVUE3HBPeZvCR+SJjQrDi7B+mgVnK94YdUxIbmV1BK6GqHUZHksS933fXeY9xHN3viZ885WM+h
	uq9HmTQRhm7VKk7YwU1dJ00+of2p6RTSZ/ujMo+/fC8nDxdd/AnMm7urfMLlC/pdpr8s8n2t0ck
	OZwZkuKFEGZ6+M8UJVshxXYQ/b9+t7/sA3s8ZpcL3S5Cr+oawtmU2uRRFk1/kRUI45A+h3IVei1
	eLwD9Hl3xd6q63oX0vAw1wmWhfWzrKTKHn/e5B0iTLpTBg+C8gHbGmnfkE2mn1HSupdXNZLewWz
	s2EGLWuDyV6f9zOHUQ4Nd1BTXg==
X-Received: by 2002:a05:600d:a:b0:4ac:aae6:6400 with SMTP id 5b1f17b1804b1-4acaae665a6mr224247265e9.13.1793712260624;
        Tue, 03 Nov 2026 05:24:20 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm28284449f8f.31.2026.11.03.05.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:24:19 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 14:24:03 +0100
Subject: [PATCH] bus: ti-sysc: Don't reserve the system timers on AM33xx
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
Message-Id: <20261103-v7-3-topic-am335lpm-ti-sysc-v1-1-1b9a23b4a7c1@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHLg6WoC/yXMwQ6CMAwA0F8hPdtkWyMEf8V4wFK0RmBZB9EQ/
 t2px3d5G5gkFYNTtUGSVU3nqcAfKuB7N90EtS+G4ELtHTlcGyTMc1TGbiQ6PuOIWdHexuhpcMG
 33PZ1A2WISQZ9/fbz5W9brg/h/C1h3z+Ok8lJfwAAAA==
X-Change-ID: 20261030-v7-3-topic-am335lpm-ti-sysc-13f0219c9d67
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Matthias Schiffer <matthias.schiffer@tq-group.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495; i=msp@baylibre.com;
 h=from:subject:message-id; bh=nVuwYE9m11lYdl/oeJjVyknAejqd1mpWoS0UcE2QfJg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXD6oj9lVMmdu1+oNC/u7HTrncbqHN86yzeVlXTFx1N
 7Tw8BuRjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIupeMDEsCTvq8DVS79WtF
 ttxF1gnM3y9IG965VbyeTckmdpFD7VuG/35rWZ/e5Nkfk7Ew/fhVSy4ZlpqNq4/MfdG35aGPeBl
 3KR8A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Commit
    3f6178392050 ("ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx")
introduced handling of am33 SoC timers that are already active as
reserved. During probe this means the clocks are enabled and a reference
is kept.

On AM33xx deep sleep is entered by the PM coprocessor which
requires the PER power domain to be idle. The system timer driver
disables the clock during suspend but the additional reference held by
ti-sysc leads to the PER power domain not being idle:

    pm33xx pm33xx: PM: Could not transition all powerdomains to target state

The reserved status is only needed where the
gpt12 system timer must be kept from idling, see commit
    3ff340e24c9d ("bus: ti-sysc: Fix gpt12 system timer issue with reserved status")

The timer configuration in the devicetree is the same on all SoCs, so
there is no reason to reserve the timers on AM33xx.

Return -ENODEV for the system timers on all other SoCs. Like -EBUSY it
stops the probe but the driver core doesn't report it as failure.

Fixes: 3f6178392050 ("ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/bus/ti-sysc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e118b900c9ac..922a90d4c5a3 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -48,7 +48,6 @@ enum sysc_soc {
 	SOC_UNKNOWN,
 	SOC_2420,
 	SOC_2430,
-	SOC_AM33,
 	SOC_3430,
 	SOC_AM35,
 	SOC_3630,
@@ -2917,7 +2916,6 @@ static void ti_sysc_idle(struct work_struct *work)
 static const struct soc_device_attribute sysc_soc_match[] = {
 	SOC_FLAG("OMAP242*", SOC_2420),
 	SOC_FLAG("OMAP243*", SOC_2430),
-	SOC_FLAG("AM33*", SOC_AM33),
 	SOC_FLAG("AM35*", SOC_AM35),
 	SOC_FLAG("OMAP3[45]*", SOC_3430),
 	SOC_FLAG("OMAP3[67]*", SOC_3630),
@@ -3124,13 +3122,12 @@ static int sysc_check_active_timer(struct sysc *ddata)
 	 * A to B4 at some point.
 	 */
 	switch (sysc_soc->soc) {
-	case SOC_AM33:
 	case SOC_3430:
 	case SOC_AM35:
 		error = -ENXIO;
 		break;
 	default:
-		error = -EBUSY;
+		error = -ENODEV;
 	}
 
 	if ((ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT) &&

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261030-v7-3-topic-am335lpm-ti-sysc-13f0219c9d67

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

