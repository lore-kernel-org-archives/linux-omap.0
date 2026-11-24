Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.121
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505231;
	b=IasRUSiosjUMrzkWYG9FGsc75+NfxOBGl0fmd7jR87AmSoHz94ASHo39xpmpVnjh7Kyi
	 5LY4eSCT9CpEeq0vXz1CDRW9EuBPD3qwMSaVLRuXD3MXuPpphIXtOKQtzhZmW5mGU/zdU
	 8I6vRUf39mphNgeeavMT3lc9mKYSRPRw3OOruDDnvfCdOZlUOUBRxgN0WjsBuDUbLvXbR
	 b8fV1bedLzc/ulyRTeB9l4iN8Lb315aFjoVQ26SrSzj8ZooATw34w8+hrr+QPbReuyO71
	 cKsP5ix2CuJnMSbttXdFbmoOF7dAlizm4FL94exei5oREvruM+U49YPXjg1ZKHlIRVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505231;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=2BvTOQLxMfY709F9WzRxgyIMCfwQfGC0EhnVtClwW74=;
	b=IT7Ztp/DeIMo/ZE21o4JwCne4CI0QlmP+ag3hSETOJN03Ab/K87C+Igihmbk6m0wn1cL
	 iZLT0TUmuOVw1uzpqbC4suHYUoye10MJ4Z0rOad0Mcl20L71CBu7tCl138CtqTafKDqEw
	 2C2kapBh0c10duoLmrihhjeXInd+pAMbOoblcoX1MmCtA6UGrI+lXBRbK3rHqs5+6VjqD
	 ewoNCMqceMfC15COMyEX3/FW/nJebx94UH/6mAFJxRzc8e73papEZSmjcBjZ3J72TAii4
	 a6E/4PmdZ1cf2QWIwwGK421pR1RBC8GaDygDzNEag3JAb8m9V09fpM65OPm9jPeMLcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=okPRrsYt;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Jo1I4q7Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.121
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962B60A3819;
	Tue, 24 Nov 2026 07:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7962B60A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=okPRrsYt;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Jo1I4q7Y
ARC-Seal: i=1; a=rsa-sha256; t=1795505177; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VXTMjt3g0e11IQFi8lbpnM90kxR8fJPktDpb0lzIhymeW2BaAz/gNLbSt5o9rbKImh
    N4vLoM7bgxdkRJ48KtCRqdmb2qSGVQ7WVLAs5f1fvjd4b4esb5rGekxJB1OnvSnp5jdG
    Z89PkrKOjdcJLFvesWXGCwBBv32S3qSBn6V4z7NkoFMmMSeYMLoLkOg3YwWqwZ2rPzFY
    +6SQz+0iLO5z+KhW6GdFa/2Bb0MxmXzKEwXlBQJ0fxdI0zbDtr/we66me6iARxSH04ZY
    i3w8qSG4/aV18ul+nou3zFDq+7b3AfWz+Dq/LKfWW/3xIihFKq1Tm46FaKBWMzg74zkw
    vt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505177;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=2BvTOQLxMfY709F9WzRxgyIMCfwQfGC0EhnVtClwW74=;
    b=k6h1H7uHmzk5j6a6wxfaPJQ50FX+NSAAQxYB+0y4nSmRFjj4vLiF4D7Z8PToSi6AzR
    2LzG1rDW+ic7vPbSs8tVDNZ9kC7ifE54G3neo+1IC5edM0cTxHrA65QntNdi19H1G43g
    Ljg4D+QZXsdYHAx8JHJ6g72vFl1ekicKajYR2lq/UG2cGjE0ma3N1iFN7WFbmufgklTL
    UOqff6ImXMiB4A8t28TctVNeK7oxGKI5sChI8BybWz7aKsaj0q+0ktIZzlM+rZ8GyYMp
    sRowlkNnA0P3hOMm0q0kGbhKgZw31CdjDmXthm09T2oawuhYZ0sAICRdr2hou/HZX6FJ
    5ZJA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505177;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=2BvTOQLxMfY709F9WzRxgyIMCfwQfGC0EhnVtClwW74=;
    b=okPRrsYtuLzyS1CA5INIv9j+2KYUBs9UvpOeH2Mg+Z/ZOxMXhfQO0ljwX3JR/Z6Xt+
    xBwrRNwoX7daHnTNXaa+qRB/8KSR2o1Iuc5G8HoYvvhu4ngCFhpxjmcgnUaOo3C9D6Fj
    iQNkkv5lkvHu9ostpp6y3F58W6BRN3drQc9dIRhjjh/+UJVOnUz91v5afyRyQahoOAjf
    mdyc/s9hL0pTUHGZuS5LoA1ARQK0iz8zS+IWuu2dexYlJ91tfSkxngCRVLAJJBbxMeKP
    Pby7aSEGbrAUtt8pGodsFuSGRkgIFQl53sYwCFjD7xwIREMk+BIM9yjaWhV3hlwomlyY
    OAKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505177;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=2BvTOQLxMfY709F9WzRxgyIMCfwQfGC0EhnVtClwW74=;
    b=Jo1I4q7Y9aa80sCc0gqgfLwreoVBRZH14hynKI1rAZcFTcTQIF4olaGpCI1SNad9eO
    BLgsvKySXrCp4SkBnJDg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7QG1HP
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:16 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	letux-kernel@openphoenux.org,
	kernel@pyra-handheld.com,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 11/20] backlight: pwm: Support enable guard period
Date: Tue, 24 Nov 2026 08:25:51 +0100
Message-ID: <54477b4e31e35af14677172088f94770ca5b9755.1795505160.git.hns@goldelico.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
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
Content-Type: text/plain; charset="us-ascii"

