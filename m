Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB912236F0;
	Mon, 10 Aug 2026 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394092; cv=none; b=JyQiZkpyVVNKqEH0m5nDMkNeweLG9gSrOb9AeBPdonlf1FiFyCP+bcsHu1FlKAd8Kc/giwOssMkQ78Na1wfsK7kx1xBB3Gezhd0EQbQUU7VaXDxo7AMv1p6Lg9k6Ea2LtImKOUW15q+Ig2D4+8cU6MdQWzqfsSdGNYvvg5BBaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394092; c=relaxed/simple;
	bh=Z//gjbzolO0j9Ht17OZ+pUqamuxMGAP6Onswa//Ty8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJ71kTOT+OH80WEwCIQBpXJQdGU4zaFWvNMSbEKq3QYATUrWxzFl7jAHdJxEOeqv0LSY6tNRZY4Zv+WxY1wcHBoF02VuKFyjEROAKBI/riRISBAcg6tMhnFqbYssoy0x7W+PKaV77vZ+/z+s9FxMgjMjNEpoD4cxmzhHpKxg4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=x+SM9lp3; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="x+SM9lp3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=5fkRRQESuJogTJbUlw1TtnlKX+cyZWiGY0fHfzIT9Xw=; t=1786394091; x=1787603691; 
	b=x+SM9lp3qedBZNa0ryQpDezSB/inEjpK6a0Ncv/aDg+46a+sIPpCYREV6svIx9DresYp2cn8DaP
	DnYI8JakFbLqPBzglrKDV5esJvGhrvoVjgjZwSi2lga5D+cW/+sMCNQc6Z6E2G9qARusJxT3T2a/F
	+uBmivzCBzew11xJ/6x3uVZN4czq7pBtNoWrTfgVLN1xsRISFuxNoiBmltCF227p0PsO29j7dLRQy
	0Hun4HhKYWtFMt8LIUnYW/UJNYcDbZc0w7URtHknOnxJmprh5zuJIjI6kpdEeodjA+3PzQiYns2nC
	PycP+ZbDhi1YBQhsEaIKpRJsvT/QjAjNDhlA==;
Date: Mon, 10 Aug 2026 22:34:13 +0200
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
Message-ID: <20260810223413.01af9a6d@kemnade.info>
In-Reply-To: <92FE1162-8C61-4186-B073-6AB4B2BDA640@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
	<f897f695c0e1e128d7ebb41be8dfdce4d634f552.1783749722.git.hns@goldelico.com>
	<anmpiADsvzW39DNx@aspen.lan>
	<DA9588C6-0238-4713-B1A1-CB2123F02028@goldelico.com>
	<20260810143914.64d29a5c@kemnade.info>
	<2C9844A3-3C4C-48E6-863D-BF8328CEE540@goldelico.com>
	<92FE1162-8C61-4186-B073-6AB4B2BDA640@goldelico.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 20:30:13 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > 
> > Yes that is what I mean. It needs to be ported somewhere. If it can be ported to
> > some compatible = "pwm_bl_for_tps61161" or what fits best it will be fine. Or it
> > could be in some compatible = "pandora_bl" driver.
> > 
> > Has to be worked out when the development machines are not blocked by 3 or 4 other
> > projects already running in parallel :)  
> 
> Nevertheless I did a quick look into the pandora_bl driver structure.
> 
> Here are my findings:
> - the code fragment is part of pandora_backlight_update_status()
> - priv->old_state remembers if brighness was set to 0 or not
> - so this code triggers on any change from bright = 0 to bright > 0
> - the pandora_bl driver is the only one to use TWL_MODULE_PWM besides twl-pwm
> 
> So the most natural way of transplanting this appears to me:
> - add this logic to the twl-pwm driver

That chip could be connected to any pwm driver, so
it does not make sense to have that in a pwm driver.

So it belongs into a backlight driver. And since it shared so much
code with the pwm_bl, it could be extended.
The compatible should have pwm in the name to be able to also add
a w1 driver later.

Regards,
Andreas
