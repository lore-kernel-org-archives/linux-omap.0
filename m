Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EEF3D669B;
	Mon, 10 Aug 2026 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365603; cv=none; b=NCqwUB1SkFZ9VRxz4VwvT/hFHiLSExeLdP3DkhidunE3LIgWJD+p0ILPZPz41sA1zMsqbvOJWXbab1pTHrVf5vZvcA4pI73q/xmL3dCHLcg1BPTPjuzbHfVYFHnfVI5nWsjyrXldTkMymsGlDpyHYFzBXW0NJsJ9y/6tuBobBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365603; c=relaxed/simple;
	bh=idY+TMDwbQ5ONQBtcS1ma7Z6izl5WGX4G7umMEjIKZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZawqWhxXFufGgXYaaXnt4gfnm5dY8J47+AXVsff9yd9cDbJ9/yLR9M7DtkqijbVgNt07AlusjFXOOGUOhTwUn+xmDv97Dm5JzRqFo2LIZa2gV8YOCTDKi/+pzOuoQZT7WlyZ4d7/NQfIIsePPLEwix7mnOdLKZbc2gBWZeFN0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=8ARx8TI3; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="8ARx8TI3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=RY/1wmCxCIFM0LLRBnTLXmBpxbfVg0FeVcj6W7X9LH0=; t=1786365602; x=1787575202; 
	b=8ARx8TI3PDgp8yyRWt3GU3iy1krWHsiSrXbJLxz137kmerIXl1MTsYcTX+3MEYDQAWVu7BWtxx6
	fjKpt1JyJ2o9wsWOdHzz0RVHnTsSCeWOui0hZuCThrlz2ZOjeOrtd5eBM5Y6QlJbwU4qeAxcy25NK
	MM+Q6pxd0wzaqp43mVR0IEbNtCvw2kD5gSNusU4/5Tn03UzR5EsPuzUdo5D4ZVybKVmqXSwqWtvw5
	EgMI1qv1mFxCSflFP6TRTOgUe3DhTzkUdqp9dABBRYEi9KJLBhK/XxsHIe4SkduSStZVPIWoj4d2I
	izBRT4VKgRrOju3JBGlRwBoxK3eaBpQu+o8g==;
Date: Mon, 10 Aug 2026 14:39:14 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Daniel Thompson <danielt@kernel.org>, Grond <grond66@riseup.net>, Stefan
 Leichter <sle85276@gmx.de>, Grazvydas Ignotas <notasas@gmail.com>, Tony
 Lindgren <tony@atomide.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Lee Jones <lee@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller
 <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Sen Wang <sen@ti.com>, Richard Fitzgerald
 <rf@opensource.cirrus.com>, Arnd Bergmann <arnd@arndb.de>, Srinivas
 Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, Kuninori Morimoto
 <kuninori.morimoto.gx@renesas.com>, Charles Keepax
 <ckeepax@opensource.cirrus.com>, Niranjan H Y <niranjan.hy@ti.com>,
 letux-kernel@openphoenux.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 kernel@pyra-handheld.com, mfd@lists.linux.dev
Subject: Re: [PATCH 15/16] backlight: remove pandora_bl
Message-ID: <20260810143914.64d29a5c@kemnade.info>
In-Reply-To: <DA9588C6-0238-4713-B1A1-CB2123F02028@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
	<f897f695c0e1e128d7ebb41be8dfdce4d634f552.1783749722.git.hns@goldelico.com>
	<anmpiADsvzW39DNx@aspen.lan>
	<DA9588C6-0238-4713-B1A1-CB2123F02028@goldelico.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 12:45:16 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi Daniel,
> 
> > Am 10.08.2026 um 12:35 schrieb Daniel Thompson <danielt@kernel.org>:
> > 
> > On Sat, Jul 11, 2026 at 08:02:02AM +0200, H. Nikolaus Schaller wrote:  
> >> Retire the platform specific pandora backlight driver since
> >> it can now be replaced by twl_pm and device tree.
> >> 
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>  
> > 
> > Yay!
> > 
> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>  
> 
> Well, there were some good comments by Sahiko to the prerequisites of this patch,
> because it has one speciality the PWM BL driver does not handle (avoid
> interpretation of PWM signals as W1 protocol).
> 
> I haven't found time to work on this, so we can't remove this yet.
> 
> In the end it may either remain a pandora_bl driver (converted to DT)
> or become a patch for something else.
> 
But then it is a TPS61161 on top of PWM, not a pandora driver.
And then there might be just a quirk for that chip in the pwm_bl using
triggered by a compatible. I guess the quirk is this:


if (priv->old_state == PANDORABL_WAS_OFF) {
-		/*
-		 * set PWM duty cycle to max. TPS61161 seems to use this
-		 * to calibrate it's PWM sensitivity when it starts.
-		 */
-		twl_i2c_write_u8(TWL_MODULE_PWM, MAX_VALUE, TWL_PWM0_OFF);
-
-		/* first enable clock, then PWM0 out */
-		twl_i2c_read_u8(TWL4030_MODULE_INTBR, &r, TWL_INTBR_GPBR1);
-		r &= ~PWM0_ENABLE;
-		r |= PWM0_CLK_ENABLE;
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
-		r |= PWM0_ENABLE;
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
-
-		/*
-		 * TI made it very easy to enable digital control, so easy that
-		 * it often triggers unintentionally and disabes PWM control,
-		 * so wait until 1 wire mode detection window ends.
-		 */
-		usleep_range(2000, 10000);
-	}

Regards,
Andreas
