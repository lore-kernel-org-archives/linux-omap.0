Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593484;
	b=b59cfSiSFjaGQu0nHZ5FC642kcfhmDfGXMLdcILfeR32EOn8ucg2mfo3oS6dcgqHTczn
	 juERaV/joihGFWNJN45UOTFka0HcKknLdu9uH5rd9GoGyJ/RUkc29YxEV1klFDkn3Esrj
	 /cQQIr+sSDqkq7OWnLCbyLLa+yJ0/u0ErVZzEIvc74GGwRlhDL3IkHYoKy+K08blKbroK
	 tNYrJ9+X+BH71MiMjzhYonD23xyzxTSlT5hX6QfEsnpRzFXeXzjPSvL54lCebeb5llyGH
	 7Jzx+EkcK3vNZcpxhndp89udqzc5qwbJJld5mZy/+SvvoJ714Jhetxe46kqy3X1k5OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=d90ll7FAqo6oPiF9VJDJ3t9cPa5ddaSwh42tVXJ/uGw=;
	b=gwJc6jIHlu74r4G9TZV8KoNMod7u4pKyOHEvuPquNtSdMtvxnEhl8HOx57w2RPlw5qRx
	 cnQYQiyRdHRMrz/u6ltKwymZrfFtvOx60ZxfrpkAnHw4y7Vj8vRNkZYya72kNRsRa3fhb
	 +zJNr+9fT7GOJPwvdnOTFiHGqiEiKRoFSjo/KUeh6qHdSGpLSCwFW9bRCbcXrXG5Sko6T
	 i22TDSqnq3g5yxGavEb3NUR320LWMfP5T8xmB7Q93dbLVF6v/+BadZcuwbDmTUY8+AFGr
	 IX36g9ok9ovYI32LZNcEsI6VM82tkAKAfRy0P3l69RNto+4FQB9SLc62HluYDQ+umQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Uf3QhiLD;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5443606A333
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 18:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5443606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Uf3QhiLD
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e977109392so7550885ad.0
        for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794593483; x=1795198283; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d90ll7FAqo6oPiF9VJDJ3t9cPa5ddaSwh42tVXJ/uGw=;
        b=Uf3QhiLDCgtNdvsfg4+OrPIcV+2hegb80cJ57nGXrDeglq6Tk7fxsiiyYVrN1p3wfC
         7FaZ3vVcPdNFukbAAZGsaoibJcM+/QOkha52s9oEn+T9li1f/WrflZdx2eIBO2ZBmCRO
         AJCdY9QnfTvPGllVwmTitCtHbnhLqqBDr4Sfor7sqUmd9NW+H1cZtt4jvy2bsu6i+wFP
         IVPfZnfPQCCS7Jyixx42BSGtrxBl2nLVFK08JAW13N/VafyGxMWS/OxpU8X5U+INfinJ
         OsFWbuDQiiBRIUm+6E+hBjN8UBQ6+bNNqkEOAHz2wlbt8Yy0FpZakMW1Mz7NVb/S/kXE
         Z4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794593483; x=1795198283;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=d90ll7FAqo6oPiF9VJDJ3t9cPa5ddaSwh42tVXJ/uGw=;
        b=1v6llsW1F5xIdSILzRfAwwvx/t+GLDV5hlV9BegzQHTOM2B6jruoQWWepie96WtjMd
         Sn+A9DOamzwx4zQmQwpXjzLl/xv+qbpldlUxwf3uq8i4Yz7Q2S3IHQA5dfVIiQ9QRixd
         68y0vsC/euoWpZIX9gJxF36IDF1L2j2uxCcdee9JM48Up95psP21m4/mv4BVajxIrN7i
         6mWGTo+QC/B4FYjfVtt28n+LWQdqGC6ob7slle7L4KoYv+A3JUH+3sdxpTn5fQY/8+0R
         +wr9uk4L7fZD0SnkixxHKXM8am4JBoJwggdgvUeIjMiXuX9iurwLWMtiLuUtPcQn8UbF
         wX+Q==
