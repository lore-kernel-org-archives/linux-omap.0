Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818263;
	b=yCGER3MJ38Gf2uB5VnwCr4MEZW6D39KVgfdQgRQgWZ6FxfRO9L0gGIKUJhs3WGeGHnhz
	 gmp1pNKikD9ZcYKaVI8Fr8jOAhiMU9GZrgXSB96eisHzjnGRtHI9dqR7tbOulXKTCgwJu
	 3WN0Lu/FjsBw0RaFrKiYDDeB6lXgRqUYu5WXjlai8nCakFNHW8ROuhCiPIa1Nfg5Fu+su
	 5xQpMJk9QB9q2j04My7sOLIL4c5Zkmz58IA9aB4eisuQ3z0k+5cS263BOa/wT0+jm3BBE
	 Cq8ZBN0M5I0MwQfyn8fwDfYU95pfRk23p47DQg5rxCOmvurflv/cv4ooxxlToJShPvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818263;
	h=DMARC-Filter:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DG0MNL/YWfSCBlponVS1KPFGxikvqnVYFgKqAIdFbPA=;
	b=AhjLm/RJYxlxniuOKcvCfPro20t2+A5EWapNtOfP6WgHj0GFI2FBUvPLAxmggd7/P5hZ
	 aMvbFtAzLRuRGGchC6v5U0BwIJjuJp7GhhO751rQ4tb2zSEKstTiy6US4WPXaHHEysxEj
	 QWMl4rmuOTqCcb6woMOUZ7KwerHyPENOYIQfx5yl2qtfBcdjQVbSXPijqy8/WfrNI2PCt
	 hiLTv0sR5cqgIghysFygGnQ+wCK0Vc6Kin6lnh1znJ+KDYiYXdUjCOIIgdMby9Non8HpC
	 ypRsNWOxS7/xWSX0cdFnSDdc+VxZq+9dNaRxluSAmf9ep3Ol9gXjYkwwrGWGIIkloug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b="iQ/r1zCx";
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D6606A334;
	Wed,  4 Nov 2026 18:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A5D6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=iQ/r1zCx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=DG0MNL/YWfSCBlponVS1KPFGxikvqnVYFgKqAIdFbPA=; t=1793818263; x=1795027863; 
	b=iQ/r1zCxD6Fxw2RXdy4Mtq4MgGZgbcipvEP7amW2O9GZnL1CgBmC3vKr8gLsRoHelRUax6myJSo
	P9UALfHIvzbvgeBk14STy1QZ997MRujypF8fHNdbXXzKi1amovvjMIS/QDjmZK6ZrLvEUnMA/d6sV
	VYOb6jPscx7D5wO7/Kh5JGiNm5TmNL+VlafxcVScPZrmIylnbRkzvlvpUGNIAGkzCAELW3zuuOoLg
	rkyCBnN7ibT36ZQfYMkcfwhPCpDlks6EmfNwlNdtuh0xhDB7C09oaynimCkWGLCrGAG2L0BUbkGGf
	CBT9nzmjC58DfLyC3oz3RMZ0SI91hD7LKTqA==;
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	andreas@kemnade.info,
	arnd@arndb.de,
	marco.crivellari@suse.com,
	bartosz.golaszewski@oss.qualcomm.com,
	tony@atomide.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brgl@kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH] Input: gpio-keys - do not rely on debouncing capabilities of dedicated irqs
Date: Wed,  4 Nov 2026 19:50:44 +0100
Message-ID: <20261104185044.2551808-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
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

If no GPIO interrupts are used, these IRQs are unlikely subject to the same
debouncing mechanisms as a GPIO interrupt would be, so stick to software
debouncing. Experienced on OMAP4 using pinctrl IRQs.

Fixes: 3717194f2492 ("Input: gpio-keys - add system suspend support for dedicated wakeirqs")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/input/keyboard/gpio_keys.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f1c31c5366f0..5813a5c82026 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -554,12 +554,16 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		bool active_low = gpiod_is_active_low(bdata->gpiod);
 
 		if (button->debounce_interval) {
-			error = gpiod_set_debounce(bdata->gpiod,
+			/* do not rely on non-gpio irqs being subject to debouncing measures */
+			if ((button->irq || button->wakeirq)) {
+				bdata->software_debounce = button->debounce_interval;
+			} else {
+				error = gpiod_set_debounce(bdata->gpiod,
 					button->debounce_interval * 1000);
-			/* use timer if gpiolib doesn't provide debounce */
-			if (error < 0)
-				bdata->software_debounce =
-						button->debounce_interval;
+				/* use timer if gpiolib doesn't provide debounce */
+				if (error < 0)
+					bdata->software_debounce = button->debounce_interval;
+			}
 
 			/*
 			 * If reading the GPIO won't sleep, we can use a
-- 
2.47.3

