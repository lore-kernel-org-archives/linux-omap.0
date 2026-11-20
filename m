Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186852;
	b=TJk/aS8QLwjdAJ1kO+Q3nLFy3TUtaKIXl3CDM1P7xNjzv0tz4+PCp33VNZe2i2CVmHAz
	 iIp3T6P/h8Pw7z8mxbrKJ+N27roDkYJIp041wArrboefyqAjte0++2MMxDkMS3zfJjDH8
	 wnSI/1ycpSni1njqXLuLRg0XC9pdaC/RF0CVLQ1O/dJUzn7hWmk4jTTEDwcXD9hkN/cD+
	 QoBJt22KHVZM0kvy00dlCdee5wUIQ2qcImx5BHzuo+y3OvaB/kxgu6jGCQdZiDmZMvTsX
	 viOiGQuh5/TPCu9gJsElbEfmGiJtXylKe43EPNWxSsvUlbpX2OIb68CebB4Bt1Gb6sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7/iYOhMINhvEOk0ds7NRqLPwYU2L0FMs7KPyj2Wr1b4=;
	b=kEv165MiWdmI20iLvUGEGR3CkTMVXNCIBPQ6t7tUUmFEWsSLnSllsfgk5XzMnx/ZJaeo
	 j8d2ZpO4FShTSdbfGccx4qcNdnZvLrDLQO/8qf4/gYzjfSbge6lDXwrTEeJXiGIBKcrN4
	 TfyIr9HLyQmm0xF8Ahg0qQT1Qy78UIXy4QZ1d7WMEdN7MeSzahxpJ6QxDiw4Jmj8VCWuu
	 WRof4mOem3ujZucshw402+2AMQN/zbGVZalcyW3b8igvgXMu2HABTWg4r1UWF8qucRPdN
	 iAJ+Z3w1i6G0ISGrG7x/crlUTu+/1VSZRl7XICsydl3bekTyDrkVj86/ANef3XRxTcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TiD8fojx;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668E60A2630
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 15:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5668E60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TiD8fojx
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b40d23e1adso842704a91.0
        for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 07:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795186851; x=1795791651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/iYOhMINhvEOk0ds7NRqLPwYU2L0FMs7KPyj2Wr1b4=;
        b=TiD8fojx05fpXLGJd9ptfNKTEs7T1NdcBKTFQxZJA32CsSSfGN14cPiJwznki7FzKp
         sYCDFhKNdWYAR4j94D8GcjDNCD3r8lxF7c6NGErd6hf3MVTC4WMkKuYsQt94gqQkhUWr
         MihaNqOWjJWrvDn3GNcuFd/k3TpcDgEwbCcAexgxqFVfPteP1mQto3nS5rTd2nRu7q2i
         vwj5dSKkcafKqAkZ5ZT4xxEyZVhWUG7rFjQnGJhDXSj4eRarZxEVEs4iTAyccpGEboey
         mVjWfAifnh6mriCsuGm7lUCAenCELKxMHueLVQEBhyQFBVkSr48bN1OLLzzzvdHUMILV
         ECeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186851; x=1795791651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/iYOhMINhvEOk0ds7NRqLPwYU2L0FMs7KPyj2Wr1b4=;
        b=Uy3gJhdD18pBGpRrR5H/fcw528ECvPltDtbPEUIGxcH0YPPnrMSLtz8Gsz5ug3lS0I
         s3mJHXnmUGFvtHwGwjPBEDPB28Qbui8kirJ8r+tb+Psyphe8vhrMF/06eYSbV7smpkHh
         x25kZEBP0tQMI8T6XcYkf+RNdR5PfpJXR87iHUrZcPjD52jwg/4BLSuRc4uJ7Kalkdiw
         VzTlo37Uk5KPqTbwuVP/rKiQLC/wXpOfj46f6bbKzBO/bHkk8YwQKph53emtN4WLwUxZ
         qN85R2rOQ0RXOanmkiRTLPiviSSJVCtCTqzM38X4EdfnP/hrPUTncsAgbxGc0/agxSFr
         HMbA==
X-Forwarded-Encrypted: i=1; AL+hErEQJMe6BDUWPJzpzj4ldB7erOXMpwBHOJJ+ZvwbaCrr5M+nr60EgFXAOl444+c93ASWMqEiOYRuou5h@vger.kernel.org
X-Gm-Message-State: APuU4Z+Jtw+vPRYtpUEqjRMpvD8BbmkX7HaNGOK6DG5PnULlXzspCfTa
	dKSjc3CoecTLSUVs+2Aal+CwOF07rR1QssNoaEt5ACc1Uh8uIL5368OH
