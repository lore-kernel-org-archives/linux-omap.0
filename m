Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630093A7F40
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769051813; cv=none; b=QrZ1ht2tEWvBqIVTrEfUwjic7JhYc0yx81z3VfQMtdgREZJ0GH4VoDpXmSMWraSbtWDqRd1RX7eslDI8eUZAXH0ptEkV/1RIYRWA+ciAEpJDZEqaKpjZmNdLnoLFqkiW4HJ+11D4g7PTpo8tMHFhfPqdCd7BRu66Q+b7lsxVFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769051813; c=relaxed/simple;
	bh=fB4qFDnLcEuztYyiCjd+RjPOd463HVI1jnS3oHKE1Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMEqKLVeLrj5JoiJtqQHDi4aUw5jtzDbfsn6Yf70fNRE0u1zsTN7Zhkj49KWETBKlYhBUD82n0GkrWXY2wVt1NqrymOFdwP3oGHA5cou5KtByWFp8dMJZLVIOh38qg+vM+cMzTxOUgU4OJLSQsH0cAV2fhWiIChbkZL2gvEfBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdCwq7/R; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdCwq7/R"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a743050256so2954055ad.3
        for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2026 19:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769051805; x=1769656605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfgKMmP8DcncE4pa4cHunaIBJ+0sSublRL5+ZWYWWN8=;
        b=FdCwq7/RVhb1nKkgHtTfqVNu6f75/PSCpOZhnuLXN+VdHp+97TwU2QEVf0Jt7vU6p2
         dbPSLA80XIZFnlnhZRcu3nhdLRuU4Y+bR1vbaCRmviTxonYTheur6sfcPClFsRBBHYMC
         46vgDzPpjLhzUg0IQRFxFJBbeA73pDCZ4SqyoJEA0nscJW27Y3TwBn6wfY2+f7sAu+P4
         /fRqJAUm864gjZGpVjN9l3mqm0A5NzZYZTcZMxkJzeiJOHaPWdc2AwqQDkFordHRw0ey
         TLoGiWvskM7655ssXohM9N+ghgW1oXL4SCFAGO7K5tDLmJooZR81gcyJmqRZ3jCWEa5R
         MYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769051805; x=1769656605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfgKMmP8DcncE4pa4cHunaIBJ+0sSublRL5+ZWYWWN8=;
        b=cuur3lQ+0HeDYalXnyXp3qFmJ8bLdAjHeEf3ZrYhX0qQnfzQff0+R2FEenbHSIKp10
         thYpWshMQlPC09ZGLalAp0ZB0I60VmT/fK4cC//XLtWkroJ/FMnsMMZfgCMNP9sRNtlX
         e1opFU9aT9qwq0wTpGvPqwxXPMegh7Okrjdk0YTcbv8E4Y8D0IJP2t9VZf6SUo34XFT+
         Btz3A01WhtuJIIDYoVgs4P7Kn/2A9o4+bj/ufS0r+ifofVZfSIeJzJlxoDOk2tbLFtnY
         ccqaGuaX55YM4995nr7ZTNXcKhbZK3wcOvv/Z9ImHU80bQnF6JEWVyLDDdn42HPPovfK
         Pj7A==
X-Forwarded-Encrypted: i=1; AJvYcCUX4xN5MBAlGTpRd2SjMRgbPXQKYiBg6+aG4sky9IVaRl7TMtIfjhKndDcpzAQWQG50ej7OpnwbexAS@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHYv7FqL/Wkxvwwsq8qkrFcJNmZIPMYrlxFwMn5DYigB2t7CR
	AxeZxtfR5beFAq8klVAAv9/1SutUuZUe5APbyeZZ+nHhlSgQ+oE6QZBx
