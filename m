Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BA91C3C1F;
	Sun, 19 Apr 2026 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615670; cv=pass; b=MX5MHPM82UFivnfa9gCrRq3ZSnalrynA26oIL05JGPmdNVYgsbArq7mx5edAxo5LBsXM4hMG5SRAsMYBjV3/73vbu6c575mQZevSySwS21PJd0TQa4CXOkF3AiZYpFgCunWAgrrSjKfy+b1Q9i3OzbE5ITS6yF4a7hpNE2NSonU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615670; c=relaxed/simple;
	bh=61vVW5aGCnzVF4GoEJPKAGsyaoh4olcL1bjqP2JGL3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaxM1daq6m8iOx4a+BmVXgWelZRXALYXk3bgFqkVJcPje/ZJ8aS8YmBluCtctOhn64SbFfjYNiJNhLreGN05Vz0ASZseCYW1Y9jqkQy7YznoR7uHu4QuERikGwtHamaYU6zPSoqWbNZV97LbOhGXweCheHAUSPh7NCGNd7bVAdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=KRzcMkLB; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="KRzcMkLB"
Received: from darkstar.. (unknown [83.245.248.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fzDPv0z8Jz49QFl;
	Sun, 19 Apr 2026 19:21:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776615667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpcBR4k0LbC/Ndgf6TQTCcQuvX8Fc8RSJqb/Bb6m7Bo=;
	b=KRzcMkLB12GjNcjXxQI6w95I0GJx3/hleCQ7rVx02HnGzZFn8Qn6IeFRwvrCqD+Y/JVBLG
	+Y58FghU+AtLCrkLekAXUXz7U48vdCsW3B/UQaznrmIvZdO+koujI2f2KJg/m/vpbTDLg3
	/l/qfBXVO4O061JWNTP8mSy2wVPkiKV5XYqPcGrmoX9zHCNh9J1D7e6E00Veb1u3yS0fy+
	gVqCBDGZM3hieH5g3FgbMPZnLSbaeqE/1/yIybahy4uNDZ8zzXDdK3Gwdy9n92TLbVmVrC
	pUlIz74rIL3Njey3WzlJ3szpAgcYOoelLplAlH2aSeoPwKKnJIU5pcSULuHWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776615667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpcBR4k0LbC/Ndgf6TQTCcQuvX8Fc8RSJqb/Bb6m7Bo=;
	b=N2aSXXZOukfVNlRb5un21AKEHCdXmsx+HVZx4bUQogCFYc+GISwLvslWrOmOa/sAvFIsW5
	tJuBEEC5oUcikBOi60o5tGkKfHWypR7lI7cLiW5+/2ZQZh6pv7MR7mTTAg90FGi5LAwhAm
	nXjrC4egxV+F641Ba79+8Xld+pR0u1EPmehDO4WeZw/hwyI0o4fzfaRNlejgEIk5wMquav
	lU6y8LhHcm7JYWx4VSiqyokulhtNIZv6dTUhqbtLpWmmW4VCE5yQ1Q6yANkMkOhju82vll
	K6gdYCez3k0sd3pxgtluklqnAAzl4DAjLUf2Ny58Fyesnj+QOoPB0f6aM6KPNA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776615667;
	b=TYxO1KuJ3rG6tTBlU6MdPmT/afCCcDZwgRkl44DiQeNJgNPwsYsShQVSlY7nFNsEHr1AVf
	afAruzwHQRXHUe7hYyCIUP7K63TMmhI3QvxaMsp7ouvOozSJUgv1SJXR9kNT33HmkQ8MxA
	OHtHsunnyAA9MEVooK5r5+EQ4fqWURpRh02YCTZMItW7Y8tx+ohcg8a8E5HXI/kmRKn/Tg
	VQy34HjZHDGgq4vwHfc6KJPEZX8MLVwedd2vT3FkpyByOtxXDfFdLTqys573ka4OTKSd4y
	TSjB/3mY2DCASXMAXnzYt39QV1aNiNBd45gFHx947Br11ZDT+WAPyeSjImFKJw==
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 2/2] Input: ads7846 - fix up the pendown GPIO setup on Nokia 770
Date: Sun, 19 Apr 2026 19:18:48 +0300
Message-ID: <20260419161848.825831-3-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419161848.825831-1-aaro.koskinen@iki.fi>
References: <20260419161848.825831-1-aaro.koskinen@iki.fi>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 767d83361aaa6 ("Input: ads7846 - Convert to use software nodes")
added gpiod set up for the IRQ in the 770 board file, then another in
the touchscreen driver for reading the pen state. This will make the probe
fail:

[    1.347381] ads7846 spi2.0: failed to request pendown GPIO
[    1.361846] ads7846: probe of spi2.0 failed with error -16

I originally tried to fix it using non-exclusive flag, but that was not
found acceptable. Instead, just use a single gpiod.

Fixes: 767d83361aaa6 ("Input: ads7846 - Convert to use software nodes")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-nokia770.c | 11 -----------
 drivers/input/touchscreen/ads7846.c  | 12 +++++++-----
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index a5bf5554800f..8b8013ab4590 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -285,9 +285,6 @@ static void __init nokia770_cbus_init(void)
 static struct gpiod_lookup_table nokia770_irq_gpio_table = {
 	.dev_id = NULL,
 	.table = {
-		/* GPIO used by SPI device 1 */
-		GPIO_LOOKUP("gpio-0-15", 15, "ads7846_irq",
-			    GPIO_ACTIVE_HIGH),
 		/* GPIO used for retu IRQ */
 		GPIO_LOOKUP("gpio-48-63", 14, "retu_irq",
 			    GPIO_ACTIVE_HIGH),
@@ -307,8 +304,6 @@ static struct gpiod_lookup_table nokia770_irq_gpio_table = {
 
 static void __init omap_nokia770_init(void)
 {
-	struct gpio_desc *d;
-
 	/* On Nokia 770, the SleepX signal is masked with an
 	 * MPUIO line by default.  It has to be unmasked for it
 	 * to become functional */
@@ -322,12 +317,6 @@ static void __init omap_nokia770_init(void)
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
 
 	gpiod_add_lookup_table(&nokia770_irq_gpio_table);
-	d = gpiod_get(NULL, "ads7846_irq", GPIOD_IN);
-	if (IS_ERR(d))
-		pr_err("Unable to get ADS7846 IRQ GPIO descriptor\n");
-	else
-		nokia770_spi_board_info[1].irq = gpiod_to_irq(d);
-
 	spi_register_board_info(nokia770_spi_board_info,
 				ARRAY_SIZE(nokia770_spi_board_info));
 	omap_serial_init();
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4f8cc450e779..ca7dbd3afe29 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1084,6 +1084,8 @@ static int ads7846_setup_pendown(struct spi_device *spi,
 			dev_err(&spi->dev, "failed to request pendown GPIO\n");
 			return PTR_ERR(ts->gpio_pendown);
 		}
+		if (!spi->irq)
+			spi->irq = gpiod_to_irq(ts->gpio_pendown);
 		if (pdata->gpio_pendown_debounce)
 			gpiod_set_debounce(ts->gpio_pendown,
 					   pdata->gpio_pendown_debounce);
@@ -1374,11 +1376,6 @@ static int ads7846_probe(struct spi_device *spi)
 	unsigned long irq_flags;
 	int err;
 
-	if (!spi->irq) {
-		dev_dbg(dev, "no IRQ?\n");
-		return -EINVAL;
-	}
-
 	/* don't exceed max specified sample rate */
 	if (spi->max_speed_hz > (125000 * SAMPLE_BITS)) {
 		dev_err(dev, "f(sample) %d KHz?\n",
@@ -1455,6 +1452,11 @@ static int ads7846_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
+	if (!spi->irq) {
+		dev_dbg(dev, "no IRQ?\n");
+		return -EINVAL;
+	}
+
 	if (pdata->penirq_recheck_delay_usecs)
 		ts->penirq_recheck_delay_usecs =
 				pdata->penirq_recheck_delay_usecs;
-- 
2.39.2

