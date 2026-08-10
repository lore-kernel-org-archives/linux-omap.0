Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EAE39AD39;
	Mon, 10 Aug 2026 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358163; cv=none; b=PotaUzHVKNwrRxRMWZV926YVJ8CHqz5Z3SULtQkI56O6UtSNW2ZXo/fj+hu3iJ/rjcae9A3HWOYC89lzX1FQN8HVYSL6YcDKrmhZOMXJgdkhn3cLdYh8a8uyYwCB8PuG6SbWS3W2b55tdLm5jbVjW+Z/65ijl2VwZgIt9wQVrqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358163; c=relaxed/simple;
	bh=aXlsx6jnI65lLrCHVH/Ds1l8OuKu1/H08tT9GG0irC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/XmvLD92XPntK91m2n/aox0U+C9tOize1nHAVjzFzjqzVzdm+BVKL4gnxUrJlFlW4hPQU71JTbuKpFdqV25qycbdoCtrjxbqLSqK3jtSfx159TcGxbeqcDGO8Z/x5lLj+LsPDLYREN598Ka46YxZ7/yB+qFLXDylTxQQtt5Pro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWM5bZIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWM5bZIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F551F000E9;
	Mon, 10 Aug 2026 10:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786358162;
	bh=aXlsx6jnI65lLrCHVH/Ds1l8OuKu1/H08tT9GG0irC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CWM5bZISaLECOKY1Wtjn0I4IsHHW5ixJ7xumDpQvvDbi+h/ismEJv96GBQEeA8Xai
	 Mm7URwrdyB+b25iei/AU/srS/DoE0czDnYav6c2okXt9fzfrjzgoqEZGSPIEyzVuO9
	 t5phGEXdiw4o91XvLM3DJ+2mSszyONGbCgMj9SaptXpuToQqlYzL1Cf2jEQqD5IVjR
	 4jBFh5JyiJN28Ve72CTKuAtb+t6EuNgybkG15ShwuwmfcEYx1PTBDpFhrwdMrzu+Kt
	 0k9p8Q0JVvb5L+gfQRTggI9gMqorpMBMC7dbYaENRs5bWvSaHxNMGPcQ5LDiBT602o
	 uxWSA/d64iu0g==
Date: Mon, 10 Aug 2026 11:35:52 +0100
From: Daniel Thompson <danielt@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Grond <grond66@riseup.net>, Stefan Leichter <sle85276@gmx.de>,
	Grazvydas Ignotas <notasas@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Sen Wang <sen@ti.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Niranjan H Y <niranjan.hy@ti.com>, letux-kernel@openphoenux.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	kernel@pyra-handheld.com, mfd@lists.linux.dev
Subject: Re: [PATCH 15/16] backlight: remove pandora_bl
Message-ID: <anmpiADsvzW39DNx@aspen.lan>
References: <cover.1783749722.git.hns@goldelico.com>
 <f897f695c0e1e128d7ebb41be8dfdce4d634f552.1783749722.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f897f695c0e1e128d7ebb41be8dfdce4d634f552.1783749722.git.hns@goldelico.com>

On Sat, Jul 11, 2026 at 08:02:02AM +0200, H. Nikolaus Schaller wrote:
> Retire the platform specific pandora backlight driver since
> it can now be replaced by twl_pm and device tree.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Yay!

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