X-Gm-Gg: AZuq6aJ/UHMtCUq8dlsuAUZwy1brMWvgJVdUs0Rh292nkjjVGXdodXKYE0OpE8oaBS9
	jPSaA6tjK8peyvC3ucK2j8DcSaRUmEcwK2EpLBkl/zhn+SeG3j+DNSDs8WMio+r2ESOC/SQ6jxS
	5UwNdYUuCqiz9jQOpuwJRHynBi8e6352wTjrF8/ERqOqTzyqtWpn5aP7ohfcitcP7NeXU8Hh+t5
	OlGvHFAWCc46kyJDQku6BSF7U7kb9pRYjVfc4mBomIVmsAwADCYNMeb4zxAz8X4b8uKLONxhwaq
	mJgZBdMBhVWhMbKY763dme/3iyJRUl79VGM0A2Ui0IYELQCPcMMNqVFs+7QAan3IcHxmQcVyvz6
	nFBMvYLjZuu+vx8kZr4cNWJaoRj/xYTusMldRQ4XzubOwOlp61oJgnO/ZrUNHvf6l6SVusCueXt
	B+++DBIZrXUdwHPPIN1bfLgS13ZQoFkH5gH2iLwQEm0PM=
X-Received: by 2002:a17:902:cf41:b0:29e:fd60:2cf9 with SMTP id d9443c01a7336-2a76b169703mr73811165ad.54.1769051804927;
        Wed, 21 Jan 2026 19:16:44 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:5396:967a:93dd:83bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm155966625ad.87.2026.01.21.19.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 19:16:44 -0800 (PST)
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
	kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v8 1/2] staging: fbtft: Fix build failure when CONFIG_FB_DEVICE=n
Date: Wed, 21 Jan 2026 19:16:34 -0800
Message-ID: <20260122031635.11414-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_FB_DEVICE is disabled, struct fb_info does
not provide a valid dev pointer. Direct dereferences of
fb_info->dev therefore result in build failures.

Fix this by avoiding direct accesses to fb_info->dev and
switching the affected debug logging to framebuffer helpers
that do not rely on a device pointer.

This fixes the following build failure reported by the
kernel test robot.

Fixes: a06d03f9f238 ("staging: fbtft: Make FB_DEVICE dependency optional")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601110740.Y9XK5HtN-lkp@intel.com
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>

---
Changes in v8:
- Add Reviewed-by tag from Andy Shevchenko.

Changes in v7:
- Split logging cleanups into a separate patch
- Limit this patch to the CONFIG_FB_DEVICE=n build fix only

Changes in v6:
- Switch debug/info logging to fb_dbg() and fb_info()(suggested by Thomas Zimmermann)
- Drop dev_of_fbinfo() usage in favor of framebuffer helpers that implicitly
  handle the debug/info context.
- Drop __func__ usage per review feedback(suggested by greg k-h)
- Add Fixes tag for a06d03f9f238 ("staging: fbtft: Make FB_DEVICE dependency optional")
  (suggested by Andy Shevchenko)

Changes in v5:
- Initial attempt to replace info->dev accesses using
  dev_of_fbinfo() helper

 drivers/staging/fbtft/fbtft-core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 8a5ccc8ae0a1..1b3b62950205 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -365,9 +365,9 @@ static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red,
 	unsigned int val;
 	int ret = 1;
 
-	dev_dbg(info->dev,
-		"%s(regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X)\n",
-		__func__, regno, red, green, blue, transp);
+	fb_dbg(info,
+	       "regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X\n",
+	       regno, red, green, blue, transp);
 
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
@@ -391,8 +391,7 @@ static int fbtft_fb_blank(int blank, struct fb_info *info)
 	struct fbtft_par *par = info->par;
 	int ret = -EINVAL;
 
-	dev_dbg(info->dev, "%s(blank=%d)\n",
-		__func__, blank);
+	fb_dbg(info, "blank=%d\n", blank);
 
 	if (!par->fbtftops.blank)
 		return ret;
@@ -793,11 +792,11 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	if (spi)
 		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
 			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
-	dev_info(fb_info->dev,
-		 "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
-		 fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
-		 fb_info->fix.smem_len >> 10, text1,
-		 HZ / fb_info->fbdefio->delay, text2);
+	fb_info(fb_info,
+		"%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
+		fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
+		fb_info->fix.smem_len >> 10, text1,
+		HZ / fb_info->fbdefio->delay, text2);
 
 	/* Turn on backlight if available */
 	if (fb_info->bl_dev) {
-- 
2.43.0

