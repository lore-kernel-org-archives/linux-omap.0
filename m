Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537113EC83B
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601645; cv=none; b=keOFgcB+PiNCacuf+a48nHe3nh+4MwUGD19AbkiqznjuvlGPERTtzzU3gQs1L8QMBXdjZKpCO+r4Jumjpwe+tYN609oOW9fE79sww9Zo134khyZXU/iNRSVn0UlEerKHflu6w++BsJ5/33ZqCn20o04yYzYWnz5fnbXjSgNmfT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601645; c=relaxed/simple;
	bh=fApNG7pEOll5/tB3rqVahJ6bvMIxHk8hHb2CY3jSzQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGA8QIMz7C4bnVp5c+wg8vmv+Fth9wB+QTLmkhlWGaGuQLvSvmkAEW7r0QmLQFe51qhjmHmPWMGpaoBj2HtK+tbsSdiR+NDg5gCA0M0A2bfeWzl3rxQaT6UjNP2hCJX2P9lcr+mo/isVnR1ouuGMLcYS+l2mzJfZMA6HGamaJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B18f2qkz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B18f2qkz"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47de0093c42so1547568f8f.3
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 02:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601636; x=1789206436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQmExMUpeIFcvU7MdenadgThwocm9EsyaVYoR2H42kg=;
        b=B18f2qkzikKfnKphA4OculxGEwrQf0Ep8+PaGaQYv/xYwiV+a89Zau/mKSmPPjQYhK
         jBtOa3jRCJrVMt4WrCdrseZhMIzpxP7K5HyQLvnDuBXwseT6zqLPO6oYjihWs5l5VQw6
         IaPriatQT0RC9lzvBO7VOXXAMuqADXWdKOJvgkOPcub3MdhRvpJ4b7usagxcgO1SuInd
         me06Vd1NkyrlDIAyGAKSjoDVx+LUxHmS9/9ZIUdmxHwmU25+LAqgMQ6GnyW4BcJimHcz
         24lVKx1gKbJppw7SPYNA7p8cpuCncSXDDngh0Emhlo8DhQgZWF0reb0Xaz8DR7S7DvIc
         dv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601636; x=1789206436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQmExMUpeIFcvU7MdenadgThwocm9EsyaVYoR2H42kg=;
        b=ba52iuIimLSmT4jxnSrQoIlxEvK2h+BpzW9T9V8HLlSWxhE5yhna/HsYgGSFrSmni6
         QI//3vmEVAV8OjddVCCkthoQ3GLBEG7f4p0oBbrWPsVv9yH1ygmnGn0MbFbPLVo2if5x
         HUtFV9kc9n4mmC8fTLfKo6ivHlWOhCuL+SQIsyRoUR56t3RtuEg80iP4V4sEg2hqYfCB
         z2pIUad20/7Jd2nPmS5SnSEaqokkVfDYQ8xE7tuP2LkO3Mc1W61cgs/bdydjUwWB8j0N
         /fQ/FeIFvY6Ee0kVA4Y+DZ6btyiyjydOxJfHWOtCj51QUDWDRKlCR3T1zC6ao0y7aDYr
         UozA==
X-Forwarded-Encrypted: i=1; AKwUvByC1z/1DXOARsSuqrTtssSmxUAx7sOnuYYFWz5/DCvofutYKFToG3aKkVxeAKSmc93Ap2AYm+P6dKo2@vger.kernel.org
X-Gm-Message-State: AFuF++nBe0U8mW6UbYEOhJKPspQqokfulPEb6NVmIbPcbLDWr0b66lvZ
	zb/7yXOEtF6NIoJ/Jbviu049B0ytydP2VGOZhaXKUWKzNylNiqdyqXpt
X-Gm-Gg: AYBFou2B0/R7Xvqnw5WwkLbBLvIHlmIhrZKMavo9qcM/k6OJHttQa37I7yvBeSd3MVX
	E/6z972PvREH7uOkvLYqCJSdnOd6ZVRcn29dZ4aZlsyAy+AHxgVC8qzJmKrCcXTSOeU0SB789sD
	EU/fzb8+azGZN0W6CjMiix5q9wjWoUVKz5K2qYvXtFKNovutBiJMiGNEMtMyWdRTlZNUlJLvB4W
	P6pdpidoCdDE4okqBACZzka4kw4MytPZKLFU7AvQ+n7boDsKnOC0y8wqMWINxdlKdqull+u6dzs
	I01TzvHccJHXf0w3PNIETw8iU003IIH5mCOd0YykBZ45td3VqzLUi5FwBikfreOQ6N6ge/5aAf5
	bH3cWnnd+SNk5wFQWxlO0Xa6+vhTYVleGp5MOGwLilaTCPoreJj4L5VqLznw+m01ed/34NKFyxL
	Up5yh7f8en0eVo82Yg15ylNlXMMnmlGkbms6+pgth+iE8RkvXgXe6ozWB0rkoAcEZBJmyg1iRD0
	qtr5fX7LKJWr3M6qPf4Wg/qZjFPXzSraaQdiDbvFQ2dRiA5mWDjusuGSW9UGjfPB9ec14UJl/IQ
	5l6MF05b/UZLTG8vQK9bwYRr+cB+0isGTcbGca+VPPnm/OwBAJY6SuXaDhLyucVF/IobWSbx6Sp
	MQw==
X-Received: by 2002:a05:6000:2287:b0:485:8b5c:da39 with SMTP id ffacd0b85a97d-4858b5ce1bdmr9454058f8f.12.1788601636313;
        Sat, 05 Sep 2026 02:47:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:15 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Mike Travis <mike.travis@hpe.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 9/9] docs: kernel-parameters: Drop the pata_legacy.qdi and pata_legacy.winbond entries
Date: Sat,  5 Sep 2026 11:46:49 +0200
Message-Id: <20260905094649.41996-10-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905094649.41996-1-kmehltretter@gmail.com>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pata_legacy no longer has the qdi and winbond module parameters:
commit 3c4d783f6922 ("ata: pata_legacy: remove VLB support") removed
both together with the VLB controller support. The entries also refer
to CONFIG_PATA_QDI_MODULE and CONFIG_PATA_WINBOND_VLB_MODULE, which do
not exist either.

Drop both entries.

Fixes: 3c4d783f6922 ("ata: pata_legacy: remove VLB support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4864e37005be..33298da28b55 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4994,19 +4994,6 @@ Kernel parameters
 			the first port in the list above (0x1f0), and so on.
 			By default all supported ports are probed.
 
-	pata_legacy.qdi=	[HW,LIBATA]
-			Format: <int>
-			Set to non-zero to probe QDI controllers.  By default
-			set to 1 if CONFIG_PATA_QDI_MODULE, 0 otherwise.
-
-	pata_legacy.winbond=	[HW,LIBATA]
-			Format: <int>
-			Set to non-zero to probe Winbond controllers.  Use
-			the standard I/O port (0x130) if 1, otherwise the
-			value given is the I/O port to use (typically 0x1b0).
-			By default set to 1 if CONFIG_PATA_WINBOND_VLB_MODULE,
-			0 otherwise.
-
 	pata_platform.pio_mask=	[HW,LIBATA]
 			Format: <int>
 			Supported PIO mode mask.  Set individual bits to allow
-- 
2.53.0

