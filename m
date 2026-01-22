Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F03921E3
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769051817; cv=none; b=DomuDuhG3NXiQ2PFoA/8EsdUfSC80BrtVpFhAtA28PF/Hoh7RprckzMJxzSTJXC0vxzE26Q6mzEaFJnXrUyUa7Xp4nI/Xjn297U5HD0XADGpYH0GN9Z3sE+zDMIfUQUWp2jcu6MvTFnF/Kuf8uB474qods7Bgj0Ee/ZwXczOG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769051817; c=relaxed/simple;
	bh=+MYoKC4GsgZniJRfFsr+5viMvEwYPUanOo3mvBb8WUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8YfL120DEYS3DJBz2jckN7Duf7PQEh5V7BAQo28KZr782F23WQ2xwdwBuI1WJOkGW0DIk7ksjQAsiSq+JkFw79mddqdEbsP9A+d1jSpT86SZE3/iT4RwaEevs9YYhmDt4flz2ACk0d96yBpdu38UZycrrWYGu0vtl63Tqkg5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO6imYFl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO6imYFl"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0fe77d141so2706615ad.1
        for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2026 19:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769051808; x=1769656608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWQboeoR7+6YsMwaf3C2xb3O23tU5oXeb/k98XP/HFY=;
        b=NO6imYFlQtOUQVLEGyIP5iQzmy6LIp4dk80HZTCfFDz3DPIrHneSq71D1YN3rYmPpm
         I7q6sLyEmbHo2PKb/e8ZzrMUoe1Y7uTkxWpGNh6fCJ5CSg2H2lFAgaGbPUCpnjjGqUdc
         KtKCAWib6zPZpGnVNOsTZmS0gAFSk8ghpztI3OjfeCrszWOJpL5kSvmg1shZ1ksAfBac
         fBhcg6HR2cneOD6K9JPhd65bjqoptJlESGMOzGP1XsMHHfJcrzF0eDLMq37O+buVMkoL
         GV1guDRyDsEAnxGwweyi6sUaRGtV95tTC20rg9cQFzevJiXGPUGOBkKKuIu/q+M8ffcP
         hXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769051808; x=1769656608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nWQboeoR7+6YsMwaf3C2xb3O23tU5oXeb/k98XP/HFY=;
        b=Nh3jog6+QNqyijFtoG80Lt0cM7+226rDN1tX1JlAMv4VvcUG1pJ5tf8pi9H9+DFe5A
         VNZln5UIhWmDryszAhkqtXbkx2UratMEXPGVxHYqY6xqw0uuMvvTJSre9GZiZ9DoC7cG
         jbtrsl/CeuYFAMX/0POnePvyDucp6uvYX9HLIi9dSZKyl6g0jthPTtAd5dpF6U4NfBYg
         3dF6Z9Bu6JoTxhESoUw0TNlePAXQky8JqUh9Y5MTNN+cM19y071Goc+mAV5ey1oWuwr2
         TuuOhTuUZ1c4yqiQMdSe4Ob1vjSc+SK2K0eGMhT8FCGRsjHIIJv0SuE8HqoKziulAI62
         qlnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJElEd3EEnECNomDh5DBBkoWhl4ZRFfIZ8gB8+9WftOfffEsj0EQtaSeEM7HXUhCIFDPzeXCfmOhjj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94LfEusabO/WBfPgovy0DPNLOCG6G5c1ZD4PMjDl2+4QhioSb
	sbdMsXC/iEY/M0Ys5yYbtAiBP7qnP7rPWlOMCJxH9ZtHeozhywUnDhbD
X-Gm-Gg: AZuq6aJ61j22gWhbqbAhR0cH5BWTpUua45s3F+Hcm6p1TyyHqk1LVE3jDMzeWMcYYTq
	9Y9j3+TEO/ULWLPyvBEWZfkARiHRwmGGq3CeiF6k0dJSHWvESqs0SUighzkNjeDLUJYbhycPYqt
	j0wwH5HOWSipXIBRV8YUHeR7xxQ2TeH/x/KmIkwQ4NOBuDJeyf8PPIiVbXSh2yrxTu2Lqjgk/Yq
	fNiw/EmLnOpO/1x8okShVejW4LBT1mVcIVav4vS6x7rTs9cCbyyog0L20GYKrOdyrIQ3Y0g8+29
	go6x7e1naPlhR890XDcS+RQ903eqNc/e/zWOU5rCH2KTQeeNbl+sw85DaxDWIKIvcuFwoXhgWbJ
	hNehHIpste1EtMA4ZvUWAzH7VU6yBUeC72/kon9OhyWPQlSakg7xJMFJ+9o1xZVSqkZzpjRQ8Jt
	83Ql41fqBxqugnht1rLFrP4QhaeFb5nvbePxHysFfRu6A=
X-Received: by 2002:a17:902:e80f:b0:2a7:682b:50af with SMTP id d9443c01a7336-2a7682b521bmr74186085ad.40.1769051807610;
        Wed, 21 Jan 2026 19:16:47 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:5396:967a:93dd:83bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm155966625ad.87.2026.01.21.19.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 19:16:47 -0800 (PST)
From: Chintan Patel <chintanlike@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	andy@kernel.org,
	deller@gmx.de,
	gregkh@linuxfoundation.org,
	Chintan Patel <chintanlike@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v8 2/2] staging: fbtft: Make framebuffer registration message debug-only
Date: Wed, 21 Jan 2026 19:16:35 -0800
Message-ID: <20260122031635.11414-2-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122031635.11414-1-chintanlike@gmail.com>
References: <20260122031635.11414-1-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The framebuffer registration message is informational only and not
useful during normal operation. Convert it to debug-level logging to
keep the driver quiet when working correctly.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>

---
Changes in v8:
- Add Reviewed-by tag from Andy Shevchenko
- Add Suggested-by tag from Greg Kroah-Hartman

 drivers/staging/fbtft/fbtft-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 1b3b62950205..f427c0914907 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -792,11 +792,11 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	if (spi)
 		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
 			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
-	fb_info(fb_info,
-		"%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
-		fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
-		fb_info->fix.smem_len >> 10, text1,
-		HZ / fb_info->fbdefio->delay, text2);
+	fb_dbg(fb_info,
+	       "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
+	       fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
+	       fb_info->fix.smem_len >> 10, text1,
+	       HZ / fb_info->fbdefio->delay, text2);
 
 	/* Turn on backlight if available */
 	if (fb_info->bl_dev) {
-- 
2.43.0