X-Gm-Gg: AZFdTZc1oHf3Mk+QOgMWHhcYfgx8nt9tJ8ucpU2RYXH2lqlmxalNd8XNMAKwWF8Qw/b
	mtRGMkZsU6u56r6Th/lG/0s44gGg5aYp8tvFjXbkKgdB6dsT77+Glg8GY4ZeRvx5hGUeEqG3mqq
	FYP6LadMeT47MOMeUquuls/NmIDoo5dGoOFeQVmU1AusevuDv4UkFVsv3hU17F4a6htBDZYC3nq
	S7hQfBOgpsgrZBeLIYZGezQzuf3OOvuWp6NKwrdi4ZMDC2j0ERPinenXJ+l8/BE4jvoqu3OtwCG
	djWRbMAcRhpOV/NY7ns8ggx5MoPkRSWbOz6rL7MJTUEDLkGMatpQWfBcUckQRmvzVeJ8pjMrjOf
	gYtbI4xn4K0l2qq+T/8E8stGtIiB0PaPvZZXTIGmGl6HK0vkmujJ5cHzVrBKAX8jM8DzU0Im4OR
	pZyAfL9pO2kexcc9+XV64ZoZsuP9zwTc9ShOVNoIIi2JMg1rIN+t2sJdY5Ynm3JLTNxWo+46QVW
	Q31+TgvGFSFjTrMJkJNRDa6sWAFZBrhaFMfIG6vVZZpN2/khFSdklVsSft44utqy8nX2vGRkhjd
	vbMfM/kuYkin6fh0/UvHRpbKCEBbNhuou8XHOzffvVZAmN0BXYdeMDy5GKJK32wB1q6D
X-Received: by 2002:a17:90b:2688:b0:3b3:cde6:d8c8 with SMTP id 98e67ed59e1d1-3b41c955b9dmr2998636a91.46.1795186850600;
        Fri, 20 Nov 2026 07:00:50 -0800 (PST)
Received: from localhost.localdomain ([115.73.20.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d96bd3sm7851802a91.12.2026.11.20.07.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:00:50 -0800 (PST)
From: Nhat Tran <nhat.tranminhk2@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-gpio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nhat Tran <nhat.tranminhk2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: tda998x: Fix CEC calibration with lazy IRQ disable
Date: Fri, 20 Nov 2026 22:00:04 +0700
Message-Id: <20261120150004.64033-1-nhat.tranminhk2@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The CEC oscillator calibration pulses the TDA998x interrupt line low for
10ms through the "nxp,calib" GPIO. Before driving the line,
tda998x_cec_calibration() calls disable_irq() so that gpiolib allows the
GPIO, which is also used as an interrupt, to be switched to an output.

gpiolib only allows that once the interrupt is actually disabled at the
GPIO controller. Since commit a8173820f441 ("gpio: gpiolib: Allow GPIO
IRQs to lazy disable"), disable_irq() is lazy on GPIO controllers that
do not implement .irq_disable, such as gpio-omap: the line is not masked
and gpiolib still considers the interrupt enabled. The direction change
is refused and the calibration pulse is never generated. On a
BeagleBone Black this happens on every boot:

  tda998x 0-0070: found TDA19988
  gpio-537 (nxp,calib): gpiod_direction_output_nonotify: tried to set a GPIO tied to an IRQ as output
  tda9950 0-0034: TDA9950 CEC interface, hardware version 3.3

Set IRQ_DISABLE_UNLAZY for the duration of the calibration so that
disable_irq() masks the line immediately, and clear it again once the
interrupt has been re-enabled.

Tested on a BeagleBone Black without an HDMI sink connected: the error
is gone, the GPIO is back to an input used as an interrupt afterwards,
no spurious interrupts are raised, and rebinding tda9950 repeatedly
reruns the calibration cleanly. CEC communication with a sink was not
tested.

Fixes: a8173820f441 ("gpio: gpiolib: Allow GPIO IRQs to lazy disable")
Cc: stable@vger.kernel.org
Signed-off-by: Nhat Tran <nhat.tranminhk2@gmail.com>
---
 drivers/gpu/drm/bridge/tda998x_drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index 0b966c9844e7..0815ce283f49 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -495,8 +495,16 @@ static void tda998x_cec_calibration(struct tda998x_priv *priv)
 	struct gpio_desc *calib = priv->calib;
 
 	mutex_lock(&priv->edid_mutex);
-	if (priv->hdmi->irq > 0)
+	if (priv->hdmi->irq > 0) {
+		/*
+		 * The pulse is driven on the IRQ line itself, and gpiolib
+		 * refuses to drive a GPIO whose interrupt is still enabled.
+		 * Make disable_irq() mask the line right away instead of
+		 * lazily, so that the GPIO can be switched to an output.
+		 */
+		irq_set_status_flags(priv->hdmi->irq, IRQ_DISABLE_UNLAZY);
 		disable_irq(priv->hdmi->irq);
+	}
 	gpiod_direction_output(calib, 1);
 	tda998x_cec_set_calibration(priv, true);
 
@@ -508,8 +516,10 @@ static void tda998x_cec_calibration(struct tda998x_priv *priv)
 
 	tda998x_cec_set_calibration(priv, false);
 	gpiod_direction_input(calib);
-	if (priv->hdmi->irq > 0)
+	if (priv->hdmi->irq > 0) {
 		enable_irq(priv->hdmi->irq);
+		irq_clear_status_flags(priv->hdmi->irq, IRQ_DISABLE_UNLAZY);
+	}
 	mutex_unlock(&priv->edid_mutex);
 }
 
-- 
2.25.1