X-Forwarded-Encrypted: i=1; AL+hErHo7Tm/Sp7Be6U9H95oljsYNANRJr8EZfVAy/fQWeBx0pJsQNOI/+4vCxIO0uqn+a1CWH+c5tcaa0cx@vger.kernel.org
X-Gm-Message-State: APuU4Z9FZj4LkA1nAYVye8/TSXXq++qGpGkBP2z3ZN4iQnUWKiFWRSLV
	niyhj8mkqbYV7rlKHffkuC82hhl9BM4Z6aRqcWpDYaa0ORCx13TxjKb8Tb3tPIl4+L5Tf3apcpf
	3TZrhJVs=
X-Gm-Gg: AYBFou3eiIvFkqPufMC9DIYkqrlwrp8heqCA+kkwWZYB595TkH/psXwu6j7bQOZZ06j
	lmRrSMOEeIqTb9AhpvTi8jwHVsqFtfblDbVMNVho7Td2udhNLDNt5Zy97h6ZdsasI2KlKb2QAgm
	UDU5nwWtECMzAq6QPDn4jjwR3CSPVNqFzPV9Q9WjMxzG7T5gHo/saNcPLGe0hjvPv+8V/f7ReYU
	Nng1iIib8yfpmLf/nrn+ub1ZfXMDmP0FTZ+01yEYsH4KlngbEOPyIBgXKgyJA8F2sMT94KBXpfX
	zN+2TFFVH2xJPd4xJqlHFX4RykL6AlGifleXrrYsVOmc36ZoAhnZLiaqrP0srOgolUUq1dF+xHl
	pKicKzRJ0e+M+f8n7OzaIq6sDL/nz458LvXqiJzyAxUQPlkNkZmCD6iLvu9AkNrjywENBRFZdMr
	N67bzZ7ipUc6BD/oDhUQ1QeK5CGoV9CYnz2QUeMaPpHiU6oY4iVD1J0/2/Gy4OhIGGVD5vT8o3E
	8Fq2D39SWnf31hh2H+Kmkoh1ynZLsv8vIi3D3a95hTF1vlppn20+xLsMlQeNauLyC/8BeQIbxnQ
	qigNueJIV66te/AHKCrWwvVzGX+abEqSlbNRbiaaWQpaeg==
X-Received: by 2002:a17:902:e801:b0:2ed:1ca2:ea5a with SMTP id d9443c01a7336-2ee0dca839cmr36180785ad.51.1794593483028;
        Fri, 13 Nov 2026 10:11:23 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2ee0f7cf7bbsm13900955ad.29.2026.11.13.10.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:11:19 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Fri, 13 Nov 2026 10:11:05 -0800
Subject: [PATCH] ARM: OMAP2+: pm34xx: add NEON wakeup dependency before
 clockdomain idle
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
Message-Id: <20261113-wip-omap3-vfp-neon-mismatch-v1-1-3f6f67b25251@baylibre.com>
X-B4-Tracking: v=1; b=H4sIALhS92oC/yXMTQ6CMBAG0KuQWTsJA8EQr2Jc1PpVxqQ/aRFIC
 He36vJt3k4FWVHo0uyUsWjRGCrk1JCdTHiC9VFNXdudRaTnVRNHb1LPi0scEAN7Ld7MdmKDYRy
 sYHRoqQ4pw+n226+3v8v7/oKdvyUdxwdCJ8FlfwAAAA==
X-Change-ID: 20261113-wip-omap3-vfp-neon-mismatch-ae585c1e8fe0
To: Andreas Kemnade <andreas@kemnade.info>, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Roger Quadros <rogerq@kernel.org>, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3137; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=nUGlnUeigsEQ9AGsMFJlNERG2aNHvO4BKiJ3p/GPSeY=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBq91LGetFzLY6wDOP+zWqz8i+v7KabRu5ykL5A0
 zJKG155IuWJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCavdSxgAKCRBZNxia0/vG
 ZcRvEACXiYcDk4LIQVYi81KCF8Ic+S4yw8GMXbsTzj/GRFeOW3QFjiwlNHs8uDx3gT+UXUrf8Fc
 qv4rO98ZLCgQJXf/MSP6i2xNeJa2ZSvoS0+qVuDNN/4zbzrqe5+k6ksJKbDWC5ozYjXgKM6H5hs
 9jq18Xs1Gi7ROFUNxfcCWuYVKZRTL22PogIUhAzzxhdqqWUotMYy3osyE2zZo3HPHFhrxIzo4B9
 YFUN984Bi1n9vvzl2rwsFzGa4aIh7zb7k2UuBZIARhMFV7VkeU58ke6p7gBrQ4qV4bTcEA6SZdz
 I2ncXp8F6dSYOKw0z3Qj1RLslxv1/lgPx+P1iHY2Be1NWOBYl3ovhzjCsDEaLnonpJNR4FAuPDO
 F61xUeY6u17W3hCvAy9UW0OX89aSVkhZTzzmsdeufLCiCBjrgf64P2UudyqkwEiKQZT8aK7xFVl
 9RzxVOLHnW4/Vdn8XVRo2HWvf4EZ+DaU1CAkBpd3CH+0ePmaUJFrK5RPAqRPyzj+rO6Os8X2UON
 tya//RQ6Ve89dvFW3B3ZwBTi5HVypzbdfHgoMtMsrb/Y0h7KhiBfG1s9UdYkXBh8LPCGuRjZKck
 IuExQVPzWHsK/Kc6Yp2qGS3Ot0kUWNx+V2oDdnukr5638VPpH1GijitY62WmU9DcorZtzeIFFkG
 DawOHbfsB/LhfGg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

