Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215013;
	b=j9wKyZUVHf1C6YaKucSiKPGlpTwF4KGoB6ttqYTNHsVAR30lm/w769wFmWF78Qy76tQS
	 SRGRCKfbX3P9qU7KghROEDxvOmMuV7Fjs268jgoSf4HPr21f+VTPfriVNda/6JofDvTQH
	 43ttlZOyIg9gBpdByVtKU+FktDmiF3Qe0CMG6UXkWSnVZOj6xEOFYGukztB6jURX2hx0P
	 3ThqQpmciAa8HhIRCJM3e0uNLEORzfBMpTvi/E1OoWl0lf9s9dkw16JVxjjIwU3dGhf8z
	 QZI44PT5xKiuMceV4pqRTFkdVekRnYnT538pL74+UBYPLO2kp2mKAtQY7kIsLS22Jzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215013;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tjiMc0u9JRfCWVfHK0ySiQtqapmVRAz5A/meQ6qpN84=;
	b=ufYY41oNeXCIf26fLm5vDFKOeA4dSVhMZDM+d3N4SCTqLk7s5NOw10Cg6yZ/FskoWi1b
	 rxwznZqciw8D0NAuU/eCQePnkUH7SHm8DNBckME0S3OLrpwXqPseyxHXoDnQWhhhROIMY
	 qs639vUDRuJY13fsX68OWV1oxoDZZeRG1Xj+gOKnvmQmgbdaWftjBkYyhqCxHYQKgOZWE
	 9EMRL3sPCswmmhGp6HTmRcf41B27ZhSuoTiq5LoCtsd2It5sKGFDH2LdlWwp6lE8uWgHl
	 B3okwMHAVZPXf4c/uAh9DuqE8+oGJ5aJphJM49MHzt2CyKRUnLuDNX+4f0MJ0OMXQBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=DKvzJ0Xz;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EC606A321;
	Wed, 28 Oct 2026 19:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D76EC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=DKvzJ0Xz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=tjiMc0u9JRfCWVfHK0ySiQtqapmVRAz5A/meQ6qpN84=; t=1793215012; x=1794424612; 
	b=DKvzJ0XzwvT7FM9dzjFlkXUd4CTstXaZQV9FHg4u5kEU4gTFPXUq+tH798lIFCv5WwbuwhUaBhK
	TvPlAWPNq4uztQC4tUsO8rXDFpAQcQRhEz/6eua1Wrnzs/xBvZtzabg88Ybrl0D4IYSDL3pnuqlhg
	gjymLu7lrvhtqZMkB7snwISXoywoZY0CgVAOICkiRXd4yoVmlSQRK8V8fv0DRXK09mlx1ABOQ2Ac7
	dCqEsMoYw2yJ54q4X/cuYe/ysmelGmmklM9khtslHMo7qk04H+ILRA8fEaUuyXDJEuBQP9WmrHimO
	RCFZwmZ8qLoOqMO1/6JiWj5RIhKMM7vKhUHA==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 28 Oct 2026 20:15:12 +0100
Subject: [PATCH 2/2] ARM: omap: cpuidle34xx: Constify state info
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
Message-Id: <20261028-susp2-v1-2-174b52857d89@kemnade.info>
References: <20261028-susp2-v1-0-174b52857d89@kemnade.info>
In-Reply-To: <20261028-susp2-v1-0-174b52857d89@kemnade.info>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=udfUXXKoplbjhUeiEbeEWkhgstB9Za6ncNNCxAZQg8E=;
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBq4knOI1TAO1AubtmAcvHnGMAx5q8xpYQh1KEN9
 6e4JkPCypeJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCauJJzgAKCRCEYUX6QCjc
 8fA8D/99UAuWZnyNbEb5wgRySI9mYsNOWcmPYZJR48NQxScCXf6WXflvl9J1hN+IyzvK3iO1k1b
 GIzrxzZg8VfSDWR3fBoVG9KuVIWAP1DHuSVWoIudPNShZasH+3ysOgAGqyXjCrLH5qRKUHDYqXM
 I/MQIoKlziGI+WG7P7opeeCYk9LwiigNK2U5ELXBNocf46zi8b0jWH8vCkzGMPes1cwFEnLSNaH
 uAFxQI3h07krmtGNfnW8+lydYUecUK48Tn9en+UmG93wGvc+OW7DmNHpODaOPOrqdfAIAr2CmdC
 ejJvD21ThAwmmVVzn05bojhrzsYT+cLJx6fhzdiK81zT9pV12aV/gnfax1zjVCF8ZfZGyRXPisX
 eNSeRH96sR27CxuVyJKFrY8OvexygLyqqIz3MSoTNEOVWpvxZq/k5VvOuLM6Sei8UKrEGujKbuf
 rWzK5dmaoacUFkTFE+y+HOZdEJ9nNDWDvi8onMhZwpVS03QFWmwWnWxzzb7V25jrTolSyByTA8T
 4YIamC059n9EF5mtToQXrQMfdM8FceMJidYVxs3ws/9/JXJ+kYc+CYOckpnXLFPtIEGfj0rOIfZ
 yrLKY/Qv1d/zae7J2d134tu3P7uy8EDyM2tD4k3J/4UI2efIpsQjjFnqbNy/D8ZXpQ8oBveVwnh
 cOgeTzHegCsuaWw==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

omap3_idle_statedata is only static read only data,
so have that fact cleary visible.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/mach-omap2/cpuidle34xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index e42dcf8c03a3..16d2e1f08b48 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -58,7 +58,7 @@ static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
  * Prevent PER OFF if CORE is not in RETention or OFF as this would
  * disable PER wakeups completely.
  */
-static struct omap3_idle_statedata omap3_idle_data[] = {
+static const struct omap3_idle_statedata omap3_idle_data[] = {
 	{
 		.mpu_state = PWRDM_POWER_ON,
 		.core_state = PWRDM_POWER_ON,
@@ -108,7 +108,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv,
 			    int index)
 {
-	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
+	const struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 	int error;
 
 	if (omap_irq_pending() || need_resched())
@@ -168,7 +168,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 static int next_valid_state(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
-	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
+	const struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 	u32 mpu_deepest_state = PWRDM_POWER_RET;
 	u32 core_deepest_state = PWRDM_POWER_RET;
 	int idx;
@@ -221,7 +221,7 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 {
 	int new_state_idx, ret;
 	u8 per_next_state, per_saved_state;
-	struct omap3_idle_statedata *cx;
+	const struct omap3_idle_statedata *cx;
 
 	/*
 	 * Use only C1 if CAM is active.

-- 
2.47.3