Some LED drivers distinguish PWM dimming from a one-wire control
mode during a startup detection window. For example, TI TPS61160/61
use the duration of low intervals on CTRL to detect EasyScale.
An initial guard interval can keep the waveform suitable for PWM
mode detection before normal dimming begins.

Add support for a new device tree property
"pwm-enable-guard-period-us". If set, the driver applies a full
duty cycle (duty_cycle == period) for the given duration whenever
the previous PWM state was disabled or had zero duty cycle.
This covers the
requirements of such devices generically, without introducing a
chip specific backlight driver.

The requested full duty need not produce an exact constant-high
output on hardware with limited duty-cycle resolution. The board
must ensure the resulting waveform meets the LED driver timing.

Suggested-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://patchwork.kernel.org/project/linux-omap/patch/f897f695c0e1e128d7ebb41be8dfdce4d634f552.1783749722.git.hns@goldelico.com/#27124981
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Andreas Kemnade proposed placing the TPS61161 PWM-mode
      initialization in backlight support rather than in the PWM
      controller. The enable guard is the generic V2 implementation.
    - Add pwm-enable-guard-period-us support to pwm-backlight.
    - Request full duty during the startup guard when the previously
      cached PWM state was disabled or had zero duty cycle.
    - Check the return value of the guard PWM update, while leaving
      the normal pwm_apply_might_sleep() handling as in upstream.
    - Retain the hardware-tested guard implementation from the working
      series; do not incorporate the later review changes to power-on
      ordering, guard triggering, duty limiting or rollback handling.
    - Clarify that requesting full duty does not guarantee constant
      HIGH on every PWM provider; actual waveform depends on hardware.
    - Keep the existing Suggested-by attribution.
    - Code and commit-message review assisted by ChatGPT.

 drivers/video/backlight/pwm_bl.c | 37 +++++++++++++++++++++++++++++++-
 include/linux/pwm_backlight.h    |  1 +
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 3ad71ee3657af..1d0a463710926 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -18,6 +19,9 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
+/* extra time added above enable_guard_period_us for usleep_range() */
+#define PWM_BL_GUARD_SLACK_US	2000
+
 struct pwm_bl_data {
 	struct pwm_device	*pwm;
 	struct device		*dev;
@@ -26,6 +30,7 @@ struct pwm_bl_data {
 	bool			enabled;
 	struct regulator	*power_supply;
 	struct gpio_desc	*enable_gpio;
+	unsigned int		enable_guard_period_us;
 	unsigned int		scale;
 	unsigned int		post_pwm_on_delay;
 	unsigned int		pwm_off_delay;
@@ -93,11 +98,39 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 	struct pwm_bl_data *pb = bl_get_data(bl);
 	int brightness = backlight_get_brightness(bl);
 	struct pwm_state state;
+	int ret;
 
 	if (pb->notify)
 		brightness = pb->notify(pb->dev, brightness);
 
 	if (brightness > 0) {
+		pwm_get_state(pb->pwm, &state);
+
+		/*
+		 * Some LED drivers detect a one-wire control mode during
+		 * a startup window (e.g. TI TPS61160/TPS61161, using
+		 * the duration of low intervals on CTRL). Request full
+		 * duty for the guard interval before normal dimming.
+		 * The PWM provider may approximate full duty.
+		 *
+		 * Apply the guard if the previous PWM state was disabled
+		 * or had zero duty cycle.
+		 */
+		if (pb->enable_guard_period_us &&
+		    (!state.enabled || !state.duty_cycle)) {
+			struct pwm_state guard = state;
+
+			guard.duty_cycle = guard.period;
+			guard.enabled = true;
+			ret = pwm_apply_might_sleep(pb->pwm, &guard);
+			if (ret)
+				return ret;
+
+			usleep_range(pb->enable_guard_period_us,
+				     pb->enable_guard_period_us +
+				     PWM_BL_GUARD_SLACK_US);
+		}
+
 		pwm_get_state(pb->pwm, &state);
 		state.duty_cycle = compute_duty_cycle(pb, brightness, &state);
 		state.enabled = true;
@@ -239,7 +272,8 @@ static int pwm_backlight_parse_dt(struct device *dev,
 	of_property_read_u32(node, "post-pwm-on-delay-ms",
 			     &data->post_pwm_on_delay);
 	of_property_read_u32(node, "pwm-off-delay-ms", &data->pwm_off_delay);
-
+	of_property_read_u32(node, "pwm-enable-guard-period-us",
+			     &data->enable_guard_period_us);
 	/*
 	 * Determine the number of brightness levels, if this property is not
 	 * set a default table of brightness levels will be used.
@@ -467,6 +501,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
+	pb->enable_guard_period_us = data->enable_guard_period_us;
 	pb->notify = data->notify;
 	pb->notify_after = data->notify_after;
 	pb->exit = data->exit;
diff --git a/include/linux/pwm_backlight.h b/include/linux/pwm_backlight.h
index 0bf80e98d5b40..35cf19b1e9768 100644
--- a/include/linux/pwm_backlight.h
+++ b/include/linux/pwm_backlight.h
@@ -13,6 +13,7 @@ struct platform_pwm_backlight_data {
 	unsigned int lth_brightness;
 	unsigned int pwm_period_ns;
 	unsigned int *levels;
+	unsigned int enable_guard_period_us;
 	unsigned int post_pwm_on_delay;
 	unsigned int pwm_off_delay;
 	int (*init)(struct device *dev);
-- 
2.56.0