On OMAP3630 (BeagleBoard-xM), about one boot in three dies early when
a context switch touches the VFP, which traps as undefined.

The VFP is unreachable because NEON is powered off while the MPU runs.
omap3_pm_init() sets NEON's next state to OFF/RET and lets all
clockdomains idle before it adds the NEON -> MPU wakeup dependency, so
NEON can power down immediately and stay off until the MPU next idles.
This was visible in pm_debug, which showed neon_pwrdm OFF:1 while
mpu_pwrdm OFF:0.

Add the wakeup dependency before the clockdomains are allowed to idle.

Tested on omap3-beagle-xm: 6/17 boots crashed before, none of 25 after;
also ran 50 suspend/resume cycles each on omap3-beagle and -xm.

Fixes: fa3c2a4fc99f ("OMAP3: PM: handle PER/NEON/CORE in idle")
Reported-by: Andreas Kemnade <andreas@kemnade.info>
Closes: https://lore.kernel.org/r/20261028212302.75ec622e@kemnade.info
Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
This patch combined with an omap_device fix from Andreas makes OMAP3
very stable on suspend/resume, including off-mode for OMAP3630.
c.f. https://lore.kernel.org/r/20261110211531.679943-1-andreas@kemnade.info
---
 arch/arm/mach-omap2/pm34xx.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9992549c7336..d11967c2f4bf 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -510,6 +510,20 @@ int __init omap3_pm_init(void)
 		goto err3;
 	}
 
+	neon_clkdm = clkdm_lookup("neon_clkdm");
+	mpu_clkdm = clkdm_lookup("mpu_clkdm");
+	per_clkdm = clkdm_lookup("per_clkdm");
+	wkup_clkdm = clkdm_lookup("wkup_clkdm");
+
+	/*
+	 * Add the NEON wakeup dependency on the MPU before the clockdomains
+	 * are allowed to idle: once pwrdms_setup() has programmed NEON's next
+	 * state to OFF/RET, an idle NEON clockdomain otherwise lets NEON power
+	 * down while the MPU keeps running, and VFP instructions then trap as
+	 * undefined until NEON is woken.
+	 */
+	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
+
 	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
 
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
@@ -523,11 +537,6 @@ int __init omap3_pm_init(void)
 	per_pwrdm = pwrdm_lookup("per_pwrdm");
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
 
-	neon_clkdm = clkdm_lookup("neon_clkdm");
-	mpu_clkdm = clkdm_lookup("mpu_clkdm");
-	per_clkdm = clkdm_lookup("per_clkdm");
-	wkup_clkdm = clkdm_lookup("wkup_clkdm");
-
 	omap_common_suspend_init(omap3_pm_suspend);
 
 	arm_pm_idle = omap3_pm_idle;
@@ -562,7 +571,6 @@ int __init omap3_pm_init(void)
 	if (IS_PM34XX_ERRATUM(PM_PER_MEMORIES_ERRATUM_i582))
 		clkdm_add_wkdep(per_clkdm, wkup_clkdm);
 
-	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
 			kmalloc(OMAP3_SAVE_SECURE_RAM_SZ, GFP_KERNEL);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261113-wip-omap3-vfp-neon-mismatch-ae585c1e8fe0

Best regards,
--  
Kevin Hilman (TI) <khilman@baylibre.com>

