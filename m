Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160B45DF69;
	Wed,  9 Sep 2026 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941241; cv=none; b=IsPNkQi1KchW4jezE9VwkL2eYMTb/TQGrvcUlHRaRmiqfjCCjI+c3Fl4XfZShBgw3bBa7dKVccODYqVDsS6th7aNsE9XVUR2r8tGy3ITB0ZLziUCP+FYNIarP6gm3LNfVpmGzBdXylzOmCK2yeg0xcWUffUdDOwETlHeOs1ZhOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941241; c=relaxed/simple;
	bh=3kNyQIqgA34vSPt4Co5AJ7Ajk+r655qVgGofXKMNeNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEcqy6V4zebnTjIu9rirUOpqDtQ3AnDoEkeJavscTSSDYub/L6+dIaDCs+rvBk0a2ojD7PbtbmVSsMgL9FK3Pyg6B4uZnvYIRNaiM3aYPq3EHQOdh4FMF/nOQ4xiSFBFuv9qZXKt5XbhmuFyFzhnrfJP//QIeYYJdGmQT1i4M1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q1gtdkY4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/HcunURC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=flHu13xp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wK6twJK7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q1gtdkY4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/HcunURC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="flHu13xp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wK6twJK7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4FEA31F80A;
	Wed,  9 Sep 2026 08:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788941219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eMCafEwvvjd0OEAupj5d6T4the4OvFpTGf66YYcY8bk=;
	b=Q1gtdkY4y7kvd9pfK99bs0VL9rfz3KWfV0tUS+BdzEJ4N5HnTpS6HYUXrUpUbHjMXDrnPB
	vkS1uwsplMjwzdvbPd1RZRZaxDggGnVD6owXc9hSWIl4qJwLroNl63jzECJdRigXvNMiFv
	uZzycWVWqoB+dI7tWfH3+ErR3GOe7l0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788941219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eMCafEwvvjd0OEAupj5d6T4the4OvFpTGf66YYcY8bk=;
	b=/HcunURCv3TEmZUPbpksNR/i8OHXdAe94dU45EF88wDKk/I/AUkh5CGYNVzZHQEHWxO5eS
	GEczaAYe2iv7AwAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788941215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eMCafEwvvjd0OEAupj5d6T4the4OvFpTGf66YYcY8bk=;
	b=flHu13xpU/AfkiBJpoZoelLkRDt7Qeaur2CHgm5X6qbVBzxwiebSIAHYVEW/2JZHF7twU6
	G/7qSGKUwGAr008oLq0MMO0KgcIzMT0qOMAA6Bl/xGo+s8mr/ATO3INCS8Hevd/6VVcwdm
	mCZeXK5zqLcU0IeO7alVt7wzwy2vja8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788941215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eMCafEwvvjd0OEAupj5d6T4the4OvFpTGf66YYcY8bk=;
	b=wK6twJK7Cl1Ukm/yOVRXCdba9kbJXSydb8+dEv6pV+iMv6dxlNZQUbS3eEDbDJyYPk52CT
	21qznI347kkC7KCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8447F13354;
	Wed,  9 Sep 2026 08:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bMH9Hp0ToWo9HwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 08:06:53 +0000
Message-ID: <23b73f4f-78b0-4991-8ce4-248753538c54@suse.de>
Date: Wed, 9 Sep 2026 10:06:52 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] ARM: omap2: remove omap24xx support
To: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
 Paul Walmsley <paul@pwsan.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, Helge Deller <deller@gmx.de>,
 Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-7-arnd@kernel.org>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260908152808.3928630-7-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_GT_50(0.00)[59];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,arm.com,nxp.com,pengutronix.de,gmail.com,mleia.com,agner.ch,foss.st.com,iki.fi,kemnade.info,baylibre.com,atomide.com,microchip.com,tuxon.dev,lunn.ch,bootlin.com,free.fr,linux-m68k.org,siemens.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,pwsan.com,gondor.apana.org.au,davemloft.net,samsung.com,gmx.de,lists.freedesktop.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]



Am 08.09.26 um 17:27 schrieb Arnd Bergmann:
>   drivers/video/fbdev/omap2/omapfb/Kconfig      |    2 +-

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de> # omapfb

>   include/linux/clk/ti.h                        |    8 -
>   86 files changed, 60 insertions(+), 10696 deletions(-)
>   delete mode 100644 arch/arm/boot/dts/ti/omap/omap2.dtsi
>   delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420-clocks.dtsi
>   delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420-h4.dts
>   delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420-n800.dts
>   delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420-n810-wimax.dts
>   delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420-n810.dts
>   delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420-n8x0-common.dtsi
>   delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420.dtsi
>   delete mode 100644 arch/arm/boot/dts/ti/omap/omap2430-clocks.dtsi
>   delete mode 100644 arch/arm/boot/dts/ti/omap/omap2430-sdp.dts
>   delete mode 100644 arch/arm/boot/dts/ti/omap/omap2430.dtsi
>   delete mode 100644 arch/arm/boot/dts/ti/omap/omap24xx-clocks.dtsi
>   delete mode 100644 arch/arm/mach-omap2/board-n8x0.c
>   delete mode 100644 arch/arm/mach-omap2/clkt2xxx_dpll.c
>   delete mode 100644 arch/arm/mach-omap2/clkt2xxx_dpllcore.c
>   delete mode 100644 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
>   delete mode 100644 arch/arm/mach-omap2/clock2xxx.h
>   delete mode 100644 arch/arm/mach-omap2/clockdomains2420_data.c
>   delete mode 100644 arch/arm/mach-omap2/clockdomains2430_data.c
>   delete mode 100644 arch/arm/mach-omap2/cm-regbits-24xx.h
>   delete mode 100644 arch/arm/mach-omap2/cm2xxx.c
>   delete mode 100644 arch/arm/mach-omap2/cm2xxx.h
>   delete mode 100644 arch/arm/mach-omap2/common-board-devices.h
>   delete mode 100644 arch/arm/mach-omap2/gpmc.h
>   delete mode 100644 arch/arm/mach-omap2/l3_2xxx.h
>   delete mode 100644 arch/arm/mach-omap2/l4_2xxx.h
>   delete mode 100644 arch/arm/mach-omap2/mmc.h
>   delete mode 100644 arch/arm/mach-omap2/msdi.c
>   delete mode 100644 arch/arm/mach-omap2/omap2-restart.c
>   delete mode 100644 arch/arm/mach-omap2/omap24xx.h
>   delete mode 100644 arch/arm/mach-omap2/omap_hwmod_2420_data.c
>   delete mode 100644 arch/arm/mach-omap2/omap_hwmod_2430_data.c
>   delete mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
>   delete mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
>   delete mode 100644 arch/arm/mach-omap2/opp2420_data.c
>   delete mode 100644 arch/arm/mach-omap2/opp2430_data.c
>   delete mode 100644 arch/arm/mach-omap2/opp2xxx.h
>   delete mode 100644 arch/arm/mach-omap2/powerdomains2xxx_data.c
>   delete mode 100644 arch/arm/mach-omap2/prm-regbits-24xx.h
>   delete mode 100644 arch/arm/mach-omap2/prm2xxx.c
>   delete mode 100644 arch/arm/mach-omap2/prm2xxx.h
>   delete mode 100644 arch/arm/mach-omap2/sdrc2xxx.c
>   delete mode 100644 arch/arm/mach-omap2/sleep24xx.S
>   delete mode 100644 arch/arm/mach-omap2/sram242x.S
>   delete mode 100644 arch/arm/mach-omap2/sram243x.S
>   delete mode 100644 arch/arm/mach-omap2/usb-tusb6010.c
>   delete mode 100644 arch/arm/mach-omap2/usb-tusb6010.h
>   delete mode 100644 arch/arm/mach-omap2/voltagedomains2xxx_data.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 028db7ad15ad..0d10f778800d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19874,7 +19874,6 @@ M:	Jarkko Nikula <jarkko.nikula@bitmer.com>
>   L:	linux-sound@vger.kernel.org
>   L:	linux-omap@vger.kernel.org
>   S:	Maintained
> -F:	sound/soc/ti/n810.c
>   F:	sound/soc/ti/omap*
>   F:	sound/soc/ti/rx51.c
>   F:	sound/soc/ti/sdma-pcm.*
> @@ -20027,7 +20026,6 @@ F:	drivers/gpio/gpio-tps65219.c
>   F:	drivers/i2c/busses/i2c-omap.c
>   F:	drivers/irqchip/irq-omap-intc.c
>   F:	drivers/mfd/*omap*.c
> -F:	drivers/mfd/menelaus.c
>   F:	drivers/mfd/palmas.c
>   F:	drivers/mfd/tps65217.c
>   F:	drivers/mfd/tps65218.c
> diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
> index 498c36ccb5ea..3c5d378df6b9 100644
> --- a/arch/arm/boot/dts/ti/omap/Makefile
> +++ b/arch/arm/boot/dts/ti/omap/Makefile
> @@ -1,10 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_ARCH_OMAP2) += \
> -	omap2420-h4.dtb \
> -	omap2420-n800.dtb \
> -	omap2420-n810.dtb \
> -	omap2420-n810-wimax.dtb \
> -	omap2430-sdp.dtb
>   dtb-$(CONFIG_ARCH_OMAP3) += \
>   	am3517-craneboard.dtb \
>   	am3517-evm.dtb \
> diff --git a/arch/arm/boot/dts/ti/omap/omap2.dtsi b/arch/arm/boot/dts/ti/omap/omap2.dtsi
> deleted file mode 100644
> index fdc1790adf43..000000000000
> --- a/arch/arm/boot/dts/ti/omap/omap2.dtsi
> +++ /dev/null
> @@ -1,338 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Device Tree Source for OMAP2 SoC
> - *
> - * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -
> -#include <dt-bindings/bus/ti-sysc.h>
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/pinctrl/omap.h>
> -
> -/ {
> -	compatible = "ti,omap2430", "ti,omap2420", "ti,omap2";
> -	interrupt-parent = <&intc>;
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	chosen { };
> -
> -	aliases {
> -		serial0 = &uart1;
> -		serial1 = &uart2;
> -		serial2 = &uart3;
> -		i2c0 = &i2c1;
> -		i2c1 = &i2c2;
> -	};
> -
> -	cpus {
> -		#address-cells = <0>;
> -		#size-cells = <0>;
> -
> -		cpu {
> -			compatible = "arm,arm1136jf-s";
> -			device_type = "cpu";
> -		};
> -	};
> -
> -	pmu {
> -		compatible = "arm,arm1136-pmu";
> -		interrupts = <3>;
> -	};
> -
> -	soc {
> -		compatible = "ti,omap-infra";
> -		mpu {
> -			compatible = "ti,omap2-mpu";
> -			ti,hwmods = "mpu";
> -		};
> -	};
> -
> -	ocp {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -		ti,hwmods = "l3_main";
> -
> -		aes: aes@480a6000 {
> -			compatible = "ti,omap2-aes";
> -			ti,hwmods = "aes";
> -			reg = <0x480a6000 0x50>;
> -			dmas = <&sdma 9 &sdma 10>;
> -			dma-names = "tx", "rx";
> -		};
> -
> -		hdq1w: 1w@480b2000 {
> -			compatible = "ti,omap2420-1w";
> -			ti,hwmods = "hdq1w";
> -			reg = <0x480b2000 0x1000>;
> -			interrupts = <58>;
> -		};
> -
> -		intc: interrupt-controller@1 {
> -			compatible = "ti,omap2-intc";
> -			interrupt-controller;
> -			#interrupt-cells = <1>;
> -			reg = <0x480FE000 0x1000>;
> -		};
> -
> -		target-module@48056000 {
> -			compatible = "ti,sysc-omap2", "ti,sysc";
> -			reg = <0x48056000 0x4>,
> -			      <0x4805602c 0x4>,
> -			      <0x48056028 0x4>;
> -			reg-names = "rev", "sysc", "syss";
> -			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
> -					 SYSC_OMAP2_EMUFREE |
> -					 SYSC_OMAP2_SOFTRESET |
> -					 SYSC_OMAP2_AUTOIDLE)>;
> -			ti,sysc-midle = <SYSC_IDLE_FORCE>,
> -					<SYSC_IDLE_NO>,
> -					<SYSC_IDLE_SMART>;
> -			ti,syss-mask = <1>;
> -			clocks = <&core_l3_ck>;
> -			clock-names = "fck";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0 0x48056000 0x1000>;
> -
> -			sdma: dma-controller@0 {
> -				compatible = "ti,omap2420-sdma", "ti,omap-sdma";
> -				reg = <0 0x1000>;
> -				interrupts = <12>,
> -					     <13>,
> -					     <14>,
> -					     <15>;
> -				#dma-cells = <1>;
> -				dma-channels = <32>;
> -				dma-requests = <64>;
> -			};
> -		};
> -
> -		i2c1: i2c@48070000 {
> -			compatible = "ti,omap2-i2c";
> -			ti,hwmods = "i2c1";
> -			reg = <0x48070000 0x80>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			interrupts = <56>;
> -		};
> -
> -		i2c2: i2c@48072000 {
> -			compatible = "ti,omap2-i2c";
> -			ti,hwmods = "i2c2";
> -			reg = <0x48072000 0x80>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			interrupts = <57>;
> -		};
> -
> -		mcspi1: spi@48098000 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "ti,omap2-mcspi";
> -			ti,hwmods = "mcspi1";
> -			reg = <0x48098000 0x100>;
> -			interrupts = <65>;
> -			dmas = <&sdma 35 &sdma 36 &sdma 37 &sdma 38
> -				&sdma 39 &sdma 40 &sdma 41 &sdma 42>;
> -			dma-names = "tx0", "rx0", "tx1", "rx1",
> -				    "tx2", "rx2", "tx3", "rx3";
> -		};
> -
> -		mcspi2: spi@4809a000 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "ti,omap2-mcspi";
> -			ti,hwmods = "mcspi2";
> -			reg = <0x4809a000 0x100>;
> -			interrupts = <66>;
> -			dmas = <&sdma 43 &sdma 44 &sdma 45 &sdma 46>;
> -			dma-names = "tx0", "rx0", "tx1", "rx1";
> -		};
> -
> -		rng: rng@480a0000 {
> -			compatible = "ti,omap2-rng";
> -			ti,hwmods = "rng";
> -			reg = <0x480a0000 0x50>;
> -			interrupts = <52>;
> -		};
> -
> -		sham: sham@480a4000 {
> -			compatible = "ti,omap2-sham";
> -			ti,hwmods = "sham";
> -			reg = <0x480a4000 0x64>;
> -			interrupts = <51>;
> -			dmas = <&sdma 13>;
> -			dma-names = "rx";
> -		};
> -
> -		uart1: serial@4806a000 {
> -			compatible = "ti,omap2-uart";
> -			ti,hwmods = "uart1";
> -			reg = <0x4806a000 0x2000>;
> -			interrupts = <72>;
> -			dmas = <&sdma 49 &sdma 50>;
> -			dma-names = "tx", "rx";
> -			clock-frequency = <48000000>;
> -		};
> -
> -		uart2: serial@4806c000 {
> -			compatible = "ti,omap2-uart";
> -			ti,hwmods = "uart2";
> -			reg = <0x4806c000 0x400>;
> -			interrupts = <73>;
> -			dmas = <&sdma 51 &sdma 52>;
> -			dma-names = "tx", "rx";
> -			clock-frequency = <48000000>;
> -		};
> -
> -		uart3: serial@4806e000 {
> -			compatible = "ti,omap2-uart";
> -			ti,hwmods = "uart3";
> -			reg = <0x4806e000 0x400>;
> -			interrupts = <74>;
> -			dmas = <&sdma 53 &sdma 54>;
> -			dma-names = "tx", "rx";
> -			clock-frequency = <48000000>;
> -		};
> -
> -		timer2_target: target-module@4802a000 {
> -			compatible = "ti,sysc-omap2-timer", "ti,sysc";
> -			reg = <0x4802a000 0x4>,
> -			      <0x4802a010 0x4>,
> -			      <0x4802a014 0x4>;
> -			reg-names = "rev", "sysc", "syss";
> -			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
> -					 SYSC_OMAP2_EMUFREE |
> -					 SYSC_OMAP2_ENAWAKEUP |
> -					 SYSC_OMAP2_SOFTRESET |
> -					 SYSC_OMAP2_AUTOIDLE)>;
> -			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> -					<SYSC_IDLE_NO>,
> -					<SYSC_IDLE_SMART>;
> -			ti,syss-mask = <1>;
> -			clocks = <&gpt2_fck>, <&gpt2_ick>;
> -			clock-names = "fck", "ick";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0x0 0x4802a000 0x1000>;
> -
> -			timer2: timer@0 {
> -				compatible = "ti,omap2420-timer";
> -				reg = <0 0x400>;
> -				interrupts = <38>;
> -			};
> -		};
> -
> -		timer3: timer@48078000 {
> -			compatible = "ti,omap2420-timer";
> -			reg = <0x48078000 0x400>;
> -			interrupts = <39>;
> -			ti,hwmods = "timer3";
> -		};
> -
> -		timer4: timer@4807a000 {
> -			compatible = "ti,omap2420-timer";
> -			reg = <0x4807a000 0x400>;
> -			interrupts = <40>;
> -			ti,hwmods = "timer4";
> -		};
> -
> -		timer5: timer@4807c000 {
> -			compatible = "ti,omap2420-timer";
> -			reg = <0x4807c000 0x400>;
> -			interrupts = <41>;
> -			ti,hwmods = "timer5";
> -			ti,timer-dsp;
> -		};
> -
> -		timer6: timer@4807e000 {
> -			compatible = "ti,omap2420-timer";
> -			reg = <0x4807e000 0x400>;
> -			interrupts = <42>;
> -			ti,hwmods = "timer6";
> -			ti,timer-dsp;
> -		};
> -
> -		timer7: timer@48080000 {
> -			compatible = "ti,omap2420-timer";
> -			reg = <0x48080000 0x400>;
> -			interrupts = <43>;
> -			ti,hwmods = "timer7";
> -			ti,timer-dsp;
> -		};
> -
> -		timer8: timer@48082000 {
> -			compatible = "ti,omap2420-timer";
> -			reg = <0x48082000 0x400>;
> -			interrupts = <44>;
> -			ti,hwmods = "timer8";
> -			ti,timer-dsp;
> -		};
> -
> -		timer9: timer@48084000 {
> -			compatible = "ti,omap2420-timer";
> -			reg = <0x48084000 0x400>;
> -			interrupts = <45>;
> -			ti,hwmods = "timer9";
> -			ti,timer-pwm;
> -		};
> -
> -		timer10: timer@48086000 {
> -			compatible = "ti,omap2420-timer";
> -			reg = <0x48086000 0x400>;
> -			interrupts = <46>;
> -			ti,hwmods = "timer10";
> -			ti,timer-pwm;
> -		};
> -
> -		timer11: timer@48088000 {
> -			compatible = "ti,omap2420-timer";
> -			reg = <0x48088000 0x400>;
> -			interrupts = <47>;
> -			ti,hwmods = "timer11";
> -			ti,timer-pwm;
> -		};
> -
> -		timer12: timer@4808a000 {
> -			compatible = "ti,omap2420-timer";
> -			reg = <0x4808a000 0x400>;
> -			interrupts = <48>;
> -			ti,hwmods = "timer12";
> -			ti,timer-pwm;
> -		};
> -
> -		dss: dss@48050000 {
> -			compatible = "ti,omap2-dss";
> -			reg = <0x48050000 0x400>;
> -			status = "disabled";
> -			ti,hwmods = "dss_core";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges;
> -
> -			dispc@48050400 {
> -				compatible = "ti,omap2-dispc";
> -				reg = <0x48050400 0x400>;
> -				interrupts = <25>;
> -				ti,hwmods = "dss_dispc";
> -			};
> -
> -			rfbi: encoder@48050800 {
> -				compatible = "ti,omap2-rfbi";
> -				reg = <0x48050800 0x400>;
> -				status = "disabled";
> -				ti,hwmods = "dss_rfbi";
> -			};
> -
> -			venc: encoder@48050c00 {
> -				compatible = "ti,omap2-venc";
> -				reg = <0x48050c00 0x400>;
> -				status = "disabled";
> -				ti,hwmods = "dss_venc";
> -			};
> -		};
> -	};
> -};
> diff --git a/arch/arm/boot/dts/ti/omap/omap2420-clocks.dtsi b/arch/arm/boot/dts/ti/omap/omap2420-clocks.dtsi
> deleted file mode 100644
> index 00a7a199a91c..000000000000
> --- a/arch/arm/boot/dts/ti/omap/omap2420-clocks.dtsi
> +++ /dev/null
> @@ -1,267 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Device Tree Source for OMAP2420 clock data
> - *
> - * Copyright (C) 2014 Texas Instruments, Inc.
> - */
> -
> -&prcm_clocks {
> -	sys_clkout2_src_gate: sys_clkout2_src_gate@70 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-no-wait-gate-clock";
> -		clocks = <&core_ck>;
> -		ti,bit-shift = <15>;
> -		reg = <0x0070>;
> -	};
> -
> -	sys_clkout2_src_mux: sys_clkout2_src_mux@70 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&core_ck>, <&sys_ck>, <&func_96m_ck>, <&func_54m_ck>;
> -		ti,bit-shift = <8>;
> -		reg = <0x0070>;
> -	};
> -
> -	sys_clkout2_src: sys_clkout2_src {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&sys_clkout2_src_gate>, <&sys_clkout2_src_mux>;
> -	};
> -
> -	sys_clkout2: sys_clkout2@70 {
> -		#clock-cells = <0>;
> -		compatible = "ti,divider-clock";
> -		clocks = <&sys_clkout2_src>;
> -		ti,bit-shift = <11>;
> -		ti,max-div = <64>;
> -		reg = <0x0070>;
> -		ti,index-power-of-two;
> -	};
> -
> -	dsp_gate_ick: dsp_gate_ick@810 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-interface-clock";
> -		clocks = <&dsp_fck>;
> -		ti,bit-shift = <1>;
> -		reg = <0x0810>;
> -	};
> -
> -	dsp_div_ick: dsp_div_ick@840 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-divider-clock";
> -		clocks = <&dsp_fck>;
> -		ti,bit-shift = <5>;
> -		ti,max-div = <3>;
> -		reg = <0x0840>;
> -		ti,index-starts-at-one;
> -	};
> -
> -	dsp_ick: dsp_ick {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&dsp_gate_ick>, <&dsp_div_ick>;
> -	};
> -
> -	iva1_gate_ifck: iva1_gate_ifck@800 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&core_ck>;
> -		ti,bit-shift = <10>;
> -		reg = <0x0800>;
> -	};
> -
> -	iva1_div_ifck: iva1_div_ifck@840 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-divider-clock";
> -		clocks = <&core_ck>;
> -		ti,bit-shift = <8>;
> -		reg = <0x0840>;
> -		ti,dividers = <0>, <1>, <2>, <3>, <4>, <0>, <6>, <0>, <8>, <0>, <0>, <0>, <12>;
> -	};
> -
> -	iva1_ifck: iva1_ifck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&iva1_gate_ifck>, <&iva1_div_ifck>;
> -	};
> -
> -	iva1_ifck_div: iva1_ifck_div {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&iva1_ifck>;
> -		clock-mult = <1>;
> -		clock-div = <2>;
> -	};
> -
> -	iva1_mpu_int_ifck: iva1_mpu_int_ifck@800 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&iva1_ifck_div>;
> -		ti,bit-shift = <8>;
> -		reg = <0x0800>;
> -	};
> -
> -	wdt3_ick: wdt3_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <28>;
> -		reg = <0x0210>;
> -	};
> -
> -	wdt3_fck: wdt3_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <28>;
> -		reg = <0x0200>;
> -	};
> -
> -	mmc_ick: mmc_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <26>;
> -		reg = <0x0210>;
> -	};
> -
> -	mmc_fck: mmc_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_96m_ck>;
> -		ti,bit-shift = <26>;
> -		reg = <0x0200>;
> -	};
> -
> -	eac_ick: eac_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <24>;
> -		reg = <0x0210>;
> -	};
> -
> -	eac_fck: eac_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_96m_ck>;
> -		ti,bit-shift = <24>;
> -		reg = <0x0200>;
> -	};
> -
> -	i2c1_fck: i2c1_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_12m_ck>;
> -		ti,bit-shift = <19>;
> -		reg = <0x0200>;
> -	};
> -
> -	i2c2_fck: i2c2_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_12m_ck>;
> -		ti,bit-shift = <20>;
> -		reg = <0x0200>;
> -	};
> -
> -	vlynq_ick: vlynq_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,bit-shift = <3>;
> -		reg = <0x0210>;
> -	};
> -
> -	vlynq_gate_fck: vlynq_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&core_ck>;
> -		ti,bit-shift = <3>;
> -		reg = <0x0200>;
> -	};
> -
> -	core_d18_ck: core_d18_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&core_ck>;
> -		clock-mult = <1>;
> -		clock-div = <18>;
> -	};
> -
> -	vlynq_mux_fck: vlynq_mux_fck@240 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_96m_ck>, <&core_ck>, <&core_d2_ck>, <&core_d3_ck>, <&core_d4_ck>, <&dummy_ck>, <&core_d6_ck>, <&dummy_ck>, <&core_d8_ck>, <&core_d9_ck>, <&dummy_ck>, <&dummy_ck>, <&core_d12_ck>, <&dummy_ck>, <&dummy_ck>, <&dummy_ck>, <&core_d16_ck>, <&dummy_ck>, <&core_d18_ck>;
> -		ti,bit-shift = <15>;
> -		reg = <0x0240>;
> -	};
> -
> -	vlynq_fck: vlynq_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&vlynq_gate_fck>, <&vlynq_mux_fck>;
> -	};
> -};
> -
> -&prcm_clockdomains {
> -	gfx_clkdm: gfx_clkdm {
> -		compatible = "ti,clockdomain";
> -		clocks = <&gfx_ick>;
> -	};
> -
> -	core_l3_clkdm: core_l3_clkdm {
> -		compatible = "ti,clockdomain";
> -		clocks = <&cam_fck>, <&vlynq_ick>, <&usb_fck>;
> -	};
> -
> -	wkup_clkdm: wkup_clkdm {
> -		compatible = "ti,clockdomain";
> -		clocks = <&dpll_ck>, <&emul_ck>, <&gpt1_ick>, <&gpios_ick>,
> -			 <&gpios_fck>, <&mpu_wdt_ick>, <&mpu_wdt_fck>,
> -			 <&sync_32k_ick>, <&wdt1_ick>, <&omapctrl_ick>;
> -	};
> -
> -	iva1_clkdm: iva1_clkdm {
> -		compatible = "ti,clockdomain";
> -		clocks = <&iva1_mpu_int_ifck>;
> -	};
> -
> -	dss_clkdm: dss_clkdm {
> -		compatible = "ti,clockdomain";
> -		clocks = <&dss_ick>, <&dss_54m_fck>;
> -	};
> -
> -	core_l4_clkdm: core_l4_clkdm {
> -		compatible = "ti,clockdomain";
> -		clocks = <&ssi_l4_ick>, <&gpt2_ick>, <&gpt3_ick>, <&gpt4_ick>,
> -			 <&gpt5_ick>, <&gpt6_ick>, <&gpt7_ick>, <&gpt8_ick>,
> -			 <&gpt9_ick>, <&gpt10_ick>, <&gpt11_ick>, <&gpt12_ick>,
> -			 <&mcbsp1_ick>, <&mcbsp2_ick>, <&mcspi1_ick>,
> -			 <&mcspi1_fck>, <&mcspi2_ick>, <&mcspi2_fck>,
> -			 <&uart1_ick>, <&uart1_fck>, <&uart2_ick>, <&uart2_fck>,
> -			 <&uart3_ick>, <&uart3_fck>, <&cam_ick>,
> -			 <&mailboxes_ick>, <&wdt4_ick>, <&wdt4_fck>,
> -			 <&wdt3_ick>, <&wdt3_fck>, <&mspro_ick>, <&mspro_fck>,
> -			 <&mmc_ick>, <&mmc_fck>, <&fac_ick>, <&fac_fck>,
> -			 <&eac_ick>, <&eac_fck>, <&hdq_ick>, <&hdq_fck>,
> -			 <&i2c1_ick>, <&i2c1_fck>, <&i2c2_ick>, <&i2c2_fck>,
> -			 <&des_ick>, <&sha_ick>, <&rng_ick>, <&aes_ick>,
> -			 <&pka_ick>;
> -	};
> -};
> -
> -&func_96m_ck {
> -	compatible = "fixed-factor-clock";
> -	clocks = <&apll96_ck>;
> -	clock-mult = <1>;
> -	clock-div = <1>;
> -};
> -
> -&dsp_div_fck {
> -	ti,dividers = <0>, <1>, <2>, <3>, <4>, <0>, <6>, <0>, <8>, <0>, <0>, <0>, <12>;
> -};
> -
> -&ssi_ssr_sst_div_fck {
> -	ti,dividers = <0>, <1>, <2>, <3>, <4>, <0>, <6>, <0>, <8>;
> -};
> diff --git a/arch/arm/boot/dts/ti/omap/omap2420-h4.dts b/arch/arm/boot/dts/ti/omap/omap2420-h4.dts
> deleted file mode 100644
> index 5acf5dd87c59..000000000000
> --- a/arch/arm/boot/dts/ti/omap/omap2420-h4.dts
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -/dts-v1/;
> -
> -#include "omap2420.dtsi"
> -
> -/ {
> -	model = "TI OMAP2420 H4 board";
> -	compatible = "ti,omap2420-h4", "ti,omap2420", "ti,omap2";
> -
> -	memory@80000000 {
> -		device_type = "memory";
> -		reg = <0x80000000 0x4000000>; /* 64 MB */
> -	};
> -};
> -
> -&gpmc {
> -	ranges = <0 0 0x08000000 0x04000000>;
> -
> -	nor@0,0 {
> -		compatible = "cfi-flash";
> -		linux,mtd-name = "intel,ge28f256l18b85";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		reg = <0 0 0x04000000>;
> -		bank-width = <2>;
> -
> -		gpmc,mux-add-data = <2>;
> -		gpmc,cs-on-ns = <10>;
> -		gpmc,cs-rd-off-ns = <160>;
> -		gpmc,cs-wr-off-ns = <160>;
> -		gpmc,adv-on-ns = <20>;
> -		gpmc,adv-rd-off-ns = <50>;
> -		gpmc,adv-wr-off-ns = <50>;
> -		gpmc,oe-on-ns = <60>;
> -		gpmc,oe-off-ns = <120>;
> -		gpmc,we-on-ns = <60>;
> -		gpmc,we-off-ns = <120>;
> -		gpmc,rd-cycle-ns = <170>;
> -		gpmc,wr-cycle-ns = <170>;
> -		gpmc,access-ns = <150>;
> -		gpmc,page-burst-access-ns = <10>;
> -
> -		partition@0 {
> -			label = "bootloader";
> -			reg = <0 0x20000>;
> -		};
> -		partition@20000 {
> -			label = "params";
> -			reg = <0x20000 0x20000>;
> -		};
> -		partition@40000 {
> -			label = "kernel";
> -			reg = <0x40000 0x200000>;
> -		};
> -		partition@240000 {
> -			label = "file-system";
> -			reg = <0x240000 0x3dc0000>;
> -		};
> -	};
> -};
> diff --git a/arch/arm/boot/dts/ti/omap/omap2420-n800.dts b/arch/arm/boot/dts/ti/omap/omap2420-n800.dts
> deleted file mode 100644
> index f06d767e818b..000000000000
> --- a/arch/arm/boot/dts/ti/omap/omap2420-n800.dts
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "omap2420-n8x0-common.dtsi"
> -
> -/ {
> -	model = "Nokia N800";
> -	compatible = "nokia,n800", "nokia,n8x0", "ti,omap2420", "ti,omap2";
> -};
> diff --git a/arch/arm/boot/dts/ti/omap/omap2420-n810-wimax.dts b/arch/arm/boot/dts/ti/omap/omap2420-n810-wimax.dts
> deleted file mode 100644
> index ac9acbd609b6..000000000000
> --- a/arch/arm/boot/dts/ti/omap/omap2420-n810-wimax.dts
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "omap2420-n8x0-common.dtsi"
> -
> -/ {
> -	model = "Nokia N810 WiMax";
> -	compatible = "nokia,n810-wimax", "nokia,n8x0", "ti,omap2420", "ti,omap2";
> -};
> diff --git a/arch/arm/boot/dts/ti/omap/omap2420-n810.dts b/arch/arm/boot/dts/ti/omap/omap2420-n810.dts
> deleted file mode 100644
> index 3bf8175d85a8..000000000000
> --- a/arch/arm/boot/dts/ti/omap/omap2420-n810.dts
> +++ /dev/null
> @@ -1,75 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "omap2420-n8x0-common.dtsi"
> -
> -/ {
> -	model = "Nokia N810";
> -	compatible = "nokia,n810", "nokia,n8x0", "ti,omap2420", "ti,omap2";
> -
> -	vio_ape: vio_ape {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vio_ape";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -	};
> -
> -	v28_aic: v28_aic {
> -		compatible = "regulator-fixed";
> -		regulator-name = "v28_aic";
> -		regulator-min-microvolt = <2800000>;
> -		regulator-max-microvolt = <2800000>;
> -	};
> -};
> -
> -&omap2420_pmx {
> -	mcbsp2_pins: mcbsp2-pins {
> -		pinctrl-single,pins = <
> -			OMAP2420_CORE_IOPAD(0x0124, PIN_INPUT | MUX_MODE1)	/* eac_ac_sclk.mcbsp2_clkx */
> -			OMAP2420_CORE_IOPAD(0x0125, PIN_INPUT | MUX_MODE1)	/* eac_ac_fs.mcbsp2_fsx */
> -			OMAP2420_CORE_IOPAD(0x0126, PIN_INPUT | MUX_MODE1)	/* eac_ac_din.mcbsp2_dr */
> -			OMAP2420_CORE_IOPAD(0x0127, PIN_OUTPUT | MUX_MODE1)	/* eac_ac_dout.mcbsp2_dx */
> -		>;
> -	};
> -
> -	aic33_pins: aic33-pins {
> -		pinctrl-single,pins = <
> -			OMAP2420_CORE_IOPAD(0x0129, PIN_OUTPUT | MUX_MODE3)	/* eac_ac_rst.gpio118 */
> -			OMAP2420_CORE_IOPAD(0x00e8, PIN_OUTPUT | MUX_MODE2)	/* vlynq_tx1.sys_clkout2 */
> -		>;
> -	};
> -};
> -
> -&i2c2 {
> -	aic33@18 {
> -		compatible = "ti,tlv320aic33";
> -		reg = <0x18>;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&aic33_pins>;
> -
> -		reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>; /* gpio118 */
> -
> -		ai3x-gpio-func = <
> -			10 /* AIC3X_GPIO1_FUNC_DIGITAL_MIC_MODCLK */
> -			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
> -		>;
> -		ai3x-micbias-vg = <1>; /* 2V */
> -
> -		AVDD-supply = <&v28_aic>;
> -		DRVDD-supply = <&v28_aic>;
> -		IOVDD-supply = <&vio_ape>;
> -		DVDD-supply = <&vio_ape>;
> -
> -		assigned-clocks = <&sys_clkout2_src>, <&sys_clkout2>;
> -		assigned-clock-parents = <&func_96m_ck>;
> -		assigned-clock-rates = <0>, <12000000>;
> -	};
> -};
> -
> -&mcbsp2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mcbsp2_pins>;
> -
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/ti/omap/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/ti/omap/omap2420-n8x0-common.dtsi
> deleted file mode 100644
> index fe9dd8bbfc85..000000000000
> --- a/arch/arm/boot/dts/ti/omap/omap2420-n8x0-common.dtsi
> +++ /dev/null
> @@ -1,123 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "omap2420.dtsi"
> -
> -/ {
> -	memory@80000000 {
> -		device_type = "memory";
> -		reg = <0x80000000 0x8000000>; /* 128 MB */
> -	};
> -
> -	chosen {
> -		stdout-path = &uart3;
> -	};
> -
> -	ocp {
> -		i2c0 {
> -			compatible = "i2c-cbus-gpio";
> -			gpios = <&gpio3 2 GPIO_ACTIVE_HIGH /* gpio66 clk */
> -				 &gpio3 1 GPIO_ACTIVE_HIGH /* gpio65 dat */
> -				 &gpio3 0 GPIO_ACTIVE_HIGH /* gpio64 sel */
> -				>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			retu: retu@1 {
> -				compatible = "nokia,retu";
> -				interrupt-parent = <&gpio4>;
> -				interrupts = <12 IRQ_TYPE_EDGE_RISING>;
> -				reg = <0x1>;
> -			};
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	clock-frequency = <400000>;
> -
> -	pmic@72 {
> -		compatible = "menelaus";
> -		reg = <0x72>;
> -		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
> -	};
> -};
> -
> -&i2c2 {
> -	clock-frequency = <400000>;
> -};
> -
> -&gpmc {
> -	ranges = <0 0 0x04000000 0x1000000>;	/* CS0: 16MB for OneNAND */
> -
> -	/* gpio-irq for dma: 26 */
> -
> -	onenand@0,0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "ti,omap2-onenand";
> -		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
> -
> -		gpmc,sync-read;
> -		gpmc,burst-length = <16>;
> -		gpmc,burst-read;
> -		gpmc,burst-wrap;
> -		gpmc,device-width = <2>;
> -		gpmc,mux-add-data = <2>;
> -		gpmc,cs-on-ns = <0>;
> -		gpmc,cs-rd-off-ns = <127>;
> -		gpmc,cs-wr-off-ns = <109>;
> -		gpmc,adv-on-ns = <0>;
> -		gpmc,adv-rd-off-ns = <18>;
> -		gpmc,adv-wr-off-ns = <18>;
> -		gpmc,oe-on-ns = <27>;
> -		gpmc,oe-off-ns = <127>;
> -		gpmc,we-on-ns = <27>;
> -		gpmc,we-off-ns = <72>;
> -		gpmc,rd-cycle-ns = <145>;
> -		gpmc,wr-cycle-ns = <136>;
> -		gpmc,access-ns = <118>;
> -		gpmc,page-burst-access-ns = <27>;
> -		gpmc,bus-turnaround-ns = <0>;
> -		gpmc,cycle2cycle-delay-ns = <0>;
> -		gpmc,wait-monitoring-ns = <0>;
> -		gpmc,clk-activation-ns = <9>;
> -		gpmc,sync-clk-ps = <27000>;
> -
> -		/* MTD partition table corresponding to old board-n8x0 file. */
> -		partition@0 {
> -			label = "bootloader";
> -			reg = <0x00000000 0x00020000>;
> -			read-only;
> -		};
> -		partition@1 {
> -			label = "config";
> -			reg = <0x00020000 0x00060000>;
> -		};
> -		partition@2 {
> -			label = "kernel";
> -			reg = <0x00080000 0x00200000>;
> -		};
> -		partition@3 {
> -			label = "initfs";
> -			reg = <0x00280000 0x00400000>;
> -		};
> -		partition@4 {
> -			label = "rootfs";
> -			reg = <0x00680000 0x0f980000>;
> -		};
> -		partition@5 {
> -			label = "omap2-onenand";
> -			reg = <0x00000000 0x10000000>;
> -		};
> -	};
> -};
> -
> -&mcspi2 {
> -	status = "okay";
> -
> -	wifi@0 {
> -		reg = <0>;
> -		compatible = "st,stlc4560";
> -		spi-max-frequency = <48000000>;
> -		interrupts-extended = <&gpio3 23 IRQ_TYPE_EDGE_RISING>;
> -		powerdown-gpios = <&gpio4 1 GPIO_ACTIVE_LOW>; /* gpio 97 */
> -	};
> -};
> diff --git a/arch/arm/boot/dts/ti/omap/omap2420.dtsi b/arch/arm/boot/dts/ti/omap/omap2420.dtsi
> deleted file mode 100644
> index 821da51cb870..000000000000
> --- a/arch/arm/boot/dts/ti/omap/omap2420.dtsi
> +++ /dev/null
> @@ -1,262 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Device Tree Source for OMAP2420 SoC
> - *
> - * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -
> -#include "omap2.dtsi"
> -
> -/ {
> -	compatible = "ti,omap2420", "ti,omap2";
> -
> -	ocp {
> -		l4: l4@48000000 {
> -			compatible = "ti,omap2-l4", "simple-bus";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0 0x48000000 0x100000>;
> -
> -			prcm: prcm@8000 {
> -				compatible = "ti,omap2-prcm";
> -				reg = <0x8000 0x1000>;
> -
> -				prcm_clocks: clocks {
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -				};
> -
> -				prcm_clockdomains: clockdomains {
> -				};
> -			};
> -
> -			scm: scm@0 {
> -				compatible = "ti,omap2-scm", "simple-bus";
> -				reg = <0x0 0x1000>;
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				#pinctrl-cells = <1>;
> -				ranges = <0 0x0 0x1000>;
> -
> -				omap2420_pmx: pinmux@30 {
> -					compatible = "ti,omap2420-padconf",
> -						     "pinctrl-single";
> -					reg = <0x30 0x0113>;
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -					#pinctrl-cells = <1>;
> -					pinctrl-single,register-width = <8>;
> -					pinctrl-single,function-mask = <0x3f>;
> -				};
> -
> -				scm_conf: scm_conf@270 {
> -					compatible = "syscon";
> -					reg = <0x270 0x100>;
> -					#address-cells = <1>;
> -					#size-cells = <1>;
> -
> -					scm_clocks: clocks {
> -						#address-cells = <1>;
> -						#size-cells = <0>;
> -					};
> -				};
> -
> -				scm_clockdomains: clockdomains {
> -				};
> -			};
> -
> -			target-module@4000 {
> -				compatible = "ti,sysc-omap2", "ti,sysc";
> -				reg = <0x4000 0x4>,
> -				      <0x4004 0x4>;
> -				reg-names = "rev", "sysc";
> -				ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> -						<SYSC_IDLE_NO>;
> -				clocks = <&func_32k_ck>;
> -				clock-names = "fck";
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				ranges = <0x0 0x4000 0x1000>;
> -
> -				counter32k: counter@0 {
> -					compatible = "ti,omap-counter32k";
> -					reg = <0 0x20>;
> -				};
> -			};
> -		};
> -
> -		gpio1: gpio@48018000 {
> -			compatible = "ti,omap2-gpio";
> -			reg = <0x48018000 0x200>;
> -			interrupts = <29>;
> -			ti,hwmods = "gpio1";
> -			ti,gpio-always-on;
> -			#gpio-cells = <2>;
> -			gpio-controller;
> -			#interrupt-cells = <2>;
> -			interrupt-controller;
> -		};
> -
> -		gpio2: gpio@4801a000 {
> -			compatible = "ti,omap2-gpio";
> -			reg = <0x4801a000 0x200>;
> -			interrupts = <30>;
> -			ti,hwmods = "gpio2";
> -			ti,gpio-always-on;
> -			#gpio-cells = <2>;
> -			gpio-controller;
> -			#interrupt-cells = <2>;
> -			interrupt-controller;
> -		};
> -
> -		gpio3: gpio@4801c000 {
> -			compatible = "ti,omap2-gpio";
> -			reg = <0x4801c000 0x200>;
> -			interrupts = <31>;
> -			ti,hwmods = "gpio3";
> -			ti,gpio-always-on;
> -			#gpio-cells = <2>;
> -			gpio-controller;
> -			#interrupt-cells = <2>;
> -			interrupt-controller;
> -		};
> -
> -		gpio4: gpio@4801e000 {
> -			compatible = "ti,omap2-gpio";
> -			reg = <0x4801e000 0x200>;
> -			interrupts = <32>;
> -			ti,hwmods = "gpio4";
> -			ti,gpio-always-on;
> -			#gpio-cells = <2>;
> -			gpio-controller;
> -			#interrupt-cells = <2>;
> -			interrupt-controller;
> -		};
> -
> -		gpmc: gpmc@6800a000 {
> -			compatible = "ti,omap2420-gpmc";
> -			reg = <0x6800a000 0x1000>;
> -			#address-cells = <2>;
> -			#size-cells = <1>;
> -			interrupts = <20>;
> -			gpmc,num-cs = <8>;
> -			gpmc,num-waitpins = <4>;
> -			ti,hwmods = "gpmc";
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -		};
> -
> -		mcbsp1: mcbsp@48074000 {
> -			compatible = "ti,omap2420-mcbsp";
> -			reg = <0x48074000 0xff>;
> -			reg-names = "mpu";
> -			interrupts = <59>, /* TX interrupt */
> -				     <60>; /* RX interrupt */
> -			interrupt-names = "tx", "rx";
> -			ti,hwmods = "mcbsp1";
> -			dmas = <&sdma 31>,
> -			       <&sdma 32>;
> -			dma-names = "tx", "rx";
> -			status = "disabled";
> -		};
> -
> -		mcbsp2: mcbsp@48076000 {
> -			compatible = "ti,omap2420-mcbsp";
> -			reg = <0x48076000 0xff>;
> -			reg-names = "mpu";
> -			interrupts = <62>, /* TX interrupt */
> -				     <63>; /* RX interrupt */
> -			interrupt-names = "tx", "rx";
> -			ti,hwmods = "mcbsp2";
> -			dmas = <&sdma 33>,
> -			       <&sdma 34>;
> -			dma-names = "tx", "rx";
> -			status = "disabled";
> -		};
> -
> -		msdi1: mmc@4809c000 {
> -			compatible = "ti,omap2420-mmc";
> -			ti,hwmods = "msdi1";
> -			reg = <0x4809c000 0x80>;
> -			interrupts = <83>;
> -			dmas = <&sdma 61 &sdma 62>;
> -			dma-names = "tx", "rx";
> -		};
> -
> -		mailbox: mailbox@48094000 {
> -			compatible = "ti,omap2-mailbox";
> -			reg = <0x48094000 0x200>;
> -			interrupts = <26>, <34>;
> -			ti,hwmods = "mailbox";
> -			#mbox-cells = <1>;
> -			ti,mbox-num-users = <4>;
> -			ti,mbox-num-fifos = <6>;
> -			mbox_dsp: mbox-dsp {
> -				ti,mbox-tx = <0 0 0>;
> -				ti,mbox-rx = <1 0 0>;
> -			};
> -			mbox_iva: mbox-iva {
> -				ti,mbox-tx = <2 1 3>;
> -				ti,mbox-rx = <3 1 3>;
> -			};
> -		};
> -
> -		timer1_target: target-module@48028000 {
> -			compatible = "ti,sysc-omap2-timer", "ti,sysc";
> -			reg = <0x48028000 0x4>,
> -			      <0x48028010 0x4>,
> -			      <0x48028014 0x4>;
> -			reg-names = "rev", "sysc", "syss";
> -			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
> -					 SYSC_OMAP2_EMUFREE |
> -					 SYSC_OMAP2_ENAWAKEUP |
> -					 SYSC_OMAP2_SOFTRESET |
> -					 SYSC_OMAP2_AUTOIDLE)>;
> -			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> -					<SYSC_IDLE_NO>,
> -					<SYSC_IDLE_SMART>;
> -			ti,syss-mask = <1>;
> -			clocks = <&gpt1_fck>, <&gpt1_ick>;
> -			clock-names = "fck", "ick";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0x0 0x48028000 0x1000>;
> -
> -			timer1: timer@0 {
> -				compatible = "ti,omap2420-timer";
> -				reg = <0 0x400>;
> -				interrupts = <37>;
> -				ti,timer-alwon;
> -			};
> -		};
> -
> -		wd_timer2: wdt@48022000 {
> -			compatible = "ti,omap2-wdt";
> -			ti,hwmods = "wd_timer2";
> -			reg = <0x48022000 0x80>;
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	compatible = "ti,omap2420-i2c";
> -};
> -
> -&i2c2 {
> -	compatible = "ti,omap2420-i2c";
> -};
> -
> -#include "omap24xx-clocks.dtsi"
> -#include "omap2420-clocks.dtsi"
> -
> -/* Preferred always-on timer for clockevent */
> -&timer1_target {
> -	ti,no-reset-on-init;
> -	ti,no-idle;
> -	timer@0 {
> -		assigned-clocks = <&gpt1_fck>;
> -		assigned-clock-parents = <&func_32k_ck>;
> -	};
> -};
> diff --git a/arch/arm/boot/dts/ti/omap/omap2430-clocks.dtsi b/arch/arm/boot/dts/ti/omap/omap2430-clocks.dtsi
> deleted file mode 100644
> index 4e5ab5189476..000000000000
> --- a/arch/arm/boot/dts/ti/omap/omap2430-clocks.dtsi
> +++ /dev/null
> @@ -1,341 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Device Tree Source for OMAP2430 clock data
> - *
> - * Copyright (C) 2014 Texas Instruments, Inc.
> - */
> -
> -&scm_clocks {
> -	mcbsp3_mux_fck: mcbsp3_mux_fck@78 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_96m_ck>, <&mcbsp_clks>;
> -		reg = <0x78>;
> -	};
> -
> -	mcbsp3_fck: mcbsp3_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&mcbsp3_gate_fck>, <&mcbsp3_mux_fck>;
> -	};
> -
> -	mcbsp4_mux_fck: mcbsp4_mux_fck@78 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_96m_ck>, <&mcbsp_clks>;
> -		ti,bit-shift = <2>;
> -		reg = <0x78>;
> -	};
> -
> -	mcbsp4_fck: mcbsp4_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&mcbsp4_gate_fck>, <&mcbsp4_mux_fck>;
> -	};
> -
> -	mcbsp5_mux_fck: mcbsp5_mux_fck@78 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_96m_ck>, <&mcbsp_clks>;
> -		ti,bit-shift = <4>;
> -		reg = <0x78>;
> -	};
> -
> -	mcbsp5_fck: mcbsp5_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&mcbsp5_gate_fck>, <&mcbsp5_mux_fck>;
> -	};
> -};
> -
> -&prcm_clocks {
> -	iva2_1_gate_ick: iva2_1_gate_ick@800 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&dsp_fck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x0800>;
> -	};
> -
> -	iva2_1_div_ick: iva2_1_div_ick@840 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-divider-clock";
> -		clocks = <&dsp_fck>;
> -		ti,bit-shift = <5>;
> -		ti,max-div = <3>;
> -		reg = <0x0840>;
> -		ti,index-starts-at-one;
> -	};
> -
> -	iva2_1_ick: iva2_1_ick {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&iva2_1_gate_ick>, <&iva2_1_div_ick>;
> -	};
> -
> -	mdm_gate_ick: mdm_gate_ick@c10 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-interface-clock";
> -		clocks = <&core_ck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x0c10>;
> -	};
> -
> -	mdm_div_ick: mdm_div_ick@c40 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-divider-clock";
> -		clocks = <&core_ck>;
> -		reg = <0x0c40>;
> -		ti,dividers = <0>, <1>, <0>, <0>, <4>, <0>, <6>, <0>, <0>, <9>;
> -	};
> -
> -	mdm_ick: mdm_ick {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&mdm_gate_ick>, <&mdm_div_ick>;
> -	};
> -
> -	mdm_osc_ck: mdm_osc_ck@c00 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&osc_ck>;
> -		ti,bit-shift = <1>;
> -		reg = <0x0c00>;
> -	};
> -
> -	mcbsp3_ick: mcbsp3_ick@214 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <3>;
> -		reg = <0x0214>;
> -	};
> -
> -	mcbsp3_gate_fck: mcbsp3_gate_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&mcbsp_clks>;
> -		ti,bit-shift = <3>;
> -		reg = <0x0204>;
> -	};
> -
> -	mcbsp4_ick: mcbsp4_ick@214 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <4>;
> -		reg = <0x0214>;
> -	};
> -
> -	mcbsp4_gate_fck: mcbsp4_gate_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&mcbsp_clks>;
> -		ti,bit-shift = <4>;
> -		reg = <0x0204>;
> -	};
> -
> -	mcbsp5_ick: mcbsp5_ick@214 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <5>;
> -		reg = <0x0214>;
> -	};
> -
> -	mcbsp5_gate_fck: mcbsp5_gate_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&mcbsp_clks>;
> -		ti,bit-shift = <5>;
> -		reg = <0x0204>;
> -	};
> -
> -	mcspi3_ick: mcspi3_ick@214 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <9>;
> -		reg = <0x0214>;
> -	};
> -
> -	mcspi3_fck: mcspi3_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_48m_ck>;
> -		ti,bit-shift = <9>;
> -		reg = <0x0204>;
> -	};
> -
> -	icr_ick: icr_ick@410 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&sys_ck>;
> -		ti,bit-shift = <6>;
> -		reg = <0x0410>;
> -	};
> -
> -	i2chs1_fck: i2chs1_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap2430-interface-clock";
> -		clocks = <&func_96m_ck>;
> -		ti,bit-shift = <19>;
> -		reg = <0x0204>;
> -	};
> -
> -	i2chs2_fck: i2chs2_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap2430-interface-clock";
> -		clocks = <&func_96m_ck>;
> -		ti,bit-shift = <20>;
> -		reg = <0x0204>;
> -	};
> -
> -	usbhs_ick: usbhs_ick@214 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,bit-shift = <6>;
> -		reg = <0x0214>;
> -	};
> -
> -	mmchs1_ick: mmchs1_ick@214 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <7>;
> -		reg = <0x0214>;
> -	};
> -
> -	mmchs1_fck: mmchs1_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_96m_ck>;
> -		ti,bit-shift = <7>;
> -		reg = <0x0204>;
> -	};
> -
> -	mmchs2_ick: mmchs2_ick@214 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <8>;
> -		reg = <0x0214>;
> -	};
> -
> -	mmchs2_fck: mmchs2_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_96m_ck>;
> -		ti,bit-shift = <8>;
> -		reg = <0x0204>;
> -	};
> -
> -	gpio5_ick: gpio5_ick@214 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <10>;
> -		reg = <0x0214>;
> -	};
> -
> -	gpio5_fck: gpio5_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <10>;
> -		reg = <0x0204>;
> -	};
> -
> -	mdm_intc_ick: mdm_intc_ick@214 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <11>;
> -		reg = <0x0214>;
> -	};
> -
> -	mmchsdb1_fck: mmchsdb1_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <16>;
> -		reg = <0x0204>;
> -	};
> -
> -	mmchsdb2_fck: mmchsdb2_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <17>;
> -		reg = <0x0204>;
> -	};
> -};
> -
> -&prcm_clockdomains {
> -	gfx_clkdm: gfx_clkdm {
> -		compatible = "ti,clockdomain";
> -		clocks = <&gfx_ick>;
> -	};
> -
> -	core_l3_clkdm: core_l3_clkdm {
> -		compatible = "ti,clockdomain";
> -		clocks = <&cam_fck>, <&usb_fck>, <&usbhs_ick>;
> -	};
> -
> -	wkup_clkdm: wkup_clkdm {
> -		compatible = "ti,clockdomain";
> -		clocks = <&dpll_ck>, <&emul_ck>, <&gpt1_ick>, <&gpios_ick>,
> -			 <&gpios_fck>, <&mpu_wdt_ick>, <&mpu_wdt_fck>,
> -			 <&sync_32k_ick>, <&wdt1_ick>, <&omapctrl_ick>,
> -			 <&icr_ick>;
> -	};
> -
> -	dss_clkdm: dss_clkdm {
> -		compatible = "ti,clockdomain";
> -		clocks = <&dss_ick>, <&dss_54m_fck>;
> -	};
> -
> -	core_l4_clkdm: core_l4_clkdm {
> -		compatible = "ti,clockdomain";
> -		clocks = <&ssi_l4_ick>, <&gpt2_ick>, <&gpt3_ick>, <&gpt4_ick>,
> -			 <&gpt5_ick>, <&gpt6_ick>, <&gpt7_ick>, <&gpt8_ick>,
> -			 <&gpt9_ick>, <&gpt10_ick>, <&gpt11_ick>, <&gpt12_ick>,
> -			 <&mcbsp1_ick>, <&mcbsp2_ick>, <&mcbsp3_ick>,
> -			 <&mcbsp4_ick>, <&mcbsp5_ick>, <&mcspi1_ick>,
> -			 <&mcspi1_fck>, <&mcspi2_ick>, <&mcspi2_fck>,
> -			 <&mcspi3_ick>, <&mcspi3_fck>, <&uart1_ick>,
> -			 <&uart1_fck>, <&uart2_ick>, <&uart2_fck>, <&uart3_ick>,
> -			 <&uart3_fck>, <&cam_ick>, <&mailboxes_ick>,
> -			 <&wdt4_ick>, <&wdt4_fck>, <&mspro_ick>, <&mspro_fck>,
> -			 <&fac_ick>, <&fac_fck>, <&hdq_ick>, <&hdq_fck>,
> -			 <&i2c1_ick>, <&i2chs1_fck>, <&i2c2_ick>, <&i2chs2_fck>,
> -			 <&des_ick>, <&sha_ick>, <&rng_ick>, <&aes_ick>,
> -			 <&pka_ick>, <&mmchs1_ick>, <&mmchs1_fck>,
> -			 <&mmchs2_ick>, <&mmchs2_fck>, <&gpio5_ick>,
> -			 <&gpio5_fck>, <&mdm_intc_ick>, <&mmchsdb1_fck>,
> -			 <&mmchsdb2_fck>;
> -	};
> -
> -	mdm_clkdm: mdm_clkdm {
> -		compatible = "ti,clockdomain";
> -		clocks = <&mdm_osc_ck>;
> -	};
> -};
> -
> -&func_96m_ck {
> -	compatible = "ti,mux-clock";
> -	clocks = <&apll96_ck>, <&alt_ck>;
> -	ti,bit-shift = <4>;
> -	reg = <0x0540>;
> -};
> -
> -&dsp_div_fck {
> -	ti,max-div = <4>;
> -	ti,index-starts-at-one;
> -};
> -
> -&ssi_ssr_sst_div_fck {
> -	ti,max-div = <5>;
> -	ti,index-starts-at-one;
> -};
> diff --git a/arch/arm/boot/dts/ti/omap/omap2430-sdp.dts b/arch/arm/boot/dts/ti/omap/omap2430-sdp.dts
> deleted file mode 100644
> index 207070677e3a..000000000000
> --- a/arch/arm/boot/dts/ti/omap/omap2430-sdp.dts
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -/dts-v1/;
> -
> -#include "omap2430.dtsi"
> -
> -/ {
> -	model = "TI OMAP2430 SDP";
> -	compatible = "ti,omap2430-sdp", "ti,omap2430", "ti,omap2";
> -
> -	memory@80000000 {
> -		device_type = "memory";
> -		reg = <0x80000000 0x8000000>; /* 128 MB */
> -	};
> -};
> -
> -&i2c2 {
> -	clock-frequency = <100000>;
> -
> -	twl: twl@48 {
> -		reg = <0x48>;
> -		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> -	};
> -};
> -
> -#include "twl4030.dtsi"
> -
> -&mmc1 {
> -	vmmc-supply = <&vmmc1>;
> -	bus-width = <4>;
> -};
> -
> -&gpmc {
> -	ranges = <5 0 0x08000000 0x01000000>;
> -	ethernet@gpmc {
> -		compatible = "smsc,lan91c94";
> -		interrupt-parent = <&gpio5>;
> -		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;	/* gpio149 */
> -		reg = <5 0x300 0xf>;
> -		bank-width = <2>;
> -		gpmc,sync-clk-ps = <0>;
> -		gpmc,mux-add-data = <2>;
> -		gpmc,device-width = <1>;
> -		gpmc,cycle2cycle-samecsen;
> -		gpmc,cycle2cycle-diffcsen;
> -		gpmc,cs-on-ns = <6>;
> -		gpmc,cs-rd-off-ns = <187>;
> -		gpmc,cs-wr-off-ns = <187>;
> -		gpmc,adv-on-ns = <18>;
> -		gpmc,adv-rd-off-ns = <48>;
> -		gpmc,adv-wr-off-ns = <48>;
> -		gpmc,oe-on-ns = <60>;
> -		gpmc,oe-off-ns = <169>;
> -		gpmc,we-on-ns = <66>;
> -		gpmc,we-off-ns = <169>;
> -		gpmc,rd-cycle-ns = <187>;
> -		gpmc,wr-cycle-ns = <187>;
> -		gpmc,access-ns = <187>;
> -		gpmc,page-burst-access-ns = <24>;
> -		gpmc,bus-turnaround-ns = <24>;
> -		gpmc,cycle2cycle-delay-ns = <24>;
> -		gpmc,wait-monitoring-ns = <0>;
> -		gpmc,clk-activation-ns = <0>;
> -		gpmc,wr-data-mux-bus-ns = <0>;
> -		gpmc,wr-access-ns = <0>;
> -	};
> -};
> -
> diff --git a/arch/arm/boot/dts/ti/omap/omap2430.dtsi b/arch/arm/boot/dts/ti/omap/omap2430.dtsi
> deleted file mode 100644
> index 01bd471f9223..000000000000
> --- a/arch/arm/boot/dts/ti/omap/omap2430.dtsi
> +++ /dev/null
> @@ -1,366 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Device Tree Source for OMAP243x SoC
> - *
> - * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -
> -#include "omap2.dtsi"
> -
> -/ {
> -	compatible = "ti,omap2430", "ti,omap2";
> -
> -	ocp {
> -		l4_wkup: l4_wkup@49000000 {
> -			compatible = "ti,omap2-l4-wkup", "simple-bus";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0 0x49000000 0x31000>;
> -
> -			prcm: prcm@6000 {
> -				compatible = "ti,omap2-prcm";
> -				reg = <0x6000 0x1000>;
> -
> -				prcm_clocks: clocks {
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -				};
> -
> -				prcm_clockdomains: clockdomains {
> -				};
> -			};
> -
> -			scm: scm@2000 {
> -				compatible = "ti,omap2-scm", "simple-bus";
> -				reg = <0x2000 0x1000>;
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				#pinctrl-cells = <1>;
> -				ranges = <0 0x2000 0x1000>;
> -
> -				omap2430_pmx: pinmux@30 {
> -					compatible = "ti,omap2430-padconf",
> -						     "pinctrl-single";
> -					reg = <0x30 0x0154>;
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -					#pinctrl-cells = <1>;
> -					pinctrl-single,register-width = <8>;
> -					pinctrl-single,function-mask = <0x3f>;
> -				};
> -
> -				scm_conf: scm_conf@270 {
> -					compatible = "ti,omap2-scm-conf", "syscon",
> -						     "simple-bus";
> -					reg = <0x270 0x240>;
> -					#address-cells = <1>;
> -					#size-cells = <1>;
> -					ranges = <0 0x270 0x240>;
> -
> -					scm_clocks: clocks {
> -						#address-cells = <1>;
> -						#size-cells = <0>;
> -					};
> -
> -					pbias_regulator: pbias_regulator@230 {
> -						compatible = "ti,pbias-omap2", "ti,pbias-omap";
> -						reg = <0x230 0x4>;
> -						syscon = <&scm_conf>;
> -						pbias_mmc_reg: pbias_mmc_omap2430 {
> -							regulator-name = "pbias_mmc_omap2430";
> -							regulator-min-microvolt = <1800000>;
> -							regulator-max-microvolt = <3000000>;
> -						};
> -					};
> -				};
> -
> -				scm_clockdomains: clockdomains {
> -				};
> -			};
> -
> -			target-module@20000 {
> -				compatible = "ti,sysc-omap2", "ti,sysc";
> -				reg = <0x20000 0x4>,
> -				      <0x20004 0x4>;
> -				reg-names = "rev", "sysc";
> -				ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> -						<SYSC_IDLE_NO>;
> -				clocks = <&func_32k_ck>;
> -				clock-names = "fck";
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				ranges = <0x0 0x20000 0x1000>;
> -
> -				counter32k: counter@0 {
> -					compatible = "ti,omap-counter32k";
> -					reg = <0 0x20>;
> -				};
> -			};
> -		};
> -
> -		gpio1: gpio@4900c000 {
> -			compatible = "ti,omap2-gpio";
> -			reg = <0x4900c000 0x200>;
> -			interrupts = <29>;
> -			ti,hwmods = "gpio1";
> -			ti,gpio-always-on;
> -			#gpio-cells = <2>;
> -			gpio-controller;
> -			#interrupt-cells = <2>;
> -			interrupt-controller;
> -		};
> -
> -		gpio2: gpio@4900e000 {
> -			compatible = "ti,omap2-gpio";
> -			reg = <0x4900e000 0x200>;
> -			interrupts = <30>;
> -			ti,hwmods = "gpio2";
> -			ti,gpio-always-on;
> -			#gpio-cells = <2>;
> -			gpio-controller;
> -			#interrupt-cells = <2>;
> -			interrupt-controller;
> -		};
> -
> -		gpio3: gpio@49010000 {
> -			compatible = "ti,omap2-gpio";
> -			reg = <0x49010000 0x200>;
> -			interrupts = <31>;
> -			ti,hwmods = "gpio3";
> -			ti,gpio-always-on;
> -			#gpio-cells = <2>;
> -			gpio-controller;
> -			#interrupt-cells = <2>;
> -			interrupt-controller;
> -		};
> -
> -		gpio4: gpio@49012000 {
> -			compatible = "ti,omap2-gpio";
> -			reg = <0x49012000 0x200>;
> -			interrupts = <32>;
> -			ti,hwmods = "gpio4";
> -			ti,gpio-always-on;
> -			#gpio-cells = <2>;
> -			gpio-controller;
> -			#interrupt-cells = <2>;
> -			interrupt-controller;
> -		};
> -
> -		gpio5: gpio@480b6000 {
> -			compatible = "ti,omap2-gpio";
> -			reg = <0x480b6000 0x200>;
> -			interrupts = <33>;
> -			ti,hwmods = "gpio5";
> -			#gpio-cells = <2>;
> -			gpio-controller;
> -			#interrupt-cells = <2>;
> -			interrupt-controller;
> -		};
> -
> -		gpmc: gpmc@6e000000 {
> -			compatible = "ti,omap2430-gpmc";
> -			reg = <0x6e000000 0x1000>;
> -			#address-cells = <2>;
> -			#size-cells = <1>;
> -			interrupts = <20>;
> -			gpmc,num-cs = <8>;
> -			gpmc,num-waitpins = <4>;
> -			ti,hwmods = "gpmc";
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -		};
> -
> -		mcbsp1: mcbsp@48074000 {
> -			compatible = "ti,omap2430-mcbsp";
> -			reg = <0x48074000 0xff>;
> -			reg-names = "mpu";
> -			interrupts = <64>, /* OCP compliant interrupt */
> -				     <59>, /* TX interrupt */
> -				     <60>, /* RX interrupt */
> -				     <61>; /* RX overflow interrupt */
> -			interrupt-names = "common", "tx", "rx", "rx_overflow";
> -			ti,buffer-size = <128>;
> -			ti,hwmods = "mcbsp1";
> -			dmas = <&sdma 31>,
> -			       <&sdma 32>;
> -			dma-names = "tx", "rx";
> -			status = "disabled";
> -		};
> -
> -		mcbsp2: mcbsp@48076000 {
> -			compatible = "ti,omap2430-mcbsp";
> -			reg = <0x48076000 0xff>;
> -			reg-names = "mpu";
> -			interrupts = <16>, /* OCP compliant interrupt */
> -				     <62>, /* TX interrupt */
> -				     <63>; /* RX interrupt */
> -			interrupt-names = "common", "tx", "rx";
> -			ti,buffer-size = <128>;
> -			ti,hwmods = "mcbsp2";
> -			dmas = <&sdma 33>,
> -			       <&sdma 34>;
> -			dma-names = "tx", "rx";
> -			status = "disabled";
> -		};
> -
> -		mcbsp3: mcbsp@4808c000 {
> -			compatible = "ti,omap2430-mcbsp";
> -			reg = <0x4808c000 0xff>;
> -			reg-names = "mpu";
> -			interrupts = <17>, /* OCP compliant interrupt */
> -				     <89>, /* TX interrupt */
> -				     <90>; /* RX interrupt */
> -			interrupt-names = "common", "tx", "rx";
> -			ti,buffer-size = <128>;
> -			ti,hwmods = "mcbsp3";
> -			dmas = <&sdma 17>,
> -			       <&sdma 18>;
> -			dma-names = "tx", "rx";
> -			status = "disabled";
> -		};
> -
> -		mcbsp4: mcbsp@4808e000 {
> -			compatible = "ti,omap2430-mcbsp";
> -			reg = <0x4808e000 0xff>;
> -			reg-names = "mpu";
> -			interrupts = <18>, /* OCP compliant interrupt */
> -				     <54>, /* TX interrupt */
> -				     <55>; /* RX interrupt */
> -			interrupt-names = "common", "tx", "rx";
> -			ti,buffer-size = <128>;
> -			ti,hwmods = "mcbsp4";
> -			dmas = <&sdma 19>,
> -			       <&sdma 20>;
> -			dma-names = "tx", "rx";
> -			status = "disabled";
> -		};
> -
> -		mcbsp5: mcbsp@48096000 {
> -			compatible = "ti,omap2430-mcbsp";
> -			reg = <0x48096000 0xff>;
> -			reg-names = "mpu";
> -			interrupts = <19>, /* OCP compliant interrupt */
> -				     <81>, /* TX interrupt */
> -				     <82>; /* RX interrupt */
> -			interrupt-names = "common", "tx", "rx";
> -			ti,buffer-size = <128>;
> -			ti,hwmods = "mcbsp5";
> -			dmas = <&sdma 21>,
> -			       <&sdma 22>;
> -			dma-names = "tx", "rx";
> -			status = "disabled";
> -		};
> -
> -		mmc1: mmc@4809c000 {
> -			compatible = "ti,omap2-hsmmc";
> -			reg = <0x4809c000 0x200>;
> -			interrupts = <83>;
> -			ti,hwmods = "mmc1";
> -			ti,dual-volt;
> -			dmas = <&sdma 61>, <&sdma 62>;
> -			dma-names = "tx", "rx";
> -			pbias-supply = <&pbias_mmc_reg>;
> -		};
> -
> -		mmc2: mmc@480b4000 {
> -			compatible = "ti,omap2-hsmmc";
> -			reg = <0x480b4000 0x200>;
> -			interrupts = <86>;
> -			ti,hwmods = "mmc2";
> -			dmas = <&sdma 47>, <&sdma 48>;
> -			dma-names = "tx", "rx";
> -		};
> -
> -		mailbox: mailbox@48094000 {
> -			compatible = "ti,omap2-mailbox";
> -			reg = <0x48094000 0x200>;
> -			interrupts = <26>;
> -			ti,hwmods = "mailbox";
> -			#mbox-cells = <1>;
> -			ti,mbox-num-users = <4>;
> -			ti,mbox-num-fifos = <6>;
> -			mbox_dsp: mbox-dsp {
> -				ti,mbox-tx = <0 0 0>;
> -				ti,mbox-rx = <1 0 0>;
> -			};
> -		};
> -
> -		timer1_target: target-module@49018000 {
> -			compatible = "ti,sysc-omap2-timer", "ti,sysc";
> -			reg = <0x49018000 0x4>,
> -			      <0x49018010 0x4>,
> -			      <0x49018014 0x4>;
> -			reg-names = "rev", "sysc", "syss";
> -			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
> -					 SYSC_OMAP2_EMUFREE |
> -					 SYSC_OMAP2_ENAWAKEUP |
> -					 SYSC_OMAP2_SOFTRESET |
> -					 SYSC_OMAP2_AUTOIDLE)>;
> -			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> -					<SYSC_IDLE_NO>,
> -					<SYSC_IDLE_SMART>;
> -			ti,syss-mask = <1>;
> -			clocks = <&gpt1_fck>, <&gpt1_ick>;
> -			clock-names = "fck", "ick";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0x0 0x49018000 0x1000>;
> -
> -			timer1: timer@0 {
> -				compatible = "ti,omap2420-timer";
> -				reg = <0 0x400>;
> -				interrupts = <37>;
> -				ti,timer-alwon;
> -			};
> -		};
> -
> -		mcspi3: spi@480b8000 {
> -			compatible = "ti,omap2-mcspi";
> -			ti,hwmods = "mcspi3";
> -			reg = <0x480b8000 0x100>;
> -			interrupts = <91>;
> -			dmas = <&sdma 15 &sdma 16 &sdma 23 &sdma 24>;
> -			dma-names = "tx0", "rx0", "tx1", "rx1";
> -		};
> -
> -		usb_otg_hs: usb_otg_hs@480ac000 {
> -			compatible = "ti,omap2-musb";
> -			ti,hwmods = "usb_otg_hs";
> -			reg = <0x480ac000 0x1000>;
> -			interrupts = <93>;
> -		};
> -
> -		wd_timer2: watchdog@49016000 {
> -			compatible = "ti,omap2-wdt";
> -			ti,hwmods = "wd_timer2";
> -			reg = <0x49016000 0x80>;
> -		};
> -	};
> -};
> -
> -&sdma {
> -	compatible = "ti,omap2430-sdma", "ti,omap-sdma";
> -};
> -
> -&i2c1 {
> -	compatible = "ti,omap2430-i2c";
> -};
> -
> -&i2c2 {
> -	compatible = "ti,omap2430-i2c";
> -};
> -
> -#include "omap24xx-clocks.dtsi"
> -#include "omap2430-clocks.dtsi"
> -
> -/* Preferred always-on timer for clockevent */
> -&timer1_target {
> -	ti,no-reset-on-init;
> -	ti,no-idle;
> -	timer@0 {
> -		assigned-clocks = <&gpt1_fck>;
> -		assigned-clock-parents = <&func_32k_ck>;
> -	};
> -};
> diff --git a/arch/arm/boot/dts/ti/omap/omap24xx-clocks.dtsi b/arch/arm/boot/dts/ti/omap/omap24xx-clocks.dtsi
> deleted file mode 100644
> index 07af87edf0e2..000000000000
> --- a/arch/arm/boot/dts/ti/omap/omap24xx-clocks.dtsi
> +++ /dev/null
> @@ -1,1241 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Device Tree Source for OMAP24xx clock data
> - *
> - * Copyright (C) 2014 Texas Instruments, Inc.
> - */
> -&scm_clocks {
> -	mcbsp1_mux_fck: mcbsp1_mux_fck@4 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_96m_ck>, <&mcbsp_clks>;
> -		ti,bit-shift = <2>;
> -		reg = <0x4>;
> -	};
> -
> -	mcbsp1_fck: mcbsp1_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&mcbsp1_gate_fck>, <&mcbsp1_mux_fck>;
> -	};
> -
> -	mcbsp2_mux_fck: mcbsp2_mux_fck@4 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_96m_ck>, <&mcbsp_clks>;
> -		ti,bit-shift = <6>;
> -		reg = <0x4>;
> -	};
> -
> -	mcbsp2_fck: mcbsp2_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&mcbsp2_gate_fck>, <&mcbsp2_mux_fck>;
> -	};
> -};
> -
> -&prcm_clocks {
> -	func_32k_ck: func_32k_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <32768>;
> -	};
> -
> -	secure_32k_ck: secure_32k_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <32768>;
> -	};
> -
> -	virt_12m_ck: virt_12m_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <12000000>;
> -	};
> -
> -	virt_13m_ck: virt_13m_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <13000000>;
> -	};
> -
> -	virt_19200000_ck: virt_19200000_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <19200000>;
> -	};
> -
> -	virt_26m_ck: virt_26m_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <26000000>;
> -	};
> -
> -	aplls_clkin_ck: aplls_clkin_ck@540 {
> -		#clock-cells = <0>;
> -		compatible = "ti,mux-clock";
> -		clocks = <&virt_19200000_ck>, <&virt_26m_ck>, <&virt_13m_ck>, <&virt_12m_ck>;
> -		ti,bit-shift = <23>;
> -		reg = <0x0540>;
> -	};
> -
> -	aplls_clkin_x2_ck: aplls_clkin_x2_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&aplls_clkin_ck>;
> -		clock-mult = <2>;
> -		clock-div = <1>;
> -	};
> -
> -	osc_ck: osc_ck@60 {
> -		#clock-cells = <0>;
> -		compatible = "ti,mux-clock";
> -		clocks = <&aplls_clkin_ck>, <&aplls_clkin_x2_ck>;
> -		ti,bit-shift = <6>;
> -		reg = <0x0060>;
> -		ti,index-starts-at-one;
> -	};
> -
> -	sys_ck: sys_ck@60 {
> -		#clock-cells = <0>;
> -		compatible = "ti,divider-clock";
> -		clocks = <&osc_ck>;
> -		ti,bit-shift = <6>;
> -		ti,max-div = <3>;
> -		reg = <0x0060>;
> -		ti,index-starts-at-one;
> -	};
> -
> -	alt_ck: alt_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <54000000>;
> -	};
> -
> -	mcbsp_clks: mcbsp_clks {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <0x0>;
> -	};
> -
> -	dpll_ck: dpll_ck@500 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap2-dpll-core-clock";
> -		clocks = <&sys_ck>, <&sys_ck>;
> -		reg = <0x0500>, <0x0540>;
> -	};
> -
> -	apll96_ck: apll96_ck@500 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap2-apll-clock";
> -		clocks = <&sys_ck>;
> -		ti,bit-shift = <2>;
> -		ti,idlest-shift = <8>;
> -		ti,clock-frequency = <96000000>;
> -		reg = <0x0500>, <0x0530>, <0x0520>;
> -	};
> -
> -	apll54_ck: apll54_ck@500 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap2-apll-clock";
> -		clocks = <&sys_ck>;
> -		ti,bit-shift = <6>;
> -		ti,idlest-shift = <9>;
> -		ti,clock-frequency = <54000000>;
> -		reg = <0x0500>, <0x0530>, <0x0520>;
> -	};
> -
> -	func_54m_ck: func_54m_ck@540 {
> -		#clock-cells = <0>;
> -		compatible = "ti,mux-clock";
> -		clocks = <&apll54_ck>, <&alt_ck>;
> -		ti,bit-shift = <5>;
> -		reg = <0x0540>;
> -	};
> -
> -	core_ck: core_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&dpll_ck>;
> -		clock-mult = <1>;
> -		clock-div = <1>;
> -	};
> -
> -	func_96m_ck: func_96m_ck@540 {
> -		#clock-cells = <0>;
> -	};
> -
> -	apll96_d2_ck: apll96_d2_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&apll96_ck>;
> -		clock-mult = <1>;
> -		clock-div = <2>;
> -	};
> -
> -	func_48m_ck: func_48m_ck@540 {
> -		#clock-cells = <0>;
> -		compatible = "ti,mux-clock";
> -		clocks = <&apll96_d2_ck>, <&alt_ck>;
> -		ti,bit-shift = <3>;
> -		reg = <0x0540>;
> -	};
> -
> -	func_12m_ck: func_12m_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&func_48m_ck>;
> -		clock-mult = <1>;
> -		clock-div = <4>;
> -	};
> -
> -	sys_clkout_src_gate: sys_clkout_src_gate@70 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-no-wait-gate-clock";
> -		clocks = <&core_ck>;
> -		ti,bit-shift = <7>;
> -		reg = <0x0070>;
> -	};
> -
> -	sys_clkout_src_mux: sys_clkout_src_mux@70 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&core_ck>, <&sys_ck>, <&func_96m_ck>, <&func_54m_ck>;
> -		reg = <0x0070>;
> -	};
> -
> -	sys_clkout_src: sys_clkout_src {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&sys_clkout_src_gate>, <&sys_clkout_src_mux>;
> -	};
> -
> -	sys_clkout: sys_clkout@70 {
> -		#clock-cells = <0>;
> -		compatible = "ti,divider-clock";
> -		clocks = <&sys_clkout_src>;
> -		ti,bit-shift = <3>;
> -		ti,max-div = <64>;
> -		reg = <0x0070>;
> -		ti,index-power-of-two;
> -	};
> -
> -	emul_ck: emul_ck@78 {
> -		#clock-cells = <0>;
> -		compatible = "ti,gate-clock";
> -		clocks = <&func_54m_ck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x0078>;
> -	};
> -
> -	mpu_ck: mpu_ck@140 {
> -		#clock-cells = <0>;
> -		compatible = "ti,divider-clock";
> -		clocks = <&core_ck>;
> -		ti,max-div = <31>;
> -		reg = <0x0140>;
> -		ti,index-starts-at-one;
> -	};
> -
> -	dsp_gate_fck: dsp_gate_fck@800 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&core_ck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x0800>;
> -	};
> -
> -	dsp_div_fck: dsp_div_fck@840 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-divider-clock";
> -		clocks = <&core_ck>;
> -		reg = <0x0840>;
> -	};
> -
> -	dsp_fck: dsp_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&dsp_gate_fck>, <&dsp_div_fck>;
> -	};
> -
> -	core_l3_ck: core_l3_ck@240 {
> -		#clock-cells = <0>;
> -		compatible = "ti,divider-clock";
> -		clocks = <&core_ck>;
> -		ti,max-div = <31>;
> -		reg = <0x0240>;
> -		ti,index-starts-at-one;
> -	};
> -
> -	gfx_3d_gate_fck: gfx_3d_gate_fck@300 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,bit-shift = <2>;
> -		reg = <0x0300>;
> -	};
> -
> -	gfx_3d_div_fck: gfx_3d_div_fck@340 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-divider-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,max-div = <4>;
> -		reg = <0x0340>;
> -		ti,index-starts-at-one;
> -	};
> -
> -	gfx_3d_fck: gfx_3d_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gfx_3d_gate_fck>, <&gfx_3d_div_fck>;
> -	};
> -
> -	gfx_2d_gate_fck: gfx_2d_gate_fck@300 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,bit-shift = <1>;
> -		reg = <0x0300>;
> -	};
> -
> -	gfx_2d_div_fck: gfx_2d_div_fck@340 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-divider-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,max-div = <4>;
> -		reg = <0x0340>;
> -		ti,index-starts-at-one;
> -	};
> -
> -	gfx_2d_fck: gfx_2d_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gfx_2d_gate_fck>, <&gfx_2d_div_fck>;
> -	};
> -
> -	gfx_ick: gfx_ick@310 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x0310>;
> -	};
> -
> -	l4_ck: l4_ck@240 {
> -		#clock-cells = <0>;
> -		compatible = "ti,divider-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,bit-shift = <5>;
> -		ti,max-div = <3>;
> -		reg = <0x0240>;
> -		ti,index-starts-at-one;
> -	};
> -
> -	dss_ick: dss_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-no-wait-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x0210>;
> -	};
> -
> -	dss1_gate_fck: dss1_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-no-wait-gate-clock";
> -		clocks = <&core_ck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x0200>;
> -	};
> -
> -	core_d2_ck: core_d2_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&core_ck>;
> -		clock-mult = <1>;
> -		clock-div = <2>;
> -	};
> -
> -	core_d3_ck: core_d3_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&core_ck>;
> -		clock-mult = <1>;
> -		clock-div = <3>;
> -	};
> -
> -	core_d4_ck: core_d4_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&core_ck>;
> -		clock-mult = <1>;
> -		clock-div = <4>;
> -	};
> -
> -	core_d5_ck: core_d5_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&core_ck>;
> -		clock-mult = <1>;
> -		clock-div = <5>;
> -	};
> -
> -	core_d6_ck: core_d6_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&core_ck>;
> -		clock-mult = <1>;
> -		clock-div = <6>;
> -	};
> -
> -	dummy_ck: dummy_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <0>;
> -	};
> -
> -	core_d8_ck: core_d8_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&core_ck>;
> -		clock-mult = <1>;
> -		clock-div = <8>;
> -	};
> -
> -	core_d9_ck: core_d9_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&core_ck>;
> -		clock-mult = <1>;
> -		clock-div = <9>;
> -	};
> -
> -	core_d12_ck: core_d12_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&core_ck>;
> -		clock-mult = <1>;
> -		clock-div = <12>;
> -	};
> -
> -	core_d16_ck: core_d16_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&core_ck>;
> -		clock-mult = <1>;
> -		clock-div = <16>;
> -	};
> -
> -	dss1_mux_fck: dss1_mux_fck@240 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&sys_ck>, <&core_ck>, <&core_d2_ck>, <&core_d3_ck>, <&core_d4_ck>, <&core_d5_ck>, <&core_d6_ck>, <&core_d8_ck>, <&core_d9_ck>, <&core_d12_ck>, <&core_d16_ck>;
> -		ti,bit-shift = <8>;
> -		reg = <0x0240>;
> -	};
> -
> -	dss1_fck: dss1_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&dss1_gate_fck>, <&dss1_mux_fck>;
> -	};
> -
> -	dss2_gate_fck: dss2_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-no-wait-gate-clock";
> -		clocks = <&func_48m_ck>;
> -		ti,bit-shift = <1>;
> -		reg = <0x0200>;
> -	};
> -
> -	dss2_mux_fck: dss2_mux_fck@240 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&sys_ck>, <&func_48m_ck>;
> -		ti,bit-shift = <13>;
> -		reg = <0x0240>;
> -	};
> -
> -	dss2_fck: dss2_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&dss2_gate_fck>, <&dss2_mux_fck>;
> -	};
> -
> -	dss_54m_fck: dss_54m_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_54m_ck>;
> -		ti,bit-shift = <2>;
> -		reg = <0x0200>;
> -	};
> -
> -	ssi_ssr_sst_gate_fck: ssi_ssr_sst_gate_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&core_ck>;
> -		ti,bit-shift = <1>;
> -		reg = <0x0204>;
> -	};
> -
> -	ssi_ssr_sst_div_fck: ssi_ssr_sst_div_fck@240 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-divider-clock";
> -		clocks = <&core_ck>;
> -		ti,bit-shift = <20>;
> -		reg = <0x0240>;
> -	};
> -
> -	ssi_ssr_sst_fck: ssi_ssr_sst_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&ssi_ssr_sst_gate_fck>, <&ssi_ssr_sst_div_fck>;
> -	};
> -
> -	usb_l4_gate_ick: usb_l4_gate_ick@214 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-interface-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x0214>;
> -	};
> -
> -	usb_l4_div_ick: usb_l4_div_ick@240 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-divider-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,bit-shift = <25>;
> -		reg = <0x0240>;
> -		ti,dividers = <0>, <1>, <2>, <0>, <4>;
> -	};
> -
> -	usb_l4_ick: usb_l4_ick {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&usb_l4_gate_ick>, <&usb_l4_div_ick>;
> -	};
> -
> -	ssi_l4_ick: ssi_l4_ick@214 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <1>;
> -		reg = <0x0214>;
> -	};
> -
> -	gpt1_ick: gpt1_ick@410 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&sys_ck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x0410>;
> -	};
> -
> -	gpt1_gate_fck: gpt1_gate_fck@400 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x0400>;
> -	};
> -
> -	gpt1_mux_fck: gpt1_mux_fck@440 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
> -		reg = <0x0440>;
> -	};
> -
> -	gpt1_fck: gpt1_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gpt1_gate_fck>, <&gpt1_mux_fck>;
> -	};
> -
> -	gpt2_ick: gpt2_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <4>;
> -		reg = <0x0210>;
> -	};
> -
> -	gpt2_gate_fck: gpt2_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <4>;
> -		reg = <0x0200>;
> -	};
> -
> -	gpt2_mux_fck: gpt2_mux_fck@244 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
> -		ti,bit-shift = <2>;
> -		reg = <0x0244>;
> -	};
> -
> -	gpt2_fck: gpt2_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gpt2_gate_fck>, <&gpt2_mux_fck>;
> -	};
> -
> -	gpt3_ick: gpt3_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <5>;
> -		reg = <0x0210>;
> -	};
> -
> -	gpt3_gate_fck: gpt3_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <5>;
> -		reg = <0x0200>;
> -	};
> -
> -	gpt3_mux_fck: gpt3_mux_fck@244 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
> -		ti,bit-shift = <4>;
> -		reg = <0x0244>;
> -	};
> -
> -	gpt3_fck: gpt3_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gpt3_gate_fck>, <&gpt3_mux_fck>;
> -	};
> -
> -	gpt4_ick: gpt4_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <6>;
> -		reg = <0x0210>;
> -	};
> -
> -	gpt4_gate_fck: gpt4_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <6>;
> -		reg = <0x0200>;
> -	};
> -
> -	gpt4_mux_fck: gpt4_mux_fck@244 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
> -		ti,bit-shift = <6>;
> -		reg = <0x0244>;
> -	};
> -
> -	gpt4_fck: gpt4_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gpt4_gate_fck>, <&gpt4_mux_fck>;
> -	};
> -
> -	gpt5_ick: gpt5_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <7>;
> -		reg = <0x0210>;
> -	};
> -
> -	gpt5_gate_fck: gpt5_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <7>;
> -		reg = <0x0200>;
> -	};
> -
> -	gpt5_mux_fck: gpt5_mux_fck@244 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
> -		ti,bit-shift = <8>;
> -		reg = <0x0244>;
> -	};
> -
> -	gpt5_fck: gpt5_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gpt5_gate_fck>, <&gpt5_mux_fck>;
> -	};
> -
> -	gpt6_ick: gpt6_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <8>;
> -		reg = <0x0210>;
> -	};
> -
> -	gpt6_gate_fck: gpt6_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <8>;
> -		reg = <0x0200>;
> -	};
> -
> -	gpt6_mux_fck: gpt6_mux_fck@244 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
> -		ti,bit-shift = <10>;
> -		reg = <0x0244>;
> -	};
> -
> -	gpt6_fck: gpt6_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gpt6_gate_fck>, <&gpt6_mux_fck>;
> -	};
> -
> -	gpt7_ick: gpt7_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <9>;
> -		reg = <0x0210>;
> -	};
> -
> -	gpt7_gate_fck: gpt7_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <9>;
> -		reg = <0x0200>;
> -	};
> -
> -	gpt7_mux_fck: gpt7_mux_fck@244 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
> -		ti,bit-shift = <12>;
> -		reg = <0x0244>;
> -	};
> -
> -	gpt7_fck: gpt7_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gpt7_gate_fck>, <&gpt7_mux_fck>;
> -	};
> -
> -	gpt8_ick: gpt8_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <10>;
> -		reg = <0x0210>;
> -	};
> -
> -	gpt8_gate_fck: gpt8_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <10>;
> -		reg = <0x0200>;
> -	};
> -
> -	gpt8_mux_fck: gpt8_mux_fck@244 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
> -		ti,bit-shift = <14>;
> -		reg = <0x0244>;
> -	};
> -
> -	gpt8_fck: gpt8_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gpt8_gate_fck>, <&gpt8_mux_fck>;
> -	};
> -
> -	gpt9_ick: gpt9_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <11>;
> -		reg = <0x0210>;
> -	};
> -
> -	gpt9_gate_fck: gpt9_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <11>;
> -		reg = <0x0200>;
> -	};
> -
> -	gpt9_mux_fck: gpt9_mux_fck@244 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
> -		ti,bit-shift = <16>;
> -		reg = <0x0244>;
> -	};
> -
> -	gpt9_fck: gpt9_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gpt9_gate_fck>, <&gpt9_mux_fck>;
> -	};
> -
> -	gpt10_ick: gpt10_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <12>;
> -		reg = <0x0210>;
> -	};
> -
> -	gpt10_gate_fck: gpt10_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <12>;
> -		reg = <0x0200>;
> -	};
> -
> -	gpt10_mux_fck: gpt10_mux_fck@244 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
> -		ti,bit-shift = <18>;
> -		reg = <0x0244>;
> -	};
> -
> -	gpt10_fck: gpt10_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gpt10_gate_fck>, <&gpt10_mux_fck>;
> -	};
> -
> -	gpt11_ick: gpt11_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <13>;
> -		reg = <0x0210>;
> -	};
> -
> -	gpt11_gate_fck: gpt11_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <13>;
> -		reg = <0x0200>;
> -	};
> -
> -	gpt11_mux_fck: gpt11_mux_fck@244 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
> -		ti,bit-shift = <20>;
> -		reg = <0x0244>;
> -	};
> -
> -	gpt11_fck: gpt11_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gpt11_gate_fck>, <&gpt11_mux_fck>;
> -	};
> -
> -	gpt12_ick: gpt12_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <14>;
> -		reg = <0x0210>;
> -	};
> -
> -	gpt12_gate_fck: gpt12_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <14>;
> -		reg = <0x0200>;
> -	};
> -
> -	gpt12_mux_fck: gpt12_mux_fck@244 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-mux-clock";
> -		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
> -		ti,bit-shift = <22>;
> -		reg = <0x0244>;
> -	};
> -
> -	gpt12_fck: gpt12_fck {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&gpt12_gate_fck>, <&gpt12_mux_fck>;
> -	};
> -
> -	mcbsp1_ick: mcbsp1_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <15>;
> -		reg = <0x0210>;
> -	};
> -
> -	mcbsp1_gate_fck: mcbsp1_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&mcbsp_clks>;
> -		ti,bit-shift = <15>;
> -		reg = <0x0200>;
> -	};
> -
> -	mcbsp2_ick: mcbsp2_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <16>;
> -		reg = <0x0210>;
> -	};
> -
> -	mcbsp2_gate_fck: mcbsp2_gate_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-gate-clock";
> -		clocks = <&mcbsp_clks>;
> -		ti,bit-shift = <16>;
> -		reg = <0x0200>;
> -	};
> -
> -	mcspi1_ick: mcspi1_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <17>;
> -		reg = <0x0210>;
> -	};
> -
> -	mcspi1_fck: mcspi1_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_48m_ck>;
> -		ti,bit-shift = <17>;
> -		reg = <0x0200>;
> -	};
> -
> -	mcspi2_ick: mcspi2_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <18>;
> -		reg = <0x0210>;
> -	};
> -
> -	mcspi2_fck: mcspi2_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_48m_ck>;
> -		ti,bit-shift = <18>;
> -		reg = <0x0200>;
> -	};
> -
> -	uart1_ick: uart1_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <21>;
> -		reg = <0x0210>;
> -	};
> -
> -	uart1_fck: uart1_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_48m_ck>;
> -		ti,bit-shift = <21>;
> -		reg = <0x0200>;
> -	};
> -
> -	uart2_ick: uart2_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <22>;
> -		reg = <0x0210>;
> -	};
> -
> -	uart2_fck: uart2_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_48m_ck>;
> -		ti,bit-shift = <22>;
> -		reg = <0x0200>;
> -	};
> -
> -	uart3_ick: uart3_ick@214 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <2>;
> -		reg = <0x0214>;
> -	};
> -
> -	uart3_fck: uart3_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_48m_ck>;
> -		ti,bit-shift = <2>;
> -		reg = <0x0204>;
> -	};
> -
> -	gpios_ick: gpios_ick@410 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&sys_ck>;
> -		ti,bit-shift = <2>;
> -		reg = <0x0410>;
> -	};
> -
> -	gpios_fck: gpios_fck@400 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <2>;
> -		reg = <0x0400>;
> -	};
> -
> -	mpu_wdt_ick: mpu_wdt_ick@410 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&sys_ck>;
> -		ti,bit-shift = <3>;
> -		reg = <0x0410>;
> -	};
> -
> -	mpu_wdt_fck: mpu_wdt_fck@400 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <3>;
> -		reg = <0x0400>;
> -	};
> -
> -	sync_32k_ick: sync_32k_ick@410 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&sys_ck>;
> -		ti,bit-shift = <1>;
> -		reg = <0x0410>;
> -	};
> -
> -	wdt1_ick: wdt1_ick@410 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&sys_ck>;
> -		ti,bit-shift = <4>;
> -		reg = <0x0410>;
> -	};
> -
> -	omapctrl_ick: omapctrl_ick@410 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&sys_ck>;
> -		ti,bit-shift = <5>;
> -		reg = <0x0410>;
> -	};
> -
> -	cam_fck: cam_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,gate-clock";
> -		clocks = <&func_96m_ck>;
> -		ti,bit-shift = <31>;
> -		reg = <0x0200>;
> -	};
> -
> -	cam_ick: cam_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-no-wait-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <31>;
> -		reg = <0x0210>;
> -	};
> -
> -	mailboxes_ick: mailboxes_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <30>;
> -		reg = <0x0210>;
> -	};
> -
> -	wdt4_ick: wdt4_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <29>;
> -		reg = <0x0210>;
> -	};
> -
> -	wdt4_fck: wdt4_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_32k_ck>;
> -		ti,bit-shift = <29>;
> -		reg = <0x0200>;
> -	};
> -
> -	mspro_ick: mspro_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <27>;
> -		reg = <0x0210>;
> -	};
> -
> -	mspro_fck: mspro_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_96m_ck>;
> -		ti,bit-shift = <27>;
> -		reg = <0x0200>;
> -	};
> -
> -	fac_ick: fac_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <25>;
> -		reg = <0x0210>;
> -	};
> -
> -	fac_fck: fac_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_12m_ck>;
> -		ti,bit-shift = <25>;
> -		reg = <0x0200>;
> -	};
> -
> -	hdq_ick: hdq_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <23>;
> -		reg = <0x0210>;
> -	};
> -
> -	hdq_fck: hdq_fck@200 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_12m_ck>;
> -		ti,bit-shift = <23>;
> -		reg = <0x0200>;
> -	};
> -
> -	i2c1_ick: i2c1_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <19>;
> -		reg = <0x0210>;
> -	};
> -
> -	i2c2_ick: i2c2_ick@210 {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <20>;
> -		reg = <0x0210>;
> -	};
> -
> -	gpmc_fck: gpmc_fck@238 {
> -		#clock-cells = <0>;
> -		compatible = "ti,fixed-factor-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,clock-div = <1>;
> -		ti,autoidle-shift = <1>;
> -		reg = <0x0238>;
> -		ti,clock-mult = <1>;
> -	};
> -
> -	sdma_fck: sdma_fck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&core_l3_ck>;
> -		clock-mult = <1>;
> -		clock-div = <1>;
> -	};
> -
> -	sdma_ick: sdma_ick@238 {
> -		#clock-cells = <0>;
> -		compatible = "ti,fixed-factor-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,clock-div = <1>;
> -		ti,autoidle-shift = <0>;
> -		reg = <0x0238>;
> -		ti,clock-mult = <1>;
> -	};
> -
> -	sdrc_ick: sdrc_ick@238 {
> -		#clock-cells = <0>;
> -		compatible = "ti,fixed-factor-clock";
> -		clocks = <&core_l3_ck>;
> -		ti,clock-div = <1>;
> -		ti,autoidle-shift = <2>;
> -		reg = <0x0238>;
> -		ti,clock-mult = <1>;
> -	};
> -
> -	des_ick: des_ick@21c {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x021c>;
> -	};
> -
> -	sha_ick: sha_ick@21c {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <1>;
> -		reg = <0x021c>;
> -	};
> -
> -	rng_ick: rng_ick@21c {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <2>;
> -		reg = <0x021c>;
> -	};
> -
> -	aes_ick: aes_ick@21c {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <3>;
> -		reg = <0x021c>;
> -	};
> -
> -	pka_ick: pka_ick@21c {
> -		#clock-cells = <0>;
> -		compatible = "ti,omap3-interface-clock";
> -		clocks = <&l4_ck>;
> -		ti,bit-shift = <4>;
> -		reg = <0x021c>;
> -	};
> -
> -	usb_fck: usb_fck@204 {
> -		#clock-cells = <0>;
> -		compatible = "ti,wait-gate-clock";
> -		clocks = <&func_48m_ck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x0204>;
> -	};
> -};
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index f827f89567fd..2e9597f50c58 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -22,9 +22,7 @@ CONFIG_NAMESPACES=y
>   CONFIG_BLK_DEV_INITRD=y
>   CONFIG_EXPERT=y
>   CONFIG_PROFILING=y
> -CONFIG_ARCH_MULTI_V6=y
>   CONFIG_OMAP_RESET_CLOCKS=y
> -CONFIG_ARCH_OMAP2=y
>   CONFIG_ARCH_OMAP3=y
>   CONFIG_ARCH_OMAP4=y
>   CONFIG_SOC_OMAP5=y
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 79f8afe3a6bf..37ecbfc0a19f 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -5,15 +5,6 @@ menu "TI OMAP/AM/DM/DRA Family"
>   config OMAP_HWMOD
>   	bool
>   
> -config ARCH_OMAP2
> -	bool "TI OMAP2"
> -	depends on ARCH_MULTI_V6
> -	depends on !SMP
> -	select ARCH_OMAP2PLUS
> -	select CPU_ARM1136R0
> -	select OMAP_HWMOD
> -	select SOC_HAS_OMAP2_SDRC
> -
>   config ARCH_OMAP3
>   	bool "TI OMAP3"
>   	depends on ARCH_MULTI_V7
> @@ -118,7 +109,7 @@ config ARCH_OMAP2PLUS
>   	select OMAP_IRQCHIP
>   	select CLKSRC_TI_32K
>   	help
> -	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
> +	  Systems based on OMAP3, OMAP4 or OMAP5
>   
>   config OMAP_INTERCONNECT_BARRIER
>   	bool
> @@ -129,7 +120,7 @@ config ARCH_OMAP
>   
>   if ARCH_OMAP2PLUS
>   
> -menu "TI OMAP2/3/4 Specific Features"
> +menu "TI OMAP3/4 Specific Features"
>   
>   config ARCH_OMAP2PLUS_TYPICAL
>   	bool "Typical OMAP configuration"
> @@ -138,8 +129,7 @@ config ARCH_OMAP2PLUS_TYPICAL
>   	select HIGHMEM
>   	select I2C
>   	select I2C_OMAP
> -	select MENELAUS if ARCH_OMAP2
> -	select NEON if CPU_V7
> +	select NEON
>   	select REGULATOR
>   	select REGULATOR_FIXED_VOLTAGE
>   	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
> @@ -204,27 +194,7 @@ config OMAP3_L2_AUX_SECURE_SERVICE_SET_ID
>   	  PPA routine service ID for setting L2 auxiliary control register.
>   
>   comment "OMAP Core Type"
> -	depends on ARCH_OMAP2
> -
> -config SOC_OMAP2420
> -	bool "OMAP2420 support (DEPRECATED)"
> -	depends on ARCH_OMAP2
> -	default y
> -	select OMAP_DM_SYSTIMER
> -	select OMAP_DM_TIMER
> -	select SOC_HAS_OMAP2_SDRC
> -	help
> -	  This SoC is scheduled for removal in early 2027,
> -	  since it uses the ARM1136r0 CPU revision.
> -
> -config SOC_OMAP2430
> -	bool "OMAP2430 support (DEPRECATED)"
> -	depends on ARCH_OMAP2
> -	default y
> -	select SOC_HAS_OMAP2_SDRC
> -	help
> -	  This SoC is scheduled for removal in early 2027,
> -	  since it uses the ARM1136r0 CPU revision.
> +	depends on ARCH_OMAP3
>   
>   config SOC_OMAP3430
>   	bool "OMAP3430 support"
> @@ -237,33 +207,9 @@ config SOC_TI81XX
>   	depends on ARCH_OMAP3
>   	default y
>   
> -comment "OMAP Legacy Platform Data Board Type"
> -	depends on ARCH_OMAP2PLUS
> -
>   config MACH_OMAP_GENERIC
>   	bool
>   
> -config MACH_OMAP2_TUSB6010
> -	bool
> -	depends on ARCH_OMAP2 && SOC_OMAP2420
> -	default y if MACH_NOKIA_N8X0
> -
> -config MACH_NOKIA_N810
> -	bool
> -
> -config MACH_NOKIA_N810_WIMAX
> -	bool
> -
> -config MACH_NOKIA_N8X0
> -	bool "Nokia N800/N810 (DEPRECATED)"
> -	depends on SOC_OMAP2420
> -	default y
> -	select MACH_NOKIA_N810
> -	select MACH_NOKIA_N810_WIMAX
> -	help
> -	  This machine is scheduled for removal in early 2027,
> -	  since it uses the ARM1136r0 CPU revision.
> -
>   endmenu
>   
>   endif
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index daf21127c82f..6c741442dc0d 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -5,23 +5,17 @@
>   
>   # Common support
>   obj-y := id.o io.o control.o devices.o fb.o pm.o \
> -	 common.o dma.o omap-headsmp.o sram.o
> +	 common.o dma.o omap-headsmp.o
>   
> -hwmod-common				= omap_hwmod.o \
> +# OMAP3 hwmod specific
> +obj-$(CONFIG_ARCH_OMAP3)		+= sram.o omap_hwmod.o \
>   					  omap_hwmod_common_data.o \
>   					  omap_hwmod_common_ipblock_data.o \
>   					  omap_device.o display.o hdq1w.o \
>   					  i2c.o wd_timer.o
> -clock-common				= clock.o
> -secure-common				= omap-smc.o omap-secure.o
>   
> -obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
> -obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
> -obj-$(CONFIG_ARCH_OMAP4) += $(secure-common)
> -obj-$(CONFIG_SOC_AM33XX) += $(secure-common)
> -obj-$(CONFIG_SOC_OMAP5)  += $(secure-common)
> -obj-$(CONFIG_SOC_AM43XX) += $(secure-common)
> -obj-$(CONFIG_SOC_DRA7XX) += $(secure-common)
> +# secure world
> +obj-y					+= omap-smc.o omap-secure.o
>   
>   ifneq ($(CONFIG_SND_SOC_OMAP_MCBSP),)
>   obj-$(CONFIG_OMAP_HWMOD) += mcbsp.o
> @@ -49,13 +43,7 @@ omap5-dra7-common-$(CONFIG_SOC_HAS_REALTIME_COUNTER) =  timer.o
>   obj-$(CONFIG_SOC_OMAP5)			+= $(omap5-dra7-common-y)
>   obj-$(CONFIG_SOC_DRA7XX)		+= $(omap5-dra7-common-y)
>   
> -# Functions loaded to SRAM
> -obj-$(CONFIG_SOC_OMAP2420)		+= sram242x.o
> -obj-$(CONFIG_SOC_OMAP2430)		+= sram243x.o
> -
>   # Restart code (OMAP4/5 currently in omap4-common.c)
> -obj-$(CONFIG_SOC_OMAP2420)		+= omap2-restart.o
> -obj-$(CONFIG_SOC_OMAP2430)		+= omap2-restart.o
>   obj-$(CONFIG_SOC_TI81XX)		+= ti81xx-restart.o
>   obj-$(CONFIG_SOC_AM33XX)		+= am33xx-restart.o
>   obj-$(CONFIG_SOC_AM43XX)		+= omap4-restart.o
> @@ -65,7 +53,6 @@ obj-$(CONFIG_SOC_OMAP5)			+= omap4-restart.o
>   obj-$(CONFIG_SOC_DRA7XX)		+= omap4-restart.o
>   
>   # SMS/SDRC
> -obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
>   # obj-$(CONFIG_ARCH_OMAP3)		+= sdrc3xxx.o
>   
>   # OPP table initialization
> @@ -80,7 +67,6 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-pm-common)
>   obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-pm-common)
>   
>   ifeq ($(CONFIG_PM),y)
> -obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
>   obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
>   omap-4-5-pm-common			+= pm44xx.o
>   obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-pm-common)
> @@ -105,7 +91,6 @@ endif
>   
>   # PRCM
>   obj-y					+= prm_common.o cm_common.o
> -obj-$(CONFIG_ARCH_OMAP2)		+= prm2xxx_3xxx.o prm2xxx.o cm2xxx.o
>   obj-$(CONFIG_ARCH_OMAP3)		+= prm2xxx_3xxx.o prm3xxx.o cm3xxx.o
>   obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
>   omap-prcm-4-5-common			=  cminst44xx.o prm44xx.o \
> @@ -122,8 +107,6 @@ obj-$(CONFIG_SOC_AM43XX)		+= $(omap-prcm-4-5-common) \
>   
>   # OMAP voltage domains
>   voltagedomain-common			:= voltage.o vc.o vp.o
> -obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common)
> -obj-$(CONFIG_ARCH_OMAP2)		+= voltagedomains2xxx_data.o
>   obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common)
>   obj-$(CONFIG_ARCH_OMAP3)		+= voltagedomains3xxx_data.o
>   obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common)
> @@ -136,9 +119,6 @@ obj-$(CONFIG_SOC_DRA7XX)		+= $(voltagedomain-common)
>   
>   # OMAP powerdomain framework
>   powerdomain-common			+= powerdomain.o powerdomain-common.o
> -obj-$(CONFIG_ARCH_OMAP2)		+= $(powerdomain-common)
> -obj-$(CONFIG_ARCH_OMAP2)		+= powerdomains2xxx_data.o
> -obj-$(CONFIG_ARCH_OMAP2)		+= powerdomains2xxx_3xxx_data.o
>   obj-$(CONFIG_ARCH_OMAP3)		+= $(powerdomain-common)
>   obj-$(CONFIG_ARCH_OMAP3)		+= powerdomains3xxx_data.o
>   obj-$(CONFIG_ARCH_OMAP3)		+= powerdomains2xxx_3xxx_data.o
> @@ -155,10 +135,6 @@ obj-$(CONFIG_SOC_DRA7XX)		+= powerdomains7xx_data.o
>   
>   # PRCM clockdomain control
>   clockdomain-common			+= clockdomain.o
> -obj-$(CONFIG_ARCH_OMAP2)		+= $(clockdomain-common)
> -obj-$(CONFIG_ARCH_OMAP2)		+= clockdomains2xxx_3xxx_data.o
> -obj-$(CONFIG_SOC_OMAP2420)		+= clockdomains2420_data.o
> -obj-$(CONFIG_SOC_OMAP2430)		+= clockdomains2430_data.o
>   obj-$(CONFIG_ARCH_OMAP3)		+= $(clockdomain-common)
>   obj-$(CONFIG_ARCH_OMAP3)		+= clockdomains2xxx_3xxx_data.o
>   obj-$(CONFIG_ARCH_OMAP3)		+= clockdomains3xxx_data.o
> @@ -176,47 +152,20 @@ obj-$(CONFIG_SOC_DRA7XX)		+= $(clockdomain-common)
>   obj-$(CONFIG_SOC_DRA7XX)		+= clockdomains7xx_data.o
>   
>   # Clock framework
> -obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common)
> -obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpllcore.o
> -obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_virt_prcm_set.o
> -obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o
> -obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common)
> -obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common)
> -obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common)
> -obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
> -obj-$(CONFIG_SOC_DRA7XX)		+= $(clock-common)
> -obj-$(CONFIG_SOC_AM43XX)		+= $(clock-common)
> -
> -# OMAP2 clock rate set data (old "OPP" data)
> -obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
> -obj-$(CONFIG_SOC_OMAP2430)		+= opp2430_data.o
> +obj-y					+= clock.o
>   
>   # hwmod data
> -obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_ipblock_data.o
> -obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
> -obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_interconnect_data.o
> -obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2420_data.o
> -obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_ipblock_data.o
> -obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
> -obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_interconnect_data.o
> -obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2430_data.o
>   obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
>   obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
>   obj-$(CONFIG_SOC_TI81XX)		+= omap_hwmod_81xx_data.o
>   
> -# OMAP2420 MSDI controller integration support ("MMC")
> -obj-$(CONFIG_SOC_OMAP2420)		+= msdi.o
> -
>   # Specific board support
>   obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o pdata-quirks.o
> -obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
>   
>   # Platform specific device init code
>   
>   obj-y					+= omap_phy_internal.o
>   
> -obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
> -
>   $(obj)/pm-asm-offsets.h: $(obj)/pm-asm-offsets.s FORCE
>   	$(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
>   
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index bff673e932fe..972b8cf0547f 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -45,40 +45,6 @@ void tick_broadcast(const struct cpumask *mask)
>   }
>   #endif
>   
> -#ifdef CONFIG_SOC_OMAP2420
> -static const char *const omap242x_boards_compat[] __initconst = {
> -	"ti,omap2420",
> -	NULL,
> -};
> -
> -DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
> -	.reserve	= omap_reserve,
> -	.map_io		= omap242x_map_io,
> -	.init_early	= omap2420_init_early,
> -	.init_machine	= omap_generic_init,
> -	.init_time	= omap_init_time_of,
> -	.dt_compat	= omap242x_boards_compat,
> -	.restart	= omap2xxx_restart,
> -MACHINE_END
> -#endif
> -
> -#ifdef CONFIG_SOC_OMAP2430
> -static const char *const omap243x_boards_compat[] __initconst = {
> -	"ti,omap2430",
> -	NULL,
> -};
> -
> -DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
> -	.reserve	= omap_reserve,
> -	.map_io		= omap243x_map_io,
> -	.init_early	= omap2430_init_early,
> -	.init_machine	= omap_generic_init,
> -	.init_time	= omap_init_time_of,
> -	.dt_compat	= omap243x_boards_compat,
> -	.restart	= omap2xxx_restart,
> -MACHINE_END
> -#endif
> -
>   #ifdef CONFIG_ARCH_OMAP3
>   /* Some boards need board name for legacy userspace in /proc/cpuinfo */
>   static const char *const n900_boards_compat[] __initconst = {
> diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
> deleted file mode 100644
> index d9acd32c5457..000000000000
> --- a/arch/arm/mach-omap2/board-n8x0.c
> +++ /dev/null
> @@ -1,512 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * linux/arch/arm/mach-omap2/board-n8x0.c
> - *
> - * Copyright (C) 2005-2009 Nokia Corporation
> - * Author: Juha Yrjola <juha.yrjola@nokia.com>
> - *
> - * Modified from mach-omap2/board-generic.c
> - */
> -
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/irq.h>
> -#include <linux/stddef.h>
> -#include <linux/i2c.h>
> -#include <linux/spi/spi.h>
> -#include <linux/usb/musb.h>
> -#include <linux/mmc/host.h>
> -#include <linux/platform_data/mmc-omap.h>
> -#include <linux/mfd/menelaus.h>
> -
> -#include <asm/mach/arch.h>
> -#include <asm/mach-types.h>
> -
> -#include "common.h"
> -#include "mmc.h"
> -#include "usb-tusb6010.h"
> -#include "soc.h"
> -#include "common-board-devices.h"
> -
> -#define TUSB6010_ASYNC_CS	1
> -#define TUSB6010_SYNC_CS	4
> -#define TUSB6010_DMACHAN	0x3f
> -
> -#define NOKIA_N810_WIMAX	(1 << 2)
> -#define NOKIA_N810		(1 << 1)
> -#define NOKIA_N800		(1 << 0)
> -
> -static u32 board_caps;
> -
> -#define board_is_n800()		(board_caps & NOKIA_N800)
> -#define board_is_n810()		(board_caps & NOKIA_N810)
> -#define board_is_n810_wimax()	(board_caps & NOKIA_N810_WIMAX)
> -
> -static void board_check_revision(void)
> -{
> -	if (of_machine_is_compatible("nokia,n800"))
> -		board_caps = NOKIA_N800;
> -	else if (of_machine_is_compatible("nokia,n810"))
> -		board_caps = NOKIA_N810;
> -	else if (of_machine_is_compatible("nokia,n810-wimax"))
> -		board_caps = NOKIA_N810_WIMAX;
> -
> -	if (!board_caps)
> -		pr_err("Unknown board\n");
> -}
> -
> -#if IS_ENABLED(CONFIG_USB_MUSB_TUSB6010)
> -
> -static struct musb_hdrc_config musb_config = {
> -	.multipoint	= 1,
> -	.dyn_fifo	= 1,
> -	.num_eps	= 16,
> -	.ram_bits	= 12,
> -};
> -
> -static struct musb_hdrc_platform_data tusb_data = {
> -	.mode		= MUSB_OTG,
> -	.min_power	= 25,	/* x2 = 50 mA drawn from VBUS as peripheral */
> -	.power		= 100,	/* Max 100 mA VBUS for host mode */
> -	.config		= &musb_config,
> -};
> -
> -static struct gpiod_lookup_table tusb_gpio_table = {
> -	.dev_id = "musb-tusb",
> -	.table = {
> -		GPIO_LOOKUP("gpio-0-31", 0, "enable", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("gpio-32-63", 26, "int", GPIO_ACTIVE_HIGH),
> -		{ }
> -	},
> -};
> -
> -static void __init n8x0_usb_init(void)
> -{
> -	int ret = 0;
> -
> -	gpiod_add_lookup_table(&tusb_gpio_table);
> -	ret = tusb6010_setup_interface(&tusb_data, TUSB6010_REFCLK_19, 2,
> -				       TUSB6010_ASYNC_CS, TUSB6010_SYNC_CS,
> -				       TUSB6010_DMACHAN);
> -	if (ret != 0)
> -		return;
> -
> -	pr_info("TUSB 6010\n");
> -
> -	return;
> -}
> -#else
> -
> -static void __init n8x0_usb_init(void) {}
> -
> -#endif /*CONFIG_USB_MUSB_TUSB6010 */
> -
> -#if defined(CONFIG_MENELAUS) && IS_ENABLED(CONFIG_MMC_OMAP)
> -
> -/*
> - * On both N800 and N810, only the first of the two MMC controllers is in use.
> - * The two MMC slots are multiplexed via Menelaus companion chip over I2C.
> - * On N800, both slots are powered via Menelaus. On N810, only one of the
> - * slots is powered via Menelaus. The N810 EMMC is powered via GPIO.
> - *
> - * VMMC				slot 1 on both N800 and N810
> - * VDCDC3_APE and VMCS2_APE	slot 2 on N800
> - * GPIO23 and GPIO9		slot 2 EMMC on N810
> - *
> - */
> -static int slot1_cover_open;
> -static int slot2_cover_open;
> -static struct device *mmc_device;
> -
> -static struct gpiod_lookup_table nokia800_mmc_gpio_table = {
> -	.dev_id = "mmci-omap.0",
> -	.table = {
> -		/* Slot switch, GPIO 96 */
> -		GPIO_LOOKUP("gpio-96-127", 0, "switch", GPIO_ACTIVE_HIGH),
> -		{ }
> -	},
> -};
> -
> -static struct gpiod_lookup_table nokia810_mmc_gpio_table = {
> -	.dev_id = "mmci-omap.0",
> -	.table = {
> -		/* Slot switch, GPIO 96 */
> -		GPIO_LOOKUP("gpio-96-127", 0, "switch", GPIO_ACTIVE_HIGH),
> -		/* Slot index 1, VSD power, GPIO 23 */
> -		GPIO_LOOKUP_IDX("gpio-0-31", 23, "vsd", 1, GPIO_ACTIVE_HIGH),
> -		/* Slot index 1, VIO power, GPIO 9 */
> -		GPIO_LOOKUP_IDX("gpio-0-31", 9, "vio", 1, GPIO_ACTIVE_HIGH),
> -		{ }
> -	},
> -};
> -
> -static int n8x0_mmc_set_power_menelaus(struct device *dev, int slot,
> -					int power_on, int vdd)
> -{
> -	int mV;
> -
> -#ifdef CONFIG_MMC_DEBUG
> -	dev_dbg(dev, "Set slot %d power: %s (vdd %d)\n", slot + 1,
> -		str_on_off(power_on), vdd);
> -#endif
> -	if (slot == 0) {
> -		if (!power_on)
> -			return menelaus_set_vmmc(0);
> -		switch (1 << vdd) {
> -		case MMC_VDD_33_34:
> -		case MMC_VDD_32_33:
> -		case MMC_VDD_31_32:
> -			mV = 3100;
> -			break;
> -		case MMC_VDD_30_31:
> -			mV = 3000;
> -			break;
> -		case MMC_VDD_28_29:
> -			mV = 2800;
> -			break;
> -		case MMC_VDD_165_195:
> -			mV = 1850;
> -			break;
> -		default:
> -			BUG();
> -		}
> -		return menelaus_set_vmmc(mV);
> -	} else {
> -		if (!power_on)
> -			return menelaus_set_vdcdc(3, 0);
> -		switch (1 << vdd) {
> -		case MMC_VDD_33_34:
> -		case MMC_VDD_32_33:
> -			mV = 3300;
> -			break;
> -		case MMC_VDD_30_31:
> -		case MMC_VDD_29_30:
> -			mV = 3000;
> -			break;
> -		case MMC_VDD_28_29:
> -		case MMC_VDD_27_28:
> -			mV = 2800;
> -			break;
> -		case MMC_VDD_24_25:
> -		case MMC_VDD_23_24:
> -			mV = 2400;
> -			break;
> -		case MMC_VDD_22_23:
> -		case MMC_VDD_21_22:
> -			mV = 2200;
> -			break;
> -		case MMC_VDD_20_21:
> -			mV = 2000;
> -			break;
> -		case MMC_VDD_165_195:
> -			mV = 1800;
> -			break;
> -		default:
> -			BUG();
> -		}
> -		return menelaus_set_vdcdc(3, mV);
> -	}
> -	return 0;
> -}
> -
> -static int n8x0_mmc_set_power(struct device *dev, int slot, int power_on,
> -			      int vdd)
> -{
> -	if (board_is_n800() || slot == 0)
> -		return n8x0_mmc_set_power_menelaus(dev, slot, power_on, vdd);
> -
> -	/* The n810 power will be handled by GPIO code in the driver */
> -
> -	return 0;
> -}
> -
> -static int n8x0_mmc_set_bus_mode(struct device *dev, int slot, int bus_mode)
> -{
> -	int r;
> -
> -	dev_dbg(dev, "Set slot %d bus mode %s\n", slot + 1,
> -		bus_mode == MMC_BUSMODE_OPENDRAIN ? "open-drain" : "push-pull");
> -	BUG_ON(slot != 0 && slot != 1);
> -	slot++;
> -	switch (bus_mode) {
> -	case MMC_BUSMODE_OPENDRAIN:
> -		r = menelaus_set_mmc_opendrain(slot, 1);
> -		break;
> -	case MMC_BUSMODE_PUSHPULL:
> -		r = menelaus_set_mmc_opendrain(slot, 0);
> -		break;
> -	default:
> -		BUG();
> -	}
> -	if (r != 0 && printk_ratelimit())
> -		dev_err(dev, "MMC: unable to set bus mode for slot %d\n",
> -			slot);
> -	return r;
> -}
> -
> -static int n8x0_mmc_get_cover_state(struct device *dev, int slot)
> -{
> -	slot++;
> -	BUG_ON(slot != 1 && slot != 2);
> -	if (slot == 1)
> -		return slot1_cover_open;
> -	else
> -		return slot2_cover_open;
> -}
> -
> -static void n8x0_mmc_callback(void *data, u8 card_mask)
> -{
> -#ifdef CONFIG_MMC_OMAP
> -	int bit, *openp, index;
> -
> -	if (board_is_n800()) {
> -		bit = 1 << 1;
> -		openp = &slot2_cover_open;
> -		index = 1;
> -	} else {
> -		bit = 1;
> -		openp = &slot1_cover_open;
> -		index = 0;
> -	}
> -
> -	if (card_mask & bit)
> -		*openp = 1;
> -	else
> -		*openp = 0;
> -
> -	omap_mmc_notify_cover_event(mmc_device, index, *openp);
> -#else
> -	pr_warn("MMC: notify cover event not available\n");
> -#endif
> -}
> -
> -static int n8x0_mmc_late_init(struct device *dev)
> -{
> -	int r, bit, *openp;
> -	int vs2sel;
> -
> -	mmc_device = dev;
> -
> -	r = menelaus_set_slot_sel(1);
> -	if (r < 0)
> -		return r;
> -
> -	if (board_is_n800())
> -		vs2sel = 0;
> -	else
> -		vs2sel = 2;
> -
> -	r = menelaus_set_mmc_slot(2, 0, vs2sel, 1);
> -	if (r < 0)
> -		return r;
> -
> -	n8x0_mmc_set_power(dev, 0, MMC_POWER_ON, 16); /* MMC_VDD_28_29 */
> -	n8x0_mmc_set_power(dev, 1, MMC_POWER_ON, 16);
> -
> -	r = menelaus_set_mmc_slot(1, 1, 0, 1);
> -	if (r < 0)
> -		return r;
> -	r = menelaus_set_mmc_slot(2, 1, vs2sel, 1);
> -	if (r < 0)
> -		return r;
> -
> -	r = menelaus_get_slot_pin_states();
> -	if (r < 0)
> -		return r;
> -
> -	if (board_is_n800()) {
> -		bit = 1 << 1;
> -		openp = &slot2_cover_open;
> -	} else {
> -		bit = 1;
> -		openp = &slot1_cover_open;
> -		slot2_cover_open = 0;
> -	}
> -
> -	/* All slot pin bits seem to be inversed until first switch change */
> -	if (r == 0xf || r == (0xf & ~bit))
> -		r = ~r;
> -
> -	if (r & bit)
> -		*openp = 1;
> -	else
> -		*openp = 0;
> -
> -	r = menelaus_register_mmc_callback(n8x0_mmc_callback, NULL);
> -
> -	return r;
> -}
> -
> -static void n8x0_mmc_shutdown(struct device *dev)
> -{
> -	int vs2sel;
> -
> -	if (board_is_n800())
> -		vs2sel = 0;
> -	else
> -		vs2sel = 2;
> -
> -	menelaus_set_mmc_slot(1, 0, 0, 0);
> -	menelaus_set_mmc_slot(2, 0, vs2sel, 0);
> -}
> -
> -static void n8x0_mmc_cleanup(struct device *dev)
> -{
> -	menelaus_unregister_mmc_callback();
> -}
> -
> -/*
> - * MMC controller1 has two slots that are multiplexed via I2C.
> - * MMC controller2 is not in use.
> - */
> -static struct omap_mmc_platform_data mmc1_data = {
> -	.nr_slots			= 0,
> -	.init				= n8x0_mmc_late_init,
> -	.cleanup			= n8x0_mmc_cleanup,
> -	.shutdown			= n8x0_mmc_shutdown,
> -	.max_freq			= 24000000,
> -	.slots[0] = {
> -		.wires			= 4,
> -		.set_power		= n8x0_mmc_set_power,
> -		.set_bus_mode		= n8x0_mmc_set_bus_mode,
> -		.get_cover_state	= n8x0_mmc_get_cover_state,
> -		.ocr_mask		= MMC_VDD_165_195 | MMC_VDD_30_31 |
> -						MMC_VDD_32_33   | MMC_VDD_33_34,
> -		.name			= "internal",
> -	},
> -	.slots[1] = {
> -		.set_power		= n8x0_mmc_set_power,
> -		.set_bus_mode		= n8x0_mmc_set_bus_mode,
> -		.get_cover_state	= n8x0_mmc_get_cover_state,
> -		.ocr_mask		= MMC_VDD_165_195 | MMC_VDD_20_21 |
> -						MMC_VDD_21_22 | MMC_VDD_22_23 |
> -						MMC_VDD_23_24 | MMC_VDD_24_25 |
> -						MMC_VDD_27_28 | MMC_VDD_28_29 |
> -						MMC_VDD_29_30 | MMC_VDD_30_31 |
> -						MMC_VDD_32_33 | MMC_VDD_33_34,
> -		.name			= "external",
> -	},
> -};
> -
> -static struct omap_mmc_platform_data *mmc_data[OMAP24XX_NR_MMC];
> -
> -static void __init n8x0_mmc_init(void)
> -{
> -	if (board_is_n810()) {
> -		mmc1_data.slots[0].name = "external";
> -
> -		/*
> -		 * Some Samsung Movinand chips do not like open-ended
> -		 * multi-block reads and fall to braind-dead state
> -		 * while doing so. Reducing the number of blocks in
> -		 * the transfer or delays in clock disable do not help
> -		 */
> -		mmc1_data.slots[1].name = "internal";
> -		mmc1_data.slots[1].ban_openended = 1;
> -		gpiod_add_lookup_table(&nokia810_mmc_gpio_table);
> -	} else {
> -		gpiod_add_lookup_table(&nokia800_mmc_gpio_table);
> -	}
> -
> -	mmc1_data.nr_slots = 2;
> -	mmc_data[0] = &mmc1_data;
> -}
> -#else
> -static struct omap_mmc_platform_data mmc1_data;
> -static void __init n8x0_mmc_init(void)
> -{
> -}
> -#endif	/* CONFIG_MMC_OMAP */
> -
> -#ifdef CONFIG_MENELAUS
> -
> -static int n8x0_auto_sleep_regulators(void)
> -{
> -	u32 val;
> -	int ret;
> -
> -	val = EN_VPLL_SLEEP | EN_VMMC_SLEEP    \
> -		| EN_VAUX_SLEEP | EN_VIO_SLEEP \
> -		| EN_VMEM_SLEEP | EN_DC3_SLEEP \
> -		| EN_VC_SLEEP | EN_DC2_SLEEP;
> -
> -	ret = menelaus_set_regulator_sleep(1, val);
> -	if (ret < 0) {
> -		pr_err("Could not set regulators to sleep on menelaus: %u\n",
> -		       ret);
> -		return ret;
> -	}
> -	return 0;
> -}
> -
> -static int n8x0_auto_voltage_scale(void)
> -{
> -	int ret;
> -
> -	ret = menelaus_set_vcore_hw(1400, 1050);
> -	if (ret < 0) {
> -		pr_err("Could not set VCORE voltage on menelaus: %u\n", ret);
> -		return ret;
> -	}
> -	return 0;
> -}
> -
> -static int n8x0_menelaus_late_init(struct device *dev)
> -{
> -	int ret;
> -
> -	ret = n8x0_auto_voltage_scale();
> -	if (ret < 0)
> -		return ret;
> -	ret = n8x0_auto_sleep_regulators();
> -	if (ret < 0)
> -		return ret;
> -	return 0;
> -}
> -
> -#else
> -static int n8x0_menelaus_late_init(struct device *dev)
> -{
> -	return 0;
> -}
> -#endif
> -
> -struct menelaus_platform_data n8x0_menelaus_platform_data = {
> -	.late_init = n8x0_menelaus_late_init,
> -};
> -
> -static struct gpiod_lookup_table nokia810_asoc_gpio_table = {
> -	.dev_id = "soc-audio",
> -	.table = {
> -		GPIO_LOOKUP("gpio-0-15", 10, "headset", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("gpio-80-111", 21, "speaker", GPIO_ACTIVE_HIGH),
> -		{ }
> -	},
> -};
> -
> -static int __init n8x0_late_initcall(void)
> -{
> -	if (!board_caps)
> -		return -ENODEV;
> -
> -	n8x0_mmc_init();
> -	n8x0_usb_init();
> -	gpiod_add_lookup_table(&nokia810_asoc_gpio_table);
> -
> -	return 0;
> -}
> -omap_late_initcall(n8x0_late_initcall);
> -
> -/*
> - * Legacy init pdata init for n8x0. Note that we want to follow the
> - * I2C bus numbering starting at 0 for device tree like other omaps.
> - */
> -void * __init n8x0_legacy_init(void)
> -{
> -	board_check_revision();
> -	return &mmc1_data;
> -}
> diff --git a/arch/arm/mach-omap2/clkt2xxx_dpll.c b/arch/arm/mach-omap2/clkt2xxx_dpll.c
> deleted file mode 100644
> index 0edebf3355fa..000000000000
> --- a/arch/arm/mach-omap2/clkt2xxx_dpll.c
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * OMAP2-specific DPLL control functions
> - *
> - * Copyright (C) 2011 Nokia Corporation
> - * Paul Walmsley
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
> -
> -#include "clock.h"
> -#include "cm2xxx.h"
> -#include "cm-regbits-24xx.h"
> -
> -/* Private functions */
> -
> -/**
> - * _allow_idle - enable DPLL autoidle bits
> - * @clk: struct clk * of the DPLL to operate on
> - *
> - * Enable DPLL automatic idle control.  The DPLL will enter low-power
> - * stop when its downstream clocks are gated.  No return value.
> - * REVISIT: DPLL can optionally enter low-power bypass by writing 0x1
> - * instead.  Add some mechanism to optionally enter this mode.
> - */
> -static void _allow_idle(struct clk_hw_omap *clk)
> -{
> -	if (!clk || !clk->dpll_data)
> -		return;
> -
> -	omap2xxx_cm_set_dpll_auto_low_power_stop();
> -}
> -
> -/**
> - * _deny_idle - prevent DPLL from automatically idling
> - * @clk: struct clk * of the DPLL to operate on
> - *
> - * Disable DPLL automatic idle control.  No return value.
> - */
> -static void _deny_idle(struct clk_hw_omap *clk)
> -{
> -	if (!clk || !clk->dpll_data)
> -		return;
> -
> -	omap2xxx_cm_set_dpll_disable_autoidle();
> -}
> -
> -
> -/* Public data */
> -const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll = {
> -	.allow_idle	= _allow_idle,
> -	.deny_idle	= _deny_idle,
> -};
> diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
> deleted file mode 100644
> index 93f6d3cd9525..000000000000
> --- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
> +++ /dev/null
> @@ -1,194 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * DPLL + CORE_CLK composite clock functions
> - *
> - * Copyright (C) 2005-2008 Texas Instruments, Inc.
> - * Copyright (C) 2004-2010 Nokia Corporation
> - *
> - * Contacts:
> - * Richard Woodruff <r-woodruff2@ti.com>
> - * Paul Walmsley
> - *
> - * Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
> - * Gordon McNutt and RidgeRun, Inc.
> - *
> - * XXX The DPLL and CORE clocks should be split into two separate clock
> - * types.
> - */
> -#undef DEBUG
> -
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/clk.h>
> -#include <linux/clk/ti.h>
> -#include <linux/io.h>
> -
> -#include "clock.h"
> -#include "clock2xxx.h"
> -#include "opp2xxx.h"
> -#include "cm2xxx.h"
> -#include "cm-regbits-24xx.h"
> -#include "sdrc.h"
> -#include "sram.h"
> -
> -/* #define DOWN_VARIABLE_DPLL 1 */		/* Experimental */
> -
> -/*
> - * dpll_core_ck: pointer to the combined dpll_ck + core_ck on OMAP2xxx
> - * (currently defined as "dpll_ck" in the OMAP2xxx clock tree).  Set
> - * during dpll_ck init and used later by omap2xxx_clk_get_core_rate().
> - */
> -static struct clk_hw_omap *dpll_core_ck;
> -
> -/**
> - * omap2xxx_clk_get_core_rate - return the CORE_CLK rate
> - *
> - * Returns the CORE_CLK rate.  CORE_CLK can have one of three rate
> - * sources on OMAP2xxx: the DPLL CLKOUT rate, DPLL CLKOUTX2, or 32KHz
> - * (the latter is unusual).  This currently should be called with
> - * struct clk *dpll_ck, which is a composite clock of dpll_ck and
> - * core_ck.
> - */
> -unsigned long omap2xxx_clk_get_core_rate(void)
> -{
> -	long long core_clk;
> -	u32 v;
> -
> -	WARN_ON(!dpll_core_ck);
> -
> -	core_clk = omap2_get_dpll_rate(dpll_core_ck);
> -
> -	v = omap2xxx_cm_get_core_clk_src();
> -
> -	if (v == CORE_CLK_SRC_32K)
> -		core_clk = 32768;
> -	else
> -		core_clk *= v;
> -
> -	return core_clk;
> -}
> -
> -/*
> - * Uses the current prcm set to tell if a rate is valid.
> - * You can go slower, but not faster within a given rate set.
> - */
> -static long omap2_dpllcore_round_rate(unsigned long target_rate)
> -{
> -	u32 high, low, core_clk_src;
> -
> -	core_clk_src = omap2xxx_cm_get_core_clk_src();
> -
> -	if (core_clk_src == CORE_CLK_SRC_DPLL) {	/* DPLL clockout */
> -		high = curr_prcm_set->dpll_speed * 2;
> -		low = curr_prcm_set->dpll_speed;
> -	} else {				/* DPLL clockout x 2 */
> -		high = curr_prcm_set->dpll_speed;
> -		low = curr_prcm_set->dpll_speed / 2;
> -	}
> -
> -#ifdef DOWN_VARIABLE_DPLL
> -	if (target_rate > high)
> -		return high;
> -	else
> -		return target_rate;
> -#else
> -	if (target_rate > low)
> -		return high;
> -	else
> -		return low;
> -#endif
> -
> -}
> -
> -unsigned long omap2_dpllcore_recalc(struct clk_hw *hw,
> -				    unsigned long parent_rate)
> -{
> -	return omap2xxx_clk_get_core_rate();
> -}
> -
> -int omap2_reprogram_dpllcore(struct clk_hw *hw, unsigned long rate,
> -			     unsigned long parent_rate)
> -{
> -	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
> -	u32 cur_rate, low, mult, div, valid_rate, done_rate;
> -	u32 bypass = 0;
> -	struct prcm_config tmpset;
> -	const struct dpll_data *dd;
> -
> -	cur_rate = omap2xxx_clk_get_core_rate();
> -	mult = omap2xxx_cm_get_core_clk_src();
> -
> -	if ((rate == (cur_rate / 2)) && (mult == 2)) {
> -		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
> -	} else if ((rate == (cur_rate * 2)) && (mult == 1)) {
> -		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
> -	} else if (rate != cur_rate) {
> -		valid_rate = omap2_dpllcore_round_rate(rate);
> -		if (valid_rate != rate)
> -			return -EINVAL;
> -
> -		if (mult == 1)
> -			low = curr_prcm_set->dpll_speed;
> -		else
> -			low = curr_prcm_set->dpll_speed / 2;
> -
> -		dd = clk->dpll_data;
> -		if (!dd)
> -			return -EINVAL;
> -
> -		tmpset.cm_clksel1_pll =
> -			omap_clk_ll_ops.clk_readl(&dd->mult_div1_reg);
> -		tmpset.cm_clksel1_pll &= ~(dd->mult_mask |
> -					   dd->div1_mask);
> -		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
> -		tmpset.cm_clksel2_pll = omap2xxx_cm_get_core_pll_config();
> -		tmpset.cm_clksel2_pll &= ~OMAP24XX_CORE_CLK_SRC_MASK;
> -		if (rate > low) {
> -			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL_X2;
> -			mult = ((rate / 2) / 1000000);
> -			done_rate = CORE_CLK_SRC_DPLL_X2;
> -		} else {
> -			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL;
> -			mult = (rate / 1000000);
> -			done_rate = CORE_CLK_SRC_DPLL;
> -		}
> -		tmpset.cm_clksel1_pll |= (div << __ffs(dd->mult_mask));
> -		tmpset.cm_clksel1_pll |= (mult << __ffs(dd->div1_mask));
> -
> -		/* Worst case */
> -		tmpset.base_sdrc_rfr = SDRC_RFR_CTRL_BYPASS;
> -
> -		if (rate == curr_prcm_set->xtal_speed)	/* If asking for 1-1 */
> -			bypass = 1;
> -
> -		/* For omap2xxx_sdrc_init_params() */
> -		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
> -
> -		/* Force dll lock mode */
> -		omap2_set_prcm(tmpset.cm_clksel1_pll, tmpset.base_sdrc_rfr,
> -			       bypass);
> -
> -		/* Errata: ret dll entry state */
> -		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
> -		omap2xxx_sdrc_reprogram(done_rate, 0);
> -	}
> -
> -	return 0;
> -}
> -
> -/**
> - * omap2xxx_clkt_dpllcore_init - clk init function for dpll_ck
> - * @clk: struct clk *dpll_ck
> - *
> - * Store a local copy of @clk in dpll_core_ck so other code can query
> - * the core rate without having to clk_get(), which can sleep.  Must
> - * only be called once.  No return value.  XXX If the clock
> - * registration process is ever changed such that dpll_ck is no longer
> - * statically defined, this code may need to change to increment some
> - * kind of use count on dpll_ck.
> - */
> -void omap2xxx_clkt_dpllcore_init(struct clk_hw *hw)
> -{
> -	WARN(dpll_core_ck, "dpll_core_ck already set - should never happen");
> -	dpll_core_ck = to_clk_hw_omap(hw);
> -}
> diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
> deleted file mode 100644
> index 2b04e422b46c..000000000000
> --- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
> +++ /dev/null
> @@ -1,259 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * OMAP2xxx DVFS virtual clock functions
> - *
> - * Copyright (C) 2005-2008, 2012 Texas Instruments, Inc.
> - * Copyright (C) 2004-2010 Nokia Corporation
> - *
> - * Contacts:
> - * Richard Woodruff <r-woodruff2@ti.com>
> - * Paul Walmsley
> - *
> - * Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
> - * Gordon McNutt and RidgeRun, Inc.
> - *
> - * XXX Some of this code should be replaceable by the upcoming OPP layer
> - * code.  However, some notion of "rate set" is probably still necessary
> - * for OMAP2xxx at least.  Rate sets should be generalized so they can be
> - * used for any OMAP chip, not just OMAP2xxx.  In particular, Richard Woodruff
> - * has in the past expressed a preference to use rate sets for OPP changes,
> - * rather than dynamically recalculating the clock tree, so if someone wants
> - * this badly enough to write the code to handle it, we should support it
> - * as an option.
> - */
> -#undef DEBUG
> -
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
> -#include <linux/cpufreq.h>
> -#include <linux/slab.h>
> -
> -#include "soc.h"
> -#include "clock.h"
> -#include "clock2xxx.h"
> -#include "opp2xxx.h"
> -#include "cm2xxx.h"
> -#include "cm-regbits-24xx.h"
> -#include "sdrc.h"
> -#include "sram.h"
> -
> -static u16 cpu_mask;
> -
> -const struct prcm_config *curr_prcm_set;
> -const struct prcm_config *rate_table;
> -
> -/*
> - * sys_ck_rate: the rate of the external high-frequency clock
> - * oscillator on the board.  Set by the SoC-specific clock init code.
> - * Once set during a boot, will not change.
> - */
> -static unsigned long sys_ck_rate;
> -
> -/**
> - * omap2_table_mpu_recalc - just return the MPU speed
> - * @clk: virt_prcm_set struct clk
> - *
> - * Set virt_prcm_set's rate to the mpu_speed field of the current PRCM set.
> - */
> -static unsigned long omap2_table_mpu_recalc(struct clk_hw *clk,
> -				     unsigned long parent_rate)
> -{
> -	return curr_prcm_set->mpu_speed;
> -}
> -
> -/*
> - * Look for a rate equal or less than the target rate given a configuration set.
> - *
> - * What's not entirely clear is "which" field represents the key field.
> - * Some might argue L3-DDR, others ARM, others IVA. This code is simple and
> - * just uses the ARM rates.
> - */
> -static int omap2_determine_rate_to_table(struct clk_hw *hw,
> -					 struct clk_rate_request *req)
> -{
> -	const struct prcm_config *ptr;
> -	long highest_rate;
> -
> -	highest_rate = -EINVAL;
> -
> -	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
> -		if (!(ptr->flags & cpu_mask))
> -			continue;
> -		if (ptr->xtal_speed != sys_ck_rate)
> -			continue;
> -
> -		highest_rate = ptr->mpu_speed;
> -
> -		/* Can check only after xtal frequency check */
> -		if (ptr->mpu_speed <= req->rate)
> -			break;
> -	}
> -	req->rate = highest_rate;
> -
> -	return 0;
> -}
> -
> -/* Sets basic clocks based on the specified rate */
> -static int omap2_select_table_rate(struct clk_hw *hw, unsigned long rate,
> -				   unsigned long parent_rate)
> -{
> -	u32 cur_rate, done_rate, bypass = 0;
> -	const struct prcm_config *prcm;
> -	unsigned long found_speed = 0;
> -	unsigned long flags;
> -
> -	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
> -		if (!(prcm->flags & cpu_mask))
> -			continue;
> -
> -		if (prcm->xtal_speed != sys_ck_rate)
> -			continue;
> -
> -		if (prcm->mpu_speed <= rate) {
> -			found_speed = prcm->mpu_speed;
> -			break;
> -		}
> -	}
> -
> -	if (!found_speed) {
> -		printk(KERN_INFO "Could not set MPU rate to %luMHz\n",
> -		       rate / 1000000);
> -		return -EINVAL;
> -	}
> -
> -	curr_prcm_set = prcm;
> -	cur_rate = omap2xxx_clk_get_core_rate();
> -
> -	if (prcm->dpll_speed == cur_rate / 2) {
> -		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
> -	} else if (prcm->dpll_speed == cur_rate * 2) {
> -		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
> -	} else if (prcm->dpll_speed != cur_rate) {
> -		local_irq_save(flags);
> -
> -		if (prcm->dpll_speed == prcm->xtal_speed)
> -			bypass = 1;
> -
> -		if ((prcm->cm_clksel2_pll & OMAP24XX_CORE_CLK_SRC_MASK) ==
> -		    CORE_CLK_SRC_DPLL_X2)
> -			done_rate = CORE_CLK_SRC_DPLL_X2;
> -		else
> -			done_rate = CORE_CLK_SRC_DPLL;
> -
> -		omap2xxx_cm_set_mod_dividers(prcm->cm_clksel_mpu,
> -					     prcm->cm_clksel_dsp,
> -					     prcm->cm_clksel_gfx,
> -					     prcm->cm_clksel1_core,
> -					     prcm->cm_clksel_mdm);
> -
> -		/* x2 to enter omap2xxx_sdrc_init_params() */
> -		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
> -
> -		omap2_set_prcm(prcm->cm_clksel1_pll, prcm->base_sdrc_rfr,
> -			       bypass);
> -
> -		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
> -		omap2xxx_sdrc_reprogram(done_rate, 0);
> -
> -		local_irq_restore(flags);
> -	}
> -
> -	return 0;
> -}
> -
> -/**
> - * omap2xxx_clkt_vps_check_bootloader_rates - determine which of the rate
> - * table sets matches the current CORE DPLL hardware rate
> - *
> - * Check the MPU rate set by bootloader.  Sets the 'curr_prcm_set'
> - * global to point to the active rate set when found; otherwise, sets
> - * it to NULL.  No return value;
> - */
> -static void omap2xxx_clkt_vps_check_bootloader_rates(void)
> -{
> -	const struct prcm_config *prcm = NULL;
> -	unsigned long rate;
> -
> -	rate = omap2xxx_clk_get_core_rate();
> -	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
> -		if (!(prcm->flags & cpu_mask))
> -			continue;
> -		if (prcm->xtal_speed != sys_ck_rate)
> -			continue;
> -		if (prcm->dpll_speed <= rate)
> -			break;
> -	}
> -	curr_prcm_set = prcm;
> -}
> -
> -/**
> - * omap2xxx_clkt_vps_late_init - store a copy of the sys_ck rate
> - *
> - * Store a copy of the sys_ck rate for later use by the OMAP2xxx DVFS
> - * code.  (The sys_ck rate does not -- or rather, must not -- change
> - * during kernel runtime.)  Must be called after we have a valid
> - * sys_ck rate, but before the virt_prcm_set clock rate is
> - * recalculated.  No return value.
> - */
> -static void omap2xxx_clkt_vps_late_init(void)
> -{
> -	struct clk *c;
> -
> -	c = clk_get(NULL, "sys_ck");
> -	if (IS_ERR(c)) {
> -		WARN(1, "could not locate sys_ck\n");
> -	} else {
> -		sys_ck_rate = clk_get_rate(c);
> -		clk_put(c);
> -	}
> -}
> -
> -#ifdef CONFIG_OF
> -#include <linux/clk-provider.h>
> -#include <linux/clkdev.h>
> -
> -static const struct clk_ops virt_prcm_set_ops = {
> -	.recalc_rate	= &omap2_table_mpu_recalc,
> -	.set_rate	= &omap2_select_table_rate,
> -	.determine_rate = &omap2_determine_rate_to_table,
> -};
> -
> -/**
> - * omap2xxx_clkt_vps_init - initialize virt_prcm_set clock
> - *
> - * Does a manual init for the virtual prcm DVFS clock for OMAP2. This
> - * function is called only from omap2 DT clock init, as the virtual
> - * node is not modelled in the DT clock data.
> - */
> -void omap2xxx_clkt_vps_init(void)
> -{
> -	struct clk_init_data init = { NULL };
> -	struct clk_hw_omap *hw = NULL;
> -	struct clk *clk;
> -	const char *parent_name = "mpu_ck";
> -
> -	omap2xxx_clkt_vps_late_init();
> -	omap2xxx_clkt_vps_check_bootloader_rates();
> -
> -	hw = kzalloc_obj(*hw);
> -	if (!hw)
> -		return;
> -	init.name = "virt_prcm_set";
> -	init.ops = &virt_prcm_set_ops;
> -	init.parent_names = &parent_name;
> -	init.num_parents = 1;
> -
> -	hw->hw.init = &init;
> -
> -	clk = clk_register(NULL, &hw->hw);
> -	if (IS_ERR(clk)) {
> -		printk(KERN_ERR "Failed to register clock\n");
> -		kfree(hw);
> -		return;
> -	}
> -
> -	clkdev_create(clk, "cpufreq_ck", NULL);
> -}
> -#endif
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 83fae51722a9..b73a80503da8 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -30,9 +30,7 @@
>   #include "clockdomain.h"
>   #include "clock.h"
>   #include "cm.h"
> -#include "cm2xxx.h"
>   #include "cm3xxx.h"
> -#include "cm-regbits-24xx.h"
>   #include "cm-regbits-34xx.h"
>   #include "common.h"
>   
> @@ -94,11 +92,7 @@ void __init ti_clk_init_features(void)
>   	}
>   
>   	/* Bypass value setup for DPLLs */
> -	if (cpu_is_omap24xx()) {
> -		features.dpll_bypass_vals |=
> -			(1 << OMAP2XXX_EN_DPLL_LPBYPASS) |
> -			(1 << OMAP2XXX_EN_DPLL_FRBYPASS);
> -	} else if (cpu_is_omap34xx()) {
> +	if (cpu_is_omap34xx()) {
>   		features.dpll_bypass_vals |=
>   			(1 << OMAP3XXX_EN_DPLL_LPBYPASS) |
>   			(1 << OMAP3XXX_EN_DPLL_FRBYPASS);
> @@ -122,9 +116,7 @@ void __init ti_clk_init_features(void)
>   	 * 34xx reverses this, just to keep us on our toes
>   	 * AM35xx uses both, depending on the module.
>   	 */
> -	if (cpu_is_omap24xx())
> -		features.cm_idlest_val = OMAP24XX_CM_IDLEST_VAL;
> -	else if (cpu_is_omap34xx())
> +	if (cpu_is_omap34xx())
>   		features.cm_idlest_val = OMAP34XX_CM_IDLEST_VAL;
>   
>   	/* On OMAP3430 ES1.0, DPLL4 can't be re-programmed */
> diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
> deleted file mode 100644
> index 73c011dadfd2..000000000000
> --- a/arch/arm/mach-omap2/clock2xxx.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * OMAP2 clock function prototypes and macros
> - *
> - * Copyright (C) 2005-2010 Texas Instruments, Inc.
> - * Copyright (C) 2004-2010 Nokia Corporation
> - */
> -
> -#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK2XXX_H
> -#define __ARCH_ARM_MACH_OMAP2_CLOCK2XXX_H
> -
> -#include <linux/clk-provider.h>
> -#include "clock.h"
> -
> -unsigned long omap2xxx_clk_get_core_rate(void);
> -
> -#endif
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index 69dc5b839335..4b5ae1f40d50 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -1213,7 +1213,7 @@ int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
>   int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh)
>   {
>   	/* The clkdm attribute does not exist yet prior OMAP4 */
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +	if (cpu_is_omap34xx())
>   		return 0;
>   
>   	/*
> @@ -1244,7 +1244,7 @@ int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh)
>   int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
>   {
>   	/* The clkdm attribute does not exist yet prior OMAP4 */
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +	if (cpu_is_omap34xx())
>   		return 0;
>   
>   	if (!oh)
> diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
> index 86a2f9e5d0ef..2d422b5f121f 100644
> --- a/arch/arm/mach-omap2/clockdomain.h
> +++ b/arch/arm/mach-omap2/clockdomain.h
> @@ -216,8 +216,6 @@ int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh);
>   void clkdm_save_context(void);
>   void clkdm_restore_context(void);
>   
> -extern void __init omap242x_clockdomains_init(void);
> -extern void __init omap243x_clockdomains_init(void);
>   extern void __init omap3xxx_clockdomains_init(void);
>   extern void __init am33xx_clockdomains_init(void);
>   extern void __init ti814x_clockdomains_init(void);
> @@ -230,14 +228,11 @@ void am43xx_clockdomains_init(void);
>   extern void clkdm_add_autodeps(struct clockdomain *clkdm);
>   extern void clkdm_del_autodeps(struct clockdomain *clkdm);
>   
> -extern struct clkdm_ops omap2_clkdm_operations;
>   extern struct clkdm_ops omap3_clkdm_operations;
>   extern struct clkdm_ops omap4_clkdm_operations;
>   extern struct clkdm_ops am33xx_clkdm_operations;
>   extern struct clkdm_ops am43xx_clkdm_operations;
>   
> -extern struct clkdm_dep gfx_24xx_wkdeps[];
> -extern struct clkdm_dep dsp_24xx_wkdeps[];
>   extern struct clockdomain wkup_common_clkdm;
>   
>   #endif
> diff --git a/arch/arm/mach-omap2/clockdomains2420_data.c b/arch/arm/mach-omap2/clockdomains2420_data.c
> deleted file mode 100644
> index ac4ffb5d2ffc..000000000000
> --- a/arch/arm/mach-omap2/clockdomains2420_data.c
> +++ /dev/null
> @@ -1,154 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * OMAP2420 clockdomains
> - *
> - * Copyright (C) 2008-2011 Texas Instruments, Inc.
> - * Copyright (C) 2008-2010 Nokia Corporation
> - *
> - * Paul Walmsley, Jouni Högander
> - *
> - * This file contains clockdomains and clockdomain wakeup dependencies
> - * for OMAP2420 chips.  Some notes:
> - *
> - * A useful validation rule for struct clockdomain: Any clockdomain
> - * referenced by a wkdep_srcs must have a dep_bit assigned.  So
> - * wkdep_srcs are really just software-controllable dependencies.
> - * Non-software-controllable dependencies do exist, but they are not
> - * encoded below (yet).
> - *
> - * 24xx does not support programmable sleep dependencies (SLEEPDEP)
> - *
> - * The overly-specific dep_bit names are due to a bit name collision
> - * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP shift
> - * value are the same for all powerdomains: 2
> - *
> - * XXX should dep_bit be a mask, so we can test to see if it is 0 as a
> - * sanity check?
> - * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
> - */
> -
> -/*
> - * To-Do List
> - * -> Port the Sleep/Wakeup dependencies for the domains
> - *    from the Power domain framework
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/io.h>
> -
> -#include "soc.h"
> -#include "clockdomain.h"
> -#include "prm2xxx_3xxx.h"
> -#include "cm2xxx_3xxx.h"
> -#include "cm-regbits-24xx.h"
> -#include "prm-regbits-24xx.h"
> -
> -/*
> - * Clockdomain dependencies for wkdeps
> - *
> - * XXX Hardware dependencies (e.g., dependencies that cannot be
> - * changed in software) are not included here yet, but should be.
> - */
> -
> -/* Wakeup dependency source arrays */
> -
> -/* 2420-specific possible wakeup dependencies */
> -
> -/* 2420 PM_WKDEP_MPU: CORE, DSP, WKUP */
> -static struct clkdm_dep mpu_2420_wkdeps[] = {
> -	{ .clkdm_name = "core_l3_clkdm" },
> -	{ .clkdm_name = "core_l4_clkdm" },
> -	{ .clkdm_name = "dsp_clkdm" },
> -	{ .clkdm_name = "wkup_clkdm" },
> -	{ NULL },
> -};
> -
> -/* 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP */
> -static struct clkdm_dep core_2420_wkdeps[] = {
> -	{ .clkdm_name = "dsp_clkdm" },
> -	{ .clkdm_name = "gfx_clkdm" },
> -	{ .clkdm_name = "mpu_clkdm" },
> -	{ .clkdm_name = "wkup_clkdm" },
> -	{ NULL },
> -};
> -
> -/*
> - * 2420-only clockdomains
> - */
> -
> -static struct clockdomain mpu_2420_clkdm = {
> -	.name		= "mpu_clkdm",
> -	.pwrdm		= { .name = "mpu_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP,
> -	.wkdep_srcs	= mpu_2420_wkdeps,
> -	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
> -};
> -
> -static struct clockdomain iva1_2420_clkdm = {
> -	.name		= "iva1_clkdm",
> -	.pwrdm		= { .name = "dsp_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> -	.dep_bit	= OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
> -	.wkdep_srcs	= dsp_24xx_wkdeps,
> -	.clktrctrl_mask = OMAP2420_AUTOSTATE_IVA_MASK,
> -};
> -
> -static struct clockdomain dsp_2420_clkdm = {
> -	.name		= "dsp_clkdm",
> -	.pwrdm		= { .name = "dsp_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> -	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
> -};
> -
> -static struct clockdomain gfx_2420_clkdm = {
> -	.name		= "gfx_clkdm",
> -	.pwrdm		= { .name = "gfx_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> -	.wkdep_srcs	= gfx_24xx_wkdeps,
> -	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
> -};
> -
> -static struct clockdomain core_l3_2420_clkdm = {
> -	.name		= "core_l3_clkdm",
> -	.pwrdm		= { .name = "core_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP,
> -	.wkdep_srcs	= core_2420_wkdeps,
> -	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
> -};
> -
> -static struct clockdomain core_l4_2420_clkdm = {
> -	.name		= "core_l4_clkdm",
> -	.pwrdm		= { .name = "core_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP,
> -	.wkdep_srcs	= core_2420_wkdeps,
> -	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
> -};
> -
> -static struct clockdomain dss_2420_clkdm = {
> -	.name		= "dss_clkdm",
> -	.pwrdm		= { .name = "core_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP,
> -	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSS_MASK,
> -};
> -
> -static struct clockdomain *clockdomains_omap242x[] __initdata = {
> -	&wkup_common_clkdm,
> -	&mpu_2420_clkdm,
> -	&iva1_2420_clkdm,
> -	&dsp_2420_clkdm,
> -	&gfx_2420_clkdm,
> -	&core_l3_2420_clkdm,
> -	&core_l4_2420_clkdm,
> -	&dss_2420_clkdm,
> -	NULL,
> -};
> -
> -void __init omap242x_clockdomains_init(void)
> -{
> -	if (!cpu_is_omap242x())
> -		return;
> -
> -	clkdm_register_platform_funcs(&omap2_clkdm_operations);
> -	clkdm_register_clkdms(clockdomains_omap242x);
> -	clkdm_complete_init();
> -}
> diff --git a/arch/arm/mach-omap2/clockdomains2430_data.c b/arch/arm/mach-omap2/clockdomains2430_data.c
> deleted file mode 100644
> index 0e97e178abaa..000000000000
> --- a/arch/arm/mach-omap2/clockdomains2430_data.c
> +++ /dev/null
> @@ -1,181 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * OMAP2xxx clockdomains
> - *
> - * Copyright (C) 2008-2009 Texas Instruments, Inc.
> - * Copyright (C) 2008-2010 Nokia Corporation
> - *
> - * Paul Walmsley, Jouni Högander
> - *
> - * This file contains clockdomains and clockdomain wakeup dependencies
> - * for OMAP2xxx chips.  Some notes:
> - *
> - * A useful validation rule for struct clockdomain: Any clockdomain
> - * referenced by a wkdep_srcs must have a dep_bit assigned.  So
> - * wkdep_srcs are really just software-controllable dependencies.
> - * Non-software-controllable dependencies do exist, but they are not
> - * encoded below (yet).
> - *
> - * 24xx does not support programmable sleep dependencies (SLEEPDEP)
> - *
> - * The overly-specific dep_bit names are due to a bit name collision
> - * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP shift
> - * value are the same for all powerdomains: 2
> - *
> - * XXX should dep_bit be a mask, so we can test to see if it is 0 as a
> - * sanity check?
> - * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
> - */
> -
> -/*
> - * To-Do List
> - * -> Port the Sleep/Wakeup dependencies for the domains
> - *    from the Power domain framework
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/io.h>
> -
> -#include "soc.h"
> -#include "clockdomain.h"
> -#include "prm2xxx_3xxx.h"
> -#include "cm2xxx_3xxx.h"
> -#include "cm-regbits-24xx.h"
> -#include "prm-regbits-24xx.h"
> -
> -/*
> - * Clockdomain dependencies for wkdeps
> - *
> - * XXX Hardware dependencies (e.g., dependencies that cannot be
> - * changed in software) are not included here yet, but should be.
> - */
> -
> -/* Wakeup dependency source arrays */
> -
> -/* 2430-specific possible wakeup dependencies */
> -
> -/* 2430 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP, MDM */
> -static struct clkdm_dep core_2430_wkdeps[] = {
> -	{ .clkdm_name = "dsp_clkdm" },
> -	{ .clkdm_name = "gfx_clkdm" },
> -	{ .clkdm_name = "mpu_clkdm" },
> -	{ .clkdm_name = "wkup_clkdm" },
> -	{ .clkdm_name = "mdm_clkdm" },
> -	{ NULL },
> -};
> -
> -/* 2430 PM_WKDEP_MPU: CORE, DSP, WKUP, MDM */
> -static struct clkdm_dep mpu_2430_wkdeps[] = {
> -	{ .clkdm_name = "core_l3_clkdm" },
> -	{ .clkdm_name = "core_l4_clkdm" },
> -	{ .clkdm_name = "dsp_clkdm" },
> -	{ .clkdm_name = "wkup_clkdm" },
> -	{ .clkdm_name = "mdm_clkdm" },
> -	{ NULL },
> -};
> -
> -/* 2430 PM_WKDEP_MDM: CORE, MPU, WKUP */
> -static struct clkdm_dep mdm_2430_wkdeps[] = {
> -	{ .clkdm_name = "core_l3_clkdm" },
> -	{ .clkdm_name = "core_l4_clkdm" },
> -	{ .clkdm_name = "mpu_clkdm" },
> -	{ .clkdm_name = "wkup_clkdm" },
> -	{ NULL },
> -};
> -
> -/*
> - * 2430-only clockdomains
> - */
> -
> -static struct clockdomain mpu_2430_clkdm = {
> -	.name		= "mpu_clkdm",
> -	.pwrdm		= { .name = "mpu_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> -	.wkdep_srcs	= mpu_2430_wkdeps,
> -	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
> -};
> -
> -/* Another case of bit name collisions between several registers: EN_MDM */
> -static struct clockdomain mdm_clkdm = {
> -	.name		= "mdm_clkdm",
> -	.pwrdm		= { .name = "mdm_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> -	.dep_bit	= OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
> -	.wkdep_srcs	= mdm_2430_wkdeps,
> -	.clktrctrl_mask = OMAP2430_AUTOSTATE_MDM_MASK,
> -};
> -
> -static struct clockdomain dsp_2430_clkdm = {
> -	.name		= "dsp_clkdm",
> -	.pwrdm		= { .name = "dsp_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> -	.dep_bit	= OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
> -	.wkdep_srcs	= dsp_24xx_wkdeps,
> -	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
> -};
> -
> -static struct clockdomain gfx_2430_clkdm = {
> -	.name		= "gfx_clkdm",
> -	.pwrdm		= { .name = "gfx_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> -	.wkdep_srcs	= gfx_24xx_wkdeps,
> -	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
> -};
> -
> -/*
> - * XXX add usecounting for clkdm dependencies, otherwise the presence
> - * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
> - * could cause trouble
> - */
> -static struct clockdomain core_l3_2430_clkdm = {
> -	.name		= "core_l3_clkdm",
> -	.pwrdm		= { .name = "core_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP,
> -	.dep_bit	= OMAP24XX_EN_CORE_SHIFT,
> -	.wkdep_srcs	= core_2430_wkdeps,
> -	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
> -};
> -
> -/*
> - * XXX add usecounting for clkdm dependencies, otherwise the presence
> - * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
> - * could cause trouble
> - */
> -static struct clockdomain core_l4_2430_clkdm = {
> -	.name		= "core_l4_clkdm",
> -	.pwrdm		= { .name = "core_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP,
> -	.dep_bit	= OMAP24XX_EN_CORE_SHIFT,
> -	.wkdep_srcs	= core_2430_wkdeps,
> -	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
> -};
> -
> -static struct clockdomain dss_2430_clkdm = {
> -	.name		= "dss_clkdm",
> -	.pwrdm		= { .name = "core_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP,
> -	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSS_MASK,
> -};
> -
> -static struct clockdomain *clockdomains_omap243x[] __initdata = {
> -	&wkup_common_clkdm,
> -	&mpu_2430_clkdm,
> -	&mdm_clkdm,
> -	&dsp_2430_clkdm,
> -	&gfx_2430_clkdm,
> -	&core_l3_2430_clkdm,
> -	&core_l4_2430_clkdm,
> -	&dss_2430_clkdm,
> -	NULL,
> -};
> -
> -void __init omap243x_clockdomains_init(void)
> -{
> -	if (!cpu_is_omap243x())
> -		return;
> -
> -	clkdm_register_platform_funcs(&omap2_clkdm_operations);
> -	clkdm_register_clkdms(clockdomains_omap243x);
> -	clkdm_complete_init();
> -}
> -
> diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
> index 220c22f5e0f5..4d20c2720660 100644
> --- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
> @@ -8,7 +8,7 @@
>    * Paul Walmsley, Jouni Högander
>    *
>    * This file contains clockdomains and clockdomain wakeup/sleep
> - * dependencies for the OMAP2/3 chips.  Some notes:
> + * dependencies for the OMAP3 chips.  Some notes:
>    *
>    * A useful validation rule for struct clockdomain: Any clockdomain
>    * referenced by a wkdep_srcs or sleepdep_srcs array must have a
> @@ -16,8 +16,6 @@
>    * software-controllable dependencies.  Non-software-controllable
>    * dependencies do exist, but they are not encoded below (yet).
>    *
> - * 24xx does not support programmable sleep dependencies (SLEEPDEP)
> - *
>    * The overly-specific dep_bit names are due to a bit name collision
>    * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP shift
>    * value are the same for all powerdomains: 2
> @@ -39,10 +37,8 @@
>   #include "clockdomain.h"
>   #include "prm2xxx_3xxx.h"
>   #include "cm2xxx_3xxx.h"
> -#include "cm-regbits-24xx.h"
>   #include "cm-regbits-34xx.h"
>   #include "cm-regbits-44xx.h"
> -#include "prm-regbits-24xx.h"
>   #include "prm-regbits-34xx.h"
>   
>   /*
> @@ -54,29 +50,8 @@
>   
>   /* Wakeup dependency source arrays */
>   
> -/* 2xxx-specific possible dependencies */
> -
> -/* 2xxx PM_WKDEP_GFX: CORE, MPU, WKUP */
> -struct clkdm_dep gfx_24xx_wkdeps[] = {
> -	{ .clkdm_name = "core_l3_clkdm" },
> -	{ .clkdm_name = "core_l4_clkdm" },
> -	{ .clkdm_name = "mpu_clkdm" },
> -	{ .clkdm_name = "wkup_clkdm" },
> -	{ NULL },
> -};
> -
> -/* 2xxx PM_WKDEP_DSP: CORE, MPU, WKUP */
> -struct clkdm_dep dsp_24xx_wkdeps[] = {
> -	{ .clkdm_name = "core_l3_clkdm" },
> -	{ .clkdm_name = "core_l4_clkdm" },
> -	{ .clkdm_name = "mpu_clkdm" },
> -	{ .clkdm_name = "wkup_clkdm" },
> -	{ NULL },
> -};
> -
> -
>   /*
> - * OMAP2/3-common clockdomains
> + * OMAP3-common clockdomains
>    *
>    * Even though the 2420 has a single PRCM module from the
>    * interconnect's perspective, internally it does appear to have
> diff --git a/arch/arm/mach-omap2/cm-regbits-24xx.h b/arch/arm/mach-omap2/cm-regbits-24xx.h
> deleted file mode 100644
> index 59c14dbb6f87..000000000000
> --- a/arch/arm/mach-omap2/cm-regbits-24xx.h
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -#ifndef __ARCH_ARM_MACH_OMAP2_CM_REGBITS_24XX_H
> -#define __ARCH_ARM_MACH_OMAP2_CM_REGBITS_24XX_H
> -
> -/*
> - * OMAP24XX Clock Management register bits
> - *
> - * Copyright (C) 2007 Texas Instruments, Inc.
> - * Copyright (C) 2007 Nokia Corporation
> - *
> - * Written by Paul Walmsley
> - */
> -
> -#define OMAP24XX_AUTOSTATE_MPU_MASK			(1 << 0)
> -#define OMAP24XX_EN_DSS1_MASK				(1 << 0)
> -#define OMAP24XX_ST_MAILBOXES_SHIFT			30
> -#define OMAP24XX_ST_HDQ_SHIFT				23
> -#define OMAP2420_ST_I2C2_SHIFT				20
> -#define OMAP2430_ST_I2CHS1_SHIFT			19
> -#define OMAP2420_ST_I2C1_SHIFT				19
> -#define OMAP2430_ST_I2CHS2_SHIFT			20
> -#define OMAP24XX_ST_MCBSP2_SHIFT			16
> -#define OMAP24XX_ST_MCBSP1_SHIFT			15
> -#define OMAP2430_ST_MCBSP5_SHIFT			5
> -#define OMAP2430_ST_MCBSP4_SHIFT			4
> -#define OMAP2430_ST_MCBSP3_SHIFT			3
> -#define OMAP24XX_ST_AES_SHIFT				3
> -#define OMAP24XX_ST_RNG_SHIFT				2
> -#define OMAP24XX_ST_SHA_SHIFT				1
> -#define OMAP24XX_CLKSEL_DSS2_MASK			(0x1 << 13)
> -#define OMAP24XX_AUTOSTATE_DSS_MASK			(1 << 2)
> -#define OMAP24XX_AUTOSTATE_L4_MASK			(1 << 1)
> -#define OMAP24XX_AUTOSTATE_L3_MASK			(1 << 0)
> -#define OMAP24XX_AUTOSTATE_GFX_MASK			(1 << 0)
> -#define OMAP24XX_ST_MPU_WDT_SHIFT			3
> -#define OMAP24XX_ST_32KSYNC_SHIFT			1
> -#define OMAP24XX_EN_54M_PLL_SHIFT			6
> -#define OMAP24XX_EN_96M_PLL_SHIFT			2
> -#define OMAP24XX_ST_54M_APLL_SHIFT			9
> -#define OMAP24XX_ST_96M_APLL_SHIFT			8
> -#define OMAP24XX_AUTO_54M_MASK				(0x3 << 6)
> -#define OMAP24XX_AUTO_96M_MASK				(0x3 << 2)
> -#define OMAP24XX_AUTO_DPLL_SHIFT			0
> -#define OMAP24XX_AUTO_DPLL_MASK				(0x3 << 0)
> -#define OMAP24XX_CORE_CLK_SRC_MASK			(0x3 << 0)
> -#define OMAP2420_AUTOSTATE_IVA_MASK			(1 << 8)
> -#define OMAP24XX_AUTOSTATE_DSP_MASK			(1 << 0)
> -#define OMAP2430_AUTOSTATE_MDM_MASK			(1 << 0)
> -#define OMAP24XX_CLKSTCTRL_DISABLE_AUTO		0x0
> -#define OMAP24XX_CLKSTCTRL_ENABLE_AUTO		0x1
> -#endif
> diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
> deleted file mode 100644
> index 1c6d69f4bf49..000000000000
> --- a/arch/arm/mach-omap2/cm2xxx.c
> +++ /dev/null
> @@ -1,302 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * OMAP2xxx CM module functions
> - *
> - * Copyright (C) 2009 Nokia Corporation
> - * Copyright (C) 2008-2010, 2012 Texas Instruments, Inc.
> - * Paul Walmsley
> - * Rajendra Nayak <rnayak@ti.com>
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/delay.h>
> -#include <linux/errno.h>
> -#include <linux/err.h>
> -#include <linux/io.h>
> -
> -#include "prm2xxx.h"
> -#include "cm.h"
> -#include "cm2xxx.h"
> -#include "cm-regbits-24xx.h"
> -#include "clockdomain.h"
> -
> -/* CM_AUTOIDLE_PLL.AUTO_* bit values for DPLLs */
> -#define DPLL_AUTOIDLE_DISABLE				0x0
> -#define OMAP2XXX_DPLL_AUTOIDLE_LOW_POWER_STOP		0x3
> -
> -/* CM_AUTOIDLE_PLL.AUTO_* bit values for APLLs (OMAP2xxx only) */
> -#define OMAP2XXX_APLL_AUTOIDLE_DISABLE			0x0
> -#define OMAP2XXX_APLL_AUTOIDLE_LOW_POWER_STOP		0x3
> -
> -/* CM_IDLEST_PLL bit value offset for APLLs (OMAP2xxx only) */
> -#define EN_APLL_LOCKED					3
> -
> -static const u8 omap2xxx_cm_idlest_offs[] = {
> -	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3, OMAP24XX_CM_IDLEST4
> -};
> -
> -/*
> - *
> - */
> -
> -static void _write_clktrctrl(u8 c, s16 module, u32 mask)
> -{
> -	u32 v;
> -
> -	v = omap2_cm_read_mod_reg(module, OMAP2_CM_CLKSTCTRL);
> -	v &= ~mask;
> -	v |= c << __ffs(mask);
> -	omap2_cm_write_mod_reg(v, module, OMAP2_CM_CLKSTCTRL);
> -}
> -
> -static bool omap2xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask)
> -{
> -	u32 v;
> -
> -	v = omap2_cm_read_mod_reg(module, OMAP2_CM_CLKSTCTRL);
> -	v &= mask;
> -	v >>= __ffs(mask);
> -
> -	return (v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO) ? 1 : 0;
> -}
> -
> -static void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask)
> -{
> -	_write_clktrctrl(OMAP24XX_CLKSTCTRL_ENABLE_AUTO, module, mask);
> -}
> -
> -static void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask)
> -{
> -	_write_clktrctrl(OMAP24XX_CLKSTCTRL_DISABLE_AUTO, module, mask);
> -}
> -
> -/*
> - * DPLL autoidle control
> - */
> -
> -static void _omap2xxx_set_dpll_autoidle(u8 m)
> -{
> -	u32 v;
> -
> -	v = omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
> -	v &= ~OMAP24XX_AUTO_DPLL_MASK;
> -	v |= m << OMAP24XX_AUTO_DPLL_SHIFT;
> -	omap2_cm_write_mod_reg(v, PLL_MOD, CM_AUTOIDLE);
> -}
> -
> -void omap2xxx_cm_set_dpll_disable_autoidle(void)
> -{
> -	_omap2xxx_set_dpll_autoidle(OMAP2XXX_DPLL_AUTOIDLE_LOW_POWER_STOP);
> -}
> -
> -void omap2xxx_cm_set_dpll_auto_low_power_stop(void)
> -{
> -	_omap2xxx_set_dpll_autoidle(DPLL_AUTOIDLE_DISABLE);
> -}
> -
> -/**
> - * omap2xxx_cm_split_idlest_reg - split CM_IDLEST reg addr into its components
> - * @idlest_reg: CM_IDLEST* virtual address
> - * @prcm_inst: pointer to an s16 to return the PRCM instance offset
> - * @idlest_reg_id: pointer to a u8 to return the CM_IDLESTx register ID
> - *
> - * XXX This function is only needed until absolute register addresses are
> - * removed from the OMAP struct clk records.
> - */
> -static int omap2xxx_cm_split_idlest_reg(struct clk_omap_reg *idlest_reg,
> -					s16 *prcm_inst,
> -					u8 *idlest_reg_id)
> -{
> -	unsigned long offs;
> -	u8 idlest_offs;
> -	int i;
> -
> -	idlest_offs = idlest_reg->offset & 0xff;
> -	for (i = 0; i < ARRAY_SIZE(omap2xxx_cm_idlest_offs); i++) {
> -		if (idlest_offs == omap2xxx_cm_idlest_offs[i]) {
> -			*idlest_reg_id = i + 1;
> -			break;
> -		}
> -	}
> -
> -	if (i == ARRAY_SIZE(omap2xxx_cm_idlest_offs))
> -		return -EINVAL;
> -
> -	offs = idlest_reg->offset;
> -	offs &= 0xff00;
> -	*prcm_inst = offs;
> -
> -	return 0;
> -}
> -
> -/*
> - *
> - */
> -
> -/**
> - * omap2xxx_cm_wait_module_ready - wait for a module to leave idle or standby
> - * @part: PRCM partition, ignored for OMAP2
> - * @prcm_mod: PRCM module offset
> - * @idlest_id: CM_IDLESTx register ID (i.e., x = 1, 2, 3)
> - * @idlest_shift: shift of the bit in the CM_IDLEST* register to check
> - *
> - * Wait for the PRCM to indicate that the module identified by
> - * (@prcm_mod, @idlest_id, @idlest_shift) is clocked.  Return 0 upon
> - * success or -EBUSY if the module doesn't enable in time.
> - */
> -static int omap2xxx_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_id,
> -					 u8 idlest_shift)
> -{
> -	int ena = 0, i = 0;
> -	u8 cm_idlest_reg;
> -	u32 mask;
> -
> -	if (!idlest_id || (idlest_id > ARRAY_SIZE(omap2xxx_cm_idlest_offs)))
> -		return -EINVAL;
> -
> -	cm_idlest_reg = omap2xxx_cm_idlest_offs[idlest_id - 1];
> -
> -	mask = 1 << idlest_shift;
> -	ena = mask;
> -
> -	omap_test_timeout(((omap2_cm_read_mod_reg(prcm_mod, cm_idlest_reg) &
> -			    mask) == ena), MAX_MODULE_READY_TIME, i);
> -
> -	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
> -}
> -
> -/* Clockdomain low-level functions */
> -
> -static void omap2xxx_clkdm_allow_idle(struct clockdomain *clkdm)
> -{
> -	omap2xxx_cm_clkdm_enable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
> -				       clkdm->clktrctrl_mask);
> -}
> -
> -static void omap2xxx_clkdm_deny_idle(struct clockdomain *clkdm)
> -{
> -	omap2xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
> -					clkdm->clktrctrl_mask);
> -}
> -
> -static int omap2xxx_clkdm_clk_enable(struct clockdomain *clkdm)
> -{
> -	bool hwsup = false;
> -
> -	if (!clkdm->clktrctrl_mask)
> -		return 0;
> -
> -	hwsup = omap2xxx_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
> -					      clkdm->clktrctrl_mask);
> -	if (!hwsup && clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
> -		omap2xxx_clkdm_wakeup(clkdm);
> -
> -	return 0;
> -}
> -
> -static int omap2xxx_clkdm_clk_disable(struct clockdomain *clkdm)
> -{
> -	bool hwsup = false;
> -
> -	if (!clkdm->clktrctrl_mask)
> -		return 0;
> -
> -	hwsup = omap2xxx_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
> -					      clkdm->clktrctrl_mask);
> -
> -	if (!hwsup && clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
> -		omap2xxx_clkdm_sleep(clkdm);
> -
> -	return 0;
> -}
> -
> -struct clkdm_ops omap2_clkdm_operations = {
> -	.clkdm_add_wkdep	= omap2_clkdm_add_wkdep,
> -	.clkdm_del_wkdep	= omap2_clkdm_del_wkdep,
> -	.clkdm_read_wkdep	= omap2_clkdm_read_wkdep,
> -	.clkdm_clear_all_wkdeps	= omap2_clkdm_clear_all_wkdeps,
> -	.clkdm_sleep		= omap2xxx_clkdm_sleep,
> -	.clkdm_wakeup		= omap2xxx_clkdm_wakeup,
> -	.clkdm_allow_idle	= omap2xxx_clkdm_allow_idle,
> -	.clkdm_deny_idle	= omap2xxx_clkdm_deny_idle,
> -	.clkdm_clk_enable	= omap2xxx_clkdm_clk_enable,
> -	.clkdm_clk_disable	= omap2xxx_clkdm_clk_disable,
> -};
> -
> -int omap2xxx_cm_fclks_active(void)
> -{
> -	u32 f1, f2;
> -
> -	f1 = omap2_cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
> -	f2 = omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
> -
> -	return (f1 | f2) ? 1 : 0;
> -}
> -
> -int omap2xxx_cm_mpu_retention_allowed(void)
> -{
> -	u32 l;
> -
> -	/* Check for MMC, UART2, UART1, McSPI2, McSPI1 and DSS1. */
> -	l = omap2_cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
> -	if (l & (OMAP2420_EN_MMC_MASK | OMAP24XX_EN_UART2_MASK |
> -		 OMAP24XX_EN_UART1_MASK | OMAP24XX_EN_MCSPI2_MASK |
> -		 OMAP24XX_EN_MCSPI1_MASK | OMAP24XX_EN_DSS1_MASK))
> -		return 0;
> -	/* Check for UART3. */
> -	l = omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
> -	if (l & OMAP24XX_EN_UART3_MASK)
> -		return 0;
> -
> -	return 1;
> -}
> -
> -u32 omap2xxx_cm_get_core_clk_src(void)
> -{
> -	u32 v;
> -
> -	v = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
> -	v &= OMAP24XX_CORE_CLK_SRC_MASK;
> -
> -	return v;
> -}
> -
> -u32 omap2xxx_cm_get_core_pll_config(void)
> -{
> -	return omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
> -}
> -
> -void omap2xxx_cm_set_mod_dividers(u32 mpu, u32 dsp, u32 gfx, u32 core, u32 mdm)
> -{
> -	u32 tmp;
> -
> -	omap2_cm_write_mod_reg(mpu, MPU_MOD, CM_CLKSEL);
> -	omap2_cm_write_mod_reg(dsp, OMAP24XX_DSP_MOD, CM_CLKSEL);
> -	omap2_cm_write_mod_reg(gfx, GFX_MOD, CM_CLKSEL);
> -	tmp = omap2_cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) &
> -		OMAP24XX_CLKSEL_DSS2_MASK;
> -	omap2_cm_write_mod_reg(core | tmp, CORE_MOD, CM_CLKSEL1);
> -	if (mdm)
> -		omap2_cm_write_mod_reg(mdm, OMAP2430_MDM_MOD, CM_CLKSEL);
> -}
> -
> -/*
> - *
> - */
> -
> -static const struct cm_ll_data omap2xxx_cm_ll_data = {
> -	.split_idlest_reg	= &omap2xxx_cm_split_idlest_reg,
> -	.wait_module_ready	= &omap2xxx_cm_wait_module_ready,
> -};
> -
> -int __init omap2xxx_cm_init(const struct omap_prcm_init_data *data)
> -{
> -	return cm_register(&omap2xxx_cm_ll_data);
> -}
> -
> -static void __exit omap2xxx_cm_exit(void)
> -{
> -	cm_unregister(&omap2xxx_cm_ll_data);
> -}
> -__exitcall(omap2xxx_cm_exit);
> diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
> deleted file mode 100644
> index 7cbeff15ffb0..000000000000
> --- a/arch/arm/mach-omap2/cm2xxx.h
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * OMAP2xxx Clock Management (CM) register definitions
> - *
> - * Copyright (C) 2007-2009, 2012 Texas Instruments, Inc.
> - * Copyright (C) 2007-2010 Nokia Corporation
> - * Paul Walmsley
> - *
> - * The CM hardware modules on the OMAP2/3 are quite similar to each
> - * other.  The CM modules/instances on OMAP4 are quite different, so
> - * they are handled in a separate file.
> - */
> -#ifndef __ARCH_ASM_MACH_OMAP2_CM2XXX_H
> -#define __ARCH_ASM_MACH_OMAP2_CM2XXX_H
> -
> -#include "prcm-common.h"
> -#include "cm2xxx_3xxx.h"
> -
> -#define OMAP2420_CM_REGADDR(module, reg)				\
> -			OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
> -#define OMAP2430_CM_REGADDR(module, reg)				\
> -			OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
> -
> -/*
> - * Module specific CM register offsets from CM_BASE + domain offset
> - * Use cm_{read,write}_mod_reg() with these registers.
> - * These register offsets generally appear in more than one PRCM submodule.
> - */
> -
> -/* OMAP2-specific register offsets */
> -
> -#define OMAP24XX_CM_FCLKEN2				0x0004
> -#define OMAP24XX_CM_ICLKEN4				0x001c
> -#define OMAP24XX_CM_AUTOIDLE4				0x003c
> -#define OMAP24XX_CM_IDLEST4				0x002c
> -
> -/* CM_IDLEST bit field values to indicate deasserted IdleReq */
> -
> -#define OMAP24XX_CM_IDLEST_VAL				0
> -
> -
> -/* Clock management domain register get/set */
> -
> -#ifndef __ASSEMBLER__
> -
> -extern void omap2xxx_cm_set_dpll_disable_autoidle(void);
> -extern void omap2xxx_cm_set_dpll_auto_low_power_stop(void);
> -
> -extern int omap2xxx_cm_fclks_active(void);
> -extern int omap2xxx_cm_mpu_retention_allowed(void);
> -extern u32 omap2xxx_cm_get_core_clk_src(void);
> -extern u32 omap2xxx_cm_get_core_pll_config(void);
> -extern void omap2xxx_cm_set_mod_dividers(u32 mpu, u32 dsp, u32 gfx, u32 core,
> -					 u32 mdm);
> -
> -int __init omap2xxx_cm_init(const struct omap_prcm_init_data *data);
> -
> -#endif
> -
> -#endif
> diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
> index 87f2c2d2d754..fc16cd1fd2d5 100644
> --- a/arch/arm/mach-omap2/cm_common.c
> +++ b/arch/arm/mach-omap2/cm_common.c
> @@ -15,7 +15,6 @@
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   
> -#include "cm2xxx.h"
>   #include "cm3xxx.h"
>   #include "cm33xx.h"
>   #include "cm44xx.h"
> @@ -230,14 +229,6 @@ static struct omap_prcm_init_data cm2_data __initdata = {
>   };
>   #endif
>   
> -#ifdef CONFIG_ARCH_OMAP2
> -static struct omap_prcm_init_data omap2_prcm_data __initdata = {
> -	.index = TI_CLKM_CM,
> -	.init = omap2xxx_cm_init,
> -	.flags = CM_NO_CLOCKS | CM_SINGLE_INSTANCE,
> -};
> -#endif
> -
>   #ifdef CONFIG_ARCH_OMAP3
>   static struct omap_prcm_init_data omap3_cm_data __initdata = {
>   	.index = TI_CLKM_CM,
> @@ -269,9 +260,6 @@ static struct omap_prcm_init_data am4_prcm_data __initdata = {
>   #endif
>   
>   static const struct of_device_id omap_cm_dt_match_table[] __initconst = {
> -#ifdef CONFIG_ARCH_OMAP2
> -	{ .compatible = "ti,omap2-prcm", .data = &omap2_prcm_data },
> -#endif
>   #ifdef CONFIG_ARCH_OMAP3
>   	{ .compatible = "ti,omap3-cm", .data = &omap3_cm_data },
>   #endif
> diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
> deleted file mode 100644
> index 69694af71475..000000000000
> --- a/arch/arm/mach-omap2/common-board-devices.h
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __OMAP_COMMON_BOARD_DEVICES__
> -#define __OMAP_COMMON_BOARD_DEVICES__
> -
> -#include <linux/mfd/menelaus.h>
> -
> -void *n8x0_legacy_init(void);
> -
> -extern struct menelaus_platform_data n8x0_menelaus_platform_data;
> -
> -#endif /* __OMAP_COMMON_BOARD_DEVICES__ */
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 9d60799e9752..f8ed97044ade 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -102,8 +102,6 @@ static inline void omap5_realtime_timer_init(void)
>   }
>   #endif
>   
> -void omap2420_init_early(void);
> -void omap2430_init_early(void);
>   void omap3430_init_early(void);
>   void omap3630_init_early(void);
>   void am33xx_init_early(void);
> @@ -130,14 +128,6 @@ static inline void omap_soc_device_init(void)
>   }
>   #endif
>   
> -#if defined(CONFIG_SOC_OMAP2420) || defined(CONFIG_SOC_OMAP2430)
> -void omap2xxx_restart(enum reboot_mode mode, const char *cmd);
> -#else
> -static inline void omap2xxx_restart(enum reboot_mode mode, const char *cmd)
> -{
> -}
> -#endif
> -
>   #ifdef CONFIG_SOC_AM33XX
>   void am33xx_restart(enum reboot_mode mode, const char *cmd);
>   #else
> @@ -183,8 +173,6 @@ static inline void omap_barrier_reserve_memblock(void)
>   /* This gets called from mach-omap2/io.c, do not call this */
>   void __init omap2_set_globals_tap(u32 class, void __iomem *tap);
>   
> -void __init omap242x_map_io(void);
> -void __init omap243x_map_io(void);
>   void __init omap3_map_io(void);
>   void __init am33xx_map_io(void);
>   void __init omap4_map_io(void);
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> index 7e7440533bf9..3ab1c6e6dde6 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -19,19 +19,11 @@
>   #include "am33xx.h"
>   
>   #ifndef __ASSEMBLY__
> -#define OMAP242X_CTRL_REGADDR(reg)					\
> -		OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
> -#define OMAP243X_CTRL_REGADDR(reg)					\
> -		OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
>   #define OMAP343X_CTRL_REGADDR(reg)					\
>   		OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
>   #define AM33XX_CTRL_REGADDR(reg)					\
>   		AM33XX_L4_WK_IO_ADDRESS(AM33XX_SCM_BASE + (reg))
>   #else
> -#define OMAP242X_CTRL_REGADDR(reg)					\
> -		OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
> -#define OMAP243X_CTRL_REGADDR(reg)					\
> -		OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
>   #define OMAP343X_CTRL_REGADDR(reg)					\
>   		OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
>   #define AM33XX_CTRL_REGADDR(reg)					\
> @@ -74,52 +66,6 @@
>   #define OMAP2_CONTROL_RPUB_KEY_H_2	(OMAP2_CONTROL_GENERAL + 0x0098)
>   #define OMAP2_CONTROL_RPUB_KEY_H_3	(OMAP2_CONTROL_GENERAL + 0x009c)
>   
> -/* 242x-only CONTROL_GENERAL register offsets */
> -#define OMAP242X_CONTROL_DEVCONF	OMAP2_CONTROL_DEVCONF0 /* match TRM */
> -#define OMAP242X_CONTROL_OCM_RAM_PERM	(OMAP2_CONTROL_GENERAL + 0x0068)
> -
> -/* 243x-only CONTROL_GENERAL register offsets */
> -/* CONTROL_IVA2_BOOT{ADDR,MOD} are at the same place on 343x - noted below */
> -#define OMAP243X_CONTROL_DEVCONF1	(OMAP2_CONTROL_GENERAL + 0x0078)
> -#define OMAP243X_CONTROL_CSIRXFE	(OMAP2_CONTROL_GENERAL + 0x007c)
> -#define OMAP243X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
> -#define OMAP243X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
> -#define OMAP243X_CONTROL_IVA2_GEMCFG	(OMAP2_CONTROL_GENERAL + 0x0198)
> -#define OMAP243X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x0230)
> -
> -/* 24xx-only CONTROL_GENERAL register offsets */
> -#define OMAP24XX_CONTROL_DEBOBS		(OMAP2_CONTROL_GENERAL + 0x0000)
> -#define OMAP24XX_CONTROL_EMU_SUPPORT	(OMAP2_CONTROL_GENERAL + 0x0008)
> -#define OMAP24XX_CONTROL_SEC_TEST	(OMAP2_CONTROL_GENERAL + 0x0044)
> -#define OMAP24XX_CONTROL_PSA_CTRL	(OMAP2_CONTROL_GENERAL + 0x0048)
> -#define OMAP24XX_CONTROL_PSA_CMD	(OMAP2_CONTROL_GENERAL + 0x004c)
> -#define OMAP24XX_CONTROL_PSA_VALUE	(OMAP2_CONTROL_GENERAL + 0x0050)
> -#define OMAP24XX_CONTROL_SEC_EMU	(OMAP2_CONTROL_GENERAL + 0x0060)
> -#define OMAP24XX_CONTROL_SEC_TAP	(OMAP2_CONTROL_GENERAL + 0x0064)
> -#define OMAP24XX_CONTROL_OCM_PUB_RAM_ADD	(OMAP2_CONTROL_GENERAL + 0x006c)
> -#define OMAP24XX_CONTROL_EXT_SEC_RAM_START_ADD	(OMAP2_CONTROL_GENERAL + 0x0070)
> -#define OMAP24XX_CONTROL_EXT_SEC_RAM_STOP_ADD	(OMAP2_CONTROL_GENERAL + 0x0074)
> -#define OMAP24XX_CONTROL_SEC_STATUS		(OMAP2_CONTROL_GENERAL + 0x0080)
> -#define OMAP24XX_CONTROL_SEC_ERR_STATUS		(OMAP2_CONTROL_GENERAL + 0x0084)
> -#define OMAP24XX_CONTROL_STATUS			(OMAP2_CONTROL_GENERAL + 0x0088)
> -#define OMAP24XX_CONTROL_GENERAL_PURPOSE_STATUS	(OMAP2_CONTROL_GENERAL + 0x008c)
> -#define OMAP24XX_CONTROL_RAND_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00a0)
> -#define OMAP24XX_CONTROL_RAND_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00a4)
> -#define OMAP24XX_CONTROL_RAND_KEY_2	(OMAP2_CONTROL_GENERAL + 0x00a8)
> -#define OMAP24XX_CONTROL_RAND_KEY_3	(OMAP2_CONTROL_GENERAL + 0x00ac)
> -#define OMAP24XX_CONTROL_CUST_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00b0)
> -#define OMAP24XX_CONTROL_CUST_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00b4)
> -#define OMAP24XX_CONTROL_TEST_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00c0)
> -#define OMAP24XX_CONTROL_TEST_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00c4)
> -#define OMAP24XX_CONTROL_TEST_KEY_2	(OMAP2_CONTROL_GENERAL + 0x00c8)
> -#define OMAP24XX_CONTROL_TEST_KEY_3	(OMAP2_CONTROL_GENERAL + 0x00cc)
> -#define OMAP24XX_CONTROL_TEST_KEY_4	(OMAP2_CONTROL_GENERAL + 0x00d0)
> -#define OMAP24XX_CONTROL_TEST_KEY_5	(OMAP2_CONTROL_GENERAL + 0x00d4)
> -#define OMAP24XX_CONTROL_TEST_KEY_6	(OMAP2_CONTROL_GENERAL + 0x00d8)
> -#define OMAP24XX_CONTROL_TEST_KEY_7	(OMAP2_CONTROL_GENERAL + 0x00dc)
> -#define OMAP24XX_CONTROL_TEST_KEY_8	(OMAP2_CONTROL_GENERAL + 0x00e0)
> -#define OMAP24XX_CONTROL_TEST_KEY_9	(OMAP2_CONTROL_GENERAL + 0x00e4)
> -
>   #define OMAP343X_CONTROL_PADCONF_SYSNIRQ (OMAP2_CONTROL_INTERFACE + 0x01b0)
>   
>   /* 34xx-only CONTROL_GENERAL register offsets */
> @@ -311,14 +257,12 @@
>    */
>   /* CONTROL_DEVCONF0 bits */
>   #define OMAP2_MMCSDIO1ADPCLKISEL	(1 << 24) /* MMC1 loop back clock */
> -#define OMAP24XX_USBSTANDBYCTRL		(1 << 15)
>   #define OMAP2_MCBSP2_CLKS_MASK		(1 << 6)
>   #define OMAP2_MCBSP1_FSR_MASK		(1 << 4)
>   #define OMAP2_MCBSP1_CLKR_MASK		(1 << 3)
>   #define OMAP2_MCBSP1_CLKS_MASK		(1 << 2)
>   
>   /* CONTROL_DEVCONF1 bits */
> -#define OMAP243X_MMC1_ACTIVE_OVERWRITE	(1 << 31)
>   #define OMAP2_MMCSDIO2ADPCLKISEL	(1 << 6) /* MMC2 loop back clock */
>   #define OMAP2_MCBSP5_CLKS_MASK		(1 << 4) /* > 242x */
>   #define OMAP2_MCBSP4_CLKS_MASK		(1 << 2) /* > 242x */
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index dbec3bb9fbf4..addc14898bd5 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -124,9 +124,7 @@ static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
>   
>   static enum omapdss_version __init omap_display_get_version(void)
>   {
> -	if (cpu_is_omap24xx())
> -		return OMAPDSS_VER_OMAP24xx;
> -	else if (cpu_is_omap3630())
> +	if (cpu_is_omap3630())
>   		return OMAPDSS_VER_OMAP3630;
>   	else if (cpu_is_omap34xx()) {
>   		if (soc_is_am35xx()) {
> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> index 830cd4e7eb44..3a6b7b4620ca 100644
> --- a/arch/arm/mach-omap2/dma.c
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -82,39 +82,6 @@ static unsigned configure_dma_errata(void)
>   {
>   	unsigned errata = 0;
>   
> -	/*
> -	 * Errata applicable for OMAP2430ES1.0 and all omap2420
> -	 *
> -	 * I.
> -	 * Erratum ID: Not Available
> -	 * Inter Frame DMA buffering issue DMA will wrongly
> -	 * buffer elements if packing and bursting is enabled. This might
> -	 * result in data gets stalled in FIFO at the end of the block.
> -	 * Workaround: DMA channels must have BUFFERING_DISABLED bit set to
> -	 * guarantee no data will stay in the DMA FIFO in case inter frame
> -	 * buffering occurs
> -	 *
> -	 * II.
> -	 * Erratum ID: Not Available
> -	 * DMA may hang when several channels are used in parallel
> -	 * In the following configuration, DMA channel hanging can occur:
> -	 * a. Channel i, hardware synchronized, is enabled
> -	 * b. Another channel (Channel x), software synchronized, is enabled.
> -	 * c. Channel i is disabled before end of transfer
> -	 * d. Channel i is reenabled.
> -	 * e. Steps 1 to 4 are repeated a certain number of times.
> -	 * f. A third channel (Channel y), software synchronized, is enabled.
> -	 * Channel x and Channel y may hang immediately after step 'f'.
> -	 * Workaround:
> -	 * For any channel used - make sure NextLCH_ID is set to the value j.
> -	 */
> -	if (cpu_is_omap2420() || (cpu_is_omap2430() &&
> -				(omap_type() == OMAP2430_REV_ES1_0))) {
> -
> -		SET_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING);
> -		SET_DMA_ERRATA(DMA_ERRATA_PARALLEL_CHANNELS);
> -	}
> -
>   	/*
>   	 * Erratum ID: i378: OMAP2+: sDMA Channel is not disabled
>   	 * after a transaction error.
> @@ -162,16 +129,6 @@ static unsigned configure_dma_errata(void)
>   	return errata;
>   }
>   
> -static const struct dma_slave_map omap24xx_sdma_dt_map[] = {
> -	/* external DMA requests when tusb6010 is used */
> -	{ "musb-hdrc.1.auto", "dmareq0", SDMA_FILTER_PARAM(2) },
> -	{ "musb-hdrc.1.auto", "dmareq1", SDMA_FILTER_PARAM(3) },
> -	{ "musb-hdrc.1.auto", "dmareq2", SDMA_FILTER_PARAM(14) }, /* OMAP2420 only */
> -	{ "musb-hdrc.1.auto", "dmareq3", SDMA_FILTER_PARAM(15) }, /* OMAP2420 only */
> -	{ "musb-hdrc.1.auto", "dmareq4", SDMA_FILTER_PARAM(16) }, /* OMAP2420 only */
> -	{ "musb-hdrc.1.auto", "dmareq5", SDMA_FILTER_PARAM(64) }, /* OMAP2420 only */
> -};
> -
>   static struct omap_dma_dev_attr dma_attr = {
>   	.dev_caps = RESERVE_CHANNEL | DMA_LINKED_LCH | GLOBAL_PRIORITY |
>   		    IS_CSSA_32 | IS_CDSA_32,
> @@ -188,15 +145,7 @@ struct omap_system_dma_plat_info dma_plat_info = {
>   static int __init omap2_system_dma_init(void)
>   {
>   	dma_plat_info.errata = configure_dma_errata();
> -
> -	if (soc_is_omap24xx()) {
> -		/* DMA slave map for drivers not yet converted to DT */
> -		dma_plat_info.slave_map = omap24xx_sdma_dt_map;
> -		dma_plat_info.slavecnt = ARRAY_SIZE(omap24xx_sdma_dt_map);
> -	}
> -
> -	if (!soc_is_omap242x())
> -		dma_attr.dev_caps |= IS_RW_PRIORITY;
> +	dma_attr.dev_caps |= IS_RW_PRIORITY;
>   
>   	if (soc_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
>   		dma_attr.dev_caps |= HS_CHANNELS_RESERVED;
> diff --git a/arch/arm/mach-omap2/fb.c b/arch/arm/mach-omap2/fb.c
> index 0f8c8efe3ae8..9a425c36f996 100644
> --- a/arch/arm/mach-omap2/fb.c
> +++ b/arch/arm/mach-omap2/fb.c
> @@ -27,15 +27,6 @@
>    * The first memory resource is the register region for VRFB,
>    * the rest are VRFB virtual memory areas for each VRFB context.
>    */
> -
> -static const struct resource omap2_vrfb_resources[] = {
> -	DEFINE_RES_MEM_NAMED(0x68008000u, 0x40, "vrfb-regs"),
> -	DEFINE_RES_MEM_NAMED(0x70000000u, 0x4000000, "vrfb-area-0"),
> -	DEFINE_RES_MEM_NAMED(0x74000000u, 0x4000000, "vrfb-area-1"),
> -	DEFINE_RES_MEM_NAMED(0x78000000u, 0x4000000, "vrfb-area-2"),
> -	DEFINE_RES_MEM_NAMED(0x7c000000u, 0x4000000, "vrfb-area-3"),
> -};
> -
>   static const struct resource omap3_vrfb_resources[] = {
>   	DEFINE_RES_MEM_NAMED(0x6C000180u, 0xc0, "vrfb-regs"),
>   	DEFINE_RES_MEM_NAMED(0x70000000u, 0x4000000, "vrfb-area-0"),
> @@ -58,10 +49,7 @@ int __init omap_init_vrfb(void)
>   	const struct resource *res;
>   	unsigned int num_res;
>   
> -	if (cpu_is_omap24xx()) {
> -		res = omap2_vrfb_resources;
> -		num_res = ARRAY_SIZE(omap2_vrfb_resources);
> -	} else if (cpu_is_omap34xx()) {
> +	if (cpu_is_omap34xx()) {
>   		res = omap3_vrfb_resources;
>   		num_res = ARRAY_SIZE(omap3_vrfb_resources);
>   	} else {
> diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
> deleted file mode 100644
> index e060f1b5c27d..000000000000
> --- a/arch/arm/mach-omap2/gpmc.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * General-Purpose Memory Controller for OMAP2
> - *
> - * Copyright (C) 2005-2006 Nokia Corporation
> - *
> - * Do not include this file in any new code, this will get removed
> - * once omap3 boots in device tree only mode.
> - */
> -#include <linux/omap-gpmc.h>
> diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
> index 3b4b9514f4fa..d956c70f8899 100644
> --- a/arch/arm/mach-omap2/i2c.c
> +++ b/arch/arm/mach-omap2/i2c.c
> @@ -39,7 +39,7 @@ int omap_i2c_reset(struct omap_hwmod *oh)
>   	u16 i2c_con;
>   	int c = 0;
>   
> -	if (soc_is_omap24xx() || soc_is_omap34xx() || soc_is_am35xx())
> +	if (soc_is_omap34xx() || soc_is_am35xx())
>   		i2c_con = OMAP2_I2C_CON_OFFSET;
>   	else
>   		i2c_con = OMAP4_I2C_CON_OFFSET;
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index cf2bfb447ee2..3e731dd21311 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -55,9 +55,7 @@ int omap_type(void)
>   	if (val < OMAP2_DEVICETYPE_MASK)
>   		return val;
>   
> -	if (soc_is_omap24xx()) {
> -		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
> -	} else if (soc_is_ti81xx()) {
> +	if (soc_is_ti81xx()) {
>   		val = omap_ctrl_readl(TI81XX_CONTROL_STATUS);
>   	} else if (soc_is_am33xx() || soc_is_am43xx()) {
>   		val = omap_ctrl_readl(AM33XX_CONTROL_STATUS);
> @@ -99,22 +97,6 @@ EXPORT_SYMBOL(omap_type);
>   
>   #define read_tap_reg(reg)	readl_relaxed(tap_base  + (reg))
>   
> -struct omap_id {
> -	u16	hawkeye;	/* Silicon type (Hawkeye id) */
> -	u8	dev;		/* Device type from production_id reg */
> -	u32	type;		/* Combined type id copied to omap_revision */
> -};
> -
> -/* Register values to detect the OMAP version */
> -static struct omap_id omap_ids[] __initdata = {
> -	{ .hawkeye = 0xb5d9, .dev = 0x0, .type = 0x24200024 },
> -	{ .hawkeye = 0xb5d9, .dev = 0x1, .type = 0x24201024 },
> -	{ .hawkeye = 0xb5d9, .dev = 0x2, .type = 0x24202024 },
> -	{ .hawkeye = 0xb5d9, .dev = 0x4, .type = 0x24220024 },
> -	{ .hawkeye = 0xb5d9, .dev = 0x8, .type = 0x24230024 },
> -	{ .hawkeye = 0xb68a, .dev = 0x0, .type = 0x24300024 },
> -};
> -
>   static void __iomem *tap_base;
>   static u16 tap_prod_id;
>   
> @@ -145,62 +127,6 @@ static int __init omap_feed_randpool(void)
>   }
>   omap_device_initcall(omap_feed_randpool);
>   
> -void __init omap2xxx_check_revision(void)
> -{
> -	int i, j;
> -	u32 idcode, prod_id;
> -	u16 hawkeye;
> -	u8  dev_type, rev;
> -	struct omap_die_id odi;
> -
> -	idcode = read_tap_reg(OMAP_TAP_IDCODE);
> -	prod_id = read_tap_reg(tap_prod_id);
> -	hawkeye = (idcode >> 12) & 0xffff;
> -	rev = (idcode >> 28) & 0x0f;
> -	dev_type = (prod_id >> 16) & 0x0f;
> -	omap_get_die_id(&odi);
> -
> -	pr_debug("OMAP_TAP_IDCODE 0x%08x REV %i HAWKEYE 0x%04x MANF %03x\n",
> -		 idcode, rev, hawkeye, (idcode >> 1) & 0x7ff);
> -	pr_debug("OMAP_TAP_DIE_ID_0: 0x%08x\n", odi.id_0);
> -	pr_debug("OMAP_TAP_DIE_ID_1: 0x%08x DEV_REV: %i\n",
> -		 odi.id_1, (odi.id_1 >> 28) & 0xf);
> -	pr_debug("OMAP_TAP_DIE_ID_2: 0x%08x\n", odi.id_2);
> -	pr_debug("OMAP_TAP_DIE_ID_3: 0x%08x\n", odi.id_3);
> -	pr_debug("OMAP_TAP_PROD_ID_0: 0x%08x DEV_TYPE: %i\n",
> -		 prod_id, dev_type);
> -
> -	/* Check hawkeye ids */
> -	for (i = 0; i < ARRAY_SIZE(omap_ids); i++) {
> -		if (hawkeye == omap_ids[i].hawkeye)
> -			break;
> -	}
> -
> -	if (i == ARRAY_SIZE(omap_ids)) {
> -		printk(KERN_ERR "Unknown OMAP CPU id\n");
> -		return;
> -	}
> -
> -	for (j = i; j < ARRAY_SIZE(omap_ids); j++) {
> -		if (dev_type == omap_ids[j].dev)
> -			break;
> -	}
> -
> -	if (j == ARRAY_SIZE(omap_ids)) {
> -		pr_err("Unknown OMAP device type. Handling it as OMAP%04x\n",
> -		       omap_ids[i].type >> 16);
> -		j = i;
> -	}
> -
> -	sprintf(soc_name, "OMAP%04x", omap_rev() >> 16);
> -	sprintf(soc_rev, "ES%x", (omap_rev() >> 12) & 0xf);
> -
> -	pr_info("%s", soc_name);
> -	if ((omap_rev() >> 8) & 0x0f)
> -		pr_cont("%s", soc_rev);
> -	pr_cont("\n");
> -}
> -
>   #define OMAP3_SHOW_FEATURE(feat)		\
>   	if (omap3_has_ ##feat())		\
>   		n += scnprintf(buf + n, sizeof(buf) - n, #feat " ");
> @@ -750,9 +676,7 @@ static const char * const omap_types[] = {
>   
>   static const char * __init omap_get_family(void)
>   {
> -	if (soc_is_omap24xx())
> -		return kasprintf(GFP_KERNEL, "OMAP2");
> -	else if (soc_is_omap34xx())
> +	if (soc_is_omap34xx())
>   		return kasprintf(GFP_KERNEL, "OMAP3");
>   	else if (soc_is_omap44xx())
>   		return kasprintf(GFP_KERNEL, "OMAP4");
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 14ec3f78000b..1c945be5e7cc 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -35,7 +35,6 @@
>   #include "sdrc.h"
>   #include "control.h"
>   #include "sram.h"
> -#include "cm2xxx.h"
>   #include "cm3xxx.h"
>   #include "cm33xx.h"
>   #include "cm44xx.h"
> @@ -43,11 +42,9 @@
>   #include "cm.h"
>   #include "prcm_mpu44xx.h"
>   #include "prminst44xx.h"
> -#include "prm2xxx.h"
>   #include "prm3xxx.h"
>   #include "prm33xx.h"
>   #include "prm44xx.h"
> -#include "opp2xxx.h"
>   #include "omap-secure.h"
>   
>   /*
> @@ -61,76 +58,6 @@ static int (*omap_clk_soc_init)(void);
>    * default mapping provided here.
>    */
>   
> -#if defined(CONFIG_SOC_OMAP2420) || defined(CONFIG_SOC_OMAP2430)
> -static struct map_desc omap24xx_io_desc[] __initdata = {
> -	{
> -		.virtual	= L3_24XX_VIRT,
> -		.pfn		= __phys_to_pfn(L3_24XX_PHYS),
> -		.length		= L3_24XX_SIZE,
> -		.type		= MT_DEVICE
> -	},
> -	{
> -		.virtual	= L4_24XX_VIRT,
> -		.pfn		= __phys_to_pfn(L4_24XX_PHYS),
> -		.length		= L4_24XX_SIZE,
> -		.type		= MT_DEVICE
> -	},
> -};
> -
> -#ifdef CONFIG_SOC_OMAP2420
> -static struct map_desc omap242x_io_desc[] __initdata = {
> -	{
> -		.virtual	= DSP_MEM_2420_VIRT,
> -		.pfn		= __phys_to_pfn(DSP_MEM_2420_PHYS),
> -		.length		= DSP_MEM_2420_SIZE,
> -		.type		= MT_DEVICE
> -	},
> -	{
> -		.virtual	= DSP_IPI_2420_VIRT,
> -		.pfn		= __phys_to_pfn(DSP_IPI_2420_PHYS),
> -		.length		= DSP_IPI_2420_SIZE,
> -		.type		= MT_DEVICE
> -	},
> -	{
> -		.virtual	= DSP_MMU_2420_VIRT,
> -		.pfn		= __phys_to_pfn(DSP_MMU_2420_PHYS),
> -		.length		= DSP_MMU_2420_SIZE,
> -		.type		= MT_DEVICE
> -	},
> -};
> -
> -#endif
> -
> -#ifdef CONFIG_SOC_OMAP2430
> -static struct map_desc omap243x_io_desc[] __initdata = {
> -	{
> -		.virtual	= L4_WK_243X_VIRT,
> -		.pfn		= __phys_to_pfn(L4_WK_243X_PHYS),
> -		.length		= L4_WK_243X_SIZE,
> -		.type		= MT_DEVICE
> -	},
> -	{
> -		.virtual	= OMAP243X_GPMC_VIRT,
> -		.pfn		= __phys_to_pfn(OMAP243X_GPMC_PHYS),
> -		.length		= OMAP243X_GPMC_SIZE,
> -		.type		= MT_DEVICE
> -	},
> -	{
> -		.virtual	= OMAP243X_SDRC_VIRT,
> -		.pfn		= __phys_to_pfn(OMAP243X_SDRC_PHYS),
> -		.length		= OMAP243X_SDRC_SIZE,
> -		.type		= MT_DEVICE
> -	},
> -	{
> -		.virtual	= OMAP243X_SMS_VIRT,
> -		.pfn		= __phys_to_pfn(OMAP243X_SMS_PHYS),
> -		.length		= OMAP243X_SMS_SIZE,
> -		.type		= MT_DEVICE
> -	},
> -};
> -#endif
> -#endif
> -
>   #ifdef	CONFIG_ARCH_OMAP3
>   static struct map_desc omap34xx_io_desc[] __initdata = {
>   	{
> @@ -305,22 +232,6 @@ static struct map_desc dra7xx_io_desc[] __initdata = {
>   };
>   #endif
>   
> -#ifdef CONFIG_SOC_OMAP2420
> -void __init omap242x_map_io(void)
> -{
> -	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
> -	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
> -}
> -#endif
> -
> -#ifdef CONFIG_SOC_OMAP2430
> -void __init omap243x_map_io(void)
> -{
> -	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
> -	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
> -}
> -#endif
> -
>   #ifdef CONFIG_ARCH_OMAP3
>   void __init omap3_map_io(void)
>   {
> @@ -365,6 +276,8 @@ void __init dra7xx_map_io(void)
>   	omap_barriers_init();
>   }
>   #endif
> +
> +#ifdef CONFIG_ARCH_OMAP3
>   /*
>    * omap2_init_reprogram_sdrc - reprogram SDRC timing parameters
>    *
> @@ -399,7 +312,6 @@ static int __init _omap2_init_reprogram_sdrc(void)
>   	return v;
>   }
>   
> -#ifdef CONFIG_OMAP_HWMOD
>   static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
>   {
>   	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
> @@ -412,55 +324,11 @@ static void __init __maybe_unused omap_hwmod_init_postsetup(void)
>   	/* Set the default postsetup state for all hwmods */
>   	omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state);
>   }
> -#else
> -static inline void omap_hwmod_init_postsetup(void)
> -{
> -}
> -#endif
> -
> -#ifdef CONFIG_SOC_OMAP2420
> -void __init omap2420_init_early(void)
> -{
> -	omap2_set_globals_tap(OMAP242X_CLASS, OMAP2_L4_IO_ADDRESS(0x48014000));
> -	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
> -			       OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE));
> -	omap2_control_base_init();
> -	omap2xxx_check_revision();
> -	omap2_prcm_base_init();
> -	omap2xxx_voltagedomains_init();
> -	omap242x_powerdomains_init();
> -	omap242x_clockdomains_init();
> -	omap2420_hwmod_init();
> -	omap_hwmod_init_postsetup();
> -	omap_clk_soc_init = omap2420_dt_clk_init;
> -	rate_table = omap2420_rate_table;
> -}
> -#endif
> -
> -#ifdef CONFIG_SOC_OMAP2430
> -void __init omap2430_init_early(void)
> -{
> -	omap2_set_globals_tap(OMAP243X_CLASS, OMAP2_L4_IO_ADDRESS(0x4900a000));
> -	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
> -			       OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE));
> -	omap2_control_base_init();
> -	omap2xxx_check_revision();
> -	omap2_prcm_base_init();
> -	omap2xxx_voltagedomains_init();
> -	omap243x_powerdomains_init();
> -	omap243x_clockdomains_init();
> -	omap2430_hwmod_init();
> -	omap_hwmod_init_postsetup();
> -	omap_clk_soc_init = omap2430_dt_clk_init;
> -	rate_table = omap2430_rate_table;
> -}
> -#endif
>   
>   /*
>    * Currently only board-omap3beagle.c should call this because of the
>    * same machine_id for 34xx and 36xx beagle.. Will get fixed with DT.
>    */
> -#ifdef CONFIG_ARCH_OMAP3
>   static void __init omap3_init_early(void)
>   {
>   	omap2_set_globals_tap(OMAP343X_CLASS, OMAP2_L4_IO_ADDRESS(0x4830A000));
> @@ -661,16 +529,18 @@ void __init dra7xx_init_late(void)
>   #endif
>   
>   
> +#ifdef CONFIG_ARCH_OMAP3
>   void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
>   				      struct omap_sdrc_params *sdrc_cs1)
>   {
>   	omap_sram_init();
>   
> -	if (cpu_is_omap24xx() || omap3_has_sdrc()) {
> +	if (omap3_has_sdrc()) {
>   		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
>   		_omap2_init_reprogram_sdrc();
>   	}
>   }
> +#endif
>   
>   int __init omap_clk_init(void)
>   {
> diff --git a/arch/arm/mach-omap2/iomap.h b/arch/arm/mach-omap2/iomap.h
> index 6191d244438a..403444bb6924 100644
> --- a/arch/arm/mach-omap2/iomap.h
> +++ b/arch/arm/mach-omap2/iomap.h
> @@ -48,52 +48,6 @@
>   #define OMAP2_EMU_IO_OFFSET		0xaa800000	/* Emulation */
>   #define OMAP2_EMU_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_EMU_IO_OFFSET)
>   
> -/*
> - * ----------------------------------------------------------------------------
> - * Omap2 specific IO mapping
> - * ----------------------------------------------------------------------------
> - */
> -
> -/* We map both L3 and L4 on OMAP2 */
> -#define L3_24XX_PHYS	L3_24XX_BASE	/* 0x68000000 --> 0xf8000000*/
> -#define L3_24XX_VIRT	(L3_24XX_PHYS + OMAP2_L3_IO_OFFSET)
> -#define L3_24XX_SIZE	SZ_1M		/* 44kB of 128MB used, want 1MB sect */
> -#define L4_24XX_PHYS	L4_24XX_BASE	/* 0x48000000 --> 0xfa000000 */
> -#define L4_24XX_VIRT	(L4_24XX_PHYS + OMAP2_L4_IO_OFFSET)
> -#define L4_24XX_SIZE	SZ_1M		/* 1MB of 128MB used, want 1MB sect */
> -
> -#define L4_WK_243X_PHYS		L4_WK_243X_BASE	/* 0x49000000 --> 0xfb000000 */
> -#define L4_WK_243X_VIRT		(L4_WK_243X_PHYS + OMAP2_L4_IO_OFFSET)
> -#define L4_WK_243X_SIZE		SZ_1M
> -#define OMAP243X_GPMC_PHYS	OMAP243X_GPMC_BASE
> -#define OMAP243X_GPMC_VIRT	(OMAP243X_GPMC_PHYS + OMAP2_L3_IO_OFFSET)
> -						/* 0x6e000000 --> 0xfe000000 */
> -#define OMAP243X_GPMC_SIZE	SZ_1M
> -#define OMAP243X_SDRC_PHYS	OMAP243X_SDRC_BASE
> -						/* 0x6D000000 --> 0xfd000000 */
> -#define OMAP243X_SDRC_VIRT	(OMAP243X_SDRC_PHYS + OMAP2_L3_IO_OFFSET)
> -#define OMAP243X_SDRC_SIZE	SZ_1M
> -#define OMAP243X_SMS_PHYS	OMAP243X_SMS_BASE
> -						/* 0x6c000000 --> 0xfc000000 */
> -#define OMAP243X_SMS_VIRT	(OMAP243X_SMS_PHYS + OMAP2_L3_IO_OFFSET)
> -#define OMAP243X_SMS_SIZE	SZ_1M
> -
> -/* 2420 IVA */
> -#define DSP_MEM_2420_PHYS	OMAP2420_DSP_MEM_BASE
> -						/* 0x58000000 --> 0xfc100000 */
> -#define DSP_MEM_2420_VIRT	0xfc100000
> -#define DSP_MEM_2420_SIZE	0x28000
> -#define DSP_IPI_2420_PHYS	OMAP2420_DSP_IPI_BASE
> -						/* 0x59000000 --> 0xfc128000 */
> -#define DSP_IPI_2420_VIRT	0xfc128000
> -#define DSP_IPI_2420_SIZE	SZ_4K
> -#define DSP_MMU_2420_PHYS	OMAP2420_DSP_MMU_BASE
> -						/* 0x5a000000 --> 0xfc129000 */
> -#define DSP_MMU_2420_VIRT	0xfc129000
> -#define DSP_MMU_2420_SIZE	SZ_4K
> -
> -/* 2430 IVA2.1 - currently unmapped */
> -
>   /*
>    * ----------------------------------------------------------------------------
>    * Omap3 specific IO mapping
> diff --git a/arch/arm/mach-omap2/l3_2xxx.h b/arch/arm/mach-omap2/l3_2xxx.h
> deleted file mode 100644
> index 6297c62428ac..000000000000
> --- a/arch/arm/mach-omap2/l3_2xxx.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * arch/arm/plat-omap/include/plat/l3_2xxx.h - L3 firewall definitions
> - *
> - * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
> - *	Sumit Semwal
> - */
> -#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_L3_2XXX_H
> -#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_L3_2XXX_H
> -
> -/* L3 CONNIDs */
> -/* Display Sub system (DSS) */
> -#define OMAP2_L3_CORE_FW_CONNID_DSS			8
> -
> -#endif
> diff --git a/arch/arm/mach-omap2/l4_2xxx.h b/arch/arm/mach-omap2/l4_2xxx.h
> deleted file mode 100644
> index 418e1072d730..000000000000
> --- a/arch/arm/mach-omap2/l4_2xxx.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * arch/arm/plat-omap/include/plat/l4_2xxx.h - L4 firewall definitions
> - *
> - * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
> - *	Sumit Semwal
> - */
> -#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_L4_2XXX_H
> -#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_L4_2XXX_H
> -
> -/* L4 CORE */
> -/* Display Sub system (DSS) */
> -#define OMAP2420_L4_CORE_FW_DSS_CORE_REGION			28
> -#define OMAP2420_L4_CORE_FW_DSS_DISPC_REGION			29
> -#define OMAP2420_L4_CORE_FW_DSS_RFBI_REGION			30
> -#define OMAP2420_L4_CORE_FW_DSS_VENC_REGION			31
> -#define OMAP2420_L4_CORE_FW_DSS_TA_REGION			32
> -
> -#endif
> diff --git a/arch/arm/mach-omap2/mmc.h b/arch/arm/mach-omap2/mmc.h
> deleted file mode 100644
> index b5533e93cb63..000000000000
> --- a/arch/arm/mach-omap2/mmc.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -
> -#define OMAP24XX_NR_MMC		2
> -#define OMAP2420_MMC_SIZE	OMAP1_MMC_SIZE
> -#define OMAP2_MMC1_BASE		0x4809c000
> -
> -#define OMAP4_MMC_REG_OFFSET	0x100
> -
> -struct omap_hwmod;
> -
> -#ifdef CONFIG_SOC_OMAP2420
> -int omap_msdi_reset(struct omap_hwmod *oh);
> -#else
> -static inline int omap_msdi_reset(struct omap_hwmod *oh)
> -{
> -	return 0;
> -}
> -#endif
> diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
> deleted file mode 100644
> index 552b2fa4e4f1..000000000000
> --- a/arch/arm/mach-omap2/msdi.c
> +++ /dev/null
> @@ -1,75 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * MSDI IP block reset
> - *
> - * Copyright (C) 2012 Texas Instruments, Inc.
> - * Paul Walmsley
> - *
> - * XXX What about pad muxing?
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/err.h>
> -
> -#include "prm.h"
> -#include "common.h"
> -#include "control.h"
> -#include "omap_hwmod.h"
> -#include "omap_device.h"
> -#include "mmc.h"
> -
> -/*
> - * MSDI_CON_OFFSET: offset in bytes of the MSDI IP block's CON register
> - *     from the IP block's base address
> - */
> -#define MSDI_CON_OFFSET				0x0c
> -
> -/* Register bitfields in the CON register */
> -#define MSDI_CON_POW_MASK			BIT(11)
> -#define MSDI_CON_CLKD_MASK			(0x3f << 0)
> -#define MSDI_CON_CLKD_SHIFT			0
> -
> -/* MSDI_TARGET_RESET_CLKD: clock divisor to use throughout the reset */
> -#define MSDI_TARGET_RESET_CLKD		0x3ff
> -
> -/**
> - * omap_msdi_reset - reset the MSDI IP block
> - * @oh: struct omap_hwmod *
> - *
> - * The MSDI IP block on OMAP2420 has to have both the POW and CLKD
> - * fields set inside its CON register for a reset to complete
> - * successfully.  This is not documented in the TRM.  For CLKD, we use
> - * the value that results in the lowest possible clock rate, to attempt
> - * to avoid disturbing any cards.
> - */
> -int omap_msdi_reset(struct omap_hwmod *oh)
> -{
> -	u16 v = 0;
> -	int c = 0;
> -
> -	/* Write to the SOFTRESET bit */
> -	omap_hwmod_softreset(oh);
> -
> -	/* Enable the MSDI core and internal clock */
> -	v |= MSDI_CON_POW_MASK;
> -	v |= MSDI_TARGET_RESET_CLKD << MSDI_CON_CLKD_SHIFT;
> -	omap_hwmod_write(v, oh, MSDI_CON_OFFSET);
> -
> -	/* Poll on RESETDONE bit */
> -	omap_test_timeout((omap_hwmod_read(oh, oh->class->sysc->syss_offs)
> -			   & SYSS_RESETDONE_MASK),
> -			  MAX_MODULE_SOFTRESET_WAIT, c);
> -
> -	if (c == MAX_MODULE_SOFTRESET_WAIT)
> -		pr_warn("%s: %s: softreset failed (waited %d usec)\n",
> -			__func__, oh->name, MAX_MODULE_SOFTRESET_WAIT);
> -	else
> -		pr_debug("%s: %s: softreset in %d usec\n", __func__,
> -			 oh->name, c);
> -
> -	/* Disable the MSDI internal clock */
> -	v &= ~MSDI_CON_CLKD_MASK;
> -	omap_hwmod_write(v, oh, MSDI_CON_OFFSET);
> -
> -	return 0;
> -}
> diff --git a/arch/arm/mach-omap2/omap2-restart.c b/arch/arm/mach-omap2/omap2-restart.c
> deleted file mode 100644
> index fdcc75c97d70..000000000000
> --- a/arch/arm/mach-omap2/omap2-restart.c
> +++ /dev/null
> @@ -1,62 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * omap2-restart.c - code common to all OMAP2xxx machines.
> - *
> - * Copyright (C) 2012 Texas Instruments
> - * Paul Walmsley
> - */
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
> -
> -#include "soc.h"
> -#include "common.h"
> -#include "prm.h"
> -
> -/*
> - * reset_virt_prcm_set_ck, reset_sys_ck: pointers to the virt_prcm_set
> - * clock and the sys_ck.  Used during the reset process
> - */
> -static struct clk *reset_virt_prcm_set_ck, *reset_sys_ck;
> -
> -/* Reboot handling */
> -
> -/**
> - * omap2xxx_restart - Set DPLL to bypass mode for reboot to work
> - *
> - * Set the DPLL to bypass so that reboot completes successfully.  No
> - * return value.
> - */
> -void omap2xxx_restart(enum reboot_mode mode, const char *cmd)
> -{
> -	u32 rate;
> -
> -	rate = clk_get_rate(reset_sys_ck);
> -	clk_set_rate(reset_virt_prcm_set_ck, rate);
> -
> -	/* XXX Should save the cmd argument for use after the reboot */
> -
> -	omap_prm_reset_system();
> -}
> -
> -/**
> - * omap2xxx_common_look_up_clks_for_reset - look up clocks needed for restart
> - *
> - * Some clocks need to be looked up in advance for the SoC restart
> - * operation to work - see omap2xxx_restart().  Returns -EINVAL upon
> - * error or 0 upon success.
> - */
> -static int __init omap2xxx_common_look_up_clks_for_reset(void)
> -{
> -	reset_virt_prcm_set_ck = clk_get(NULL, "virt_prcm_set");
> -	if (IS_ERR(reset_virt_prcm_set_ck))
> -		return -EINVAL;
> -
> -	reset_sys_ck = clk_get(NULL, "sys_ck");
> -	if (IS_ERR(reset_sys_ck))
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -omap_postcore_initcall(omap2xxx_common_look_up_clks_for_reset);
> diff --git a/arch/arm/mach-omap2/omap24xx.h b/arch/arm/mach-omap2/omap24xx.h
> deleted file mode 100644
> index d9ecc0578292..000000000000
> --- a/arch/arm/mach-omap2/omap24xx.h
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * This file contains the processor specific definitions
> - * of the TI OMAP24XX.
> - *
> - * Copyright (C) 2007 Texas Instruments.
> - * Copyright (C) 2007 Nokia Corporation.
> - */
> -
> -#ifndef __ASM_ARCH_OMAP2_H
> -#define __ASM_ARCH_OMAP2_H
> -
> -/*
> - * Please place only base defines here and put the rest in device
> - * specific headers. Note also that some of these defines are needed
> - * for omap1 to compile without adding ifdefs.
> - */
> -
> -#define L4_24XX_BASE		0x48000000
> -#define L4_WK_243X_BASE		0x49000000
> -#define L3_24XX_BASE		0x68000000
> -
> -/* interrupt controller */
> -#define OMAP24XX_IC_BASE	(L4_24XX_BASE + 0xfe000)
> -#define OMAP24XX_IVA_INTC_BASE	0x40000000
> -
> -#define OMAP242X_CTRL_BASE	L4_24XX_BASE
> -#define OMAP2420_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
> -#define OMAP2420_PRCM_BASE	(L4_24XX_BASE + 0x8000)
> -#define OMAP2420_CM_BASE	(L4_24XX_BASE + 0x8000)
> -#define OMAP2420_PRM_BASE	OMAP2420_CM_BASE
> -#define OMAP2420_SDRC_BASE	(L3_24XX_BASE + 0x9000)
> -#define OMAP2420_SMS_BASE	0x68008000
> -#define OMAP2420_GPMC_BASE	0x6800a000
> -
> -#define OMAP2430_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
> -#define OMAP2430_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
> -#define OMAP2430_CM_BASE	(L4_WK_243X_BASE + 0x6000)
> -#define OMAP2430_PRM_BASE	OMAP2430_CM_BASE
> -
> -#define OMAP243X_SMS_BASE	0x6C000000
> -#define OMAP243X_SDRC_BASE	0x6D000000
> -#define OMAP243X_GPMC_BASE	0x6E000000
> -#define OMAP243X_SCM_BASE	(L4_WK_243X_BASE + 0x2000)
> -#define OMAP243X_CTRL_BASE	OMAP243X_SCM_BASE
> -#define OMAP243X_HS_BASE	(L4_24XX_BASE + 0x000ac000)
> -
> -/* DSP SS */
> -#define OMAP2420_DSP_BASE	0x58000000
> -#define OMAP2420_DSP_MEM_BASE	(OMAP2420_DSP_BASE + 0x0)
> -#define OMAP2420_DSP_IPI_BASE	(OMAP2420_DSP_BASE + 0x1000000)
> -#define OMAP2420_DSP_MMU_BASE	(OMAP2420_DSP_BASE + 0x2000000)
> -
> -#define OMAP243X_DSP_BASE	0x5C000000
> -#define OMAP243X_DSP_MEM_BASE	(OMAP243X_DSP_BASE + 0x0)
> -#define OMAP243X_DSP_MMU_BASE	(OMAP243X_DSP_BASE + 0x1000000)
> -
> -/* Mailbox */
> -#define OMAP24XX_MAILBOX_BASE	(L4_24XX_BASE + 0x94000)
> -
> -/* Camera */
> -#define OMAP24XX_CAMERA_BASE	(L4_24XX_BASE + 0x52000)
> -
> -/* Security */
> -#define OMAP24XX_SEC_BASE	(L4_24XX_BASE + 0xA0000)
> -#define OMAP24XX_SEC_RNG_BASE	(OMAP24XX_SEC_BASE + 0x0000)
> -#define OMAP24XX_SEC_DES_BASE	(OMAP24XX_SEC_BASE + 0x2000)
> -#define OMAP24XX_SEC_SHA1MD5_BASE (OMAP24XX_SEC_BASE + 0x4000)
> -#define OMAP24XX_SEC_AES_BASE	(OMAP24XX_SEC_BASE + 0x6000)
> -#define OMAP24XX_SEC_PKA_BASE	(OMAP24XX_SEC_BASE + 0x8000)
> -
> -#endif /* __ASM_ARCH_OMAP2_H */
> -
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 03cd523dff87..c918399ea735 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -153,9 +153,7 @@
>   #include "common.h"
>   #include "clockdomain.h"
>   #include "hdq1w.h"
> -#include "mmc.h"
>   #include "powerdomain.h"
> -#include "cm2xxx.h"
>   #include "cm3xxx.h"
>   #include "cm33xx.h"
>   #include "prm.h"
> @@ -3469,10 +3467,6 @@ static int omap_hwmod_allocate_module(struct device *dev, struct omap_hwmod *oh,
>   	return -ENOMEM;
>   }
>   
> -static const struct omap_hwmod_reset omap24xx_reset_quirks[] = {
> -	{ .match = "msdi", .len = 4, .reset = omap_msdi_reset, },
> -};
> -
>   static const struct omap_hwmod_reset omap_reset_quirks[] = {
>   	{ .match = "dss_core", .len = 8, .reset = omap_dss_reset, },
>   	{ .match = "hdq1w", .len = 5, .reset = omap_hdq1w_reset, },
> @@ -3503,11 +3497,6 @@ static void
>   omap_hwmod_init_reset_quirks(struct device *dev, struct omap_hwmod *oh,
>   			     const struct ti_sysc_module_data *data)
>   {
> -	if (soc_is_omap24xx())
> -		omap_hwmod_init_reset_quirk(dev, oh, data,
> -					    omap24xx_reset_quirks,
> -					    ARRAY_SIZE(omap24xx_reset_quirks));
> -
>   	omap_hwmod_init_reset_quirk(dev, oh, data, omap_reset_quirks,
>   				    ARRAY_SIZE(omap_reset_quirks));
>   }
> @@ -3914,12 +3903,7 @@ int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state)
>    */
>   void __init omap_hwmod_init(void)
>   {
> -	if (cpu_is_omap24xx()) {
> -		soc_ops.wait_target_ready = _omap2xxx_3xxx_wait_target_ready;
> -		soc_ops.assert_hardreset = _omap2_assert_hardreset;
> -		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
> -		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
> -	} else if (cpu_is_omap34xx()) {
> +	if (cpu_is_omap34xx()) {
>   		soc_ops.wait_target_ready = _omap2xxx_3xxx_wait_target_ready;
>   		soc_ops.assert_hardreset = _omap2_assert_hardreset;
>   		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
> diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
> index dcab7a01c10e..b60cd09c1997 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.h
> +++ b/arch/arm/mach-omap2/omap_hwmod.h
> @@ -663,8 +663,6 @@ omap_hwmod_for_each_by_class(const char *classname,
>    * Chip variant-specific hwmod init routines - XXX should be converted
>    * to use initcalls once the initial boot ordering is straightened out
>    */
> -extern int omap2420_hwmod_init(void);
> -extern int omap2430_hwmod_init(void);
>   extern int omap3xxx_hwmod_init(void);
>   extern int dm814x_hwmod_init(void);
>   extern int dm816x_hwmod_init(void);
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> deleted file mode 100644
> index dbd9dc9f0962..000000000000
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ /dev/null
> @@ -1,402 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * omap_hwmod_2420_data.c - hardware modules present on the OMAP2420 chips
> - *
> - * Copyright (C) 2009-2011 Nokia Corporation
> - * Copyright (C) 2012 Texas Instruments, Inc.
> - * Paul Walmsley
> - *
> - * XXX handle crossbar/shared link difference for L3?
> - * XXX these should be marked initdata for multi-OMAP kernels
> - */
> -
> -#include <linux/platform_data/i2c-omap.h>
> -
> -#include "omap_hwmod.h"
> -#include "l3_2xxx.h"
> -#include "l4_2xxx.h"
> -
> -#include "omap_hwmod_common_data.h"
> -
> -#include "cm-regbits-24xx.h"
> -#include "prm-regbits-24xx.h"
> -#include "i2c.h"
> -#include "mmc.h"
> -#include "wd_timer.h"
> -
> -/*
> - * OMAP2420 hardware module integration data
> - *
> - * All of the data in this section should be autogeneratable from the
> - * TI hardware database or other technical documentation.  Data that
> - * is driver-specific or driver-kernel integration-specific belongs
> - * elsewhere.
> - */
> -
> -/*
> - * IP blocks
> - */
> -
> -/* IVA1 (IVA1) */
> -static struct omap_hwmod_class iva1_hwmod_class = {
> -	.name		= "iva1",
> -};
> -
> -static struct omap_hwmod_rst_info omap2420_iva_resets[] = {
> -	{ .name = "iva", .rst_shift = 8 },
> -};
> -
> -static struct omap_hwmod omap2420_iva_hwmod = {
> -	.name		= "iva",
> -	.class		= &iva1_hwmod_class,
> -	.clkdm_name	= "iva1_clkdm",
> -	.rst_lines	= omap2420_iva_resets,
> -	.rst_lines_cnt	= ARRAY_SIZE(omap2420_iva_resets),
> -	.main_clk	= "iva1_ifck",
> -};
> -
> -/* DSP */
> -static struct omap_hwmod_class dsp_hwmod_class = {
> -	.name		= "dsp",
> -};
> -
> -static struct omap_hwmod_rst_info omap2420_dsp_resets[] = {
> -	{ .name = "logic", .rst_shift = 0 },
> -	{ .name = "mmu", .rst_shift = 1 },
> -};
> -
> -static struct omap_hwmod omap2420_dsp_hwmod = {
> -	.name		= "dsp",
> -	.class		= &dsp_hwmod_class,
> -	.clkdm_name	= "dsp_clkdm",
> -	.rst_lines	= omap2420_dsp_resets,
> -	.rst_lines_cnt	= ARRAY_SIZE(omap2420_dsp_resets),
> -	.main_clk	= "dsp_fck",
> -};
> -
> -/* I2C common */
> -static struct omap_hwmod_class_sysconfig i2c_sysc = {
> -	.rev_offs	= 0x00,
> -	.sysc_offs	= 0x20,
> -	.syss_offs	= 0x10,
> -	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class i2c_class = {
> -	.name		= "i2c",
> -	.sysc		= &i2c_sysc,
> -	.reset		= &omap_i2c_reset,
> -};
> -
> -/* I2C1 */
> -static struct omap_hwmod omap2420_i2c1_hwmod = {
> -	.name		= "i2c1",
> -	.main_clk	= "i2c1_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP2420_ST_I2C1_SHIFT,
> -		},
> -	},
> -	.class		= &i2c_class,
> -	/*
> -	 * From mach-omap2/pm24xx.c: "Putting MPU into the WFI state
> -	 * while a transfer is active seems to cause the I2C block to
> -	 * timeout. Why? Good question."
> -	 */
> -	.flags		= (HWMOD_16BIT_REG | HWMOD_BLOCK_WFI),
> -};
> -
> -/* I2C2 */
> -static struct omap_hwmod omap2420_i2c2_hwmod = {
> -	.name		= "i2c2",
> -	.main_clk	= "i2c2_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP2420_ST_I2C2_SHIFT,
> -		},
> -	},
> -	.class		= &i2c_class,
> -	.flags		= HWMOD_16BIT_REG,
> -};
> -
> -/* mailbox */
> -static struct omap_hwmod omap2420_mailbox_hwmod = {
> -	.name		= "mailbox",
> -	.class		= &omap2xxx_mailbox_hwmod_class,
> -	.main_clk	= "mailboxes_ick",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
> -		},
> -	},
> -};
> -
> -/*
> - * 'mcbsp' class
> - * multi channel buffered serial port controller
> - */
> -
> -static struct omap_hwmod_class omap2420_mcbsp_hwmod_class = {
> -	.name = "mcbsp",
> -};
> -
> -static struct omap_hwmod_opt_clk mcbsp_opt_clks[] = {
> -	{ .role = "pad_fck", .clk = "mcbsp_clks" },
> -	{ .role = "prcm_fck", .clk = "func_96m_ck" },
> -};
> -
> -/* mcbsp1 */
> -static struct omap_hwmod omap2420_mcbsp1_hwmod = {
> -	.name		= "mcbsp1",
> -	.class		= &omap2420_mcbsp_hwmod_class,
> -	.main_clk	= "mcbsp1_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_MCBSP1_SHIFT,
> -		},
> -	},
> -	.opt_clks	= mcbsp_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
> -};
> -
> -/* mcbsp2 */
> -static struct omap_hwmod omap2420_mcbsp2_hwmod = {
> -	.name		= "mcbsp2",
> -	.class		= &omap2420_mcbsp_hwmod_class,
> -	.main_clk	= "mcbsp2_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_MCBSP2_SHIFT,
> -		},
> -	},
> -	.opt_clks	= mcbsp_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
> -};
> -
> -static struct omap_hwmod_class_sysconfig omap2420_msdi_sysc = {
> -	.rev_offs	= 0x3c,
> -	.sysc_offs	= 0x64,
> -	.syss_offs	= 0x68,
> -	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class omap2420_msdi_hwmod_class = {
> -	.name	= "msdi",
> -	.sysc	= &omap2420_msdi_sysc,
> -	.reset	= &omap_msdi_reset,
> -};
> -
> -/* msdi1 */
> -static struct omap_hwmod omap2420_msdi1_hwmod = {
> -	.name		= "msdi1",
> -	.class		= &omap2420_msdi_hwmod_class,
> -	.main_clk	= "mmc_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP2420_ST_MMC_SHIFT,
> -		},
> -	},
> -	.flags		= HWMOD_16BIT_REG,
> -};
> -
> -/* HDQ1W/1-wire */
> -static struct omap_hwmod omap2420_hdq1w_hwmod = {
> -	.name		= "hdq1w",
> -	.main_clk	= "hdq_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_HDQ_SHIFT,
> -		},
> -	},
> -	.class		= &omap2_hdq1w_class,
> -};
> -
> -/*
> - * interfaces
> - */
> -
> -/* L4 CORE -> I2C1 interface */
> -static struct omap_hwmod_ocp_if omap2420_l4_core__i2c1 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2420_i2c1_hwmod,
> -	.clk		= "i2c1_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* L4 CORE -> I2C2 interface */
> -static struct omap_hwmod_ocp_if omap2420_l4_core__i2c2 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2420_i2c2_hwmod,
> -	.clk		= "i2c2_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* IVA <- L3 interface */
> -static struct omap_hwmod_ocp_if omap2420_l3__iva = {
> -	.master		= &omap2xxx_l3_main_hwmod,
> -	.slave		= &omap2420_iva_hwmod,
> -	.clk		= "core_l3_ck",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* DSP <- L3 interface */
> -static struct omap_hwmod_ocp_if omap2420_l3__dsp = {
> -	.master		= &omap2xxx_l3_main_hwmod,
> -	.slave		= &omap2420_dsp_hwmod,
> -	.clk		= "dsp_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_wkup -> wd_timer2 */
> -static struct omap_hwmod_ocp_if omap2420_l4_wkup__wd_timer2 = {
> -	.master		= &omap2xxx_l4_wkup_hwmod,
> -	.slave		= &omap2xxx_wd_timer2_hwmod,
> -	.clk		= "mpu_wdt_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_wkup -> gpio1 */
> -static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio1 = {
> -	.master		= &omap2xxx_l4_wkup_hwmod,
> -	.slave		= &omap2xxx_gpio1_hwmod,
> -	.clk		= "gpios_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_wkup -> gpio2 */
> -static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio2 = {
> -	.master		= &omap2xxx_l4_wkup_hwmod,
> -	.slave		= &omap2xxx_gpio2_hwmod,
> -	.clk		= "gpios_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_wkup -> gpio3 */
> -static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio3 = {
> -	.master		= &omap2xxx_l4_wkup_hwmod,
> -	.slave		= &omap2xxx_gpio3_hwmod,
> -	.clk		= "gpios_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_wkup -> gpio4 */
> -static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio4 = {
> -	.master		= &omap2xxx_l4_wkup_hwmod,
> -	.slave		= &omap2xxx_gpio4_hwmod,
> -	.clk		= "gpios_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> mailbox */
> -static struct omap_hwmod_ocp_if omap2420_l4_core__mailbox = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2420_mailbox_hwmod,
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> mcbsp1 */
> -static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp1 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2420_mcbsp1_hwmod,
> -	.clk		= "mcbsp1_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> mcbsp2 */
> -static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2420_mcbsp2_hwmod,
> -	.clk		= "mcbsp2_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> msdi1 */
> -static struct omap_hwmod_ocp_if omap2420_l4_core__msdi1 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2420_msdi1_hwmod,
> -	.clk		= "mmc_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> hdq1w interface */
> -static struct omap_hwmod_ocp_if omap2420_l4_core__hdq1w = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2420_hdq1w_hwmod,
> -	.clk		= "hdq_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -	.flags		= OMAP_FIREWALL_L4 | OCPIF_SWSUP_IDLE,
> -};
> -
> -static struct omap_hwmod_ocp_if omap2420_l3__gpmc = {
> -	.master		= &omap2xxx_l3_main_hwmod,
> -	.slave		= &omap2xxx_gpmc_hwmod,
> -	.clk		= "core_l3_ck",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
> -	&omap2xxx_l3_main__l4_core,
> -	&omap2xxx_mpu__l3_main,
> -	&omap2xxx_dss__l3,
> -	&omap2xxx_l4_core__mcspi1,
> -	&omap2xxx_l4_core__mcspi2,
> -	&omap2xxx_l4_core__l4_wkup,
> -	&omap2_l4_core__uart1,
> -	&omap2_l4_core__uart2,
> -	&omap2_l4_core__uart3,
> -	&omap2420_l4_core__i2c1,
> -	&omap2420_l4_core__i2c2,
> -	&omap2420_l3__iva,
> -	&omap2420_l3__dsp,
> -	&omap2xxx_l4_core__timer3,
> -	&omap2xxx_l4_core__timer4,
> -	&omap2xxx_l4_core__timer5,
> -	&omap2xxx_l4_core__timer6,
> -	&omap2xxx_l4_core__timer7,
> -	&omap2xxx_l4_core__timer8,
> -	&omap2xxx_l4_core__timer9,
> -	&omap2xxx_l4_core__timer10,
> -	&omap2xxx_l4_core__timer11,
> -	&omap2xxx_l4_core__timer12,
> -	&omap2420_l4_wkup__wd_timer2,
> -	&omap2xxx_l4_core__dss,
> -	&omap2xxx_l4_core__dss_dispc,
> -	&omap2xxx_l4_core__dss_rfbi,
> -	&omap2xxx_l4_core__dss_venc,
> -	&omap2420_l4_wkup__gpio1,
> -	&omap2420_l4_wkup__gpio2,
> -	&omap2420_l4_wkup__gpio3,
> -	&omap2420_l4_wkup__gpio4,
> -	&omap2420_l4_core__mailbox,
> -	&omap2420_l4_core__mcbsp1,
> -	&omap2420_l4_core__mcbsp2,
> -	&omap2420_l4_core__msdi1,
> -	&omap2xxx_l4_core__rng,
> -	&omap2xxx_l4_core__sham,
> -	&omap2xxx_l4_core__aes,
> -	&omap2420_l4_core__hdq1w,
> -	&omap2420_l3__gpmc,
> -	NULL,
> -};
> -
> -int __init omap2420_hwmod_init(void)
> -{
> -	omap_hwmod_init();
> -	return omap_hwmod_register_links(omap2420_hwmod_ocp_ifs);
> -}
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> deleted file mode 100644
> index c93200801b34..000000000000
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ /dev/null
> @@ -1,606 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * omap_hwmod_2430_data.c - hardware modules present on the OMAP2430 chips
> - *
> - * Copyright (C) 2009-2011 Nokia Corporation
> - * Copyright (C) 2012 Texas Instruments, Inc.
> - * Paul Walmsley
> - *
> - * XXX handle crossbar/shared link difference for L3?
> - * XXX these should be marked initdata for multi-OMAP kernels
> - */
> -
> -#include <linux/platform_data/i2c-omap.h>
> -#include <linux/platform_data/hsmmc-omap.h>
> -
> -#include "omap_hwmod.h"
> -#include "l3_2xxx.h"
> -
> -#include "soc.h"
> -#include "omap_hwmod_common_data.h"
> -#include "prm-regbits-24xx.h"
> -#include "cm-regbits-24xx.h"
> -#include "i2c.h"
> -#include "wd_timer.h"
> -
> -/*
> - * OMAP2430 hardware module integration data
> - *
> - * All of the data in this section should be autogeneratable from the
> - * TI hardware database or other technical documentation.  Data that
> - * is driver-specific or driver-kernel integration-specific belongs
> - * elsewhere.
> - */
> -
> -/*
> - * IP blocks
> - */
> -
> -/* IVA2 (IVA2) */
> -static struct omap_hwmod_rst_info omap2430_iva_resets[] = {
> -	{ .name = "logic", .rst_shift = 0 },
> -	{ .name = "mmu", .rst_shift = 1 },
> -};
> -
> -static struct omap_hwmod omap2430_iva_hwmod = {
> -	.name		= "iva",
> -	.class		= &iva_hwmod_class,
> -	.clkdm_name	= "dsp_clkdm",
> -	.rst_lines	= omap2430_iva_resets,
> -	.rst_lines_cnt	= ARRAY_SIZE(omap2430_iva_resets),
> -	.main_clk	= "dsp_fck",
> -};
> -
> -/* I2C common */
> -static struct omap_hwmod_class_sysconfig i2c_sysc = {
> -	.rev_offs	= 0x00,
> -	.sysc_offs	= 0x20,
> -	.syss_offs	= 0x10,
> -	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
> -			   SYSS_HAS_RESET_STATUS),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class i2c_class = {
> -	.name		= "i2c",
> -	.sysc		= &i2c_sysc,
> -	.reset		= &omap_i2c_reset,
> -};
> -
> -/* I2C1 */
> -static struct omap_hwmod omap2430_i2c1_hwmod = {
> -	.name		= "i2c1",
> -	.flags		= HWMOD_16BIT_REG,
> -	.main_clk	= "i2chs1_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			/*
> -			 * NOTE: The CM_FCLKEN* and CM_ICLKEN* for
> -			 * I2CHS IP's do not follow the usual pattern.
> -			 * prcm_reg_id alone cannot be used to program
> -			 * the iclk and fclk. Needs to be handled using
> -			 * additional flags when clk handling is moved
> -			 * to hwmod framework.
> -			 */
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP2430_ST_I2CHS1_SHIFT,
> -		},
> -	},
> -	.class		= &i2c_class,
> -};
> -
> -/* I2C2 */
> -static struct omap_hwmod omap2430_i2c2_hwmod = {
> -	.name		= "i2c2",
> -	.flags		= HWMOD_16BIT_REG,
> -	.main_clk	= "i2chs2_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP2430_ST_I2CHS2_SHIFT,
> -		},
> -	},
> -	.class		= &i2c_class,
> -};
> -
> -/* gpio5 */
> -static struct omap_hwmod omap2430_gpio5_hwmod = {
> -	.name		= "gpio5",
> -	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -	.main_clk	= "gpio5_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 2,
> -			.idlest_idle_bit = OMAP2430_ST_GPIO5_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_gpio_hwmod_class,
> -};
> -
> -/* mailbox */
> -static struct omap_hwmod omap2430_mailbox_hwmod = {
> -	.name		= "mailbox",
> -	.class		= &omap2xxx_mailbox_hwmod_class,
> -	.main_clk	= "mailboxes_ick",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
> -		},
> -	},
> -};
> -
> -/* mcspi3 */
> -static struct omap_hwmod omap2430_mcspi3_hwmod = {
> -	.name		= "mcspi3",
> -	.main_clk	= "mcspi3_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 2,
> -			.idlest_idle_bit = OMAP2430_ST_MCSPI3_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_mcspi_class,
> -};
> -
> -/* usbhsotg */
> -static struct omap_hwmod_class_sysconfig omap2430_usbhsotg_sysc = {
> -	.rev_offs	= 0x0400,
> -	.sysc_offs	= 0x0404,
> -	.syss_offs	= 0x0408,
> -	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
> -			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> -			  SYSC_HAS_AUTOIDLE),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -			  MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class usbotg_class = {
> -	.name = "usbotg",
> -	.sysc = &omap2430_usbhsotg_sysc,
> -};
> -
> -/* usb_otg_hs */
> -static struct omap_hwmod omap2430_usbhsotg_hwmod = {
> -	.name		= "usb_otg_hs",
> -	.main_clk	= "usbhs_ick",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP2430_ST_USBHS_SHIFT,
> -		},
> -	},
> -	.class		= &usbotg_class,
> -	/*
> -	 * Erratum ID: i479  idle_req / idle_ack mechanism potentially
> -	 * broken when autoidle is enabled
> -	 * workaround is to disable the autoidle bit at module level.
> -	 */
> -	.flags		= HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE
> -				| HWMOD_SWSUP_MSTANDBY,
> -};
> -
> -/*
> - * 'mcbsp' class
> - * multi channel buffered serial port controller
> - */
> -
> -static struct omap_hwmod_class_sysconfig omap2430_mcbsp_sysc = {
> -	.rev_offs	= 0x007C,
> -	.sysc_offs	= 0x008C,
> -	.sysc_flags	= (SYSC_HAS_SOFTRESET),
> -	.sysc_fields    = &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class omap2430_mcbsp_hwmod_class = {
> -	.name = "mcbsp",
> -	.sysc = &omap2430_mcbsp_sysc,
> -};
> -
> -static struct omap_hwmod_opt_clk mcbsp_opt_clks[] = {
> -	{ .role = "pad_fck", .clk = "mcbsp_clks" },
> -	{ .role = "prcm_fck", .clk = "func_96m_ck" },
> -};
> -
> -/* mcbsp1 */
> -static struct omap_hwmod omap2430_mcbsp1_hwmod = {
> -	.name		= "mcbsp1",
> -	.class		= &omap2430_mcbsp_hwmod_class,
> -	.main_clk	= "mcbsp1_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_MCBSP1_SHIFT,
> -		},
> -	},
> -	.opt_clks	= mcbsp_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
> -};
> -
> -/* mcbsp2 */
> -static struct omap_hwmod omap2430_mcbsp2_hwmod = {
> -	.name		= "mcbsp2",
> -	.class		= &omap2430_mcbsp_hwmod_class,
> -	.main_clk	= "mcbsp2_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_MCBSP2_SHIFT,
> -		},
> -	},
> -	.opt_clks	= mcbsp_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
> -};
> -
> -/* mcbsp3 */
> -static struct omap_hwmod omap2430_mcbsp3_hwmod = {
> -	.name		= "mcbsp3",
> -	.class		= &omap2430_mcbsp_hwmod_class,
> -	.main_clk	= "mcbsp3_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 2,
> -			.idlest_idle_bit = OMAP2430_ST_MCBSP3_SHIFT,
> -		},
> -	},
> -	.opt_clks	= mcbsp_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
> -};
> -
> -/* mcbsp4 */
> -static struct omap_hwmod omap2430_mcbsp4_hwmod = {
> -	.name		= "mcbsp4",
> -	.class		= &omap2430_mcbsp_hwmod_class,
> -	.main_clk	= "mcbsp4_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 2,
> -			.idlest_idle_bit = OMAP2430_ST_MCBSP4_SHIFT,
> -		},
> -	},
> -	.opt_clks	= mcbsp_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
> -};
> -
> -/* mcbsp5 */
> -static struct omap_hwmod omap2430_mcbsp5_hwmod = {
> -	.name		= "mcbsp5",
> -	.class		= &omap2430_mcbsp_hwmod_class,
> -	.main_clk	= "mcbsp5_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 2,
> -			.idlest_idle_bit = OMAP2430_ST_MCBSP5_SHIFT,
> -		},
> -	},
> -	.opt_clks	= mcbsp_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
> -};
> -
> -/* MMC/SD/SDIO common */
> -static struct omap_hwmod_class_sysconfig omap2430_mmc_sysc = {
> -	.rev_offs	= 0x1fc,
> -	.sysc_offs	= 0x10,
> -	.syss_offs	= 0x14,
> -	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
> -			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> -			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> -	.sysc_fields    = &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class omap2430_mmc_class = {
> -	.name = "mmc",
> -	.sysc = &omap2430_mmc_sysc,
> -};
> -
> -/* MMC/SD/SDIO1 */
> -static struct omap_hwmod_opt_clk omap2430_mmc1_opt_clks[] = {
> -	{ .role = "dbck", .clk = "mmchsdb1_fck" },
> -};
> -
> -static struct omap_hsmmc_dev_attr mmc1_dev_attr = {
> -	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
> -};
> -
> -static struct omap_hwmod omap2430_mmc1_hwmod = {
> -	.name		= "mmc1",
> -	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -	.opt_clks	= omap2430_mmc1_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(omap2430_mmc1_opt_clks),
> -	.main_clk	= "mmchs1_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 2,
> -			.idlest_idle_bit = OMAP2430_ST_MMCHS1_SHIFT,
> -		},
> -	},
> -	.dev_attr	= &mmc1_dev_attr,
> -	.class		= &omap2430_mmc_class,
> -};
> -
> -/* MMC/SD/SDIO2 */
> -static struct omap_hwmod_opt_clk omap2430_mmc2_opt_clks[] = {
> -	{ .role = "dbck", .clk = "mmchsdb2_fck" },
> -};
> -
> -static struct omap_hwmod omap2430_mmc2_hwmod = {
> -	.name		= "mmc2",
> -	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -	.opt_clks	= omap2430_mmc2_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(omap2430_mmc2_opt_clks),
> -	.main_clk	= "mmchs2_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 2,
> -			.idlest_idle_bit = OMAP2430_ST_MMCHS2_SHIFT,
> -		},
> -	},
> -	.class		= &omap2430_mmc_class,
> -};
> -
> -/* HDQ1W/1-wire */
> -static struct omap_hwmod omap2430_hdq1w_hwmod = {
> -	.name		= "hdq1w",
> -	.main_clk	= "hdq_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_HDQ_SHIFT,
> -		},
> -	},
> -	.class		= &omap2_hdq1w_class,
> -};
> -
> -/*
> - * interfaces
> - */
> -
> -/* L3 -> L4_CORE interface */
> -/* l3_core -> usbhsotg  interface */
> -static struct omap_hwmod_ocp_if omap2430_usbhsotg__l3 = {
> -	.master		= &omap2430_usbhsotg_hwmod,
> -	.slave		= &omap2xxx_l3_main_hwmod,
> -	.clk		= "core_l3_ck",
> -	.user		= OCP_USER_MPU,
> -};
> -
> -/* L4 CORE -> I2C1 interface */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__i2c1 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_i2c1_hwmod,
> -	.clk		= "i2c1_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* L4 CORE -> I2C2 interface */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__i2c2 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_i2c2_hwmod,
> -	.clk		= "i2c2_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/*  l4_core ->usbhsotg  interface */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__usbhsotg = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_usbhsotg_hwmod,
> -	.clk		= "usb_l4_ick",
> -	.user		= OCP_USER_MPU,
> -};
> -
> -/* L4 CORE -> MMC1 interface */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__mmc1 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_mmc1_hwmod,
> -	.clk		= "mmchs1_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* L4 CORE -> MMC2 interface */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_mmc2_hwmod,
> -	.clk		= "mmchs2_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4 core -> mcspi3 interface */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi3 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_mcspi3_hwmod,
> -	.clk		= "mcspi3_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* IVA2 <- L3 interface */
> -static struct omap_hwmod_ocp_if omap2430_l3__iva = {
> -	.master		= &omap2xxx_l3_main_hwmod,
> -	.slave		= &omap2430_iva_hwmod,
> -	.clk		= "core_l3_ck",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_wkup -> wd_timer2 */
> -static struct omap_hwmod_ocp_if omap2430_l4_wkup__wd_timer2 = {
> -	.master		= &omap2xxx_l4_wkup_hwmod,
> -	.slave		= &omap2xxx_wd_timer2_hwmod,
> -	.clk		= "mpu_wdt_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_wkup -> gpio1 */
> -static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio1 = {
> -	.master		= &omap2xxx_l4_wkup_hwmod,
> -	.slave		= &omap2xxx_gpio1_hwmod,
> -	.clk		= "gpios_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_wkup -> gpio2 */
> -static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio2 = {
> -	.master		= &omap2xxx_l4_wkup_hwmod,
> -	.slave		= &omap2xxx_gpio2_hwmod,
> -	.clk		= "gpios_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_wkup -> gpio3 */
> -static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio3 = {
> -	.master		= &omap2xxx_l4_wkup_hwmod,
> -	.slave		= &omap2xxx_gpio3_hwmod,
> -	.clk		= "gpios_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_wkup -> gpio4 */
> -static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio4 = {
> -	.master		= &omap2xxx_l4_wkup_hwmod,
> -	.slave		= &omap2xxx_gpio4_hwmod,
> -	.clk		= "gpios_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> gpio5 */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__gpio5 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_gpio5_hwmod,
> -	.clk		= "gpio5_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> mailbox */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__mailbox = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_mailbox_hwmod,
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> mcbsp1 */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp1 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_mcbsp1_hwmod,
> -	.clk		= "mcbsp1_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> mcbsp2 */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp2 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_mcbsp2_hwmod,
> -	.clk		= "mcbsp2_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> mcbsp3 */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp3 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_mcbsp3_hwmod,
> -	.clk		= "mcbsp3_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> mcbsp4 */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp4 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_mcbsp4_hwmod,
> -	.clk		= "mcbsp4_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> mcbsp5 */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp5 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_mcbsp5_hwmod,
> -	.clk		= "mcbsp5_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> hdq1w */
> -static struct omap_hwmod_ocp_if omap2430_l4_core__hdq1w = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2430_hdq1w_hwmod,
> -	.clk		= "hdq_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -	.flags		= OMAP_FIREWALL_L4 | OCPIF_SWSUP_IDLE,
> -};
> -
> -static struct omap_hwmod_ocp_if omap2430_l3__gpmc = {
> -	.master		= &omap2xxx_l3_main_hwmod,
> -	.slave		= &omap2xxx_gpmc_hwmod,
> -	.clk		= "core_l3_ck",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -static struct omap_hwmod_ocp_if *omap2430_hwmod_ocp_ifs[] __initdata = {
> -	&omap2xxx_l3_main__l4_core,
> -	&omap2xxx_mpu__l3_main,
> -	&omap2xxx_dss__l3,
> -	&omap2430_usbhsotg__l3,
> -	&omap2430_l4_core__i2c1,
> -	&omap2430_l4_core__i2c2,
> -	&omap2xxx_l4_core__l4_wkup,
> -	&omap2_l4_core__uart1,
> -	&omap2_l4_core__uart2,
> -	&omap2_l4_core__uart3,
> -	&omap2430_l4_core__usbhsotg,
> -	&omap2430_l4_core__mmc1,
> -	&omap2430_l4_core__mmc2,
> -	&omap2xxx_l4_core__mcspi1,
> -	&omap2xxx_l4_core__mcspi2,
> -	&omap2430_l4_core__mcspi3,
> -	&omap2430_l3__iva,
> -	&omap2xxx_l4_core__timer3,
> -	&omap2xxx_l4_core__timer4,
> -	&omap2xxx_l4_core__timer5,
> -	&omap2xxx_l4_core__timer6,
> -	&omap2xxx_l4_core__timer7,
> -	&omap2xxx_l4_core__timer8,
> -	&omap2xxx_l4_core__timer9,
> -	&omap2xxx_l4_core__timer10,
> -	&omap2xxx_l4_core__timer11,
> -	&omap2xxx_l4_core__timer12,
> -	&omap2430_l4_wkup__wd_timer2,
> -	&omap2xxx_l4_core__dss,
> -	&omap2xxx_l4_core__dss_dispc,
> -	&omap2xxx_l4_core__dss_rfbi,
> -	&omap2xxx_l4_core__dss_venc,
> -	&omap2430_l4_wkup__gpio1,
> -	&omap2430_l4_wkup__gpio2,
> -	&omap2430_l4_wkup__gpio3,
> -	&omap2430_l4_wkup__gpio4,
> -	&omap2430_l4_core__gpio5,
> -	&omap2430_l4_core__mailbox,
> -	&omap2430_l4_core__mcbsp1,
> -	&omap2430_l4_core__mcbsp2,
> -	&omap2430_l4_core__mcbsp3,
> -	&omap2430_l4_core__mcbsp4,
> -	&omap2430_l4_core__mcbsp5,
> -	&omap2430_l4_core__hdq1w,
> -	&omap2xxx_l4_core__rng,
> -	&omap2xxx_l4_core__sham,
> -	&omap2xxx_l4_core__aes,
> -	&omap2430_l3__gpmc,
> -	NULL,
> -};
> -
> -int __init omap2430_hwmod_init(void)
> -{
> -	omap_hwmod_init();
> -	return omap_hwmod_register_links(omap2430_hwmod_ocp_ifs);
> -}
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
> deleted file mode 100644
> index 761d34914ed9..000000000000
> --- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
> +++ /dev/null
> @@ -1,256 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * omap_hwmod_2xxx_interconnect_data.c - common interconnect data for OMAP2xxx
> - *
> - * Copyright (C) 2009-2011 Nokia Corporation
> - * Paul Walmsley
> - *
> - * XXX handle crossbar/shared link difference for L3?
> - * XXX these should be marked initdata for multi-OMAP kernels
> - */
> -#include <linux/sizes.h>
> -
> -#include "omap_hwmod.h"
> -#include "l3_2xxx.h"
> -#include "l4_2xxx.h"
> -
> -#include "omap_hwmod_common_data.h"
> -
> -/*
> - * Common interconnect data
> - */
> -
> -/* L3 -> L4_CORE interface */
> -struct omap_hwmod_ocp_if omap2xxx_l3_main__l4_core = {
> -	.master	= &omap2xxx_l3_main_hwmod,
> -	.slave	= &omap2xxx_l4_core_hwmod,
> -	.user	= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* MPU -> L3 interface */
> -struct omap_hwmod_ocp_if omap2xxx_mpu__l3_main = {
> -	.master = &omap2xxx_mpu_hwmod,
> -	.slave	= &omap2xxx_l3_main_hwmod,
> -	.user	= OCP_USER_MPU,
> -};
> -
> -/* DSS -> l3 */
> -struct omap_hwmod_ocp_if omap2xxx_dss__l3 = {
> -	.master		= &omap2xxx_dss_core_hwmod,
> -	.slave		= &omap2xxx_l3_main_hwmod,
> -	.fw = {
> -		.omap2 = {
> -			.l3_perm_bit  = OMAP2_L3_CORE_FW_CONNID_DSS,
> -			.flags	= OMAP_FIREWALL_L3,
> -		},
> -	},
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* L4_CORE -> L4_WKUP interface */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__l4_wkup = {
> -	.master	= &omap2xxx_l4_core_hwmod,
> -	.slave	= &omap2xxx_l4_wkup_hwmod,
> -	.user	= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* L4 CORE -> UART1 interface */
> -struct omap_hwmod_ocp_if omap2_l4_core__uart1 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_uart1_hwmod,
> -	.clk		= "uart1_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* L4 CORE -> UART2 interface */
> -struct omap_hwmod_ocp_if omap2_l4_core__uart2 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_uart2_hwmod,
> -	.clk		= "uart2_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* L4 PER -> UART3 interface */
> -struct omap_hwmod_ocp_if omap2_l4_core__uart3 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_uart3_hwmod,
> -	.clk		= "uart3_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4 core -> mcspi1 interface */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__mcspi1 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_mcspi1_hwmod,
> -	.clk		= "mcspi1_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4 core -> mcspi2 interface */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__mcspi2 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_mcspi2_hwmod,
> -	.clk		= "mcspi2_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> timer3 */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__timer3 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_timer3_hwmod,
> -	.clk		= "gpt3_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> timer4 */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__timer4 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_timer4_hwmod,
> -	.clk		= "gpt4_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> timer5 */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__timer5 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_timer5_hwmod,
> -	.clk		= "gpt5_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> timer6 */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__timer6 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_timer6_hwmod,
> -	.clk		= "gpt6_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> timer7 */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__timer7 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_timer7_hwmod,
> -	.clk		= "gpt7_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> timer8 */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__timer8 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_timer8_hwmod,
> -	.clk		= "gpt8_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> timer9 */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__timer9 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_timer9_hwmod,
> -	.clk		= "gpt9_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> timer10 */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__timer10 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_timer10_hwmod,
> -	.clk		= "gpt10_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> timer11 */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__timer11 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_timer11_hwmod,
> -	.clk		= "gpt11_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> timer12 */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__timer12 = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_timer12_hwmod,
> -	.clk		= "gpt12_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> dss */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__dss = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_dss_core_hwmod,
> -	.clk		= "dss_ick",
> -	.fw = {
> -		.omap2 = {
> -			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_CORE_REGION,
> -			.flags	= OMAP_FIREWALL_L4,
> -		},
> -	},
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> dss_dispc */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_dispc = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_dss_dispc_hwmod,
> -	.clk		= "dss_ick",
> -	.fw = {
> -		.omap2 = {
> -			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_DISPC_REGION,
> -			.flags	= OMAP_FIREWALL_L4,
> -		},
> -	},
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> dss_rfbi */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_rfbi = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_dss_rfbi_hwmod,
> -	.clk		= "dss_ick",
> -	.fw = {
> -		.omap2 = {
> -			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_CORE_REGION,
> -			.flags	= OMAP_FIREWALL_L4,
> -		},
> -	},
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> dss_venc */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_venc = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_dss_venc_hwmod,
> -	.clk		= "dss_ick",
> -	.fw = {
> -		.omap2 = {
> -			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_VENC_REGION,
> -			.flags	= OMAP_FIREWALL_L4,
> -		},
> -	},
> -	.flags		= OCPIF_SWSUP_IDLE,
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_core -> rng */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__rng = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_rng_hwmod,
> -	.clk		= "rng_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4 core -> sham interface */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__sham = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_sham_hwmod,
> -	.clk		= "sha_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4 core -> aes interface */
> -struct omap_hwmod_ocp_if omap2xxx_l4_core__aes = {
> -	.master		= &omap2xxx_l4_core_hwmod,
> -	.slave		= &omap2xxx_aes_hwmod,
> -	.clk		= "aes_ick",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
> deleted file mode 100644
> index 4982e04ead53..000000000000
> --- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
> +++ /dev/null
> @@ -1,668 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * omap_hwmod_2xxx_ipblock_data.c - common IP block data for OMAP2xxx
> - *
> - * Copyright (C) 2011 Nokia Corporation
> - * Paul Walmsley
> - */
> -
> -#include <linux/types.h>
> -
> -#include "omap_hwmod.h"
> -#include "omap_hwmod_common_data.h"
> -#include "cm-regbits-24xx.h"
> -#include "prm-regbits-24xx.h"
> -#include "wd_timer.h"
> -
> -/*
> - * 'dispc' class
> - * display controller
> - */
> -
> -static struct omap_hwmod_class_sysconfig omap2_dispc_sysc = {
> -	.rev_offs	= 0x0000,
> -	.sysc_offs	= 0x0010,
> -	.syss_offs	= 0x0014,
> -	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
> -			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class omap2_dispc_hwmod_class = {
> -	.name	= "dispc",
> -	.sysc	= &omap2_dispc_sysc,
> -};
> -
> -/* OMAP2xxx Timer Common */
> -static struct omap_hwmod_class_sysconfig omap2xxx_timer_sysc = {
> -	.rev_offs	= 0x0000,
> -	.sysc_offs	= 0x0010,
> -	.syss_offs	= 0x0014,
> -	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
> -			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> -			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class omap2xxx_timer_hwmod_class = {
> -	.name	= "timer",
> -	.sysc	= &omap2xxx_timer_sysc,
> -};
> -
> -/*
> - * 'wd_timer' class
> - * 32-bit watchdog upward counter that generates a pulse on the reset pin on
> - * overflow condition
> - */
> -
> -static struct omap_hwmod_class_sysconfig omap2xxx_wd_timer_sysc = {
> -	.rev_offs	= 0x0000,
> -	.sysc_offs	= 0x0010,
> -	.syss_offs	= 0x0014,
> -	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_SOFTRESET |
> -			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class omap2xxx_wd_timer_hwmod_class = {
> -	.name		= "wd_timer",
> -	.sysc		= &omap2xxx_wd_timer_sysc,
> -	.pre_shutdown	= &omap2_wd_timer_disable,
> -	.reset		= &omap2_wd_timer_reset,
> -};
> -
> -/*
> - * 'gpio' class
> - * general purpose io module
> - */
> -static struct omap_hwmod_class_sysconfig omap2xxx_gpio_sysc = {
> -	.rev_offs	= 0x0000,
> -	.sysc_offs	= 0x0010,
> -	.syss_offs	= 0x0014,
> -	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
> -			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
> -			   SYSS_HAS_RESET_STATUS),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -struct omap_hwmod_class omap2xxx_gpio_hwmod_class = {
> -	.name = "gpio",
> -	.sysc = &omap2xxx_gpio_sysc,
> -};
> -
> -/*
> - * 'mailbox' class
> - * mailbox module allowing communication between the on-chip processors
> - * using a queued mailbox-interrupt mechanism.
> - */
> -
> -static struct omap_hwmod_class_sysconfig omap2xxx_mailbox_sysc = {
> -	.rev_offs	= 0x000,
> -	.sysc_offs	= 0x010,
> -	.syss_offs	= 0x014,
> -	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
> -			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -struct omap_hwmod_class omap2xxx_mailbox_hwmod_class = {
> -	.name	= "mailbox",
> -	.sysc	= &omap2xxx_mailbox_sysc,
> -};
> -
> -/*
> - * 'mcspi' class
> - * multichannel serial port interface (mcspi) / master/slave synchronous serial
> - * bus
> - */
> -
> -static struct omap_hwmod_class_sysconfig omap2xxx_mcspi_sysc = {
> -	.rev_offs	= 0x0000,
> -	.sysc_offs	= 0x0010,
> -	.syss_offs	= 0x0014,
> -	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
> -				SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> -				SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -struct omap_hwmod_class omap2xxx_mcspi_class = {
> -	.name	= "mcspi",
> -	.sysc	= &omap2xxx_mcspi_sysc,
> -};
> -
> -/*
> - * 'gpmc' class
> - * general purpose memory controller
> - */
> -
> -static struct omap_hwmod_class_sysconfig omap2xxx_gpmc_sysc = {
> -	.rev_offs	= 0x0000,
> -	.sysc_offs	= 0x0010,
> -	.syss_offs	= 0x0014,
> -	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
> -			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class omap2xxx_gpmc_hwmod_class = {
> -	.name	= "gpmc",
> -	.sysc	= &omap2xxx_gpmc_sysc,
> -};
> -
> -/*
> - * IP blocks
> - */
> -
> -/* L3 */
> -struct omap_hwmod omap2xxx_l3_main_hwmod = {
> -	.name		= "l3_main",
> -	.class		= &l3_hwmod_class,
> -	.flags		= HWMOD_NO_IDLEST,
> -};
> -
> -/* L4 CORE */
> -struct omap_hwmod omap2xxx_l4_core_hwmod = {
> -	.name		= "l4_core",
> -	.class		= &l4_hwmod_class,
> -	.flags		= HWMOD_NO_IDLEST,
> -};
> -
> -/* L4 WKUP */
> -struct omap_hwmod omap2xxx_l4_wkup_hwmod = {
> -	.name		= "l4_wkup",
> -	.class		= &l4_hwmod_class,
> -	.flags		= HWMOD_NO_IDLEST,
> -};
> -
> -/* MPU */
> -struct omap_hwmod omap2xxx_mpu_hwmod = {
> -	.name		= "mpu",
> -	.class		= &mpu_hwmod_class,
> -	.main_clk	= "mpu_ck",
> -};
> -
> -/* timer3 */
> -struct omap_hwmod omap2xxx_timer3_hwmod = {
> -	.name		= "timer3",
> -	.main_clk	= "gpt3_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPT3_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_timer_hwmod_class,
> -	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
> -};
> -
> -/* timer4 */
> -struct omap_hwmod omap2xxx_timer4_hwmod = {
> -	.name		= "timer4",
> -	.main_clk	= "gpt4_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPT4_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_timer_hwmod_class,
> -	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
> -};
> -
> -/* timer5 */
> -struct omap_hwmod omap2xxx_timer5_hwmod = {
> -	.name		= "timer5",
> -	.main_clk	= "gpt5_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_timer_hwmod_class,
> -	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
> -};
> -
> -/* timer6 */
> -struct omap_hwmod omap2xxx_timer6_hwmod = {
> -	.name		= "timer6",
> -	.main_clk	= "gpt6_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPT6_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_timer_hwmod_class,
> -	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
> -};
> -
> -/* timer7 */
> -struct omap_hwmod omap2xxx_timer7_hwmod = {
> -	.name		= "timer7",
> -	.main_clk	= "gpt7_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPT7_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_timer_hwmod_class,
> -	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
> -};
> -
> -/* timer8 */
> -struct omap_hwmod omap2xxx_timer8_hwmod = {
> -	.name		= "timer8",
> -	.main_clk	= "gpt8_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPT8_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_timer_hwmod_class,
> -	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
> -};
> -
> -/* timer9 */
> -struct omap_hwmod omap2xxx_timer9_hwmod = {
> -	.name		= "timer9",
> -	.main_clk	= "gpt9_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPT9_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_timer_hwmod_class,
> -	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
> -};
> -
> -/* timer10 */
> -struct omap_hwmod omap2xxx_timer10_hwmod = {
> -	.name		= "timer10",
> -	.main_clk	= "gpt10_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPT10_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_timer_hwmod_class,
> -	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
> -};
> -
> -/* timer11 */
> -struct omap_hwmod omap2xxx_timer11_hwmod = {
> -	.name		= "timer11",
> -	.main_clk	= "gpt11_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPT11_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_timer_hwmod_class,
> -	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
> -};
> -
> -/* timer12 */
> -struct omap_hwmod omap2xxx_timer12_hwmod = {
> -	.name		= "timer12",
> -	.main_clk	= "gpt12_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPT12_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_timer_hwmod_class,
> -	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
> -};
> -
> -/* wd_timer2 */
> -struct omap_hwmod omap2xxx_wd_timer2_hwmod = {
> -	.name		= "wd_timer2",
> -	.class		= &omap2xxx_wd_timer_hwmod_class,
> -	.main_clk	= "mpu_wdt_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = WKUP_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_MPU_WDT_SHIFT,
> -		},
> -	},
> -};
> -
> -/* UART1 */
> -
> -struct omap_hwmod omap2xxx_uart1_hwmod = {
> -	.name		= "uart1",
> -	.main_clk	= "uart1_fck",
> -	.flags		= DEBUG_OMAP2UART1_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_EN_UART1_SHIFT,
> -		},
> -	},
> -	.class		= &omap2_uart_class,
> -};
> -
> -/* UART2 */
> -
> -struct omap_hwmod omap2xxx_uart2_hwmod = {
> -	.name		= "uart2",
> -	.main_clk	= "uart2_fck",
> -	.flags		= DEBUG_OMAP2UART2_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_EN_UART2_SHIFT,
> -		},
> -	},
> -	.class		= &omap2_uart_class,
> -};
> -
> -/* UART3 */
> -
> -struct omap_hwmod omap2xxx_uart3_hwmod = {
> -	.name		= "uart3",
> -	.main_clk	= "uart3_fck",
> -	.flags		= DEBUG_OMAP2UART3_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 2,
> -			.idlest_idle_bit = OMAP24XX_EN_UART3_SHIFT,
> -		},
> -	},
> -	.class		= &omap2_uart_class,
> -};
> -
> -/* dss */
> -
> -static struct omap_hwmod_opt_clk dss_opt_clks[] = {
> -	/*
> -	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
> -	 * driver does not use these clocks.
> -	 */
> -	{ .role = "tv_clk", .clk = "dss_54m_fck" },
> -	{ .role = "sys_clk", .clk = "dss2_fck" },
> -};
> -
> -struct omap_hwmod omap2xxx_dss_core_hwmod = {
> -	.name		= "dss_core",
> -	.class		= &omap2_dss_hwmod_class,
> -	.main_clk	= "dss1_fck", /* instead of dss_fck */
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -		},
> -	},
> -	.opt_clks	= dss_opt_clks,
> -	.opt_clks_cnt = ARRAY_SIZE(dss_opt_clks),
> -	.flags		= HWMOD_NO_IDLEST | HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -};
> -
> -struct omap_hwmod omap2xxx_dss_dispc_hwmod = {
> -	.name		= "dss_dispc",
> -	.class		= &omap2_dispc_hwmod_class,
> -	.main_clk	= "dss1_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -		},
> -	},
> -	.flags		= HWMOD_NO_IDLEST,
> -	.dev_attr	= &omap2_3_dss_dispc_dev_attr,
> -};
> -
> -static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
> -	{ .role = "ick", .clk = "dss_ick" },
> -};
> -
> -struct omap_hwmod omap2xxx_dss_rfbi_hwmod = {
> -	.name		= "dss_rfbi",
> -	.class		= &omap2_rfbi_hwmod_class,
> -	.main_clk	= "dss1_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -		},
> -	},
> -	.opt_clks	= dss_rfbi_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
> -	.flags		= HWMOD_NO_IDLEST,
> -};
> -
> -struct omap_hwmod omap2xxx_dss_venc_hwmod = {
> -	.name		= "dss_venc",
> -	.class		= &omap2_venc_hwmod_class,
> -	.main_clk	= "dss_54m_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -		},
> -	},
> -	.flags		= HWMOD_NO_IDLEST,
> -};
> -
> -/* gpio1 */
> -struct omap_hwmod omap2xxx_gpio1_hwmod = {
> -	.name		= "gpio1",
> -	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -	.main_clk	= "gpios_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = WKUP_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_gpio_hwmod_class,
> -};
> -
> -/* gpio2 */
> -struct omap_hwmod omap2xxx_gpio2_hwmod = {
> -	.name		= "gpio2",
> -	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -	.main_clk	= "gpios_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = WKUP_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_gpio_hwmod_class,
> -};
> -
> -/* gpio3 */
> -struct omap_hwmod omap2xxx_gpio3_hwmod = {
> -	.name		= "gpio3",
> -	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -	.main_clk	= "gpios_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = WKUP_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_gpio_hwmod_class,
> -};
> -
> -/* gpio4 */
> -struct omap_hwmod omap2xxx_gpio4_hwmod = {
> -	.name		= "gpio4",
> -	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -	.main_clk	= "gpios_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = WKUP_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_gpio_hwmod_class,
> -};
> -
> -/* mcspi1 */
> -struct omap_hwmod omap2xxx_mcspi1_hwmod = {
> -	.name		= "mcspi1",
> -	.main_clk	= "mcspi1_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_MCSPI1_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_mcspi_class,
> -};
> -
> -/* mcspi2 */
> -struct omap_hwmod omap2xxx_mcspi2_hwmod = {
> -	.name		= "mcspi2",
> -	.main_clk	= "mcspi2_fck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 1,
> -			.idlest_idle_bit = OMAP24XX_ST_MCSPI2_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_mcspi_class,
> -};
> -
> -/* gpmc */
> -struct omap_hwmod omap2xxx_gpmc_hwmod = {
> -	.name		= "gpmc",
> -	.class		= &omap2xxx_gpmc_hwmod_class,
> -	.main_clk	= "gpmc_fck",
> -	/* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
> -	.flags		= HWMOD_NO_IDLEST | DEBUG_OMAP_GPMC_HWMOD_FLAGS,
> -	.prcm		= {
> -		.omap2	= {
> -			.module_offs = CORE_MOD,
> -		},
> -	},
> -};
> -
> -/* RNG */
> -
> -static struct omap_hwmod_class_sysconfig omap2_rng_sysc = {
> -	.rev_offs	= 0x3c,
> -	.sysc_offs	= 0x40,
> -	.syss_offs	= 0x44,
> -	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
> -			   SYSS_HAS_RESET_STATUS),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class omap2_rng_hwmod_class = {
> -	.name		= "rng",
> -	.sysc		= &omap2_rng_sysc,
> -};
> -
> -struct omap_hwmod omap2xxx_rng_hwmod = {
> -	.name		= "rng",
> -	.main_clk	= "l4_ck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 4,
> -			.idlest_idle_bit = OMAP24XX_ST_RNG_SHIFT,
> -		},
> -	},
> -	/*
> -	 * XXX The first read from the SYSSTATUS register of the RNG
> -	 * after the SYSCONFIG SOFTRESET bit is set triggers an
> -	 * imprecise external abort.  It's unclear why this happens.
> -	 * Until this is analyzed, skip the IP block reset.
> -	 */
> -	.flags		= HWMOD_INIT_NO_RESET,
> -	.class		= &omap2_rng_hwmod_class,
> -};
> -
> -/* SHAM */
> -
> -static struct omap_hwmod_class_sysconfig omap2_sham_sysc = {
> -	.rev_offs	= 0x5c,
> -	.sysc_offs	= 0x60,
> -	.syss_offs	= 0x64,
> -	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
> -			   SYSS_HAS_RESET_STATUS),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class omap2xxx_sham_class = {
> -	.name	= "sham",
> -	.sysc	= &omap2_sham_sysc,
> -};
> -
> -struct omap_hwmod omap2xxx_sham_hwmod = {
> -	.name		= "sham",
> -	.main_clk	= "l4_ck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 4,
> -			.idlest_idle_bit = OMAP24XX_ST_SHA_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_sham_class,
> -};
> -
> -/* AES */
> -
> -static struct omap_hwmod_class_sysconfig omap2_aes_sysc = {
> -	.rev_offs	= 0x44,
> -	.sysc_offs	= 0x48,
> -	.syss_offs	= 0x4c,
> -	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
> -			   SYSS_HAS_RESET_STATUS),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class omap2xxx_aes_class = {
> -	.name	= "aes",
> -	.sysc	= &omap2_aes_sysc,
> -};
> -
> -struct omap_hwmod omap2xxx_aes_hwmod = {
> -	.name		= "aes",
> -	.main_clk	= "l4_ck",
> -	.prcm		= {
> -		.omap2 = {
> -			.module_offs = CORE_MOD,
> -			.idlest_reg_id = 4,
> -			.idlest_idle_bit = OMAP24XX_ST_AES_SHIFT,
> -		},
> -	},
> -	.class		= &omap2xxx_aes_class,
> -};
> diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
> index 69dddc53e1d8..8b270cb3f64b 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
> +++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
> @@ -15,68 +15,6 @@
>   #include "common.h"
>   #include "display.h"
>   
> -/* Common IP block data across OMAP2xxx */
> -extern struct omap_hwmod omap2xxx_l3_main_hwmod;
> -extern struct omap_hwmod omap2xxx_l4_core_hwmod;
> -extern struct omap_hwmod omap2xxx_l4_wkup_hwmod;
> -extern struct omap_hwmod omap2xxx_mpu_hwmod;
> -extern struct omap_hwmod omap2xxx_timer3_hwmod;
> -extern struct omap_hwmod omap2xxx_timer4_hwmod;
> -extern struct omap_hwmod omap2xxx_timer5_hwmod;
> -extern struct omap_hwmod omap2xxx_timer6_hwmod;
> -extern struct omap_hwmod omap2xxx_timer7_hwmod;
> -extern struct omap_hwmod omap2xxx_timer8_hwmod;
> -extern struct omap_hwmod omap2xxx_timer9_hwmod;
> -extern struct omap_hwmod omap2xxx_timer10_hwmod;
> -extern struct omap_hwmod omap2xxx_timer11_hwmod;
> -extern struct omap_hwmod omap2xxx_timer12_hwmod;
> -extern struct omap_hwmod omap2xxx_wd_timer2_hwmod;
> -extern struct omap_hwmod omap2xxx_uart1_hwmod;
> -extern struct omap_hwmod omap2xxx_uart2_hwmod;
> -extern struct omap_hwmod omap2xxx_uart3_hwmod;
> -extern struct omap_hwmod omap2xxx_dss_core_hwmod;
> -extern struct omap_hwmod omap2xxx_dss_dispc_hwmod;
> -extern struct omap_hwmod omap2xxx_dss_rfbi_hwmod;
> -extern struct omap_hwmod omap2xxx_dss_venc_hwmod;
> -extern struct omap_hwmod omap2xxx_gpio1_hwmod;
> -extern struct omap_hwmod omap2xxx_gpio2_hwmod;
> -extern struct omap_hwmod omap2xxx_gpio3_hwmod;
> -extern struct omap_hwmod omap2xxx_gpio4_hwmod;
> -extern struct omap_hwmod omap2xxx_mcspi1_hwmod;
> -extern struct omap_hwmod omap2xxx_mcspi2_hwmod;
> -extern struct omap_hwmod omap2xxx_gpmc_hwmod;
> -extern struct omap_hwmod omap2xxx_rng_hwmod;
> -extern struct omap_hwmod omap2xxx_sham_hwmod;
> -extern struct omap_hwmod omap2xxx_aes_hwmod;
> -
> -/* Common interface data across OMAP2xxx */
> -extern struct omap_hwmod_ocp_if omap2xxx_l3_main__l4_core;
> -extern struct omap_hwmod_ocp_if omap2xxx_mpu__l3_main;
> -extern struct omap_hwmod_ocp_if omap2xxx_dss__l3;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__l4_wkup;
> -extern struct omap_hwmod_ocp_if omap2_l4_core__uart1;
> -extern struct omap_hwmod_ocp_if omap2_l4_core__uart2;
> -extern struct omap_hwmod_ocp_if omap2_l4_core__uart3;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__mcspi1;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__mcspi2;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer3;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer4;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer5;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer6;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer7;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer8;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer9;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer10;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer11;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer12;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_dispc;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_rfbi;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_venc;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__rng;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__sham;
> -extern struct omap_hwmod_ocp_if omap2xxx_l4_core__aes;
> -
>   /* OMAP hwmod classes - forward declarations */
>   extern struct omap_hwmod_class l3_hwmod_class;
>   extern struct omap_hwmod_class l4_hwmod_class;
> @@ -88,10 +26,6 @@ extern struct omap_hwmod_class omap2_rfbi_hwmod_class;
>   extern struct omap_hwmod_class omap2_venc_hwmod_class;
>   extern struct omap_hwmod_class omap2_hdq1w_class;
>   
> -extern struct omap_hwmod_class omap2xxx_gpio_hwmod_class;
> -extern struct omap_hwmod_class omap2xxx_mailbox_hwmod_class;
> -extern struct omap_hwmod_class omap2xxx_mcspi_class;
> -
>   extern struct omap_dss_dispc_dev_attr omap2_3_dss_dispc_dev_attr;
>   
>   #endif
> diff --git a/arch/arm/mach-omap2/opp2420_data.c b/arch/arm/mach-omap2/opp2420_data.c
> deleted file mode 100644
> index 18a448f938ea..000000000000
> --- a/arch/arm/mach-omap2/opp2420_data.c
> +++ /dev/null
> @@ -1,131 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * opp2420_data.c - old-style "OPP" table for OMAP2420
> - *
> - * Copyright (C) 2005-2009 Texas Instruments, Inc.
> - * Copyright (C) 2004-2009 Nokia Corporation
> - *
> - * Richard Woodruff <r-woodruff2@ti.com>
> - *
> - * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
> - * These configurations are characterized by voltage and speed for clocks.
> - * The device is only validated for certain combinations. One way to express
> - * these combinations is via the 'ratios' which the clocks operate with
> - * respect to each other. These ratio sets are for a given voltage/DPLL
> - * setting. All configurations can be described by a DPLL setting and a ratio.
> - *
> - * XXX Missing voltage data.
> - * XXX Missing 19.2MHz sys_clk rate sets (needed for N800/N810)
> - *
> - * THe format described in this file is deprecated.  Once a reasonable
> - * OPP API exists, the data in this file should be converted to use it.
> - *
> - * This is technically part of the OMAP2xxx clock code.
> - *
> - * Considerable work is still needed to fully support dynamic frequency
> - * changes on OMAP2xxx-series chips.  Readers interested in such a
> - * project are encouraged to review the Maemo Diablo RX-34 and RX-44
> - * kernel source at:
> - *     http://repository.maemo.org/pool/diablo/free/k/kernel-source-diablo/
> - */
> -
> -#include <linux/kernel.h>
> -
> -#include "opp2xxx.h"
> -#include "sdrc.h"
> -#include "clock.h"
> -
> -/*
> - * Key dividers which make up a PRCM set. Ratios for a PRCM are mandated.
> - * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,
> - * CM_CLKSEL_DSP, CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL,
> - * CM_CLKSEL2_PLL, CM_CLKSEL_MDM
> - *
> - * Filling in table based on H4 boards available.  There are quite a
> - * few more rate combinations which could be defined.
> - *
> - * When multiple values are defined the start up will try and choose
> - * the fastest one. If a 'fast' value is defined, then automatically,
> - * the /2 one should be included as it can be used.  Generally having
> - * more than one fast set does not make sense, as static timings need
> - * to be changed to change the set.  The exception is the bypass
> - * setting which is available for low power bypass.
> - *
> - * Note: This table needs to be sorted, fastest to slowest.
> - **/
> -const struct prcm_config omap2420_rate_table[] = {
> -	/* PRCM I - FAST */
> -	{S12M, S660M, S330M, RI_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
> -		RI_CM_CLKSEL_DSP_VAL, RI_CM_CLKSEL_GFX_VAL,
> -		RI_CM_CLKSEL1_CORE_VAL, MI_CM_CLKSEL1_PLL_12_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_165MHz,
> -		RATE_IN_242X},
> -
> -	/* PRCM II - FAST */
> -	{S12M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
> -		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
> -		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
> -		RATE_IN_242X},
> -
> -	{S13M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
> -		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
> -		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
> -		RATE_IN_242X},
> -
> -	/* PRCM III - FAST */
> -	{S12M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
> -		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
> -		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
> -		RATE_IN_242X},
> -
> -	{S13M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
> -		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
> -		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
> -		RATE_IN_242X},
> -
> -	/* PRCM II - SLOW */
> -	{S12M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
> -		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
> -		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
> -		RATE_IN_242X},
> -
> -	{S13M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
> -		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
> -		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
> -		RATE_IN_242X},
> -
> -	/* PRCM III - SLOW */
> -	{S12M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
> -		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
> -		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
> -		RATE_IN_242X},
> -
> -	{S13M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
> -		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
> -		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
> -		RATE_IN_242X},
> -
> -	/* PRCM-VII (boot-bypass) */
> -	{S12M, S12M, S12M, RVII_CM_CLKSEL_MPU_VAL,		/* 12MHz ARM*/
> -		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
> -		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_12_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_BYPASS,
> -		RATE_IN_242X},
> -
> -	/* PRCM-VII (boot-bypass) */
> -	{S13M, S13M, S13M, RVII_CM_CLKSEL_MPU_VAL,		/* 13MHz ARM */
> -		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
> -		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_BYPASS,
> -		RATE_IN_242X},
> -
> -	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
> -};
> diff --git a/arch/arm/mach-omap2/opp2430_data.c b/arch/arm/mach-omap2/opp2430_data.c
> deleted file mode 100644
> index ded8b566a23a..000000000000
> --- a/arch/arm/mach-omap2/opp2430_data.c
> +++ /dev/null
> @@ -1,136 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * opp2430_data.c - old-style "OPP" table for OMAP2430
> - *
> - * Copyright (C) 2005-2009 Texas Instruments, Inc.
> - * Copyright (C) 2004-2009 Nokia Corporation
> - *
> - * Richard Woodruff <r-woodruff2@ti.com>
> - *
> - * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
> - * These configurations are characterized by voltage and speed for clocks.
> - * The device is only validated for certain combinations. One way to express
> - * these combinations is via the 'ratios' which the clocks operate with
> - * respect to each other. These ratio sets are for a given voltage/DPLL
> - * setting. All configurations can be described by a DPLL setting and a ratio.
> - *
> - * 2430 differs from 2420 in that there are no more phase synchronizers used.
> - * They both have a slightly different clock domain setup. 2420(iva1,dsp) vs
> - * 2430 (iva2.1, NOdsp, mdm)
> - *
> - * XXX Missing voltage data.
> - * XXX Missing 19.2MHz sys_clk rate sets.
> - *
> - * THe format described in this file is deprecated.  Once a reasonable
> - * OPP API exists, the data in this file should be converted to use it.
> - *
> - * This is technically part of the OMAP2xxx clock code.
> - */
> -
> -#include <linux/kernel.h>
> -
> -#include "opp2xxx.h"
> -#include "sdrc.h"
> -#include "clock.h"
> -
> -/*
> - * Key dividers which make up a PRCM set. Ratios for a PRCM are mandated.
> - * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,
> - * CM_CLKSEL_DSP, CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL,
> - * CM_CLKSEL2_PLL, CM_CLKSEL_MDM
> - *
> - * Filling in table based on 2430-SDPs variants available.  There are
> - * quite a few more rate combinations which could be defined.
> - *
> - * When multiple values are defined the start up will try and choose
> - * the fastest one. If a 'fast' value is defined, then automatically,
> - * the /2 one should be included as it can be used.  Generally having
> - * more than one fast set does not make sense, as static timings need
> - * to be changed to change the set.  The exception is the bypass
> - * setting which is available for low power bypass.
> - *
> - * Note: This table needs to be sorted, fastest to slowest.
> - */
> -const struct prcm_config omap2430_rate_table[] = {
> -	/* PRCM #4 - ratio2 (ES2.1) - FAST */
> -	{S13M, S798M, S399M, R2_CM_CLKSEL_MPU_VAL,		/* 399MHz ARM */
> -		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
> -		R2_CM_CLKSEL1_CORE_VAL, M4_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, R2_CM_CLKSEL_MDM_VAL,
> -		SDRC_RFR_CTRL_133MHz,
> -		RATE_IN_243X},
> -
> -	/* PRCM #2 - ratio1 (ES2) - FAST */
> -	{S13M, S658M, S329M, R1_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
> -		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
> -		R1_CM_CLKSEL1_CORE_VAL, M2_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
> -		SDRC_RFR_CTRL_165MHz,
> -		RATE_IN_243X},
> -
> -	/* PRCM #5a - ratio1 - FAST */
> -	{S13M, S532M, S266M, R1_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
> -		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
> -		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
> -		SDRC_RFR_CTRL_133MHz,
> -		RATE_IN_243X},
> -
> -	/* PRCM #5b - ratio1 - FAST */
> -	{S13M, S400M, S200M, R1_CM_CLKSEL_MPU_VAL,		/* 200MHz ARM */
> -		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
> -		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
> -		SDRC_RFR_CTRL_100MHz,
> -		RATE_IN_243X},
> -
> -	/* PRCM #4 - ratio1 (ES2.1) - SLOW */
> -	{S13M, S399M, S199M, R2_CM_CLKSEL_MPU_VAL,		/* 200MHz ARM */
> -		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
> -		R2_CM_CLKSEL1_CORE_VAL, M4_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_1x_VAL, R2_CM_CLKSEL_MDM_VAL,
> -		SDRC_RFR_CTRL_133MHz,
> -		RATE_IN_243X},
> -
> -	/* PRCM #2 - ratio1 (ES2) - SLOW */
> -	{S13M, S329M, S164M, R1_CM_CLKSEL_MPU_VAL,		/* 165MHz ARM */
> -		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
> -		R1_CM_CLKSEL1_CORE_VAL, M2_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
> -		SDRC_RFR_CTRL_165MHz,
> -		RATE_IN_243X},
> -
> -	/* PRCM #5a - ratio1 - SLOW */
> -	{S13M, S266M, S133M, R1_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
> -		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
> -		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
> -		SDRC_RFR_CTRL_133MHz,
> -		RATE_IN_243X},
> -
> -	/* PRCM #5b - ratio1 - SLOW*/
> -	{S13M, S200M, S100M, R1_CM_CLKSEL_MPU_VAL,		/* 100MHz ARM */
> -		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
> -		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
> -		SDRC_RFR_CTRL_100MHz,
> -		RATE_IN_243X},
> -
> -	/* PRCM-boot/bypass */
> -	{S13M, S13M, S13M, RB_CM_CLKSEL_MPU_VAL,		/* 13MHz */
> -		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
> -		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_13_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
> -		SDRC_RFR_CTRL_BYPASS,
> -		RATE_IN_243X},
> -
> -	/* PRCM-boot/bypass */
> -	{S12M, S12M, S12M, RB_CM_CLKSEL_MPU_VAL,		/* 12MHz */
> -		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
> -		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_12_VAL,
> -		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
> -		SDRC_RFR_CTRL_BYPASS,
> -		RATE_IN_243X},
> -
> -	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
> -};
> diff --git a/arch/arm/mach-omap2/opp2xxx.h b/arch/arm/mach-omap2/opp2xxx.h
> deleted file mode 100644
> index a451182cdc02..000000000000
> --- a/arch/arm/mach-omap2/opp2xxx.h
> +++ /dev/null
> @@ -1,430 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * opp2xxx.h - macros for old-style OMAP2xxx "OPP" definitions
> - *
> - * Copyright (C) 2005-2009 Texas Instruments, Inc.
> - * Copyright (C) 2004-2009 Nokia Corporation
> - *
> - * Richard Woodruff <r-woodruff2@ti.com>
> - *
> - * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
> - * These configurations are characterized by voltage and speed for clocks.
> - * The device is only validated for certain combinations. One way to express
> - * these combinations is via the 'ratio's' which the clocks operate with
> - * respect to each other. These ratio sets are for a given voltage/DPLL
> - * setting. All configurations can be described by a DPLL setting and a ratio
> - * There are 3 ratio sets for the 2430 and X ratio sets for 2420.
> - *
> - * 2430 differs from 2420 in that there are no more phase synchronizers used.
> - * They both have a slightly different clock domain setup. 2420(iva1,dsp) vs
> - * 2430 (iva2.1, NOdsp, mdm)
> - *
> - * XXX Missing voltage data.
> - *
> - * THe format described in this file is deprecated.  Once a reasonable
> - * OPP API exists, the data in this file should be converted to use it.
> - *
> - * This is technically part of the OMAP2xxx clock code.
> - */
> -
> -#ifndef __ARCH_ARM_MACH_OMAP2_OPP2XXX_H
> -#define __ARCH_ARM_MACH_OMAP2_OPP2XXX_H
> -
> -/**
> - * struct prcm_config - define clock rates on a per-OPP basis (24xx)
> - *
> - * Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
> - * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
> - * CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL CM_CLKSEL2_PLL, CM_CLKSEL_MDM
> - *
> - * This is deprecated.  As soon as we have a decent OPP API, we should
> - * move all this stuff to it.
> - */
> -struct prcm_config {
> -	unsigned long xtal_speed;	/* crystal rate */
> -	unsigned long dpll_speed;	/* dpll: out*xtal*M/(N-1)table_recalc */
> -	unsigned long mpu_speed;	/* speed of MPU */
> -	unsigned long cm_clksel_mpu;	/* mpu divider */
> -	unsigned long cm_clksel_dsp;	/* dsp+iva1 div(2420), iva2.1(2430) */
> -	unsigned long cm_clksel_gfx;	/* gfx dividers */
> -	unsigned long cm_clksel1_core;	/* major subsystem dividers */
> -	unsigned long cm_clksel1_pll;	/* m,n */
> -	unsigned long cm_clksel2_pll;	/* dpllx1 or x2 out */
> -	unsigned long cm_clksel_mdm;	/* modem dividers 2430 only */
> -	unsigned long base_sdrc_rfr;	/* base refresh timing for a set */
> -	unsigned short flags;
> -};
> -
> -
> -/* Core fields for cm_clksel, not ratio governed */
> -#define RX_CLKSEL_DSS1			(0x10 << 8)
> -#define RX_CLKSEL_DSS2			(0x0 << 13)
> -#define RX_CLKSEL_SSI			(0x5 << 20)
> -
> -/*-------------------------------------------------------------------------
> - * Voltage/DPLL ratios
> - *-------------------------------------------------------------------------*/
> -
> -/* 2430 Ratio's, 2430-Ratio Config 1 */
> -#define R1_CLKSEL_L3			(4 << 0)
> -#define R1_CLKSEL_L4			(2 << 5)
> -#define R1_CLKSEL_USB			(4 << 25)
> -#define R1_CM_CLKSEL1_CORE_VAL		(R1_CLKSEL_USB | RX_CLKSEL_SSI | \
> -					 RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
> -					 R1_CLKSEL_L4 | R1_CLKSEL_L3)
> -#define R1_CLKSEL_MPU			(2 << 0)
> -#define R1_CM_CLKSEL_MPU_VAL		R1_CLKSEL_MPU
> -#define R1_CLKSEL_DSP			(2 << 0)
> -#define R1_CLKSEL_DSP_IF		(2 << 5)
> -#define R1_CM_CLKSEL_DSP_VAL		(R1_CLKSEL_DSP | R1_CLKSEL_DSP_IF)
> -#define R1_CLKSEL_GFX			(2 << 0)
> -#define R1_CM_CLKSEL_GFX_VAL		R1_CLKSEL_GFX
> -#define R1_CLKSEL_MDM			(4 << 0)
> -#define R1_CM_CLKSEL_MDM_VAL		R1_CLKSEL_MDM
> -
> -/* 2430-Ratio Config 2 */
> -#define R2_CLKSEL_L3			(6 << 0)
> -#define R2_CLKSEL_L4			(2 << 5)
> -#define R2_CLKSEL_USB			(2 << 25)
> -#define R2_CM_CLKSEL1_CORE_VAL		(R2_CLKSEL_USB | RX_CLKSEL_SSI | \
> -					 RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
> -					 R2_CLKSEL_L4 | R2_CLKSEL_L3)
> -#define R2_CLKSEL_MPU			(2 << 0)
> -#define R2_CM_CLKSEL_MPU_VAL		R2_CLKSEL_MPU
> -#define R2_CLKSEL_DSP			(2 << 0)
> -#define R2_CLKSEL_DSP_IF		(3 << 5)
> -#define R2_CM_CLKSEL_DSP_VAL		(R2_CLKSEL_DSP | R2_CLKSEL_DSP_IF)
> -#define R2_CLKSEL_GFX			(2 << 0)
> -#define R2_CM_CLKSEL_GFX_VAL		R2_CLKSEL_GFX
> -#define R2_CLKSEL_MDM			(6 << 0)
> -#define R2_CM_CLKSEL_MDM_VAL		R2_CLKSEL_MDM
> -
> -/* 2430-Ratio Bootm (BYPASS) */
> -#define RB_CLKSEL_L3			(1 << 0)
> -#define RB_CLKSEL_L4			(1 << 5)
> -#define RB_CLKSEL_USB			(1 << 25)
> -#define RB_CM_CLKSEL1_CORE_VAL		(RB_CLKSEL_USB | RX_CLKSEL_SSI | \
> -					 RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
> -					 RB_CLKSEL_L4 | RB_CLKSEL_L3)
> -#define RB_CLKSEL_MPU			(1 << 0)
> -#define RB_CM_CLKSEL_MPU_VAL		RB_CLKSEL_MPU
> -#define RB_CLKSEL_DSP			(1 << 0)
> -#define RB_CLKSEL_DSP_IF		(1 << 5)
> -#define RB_CM_CLKSEL_DSP_VAL		(RB_CLKSEL_DSP | RB_CLKSEL_DSP_IF)
> -#define RB_CLKSEL_GFX			(1 << 0)
> -#define RB_CM_CLKSEL_GFX_VAL		RB_CLKSEL_GFX
> -#define RB_CLKSEL_MDM			(1 << 0)
> -#define RB_CM_CLKSEL_MDM_VAL		RB_CLKSEL_MDM
> -
> -/* 2420 Ratio Equivalents */
> -#define RXX_CLKSEL_VLYNQ		(0x12 << 15)
> -#define RXX_CLKSEL_SSI			(0x8 << 20)
> -
> -/* 2420-PRCM III 532MHz core */
> -#define RIII_CLKSEL_L3			(4 << 0)	/* 133MHz */
> -#define RIII_CLKSEL_L4			(2 << 5)	/* 66.5MHz */
> -#define RIII_CLKSEL_USB			(4 << 25)	/* 33.25MHz */
> -#define RIII_CM_CLKSEL1_CORE_VAL	(RIII_CLKSEL_USB | RXX_CLKSEL_SSI | \
> -					 RXX_CLKSEL_VLYNQ | RX_CLKSEL_DSS2 | \
> -					 RX_CLKSEL_DSS1 | RIII_CLKSEL_L4 | \
> -					 RIII_CLKSEL_L3)
> -#define RIII_CLKSEL_MPU			(2 << 0)	/* 266MHz */
> -#define RIII_CM_CLKSEL_MPU_VAL		RIII_CLKSEL_MPU
> -#define RIII_CLKSEL_DSP			(3 << 0)	/* c5x - 177.3MHz */
> -#define RIII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 88.67MHz */
> -#define RIII_SYNC_DSP			(1 << 7)	/* Enable sync */
> -#define RIII_CLKSEL_IVA			(6 << 8)	/* iva1 - 88.67MHz */
> -#define RIII_SYNC_IVA			(1 << 13)	/* Enable sync */
> -#define RIII_CM_CLKSEL_DSP_VAL		(RIII_SYNC_IVA | RIII_CLKSEL_IVA | \
> -					 RIII_SYNC_DSP | RIII_CLKSEL_DSP_IF | \
> -					 RIII_CLKSEL_DSP)
> -#define RIII_CLKSEL_GFX			(2 << 0)	/* 66.5MHz */
> -#define RIII_CM_CLKSEL_GFX_VAL		RIII_CLKSEL_GFX
> -
> -/* 2420-PRCM II 600MHz core */
> -#define RII_CLKSEL_L3			(6 << 0)	/* 100MHz */
> -#define RII_CLKSEL_L4			(2 << 5)	/* 50MHz */
> -#define RII_CLKSEL_USB			(2 << 25)	/* 50MHz */
> -#define RII_CM_CLKSEL1_CORE_VAL		(RII_CLKSEL_USB | RXX_CLKSEL_SSI | \
> -					 RXX_CLKSEL_VLYNQ | RX_CLKSEL_DSS2 | \
> -					 RX_CLKSEL_DSS1 | RII_CLKSEL_L4 | \
> -					 RII_CLKSEL_L3)
> -#define RII_CLKSEL_MPU			(2 << 0)	/* 300MHz */
> -#define RII_CM_CLKSEL_MPU_VAL		RII_CLKSEL_MPU
> -#define RII_CLKSEL_DSP			(3 << 0)	/* c5x - 200MHz */
> -#define RII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 100MHz */
> -#define RII_SYNC_DSP			(0 << 7)	/* Bypass sync */
> -#define RII_CLKSEL_IVA			(3 << 8)	/* iva1 - 200MHz */
> -#define RII_SYNC_IVA			(0 << 13)	/* Bypass sync */
> -#define RII_CM_CLKSEL_DSP_VAL		(RII_SYNC_IVA | RII_CLKSEL_IVA | \
> -					 RII_SYNC_DSP | RII_CLKSEL_DSP_IF | \
> -					 RII_CLKSEL_DSP)
> -#define RII_CLKSEL_GFX			(2 << 0)	/* 50MHz */
> -#define RII_CM_CLKSEL_GFX_VAL		RII_CLKSEL_GFX
> -
> -/* 2420-PRCM I 660MHz core */
> -#define RI_CLKSEL_L3			(4 << 0)	/* 165MHz */
> -#define RI_CLKSEL_L4			(2 << 5)	/* 82.5MHz */
> -#define RI_CLKSEL_USB			(4 << 25)	/* 41.25MHz */
> -#define RI_CM_CLKSEL1_CORE_VAL		(RI_CLKSEL_USB |		\
> -					 RXX_CLKSEL_SSI | RXX_CLKSEL_VLYNQ | \
> -					 RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
> -					 RI_CLKSEL_L4 | RI_CLKSEL_L3)
> -#define RI_CLKSEL_MPU			(2 << 0)	/* 330MHz */
> -#define RI_CM_CLKSEL_MPU_VAL		RI_CLKSEL_MPU
> -#define RI_CLKSEL_DSP			(3 << 0)	/* c5x - 220MHz */
> -#define RI_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 110MHz */
> -#define RI_SYNC_DSP			(1 << 7)	/* Activate sync */
> -#define RI_CLKSEL_IVA			(4 << 8)	/* iva1 - 165MHz */
> -#define RI_SYNC_IVA			(0 << 13)	/* Bypass sync */
> -#define RI_CM_CLKSEL_DSP_VAL		(RI_SYNC_IVA | RI_CLKSEL_IVA |	\
> -					 RI_SYNC_DSP | RI_CLKSEL_DSP_IF | \
> -					 RI_CLKSEL_DSP)
> -#define RI_CLKSEL_GFX			(1 << 0)	/* 165MHz */
> -#define RI_CM_CLKSEL_GFX_VAL		RI_CLKSEL_GFX
> -
> -/* 2420-PRCM VII (boot) */
> -#define RVII_CLKSEL_L3			(1 << 0)
> -#define RVII_CLKSEL_L4			(1 << 5)
> -#define RVII_CLKSEL_DSS1		(1 << 8)
> -#define RVII_CLKSEL_DSS2		(0 << 13)
> -#define RVII_CLKSEL_VLYNQ		(1 << 15)
> -#define RVII_CLKSEL_SSI			(1 << 20)
> -#define RVII_CLKSEL_USB			(1 << 25)
> -
> -#define RVII_CM_CLKSEL1_CORE_VAL	(RVII_CLKSEL_USB | RVII_CLKSEL_SSI | \
> -					 RVII_CLKSEL_VLYNQ | \
> -					 RVII_CLKSEL_DSS2 | RVII_CLKSEL_DSS1 | \
> -					 RVII_CLKSEL_L4 | RVII_CLKSEL_L3)
> -
> -#define RVII_CLKSEL_MPU			(1 << 0) /* all divide by 1 */
> -#define RVII_CM_CLKSEL_MPU_VAL		RVII_CLKSEL_MPU
> -
> -#define RVII_CLKSEL_DSP			(1 << 0)
> -#define RVII_CLKSEL_DSP_IF		(1 << 5)
> -#define RVII_SYNC_DSP			(0 << 7)
> -#define RVII_CLKSEL_IVA			(1 << 8)
> -#define RVII_SYNC_IVA			(0 << 13)
> -#define RVII_CM_CLKSEL_DSP_VAL		(RVII_SYNC_IVA | RVII_CLKSEL_IVA | \
> -					 RVII_SYNC_DSP | RVII_CLKSEL_DSP_IF | \
> -					 RVII_CLKSEL_DSP)
> -
> -#define RVII_CLKSEL_GFX			(1 << 0)
> -#define RVII_CM_CLKSEL_GFX_VAL		RVII_CLKSEL_GFX
> -
> -/*-------------------------------------------------------------------------
> - * 2430 Target modes: Along with each configuration the CPU has several
> - * modes which goes along with them. Modes mainly are the addition of
> - * describe DPLL combinations to go along with a ratio.
> - *-------------------------------------------------------------------------*/
> -
> -/* Hardware governed */
> -#define MX_48M_SRC			(0 << 3)
> -#define MX_54M_SRC			(0 << 5)
> -#define MX_APLLS_CLIKIN_12		(3 << 23)
> -#define MX_APLLS_CLIKIN_13		(2 << 23)
> -#define MX_APLLS_CLIKIN_19_2		(0 << 23)
> -
> -/*
> - * 2430 - standalone, 2*ref*M/(n+1), M/N is for exactness not relock speed
> - * #5a	(ratio1) baseport-target, target DPLL = 266*2 = 532MHz
> - */
> -#define M5A_DPLL_MULT_12		(133 << 12)
> -#define M5A_DPLL_DIV_12			(5 << 8)
> -#define M5A_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M5A_DPLL_DIV_12 | M5A_DPLL_MULT_12 | \
> -					 MX_APLLS_CLIKIN_12)
> -#define M5A_DPLL_MULT_13		(61 << 12)
> -#define M5A_DPLL_DIV_13			(2 << 8)
> -#define M5A_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M5A_DPLL_DIV_13 | M5A_DPLL_MULT_13 | \
> -					 MX_APLLS_CLIKIN_13)
> -#define M5A_DPLL_MULT_19		(55 << 12)
> -#define M5A_DPLL_DIV_19			(3 << 8)
> -#define M5A_CM_CLKSEL1_PLL_19_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M5A_DPLL_DIV_19 | M5A_DPLL_MULT_19 | \
> -					 MX_APLLS_CLIKIN_19_2)
> -/* #5b	(ratio1) target DPLL = 200*2 = 400MHz */
> -#define M5B_DPLL_MULT_12		(50 << 12)
> -#define M5B_DPLL_DIV_12			(2 << 8)
> -#define M5B_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M5B_DPLL_DIV_12 | M5B_DPLL_MULT_12 | \
> -					 MX_APLLS_CLIKIN_12)
> -#define M5B_DPLL_MULT_13		(200 << 12)
> -#define M5B_DPLL_DIV_13			(12 << 8)
> -
> -#define M5B_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M5B_DPLL_DIV_13 | M5B_DPLL_MULT_13 | \
> -					 MX_APLLS_CLIKIN_13)
> -#define M5B_DPLL_MULT_19		(125 << 12)
> -#define M5B_DPLL_DIV_19			(31 << 8)
> -#define M5B_CM_CLKSEL1_PLL_19_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M5B_DPLL_DIV_19 | M5B_DPLL_MULT_19 | \
> -					 MX_APLLS_CLIKIN_19_2)
> -/*
> - * #4	(ratio2), DPLL = 399*2 = 798MHz, L3=133MHz
> - */
> -#define M4_DPLL_MULT_12			(133 << 12)
> -#define M4_DPLL_DIV_12			(3 << 8)
> -#define M4_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M4_DPLL_DIV_12 | M4_DPLL_MULT_12 | \
> -					 MX_APLLS_CLIKIN_12)
> -
> -#define M4_DPLL_MULT_13			(399 << 12)
> -#define M4_DPLL_DIV_13			(12 << 8)
> -#define M4_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M4_DPLL_DIV_13 | M4_DPLL_MULT_13 | \
> -					 MX_APLLS_CLIKIN_13)
> -
> -#define M4_DPLL_MULT_19			(145 << 12)
> -#define M4_DPLL_DIV_19			(6 << 8)
> -#define M4_CM_CLKSEL1_PLL_19_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M4_DPLL_DIV_19 | M4_DPLL_MULT_19 | \
> -					 MX_APLLS_CLIKIN_19_2)
> -
> -/*
> - * #3	(ratio2) baseport-target, target DPLL = 330*2 = 660MHz
> - */
> -#define M3_DPLL_MULT_12			(55 << 12)
> -#define M3_DPLL_DIV_12			(1 << 8)
> -#define M3_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M3_DPLL_DIV_12 | M3_DPLL_MULT_12 | \
> -					 MX_APLLS_CLIKIN_12)
> -#define M3_DPLL_MULT_13			(76 << 12)
> -#define M3_DPLL_DIV_13			(2 << 8)
> -#define M3_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M3_DPLL_DIV_13 | M3_DPLL_MULT_13 | \
> -					 MX_APLLS_CLIKIN_13)
> -#define M3_DPLL_MULT_19			(17 << 12)
> -#define M3_DPLL_DIV_19			(0 << 8)
> -#define M3_CM_CLKSEL1_PLL_19_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M3_DPLL_DIV_19 | M3_DPLL_MULT_19 | \
> -					 MX_APLLS_CLIKIN_19_2)
> -
> -/*
> - * #2   (ratio1) DPLL = 330*2 = 660MHz, L3=165MHz
> - */
> -#define M2_DPLL_MULT_12		        (55 << 12)
> -#define M2_DPLL_DIV_12		        (1 << 8)
> -#define M2_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M2_DPLL_DIV_12 | M2_DPLL_MULT_12 | \
> -					 MX_APLLS_CLIKIN_12)
> -
> -/* Speed changes - Used 658.7MHz instead of 660MHz for LP-Refresh M=76 N=2,
> - * relock time issue */
> -/* Core frequency changed from 330/165 to 329/164 MHz*/
> -#define M2_DPLL_MULT_13		        (76 << 12)
> -#define M2_DPLL_DIV_13		        (2 << 8)
> -#define M2_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M2_DPLL_DIV_13 | M2_DPLL_MULT_13 | \
> -					 MX_APLLS_CLIKIN_13)
> -
> -#define M2_DPLL_MULT_19		        (17 << 12)
> -#define M2_DPLL_DIV_19		        (0 << 8)
> -#define M2_CM_CLKSEL1_PLL_19_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 M2_DPLL_DIV_19 | M2_DPLL_MULT_19 | \
> -					 MX_APLLS_CLIKIN_19_2)
> -
> -/* boot (boot) */
> -#define MB_DPLL_MULT			(1 << 12)
> -#define MB_DPLL_DIV			(0 << 8)
> -#define MB_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 MB_DPLL_DIV | MB_DPLL_MULT | \
> -					 MX_APLLS_CLIKIN_12)
> -
> -#define MB_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 MB_DPLL_DIV | MB_DPLL_MULT | \
> -					 MX_APLLS_CLIKIN_13)
> -
> -#define MB_CM_CLKSEL1_PLL_19_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 MB_DPLL_DIV | MB_DPLL_MULT | \
> -					 MX_APLLS_CLIKIN_19)
> -
> -/*
> - * 2430 - chassis (sedna)
> - * 165 (ratio1) same as above #2
> - * 150 (ratio1)
> - * 133 (ratio2) same as above #4
> - * 110 (ratio2) same as above #3
> - * 104 (ratio2)
> - * boot (boot)
> - */
> -
> -/* PRCM I target DPLL = 2*330MHz = 660MHz */
> -#define MI_DPLL_MULT_12			(55 << 12)
> -#define MI_DPLL_DIV_12			(1 << 8)
> -#define MI_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
> -					 MI_DPLL_DIV_12 | MI_DPLL_MULT_12 | \
> -					 MX_APLLS_CLIKIN_12)
> -
> -/*
> - * 2420 Equivalent - mode registers
> - * PRCM II , target DPLL = 2*300MHz = 600MHz
> - */
> -#define MII_DPLL_MULT_12		(50 << 12)
> -#define MII_DPLL_DIV_12			(1 << 8)
> -#define MII_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC |	\
> -					 MII_DPLL_DIV_12 | MII_DPLL_MULT_12 | \
> -					 MX_APLLS_CLIKIN_12)
> -#define MII_DPLL_MULT_13		(300 << 12)
> -#define MII_DPLL_DIV_13			(12 << 8)
> -#define MII_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC |	\
> -					 MII_DPLL_DIV_13 | MII_DPLL_MULT_13 | \
> -					 MX_APLLS_CLIKIN_13)
> -
> -/* PRCM III target DPLL = 2*266 = 532MHz*/
> -#define MIII_DPLL_MULT_12		(133 << 12)
> -#define MIII_DPLL_DIV_12		(5 << 8)
> -#define MIII_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC |	\
> -					 MIII_DPLL_DIV_12 | \
> -					 MIII_DPLL_MULT_12 | MX_APLLS_CLIKIN_12)
> -#define MIII_DPLL_MULT_13		(266 << 12)
> -#define MIII_DPLL_DIV_13		(12 << 8)
> -#define MIII_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC |	\
> -					 MIII_DPLL_DIV_13 | \
> -					 MIII_DPLL_MULT_13 | MX_APLLS_CLIKIN_13)
> -
> -/* PRCM VII (boot bypass) */
> -#define MVII_CM_CLKSEL1_PLL_12_VAL	MB_CM_CLKSEL1_PLL_12_VAL
> -#define MVII_CM_CLKSEL1_PLL_13_VAL	MB_CM_CLKSEL1_PLL_13_VAL
> -
> -/* High and low operation value */
> -#define MX_CLKSEL2_PLL_2x_VAL		(2 << 0)
> -#define MX_CLKSEL2_PLL_1x_VAL		(1 << 0)
> -
> -/* MPU speed defines */
> -#define S12M	12000000
> -#define S13M	13000000
> -#define S19M	19200000
> -#define S26M	26000000
> -#define S100M	100000000
> -#define S133M	133000000
> -#define S150M	150000000
> -#define S164M	164000000
> -#define S165M	165000000
> -#define S199M	199000000
> -#define S200M	200000000
> -#define S266M	266000000
> -#define S300M	300000000
> -#define S329M	329000000
> -#define S330M	330000000
> -#define S399M	399000000
> -#define S400M	400000000
> -#define S532M	532000000
> -#define S600M	600000000
> -#define S658M	658000000
> -#define S660M	660000000
> -#define S798M	798000000
> -
> -
> -extern const struct prcm_config omap2420_rate_table[];
> -
> -#ifdef CONFIG_SOC_OMAP2430
> -extern const struct prcm_config omap2430_rate_table[];
> -#else
> -#define omap2430_rate_table	NULL
> -#endif
> -extern const struct prcm_config *rate_table;
> -extern const struct prcm_config *curr_prcm_set;
> -
> -#endif
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index b947bacf23a3..8b8021b297aa 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -27,7 +27,6 @@
>   
>   #include "clockdomain.h"
>   #include "common.h"
> -#include "common-board-devices.h"
>   #include "control.h"
>   #include "omap_device.h"
>   #include "omap-secure.h"
> @@ -42,15 +41,6 @@ struct pdata_init {
>   
>   static struct of_dev_auxdata omap_auxdata_lookup[];
>   
> -#ifdef CONFIG_MACH_NOKIA_N8X0
> -static void __init omap2420_n8x0_legacy_init(void)
> -{
> -	omap_auxdata_lookup[0].platform_data = n8x0_legacy_init();
> -}
> -#else
> -#define omap2420_n8x0_legacy_init	NULL
> -#endif
> -
>   #ifdef CONFIG_ARCH_OMAP3
>   /*
>    * Configures GPIOs 126, 127 and 129 to 1.8V mode instead of 3.0V
> @@ -431,26 +421,9 @@ static void __init omap3_mcbsp_init(void)
>   static void __init omap3_mcbsp_init(void) {}
>   #endif
>   
> -/*
> - * Few boards still need auxdata populated before we populate
> - * the dev entries in of_platform_populate().
> - */
> -static struct pdata_init auxdata_quirks[] __initdata = {
> -#ifdef CONFIG_SOC_OMAP2420
> -	{ "nokia,n800", omap2420_n8x0_legacy_init, },
> -	{ "nokia,n810", omap2420_n8x0_legacy_init, },
> -	{ "nokia,n810-wimax", omap2420_n8x0_legacy_init, },
> -#endif
> -	{ /* sentinel */ },
> -};
> -
>   struct omap_sr_data __maybe_unused omap_sr_pdata[OMAP_SR_NR];
>   
>   static struct of_dev_auxdata omap_auxdata_lookup[] = {
> -#ifdef CONFIG_MACH_NOKIA_N8X0
> -	OF_DEV_AUXDATA("ti,omap2420-mmc", 0x4809c000, "mmci-omap.0", NULL),
> -	OF_DEV_AUXDATA("menelaus", 0x72, "1-0072", &n8x0_menelaus_platform_data),
> -#endif
>   #ifdef CONFIG_ARCH_OMAP3
>   	OF_DEV_AUXDATA("ti,omap2-iommu", 0x5d000000, "5d000000.mmu",
>   		       &omap3_iommu_pdata),
> @@ -560,13 +533,11 @@ void __init pdata_quirks_init(const struct of_device_id *omap_dt_match_table)
>   	 * We still need this for omap2420 and omap3 PM to work, others are
>   	 * using drivers/misc/sram.c already.
>   	 */
> -	if (of_machine_is_compatible("ti,omap2420") ||
> -	    of_machine_is_compatible("ti,omap3"))
> +	if (IS_ENABLED(CONFIG_ARCH_OMAP3) &&
> +	    of_machine_is_compatible("ti,omap3")) {
>   		omap_sdrc_init(NULL, NULL);
> -
> -	if (of_machine_is_compatible("ti,omap3"))
>   		omap3_mcbsp_init();
> -	pdata_quirks_check(auxdata_quirks);
> +	}
>   
>   	pdata_quirks_init_clocks(omap_dt_match_table);
>   
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index f97ff93f2fb4..5751b85e9ffb 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -43,11 +43,6 @@ extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
>   #define pm_dbg_update_time(pwrdm, prev) do {} while (0);
>   #endif /* CONFIG_PM_DEBUG */
>   
> -/* 24xx */
> -extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
> -					void __iomem *sdrc_power);
> -extern unsigned int omap24xx_cpu_suspend_sz;
> -
>   /* 3xxx */
>   extern void omap34xx_cpu_suspend(int save_state);
>   
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index fbc89999460b..eaf6d1104dc2 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -244,8 +244,6 @@ int pwrdm_post_transition(struct powerdomain *pwrdm);
>   
>   extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 state);
>   
> -extern void omap242x_powerdomains_init(void);
> -extern void omap243x_powerdomains_init(void);
>   extern void omap3xxx_powerdomains_init(void);
>   extern void am33xx_powerdomains_init(void);
>   extern void omap44xx_powerdomains_init(void);
> @@ -253,7 +251,6 @@ extern void omap54xx_powerdomains_init(void);
>   extern void dra7xx_powerdomains_init(void);
>   void am43xx_powerdomains_init(void);
>   
> -extern struct pwrdm_ops omap2_pwrdm_operations;
>   extern struct pwrdm_ops omap3_pwrdm_operations;
>   extern struct pwrdm_ops am33xx_pwrdm_operations;
>   extern struct pwrdm_ops omap4_pwrdm_operations;
> diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_data.c
> deleted file mode 100644
> index fa259adbdc61..000000000000
> --- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
> +++ /dev/null
> @@ -1,134 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * OMAP2XXX powerdomain definitions
> - *
> - * Copyright (C) 2007-2008, 2011 Texas Instruments, Inc.
> - * Copyright (C) 2007-2011 Nokia Corporation
> - *
> - * Paul Walmsley, Jouni Högander
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -
> -#include "soc.h"
> -#include "powerdomain.h"
> -#include "powerdomains2xxx_3xxx_data.h"
> -
> -#include "prcm-common.h"
> -#include "prm2xxx_3xxx.h"
> -#include "prm-regbits-24xx.h"
> -
> -/* 24XX powerdomains and dependencies */
> -
> -/* Powerdomains */
> -
> -static struct powerdomain dsp_pwrdm = {
> -	.name		  = "dsp_pwrdm",
> -	.prcm_offs	  = OMAP24XX_DSP_MOD,
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> -	.pwrsts_logic_ret = PWRSTS_RET,
> -	.banks		  = 1,
> -	.pwrsts_mem_ret	  = {
> -		[0] = PWRSTS_RET,
> -	},
> -	.pwrsts_mem_on	  = {
> -		[0] = PWRSTS_ON,
> -	},
> -	.voltdm		  = { .name = "core" },
> -};
> -
> -static struct powerdomain mpu_24xx_pwrdm = {
> -	.name		  = "mpu_pwrdm",
> -	.prcm_offs	  = MPU_MOD,
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> -	.pwrsts_logic_ret = PWRSTS_OFF_RET,
> -	.banks		  = 1,
> -	.pwrsts_mem_ret	  = {
> -		[0] = PWRSTS_RET,
> -	},
> -	.pwrsts_mem_on	  = {
> -		[0] = PWRSTS_ON,
> -	},
> -	.voltdm		  = { .name = "core" },
> -};
> -
> -static struct powerdomain core_24xx_pwrdm = {
> -	.name		  = "core_pwrdm",
> -	.prcm_offs	  = CORE_MOD,
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> -	.pwrsts_logic_ret = PWRSTS_RET,
> -	.banks		  = 3,
> -	.pwrsts_mem_ret	  = {
> -		[0] = PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
> -		[1] = PWRSTS_OFF_RET,	 /* MEM2RETSTATE */
> -		[2] = PWRSTS_OFF_RET,	 /* MEM3RETSTATE */
> -	},
> -	.pwrsts_mem_on	  = {
> -		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
> -		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
> -		[2] = PWRSTS_OFF_RET_ON, /* MEM3ONSTATE */
> -	},
> -	.voltdm		  = { .name = "core" },
> -};
> -
> -
> -/*
> - * 2430-specific powerdomains
> - */
> -
> -/* XXX 2430 KILLDOMAINWKUP bit?  No current users apparently */
> -
> -static struct powerdomain mdm_pwrdm = {
> -	.name		  = "mdm_pwrdm",
> -	.prcm_offs	  = OMAP2430_MDM_MOD,
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> -	.pwrsts_logic_ret = PWRSTS_RET,
> -	.banks		  = 1,
> -	.pwrsts_mem_ret	  = {
> -		[0] = PWRSTS_RET, /* MEMRETSTATE */
> -	},
> -	.pwrsts_mem_on	  = {
> -		[0] = PWRSTS_ON,  /* MEMONSTATE */
> -	},
> -	.voltdm		  = { .name = "core" },
> -};
> -
> -/*
> - *
> - */
> -
> -static struct powerdomain *powerdomains_omap24xx[] __initdata = {
> -	&wkup_omap2_pwrdm,
> -	&gfx_omap2_pwrdm,
> -	&dsp_pwrdm,
> -	&mpu_24xx_pwrdm,
> -	&core_24xx_pwrdm,
> -	NULL
> -};
> -
> -static struct powerdomain *powerdomains_omap2430[] __initdata = {
> -	&mdm_pwrdm,
> -	NULL
> -};
> -
> -void __init omap242x_powerdomains_init(void)
> -{
> -	if (!cpu_is_omap2420())
> -		return;
> -
> -	pwrdm_register_platform_funcs(&omap2_pwrdm_operations);
> -	pwrdm_register_pwrdms(powerdomains_omap24xx);
> -	pwrdm_complete_init();
> -}
> -
> -void __init omap243x_powerdomains_init(void)
> -{
> -	if (!cpu_is_omap2430())
> -		return;
> -
> -	pwrdm_register_platform_funcs(&omap2_pwrdm_operations);
> -	pwrdm_register_pwrdms(powerdomains_omap24xx);
> -	pwrdm_register_pwrdms(powerdomains_omap2430);
> -	pwrdm_complete_init();
> -}
> diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
> index 5e3544a63526..e326bb6a09db 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -27,12 +27,6 @@
>   #define PLL_MOD						0x500
>   
>   
> -/* Chip-specific module offsets */
> -#define OMAP24XX_GR_MOD					OCP_MOD
> -#define OMAP24XX_DSP_MOD				0x800
> -
> -#define OMAP2430_MDM_MOD				0xc00
> -
>   /* IVA2 module is < base on 3430 */
>   #define OMAP3430_IVA2_MOD				-0x800
>   #define OMAP3430ES2_SGX_MOD				GFX_MOD
> @@ -63,147 +57,6 @@
>   #define TI816X_PRM_SGX_MOD				0x0f00
>   #define TI81XX_PRM_ALWON_MOD			0x1800
>   
> -/* 24XX register bits shared between CM & PRM registers */
> -
> -/* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
> -#define OMAP2420_EN_MMC_SHIFT				26
> -#define OMAP2420_EN_MMC_MASK				(1 << 26)
> -#define OMAP24XX_EN_UART2_SHIFT				22
> -#define OMAP24XX_EN_UART2_MASK				(1 << 22)
> -#define OMAP24XX_EN_UART1_SHIFT				21
> -#define OMAP24XX_EN_UART1_MASK				(1 << 21)
> -#define OMAP24XX_EN_MCSPI2_SHIFT			18
> -#define OMAP24XX_EN_MCSPI2_MASK				(1 << 18)
> -#define OMAP24XX_EN_MCSPI1_SHIFT			17
> -#define OMAP24XX_EN_MCSPI1_MASK				(1 << 17)
> -#define OMAP24XX_EN_MCBSP2_SHIFT			16
> -#define OMAP24XX_EN_MCBSP2_MASK				(1 << 16)
> -#define OMAP24XX_EN_MCBSP1_SHIFT			15
> -#define OMAP24XX_EN_MCBSP1_MASK				(1 << 15)
> -#define OMAP24XX_EN_GPT12_SHIFT				14
> -#define OMAP24XX_EN_GPT12_MASK				(1 << 14)
> -#define OMAP24XX_EN_GPT11_SHIFT				13
> -#define OMAP24XX_EN_GPT11_MASK				(1 << 13)
> -#define OMAP24XX_EN_GPT10_SHIFT				12
> -#define OMAP24XX_EN_GPT10_MASK				(1 << 12)
> -#define OMAP24XX_EN_GPT9_SHIFT				11
> -#define OMAP24XX_EN_GPT9_MASK				(1 << 11)
> -#define OMAP24XX_EN_GPT8_SHIFT				10
> -#define OMAP24XX_EN_GPT8_MASK				(1 << 10)
> -#define OMAP24XX_EN_GPT7_SHIFT				9
> -#define OMAP24XX_EN_GPT7_MASK				(1 << 9)
> -#define OMAP24XX_EN_GPT6_SHIFT				8
> -#define OMAP24XX_EN_GPT6_MASK				(1 << 8)
> -#define OMAP24XX_EN_GPT5_SHIFT				7
> -#define OMAP24XX_EN_GPT5_MASK				(1 << 7)
> -#define OMAP24XX_EN_GPT4_SHIFT				6
> -#define OMAP24XX_EN_GPT4_MASK				(1 << 6)
> -#define OMAP24XX_EN_GPT3_SHIFT				5
> -#define OMAP24XX_EN_GPT3_MASK				(1 << 5)
> -#define OMAP24XX_EN_GPT2_SHIFT				4
> -#define OMAP24XX_EN_GPT2_MASK				(1 << 4)
> -#define OMAP2420_EN_VLYNQ_SHIFT				3
> -#define OMAP2420_EN_VLYNQ_MASK				(1 << 3)
> -
> -/* CM_FCLKEN2_CORE, CM_ICLKEN2_CORE, PM_WKEN2_CORE shared bits */
> -#define OMAP2430_EN_GPIO5_SHIFT				10
> -#define OMAP2430_EN_GPIO5_MASK				(1 << 10)
> -#define OMAP2430_EN_MCSPI3_SHIFT			9
> -#define OMAP2430_EN_MCSPI3_MASK				(1 << 9)
> -#define OMAP2430_EN_MMCHS2_SHIFT			8
> -#define OMAP2430_EN_MMCHS2_MASK				(1 << 8)
> -#define OMAP2430_EN_MMCHS1_SHIFT			7
> -#define OMAP2430_EN_MMCHS1_MASK				(1 << 7)
> -#define OMAP24XX_EN_UART3_SHIFT				2
> -#define OMAP24XX_EN_UART3_MASK				(1 << 2)
> -#define OMAP24XX_EN_USB_SHIFT				0
> -#define OMAP24XX_EN_USB_MASK				(1 << 0)
> -
> -/* CM_ICLKEN2_CORE, PM_WKEN2_CORE shared bits */
> -#define OMAP2430_EN_MDM_INTC_SHIFT			11
> -#define OMAP2430_EN_MDM_INTC_MASK			(1 << 11)
> -#define OMAP2430_EN_USBHS_SHIFT				6
> -#define OMAP2430_EN_USBHS_MASK				(1 << 6)
> -#define OMAP24XX_EN_GPMC_SHIFT				1
> -#define OMAP24XX_EN_GPMC_MASK				(1 << 1)
> -
> -/* CM_IDLEST1_CORE, PM_WKST1_CORE shared bits */
> -#define OMAP2420_ST_MMC_SHIFT				26
> -#define OMAP2420_ST_MMC_MASK				(1 << 26)
> -#define OMAP24XX_ST_UART2_SHIFT				22
> -#define OMAP24XX_ST_UART2_MASK				(1 << 22)
> -#define OMAP24XX_ST_UART1_SHIFT				21
> -#define OMAP24XX_ST_UART1_MASK				(1 << 21)
> -#define OMAP24XX_ST_MCSPI2_SHIFT			18
> -#define OMAP24XX_ST_MCSPI2_MASK				(1 << 18)
> -#define OMAP24XX_ST_MCSPI1_SHIFT			17
> -#define OMAP24XX_ST_MCSPI1_MASK				(1 << 17)
> -#define OMAP24XX_ST_MCBSP2_SHIFT			16
> -#define OMAP24XX_ST_MCBSP2_MASK				(1 << 16)
> -#define OMAP24XX_ST_MCBSP1_SHIFT			15
> -#define OMAP24XX_ST_MCBSP1_MASK				(1 << 15)
> -#define OMAP24XX_ST_GPT12_SHIFT				14
> -#define OMAP24XX_ST_GPT12_MASK				(1 << 14)
> -#define OMAP24XX_ST_GPT11_SHIFT				13
> -#define OMAP24XX_ST_GPT11_MASK				(1 << 13)
> -#define OMAP24XX_ST_GPT10_SHIFT				12
> -#define OMAP24XX_ST_GPT10_MASK				(1 << 12)
> -#define OMAP24XX_ST_GPT9_SHIFT				11
> -#define OMAP24XX_ST_GPT9_MASK				(1 << 11)
> -#define OMAP24XX_ST_GPT8_SHIFT				10
> -#define OMAP24XX_ST_GPT8_MASK				(1 << 10)
> -#define OMAP24XX_ST_GPT7_SHIFT				9
> -#define OMAP24XX_ST_GPT7_MASK				(1 << 9)
> -#define OMAP24XX_ST_GPT6_SHIFT				8
> -#define OMAP24XX_ST_GPT6_MASK				(1 << 8)
> -#define OMAP24XX_ST_GPT5_SHIFT				7
> -#define OMAP24XX_ST_GPT5_MASK				(1 << 7)
> -#define OMAP24XX_ST_GPT4_SHIFT				6
> -#define OMAP24XX_ST_GPT4_MASK				(1 << 6)
> -#define OMAP24XX_ST_GPT3_SHIFT				5
> -#define OMAP24XX_ST_GPT3_MASK				(1 << 5)
> -#define OMAP24XX_ST_GPT2_SHIFT				4
> -#define OMAP24XX_ST_GPT2_MASK				(1 << 4)
> -#define OMAP2420_ST_VLYNQ_SHIFT				3
> -#define OMAP2420_ST_VLYNQ_MASK				(1 << 3)
> -
> -/* CM_IDLEST2_CORE, PM_WKST2_CORE shared bits */
> -#define OMAP2430_ST_MDM_INTC_SHIFT			11
> -#define OMAP2430_ST_MDM_INTC_MASK			(1 << 11)
> -#define OMAP2430_ST_GPIO5_SHIFT				10
> -#define OMAP2430_ST_GPIO5_MASK				(1 << 10)
> -#define OMAP2430_ST_MCSPI3_SHIFT			9
> -#define OMAP2430_ST_MCSPI3_MASK				(1 << 9)
> -#define OMAP2430_ST_MMCHS2_SHIFT			8
> -#define OMAP2430_ST_MMCHS2_MASK				(1 << 8)
> -#define OMAP2430_ST_MMCHS1_SHIFT			7
> -#define OMAP2430_ST_MMCHS1_MASK				(1 << 7)
> -#define OMAP2430_ST_USBHS_SHIFT				6
> -#define OMAP2430_ST_USBHS_MASK				(1 << 6)
> -#define OMAP24XX_ST_UART3_SHIFT				2
> -#define OMAP24XX_ST_UART3_MASK				(1 << 2)
> -#define OMAP24XX_ST_USB_SHIFT				0
> -#define OMAP24XX_ST_USB_MASK				(1 << 0)
> -
> -/* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
> -#define OMAP24XX_EN_GPIOS_SHIFT				2
> -#define OMAP24XX_EN_GPIOS_MASK				(1 << 2)
> -#define OMAP24XX_EN_GPT1_SHIFT				0
> -#define OMAP24XX_EN_GPT1_MASK				(1 << 0)
> -
> -/* PM_WKST_WKUP, CM_IDLEST_WKUP shared bits */
> -#define OMAP24XX_ST_GPIOS_SHIFT				2
> -#define OMAP24XX_ST_GPIOS_MASK				(1 << 2)
> -#define OMAP24XX_ST_32KSYNC_SHIFT			1
> -#define OMAP24XX_ST_32KSYNC_MASK			(1 << 1)
> -#define OMAP24XX_ST_GPT1_SHIFT				0
> -#define OMAP24XX_ST_GPT1_MASK				(1 << 0)
> -
> -/* CM_IDLEST_MDM and PM_WKST_MDM shared bits */
> -#define OMAP2430_ST_MDM_SHIFT				0
> -#define OMAP2430_ST_MDM_MASK				(1 << 0)
> -
> -
>   /* 3430 register bits shared between CM & PRM registers */
>   
>   /* CM_REVISION, PRM_REVISION shared bits */
> diff --git a/arch/arm/mach-omap2/prm-regbits-24xx.h b/arch/arm/mach-omap2/prm-regbits-24xx.h
> deleted file mode 100644
> index ff83801f6439..000000000000
> --- a/arch/arm/mach-omap2/prm-regbits-24xx.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -#ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_24XX_H
> -#define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_24XX_H
> -
> -/*
> - * OMAP24XX Power/Reset Management register bits
> - *
> - * Copyright (C) 2007 Texas Instruments, Inc.
> - * Copyright (C) 2007 Nokia Corporation
> - *
> - * Written by Paul Walmsley
> - */
> -
> -#include "prm2xxx.h"
> -
> -#define OMAP24XX_EN_CORE_SHIFT 				0
> -#define OMAP24XX_FORCESTATE_MASK			(1 << 18)
> -#define OMAP24XX_AUTOIDLE_MASK				(1 << 0)
> -#define OMAP24XX_AUTO_EXTVOLT_MASK			(1 << 15)
> -#define OMAP24XX_SETOFF_LEVEL_SHIFT			12
> -#define OMAP24XX_MEMRETCTRL_MASK			(1 << 8)
> -#define OMAP24XX_SETRET_LEVEL_SHIFT			6
> -#define OMAP24XX_VOLT_LEVEL_SHIFT			0
> -#define OMAP2420_CLKOUT2_EN_SHIFT			15
> -#define OMAP2420_CLKOUT2_DIV_SHIFT			11
> -#define OMAP2420_CLKOUT2_DIV_WIDTH			3
> -#define OMAP2420_CLKOUT2_SOURCE_MASK			(0x3 << 8)
> -#define OMAP24XX_CLKOUT_EN_SHIFT			7
> -#define OMAP24XX_CLKOUT_DIV_SHIFT			3
> -#define OMAP24XX_CLKOUT_DIV_WIDTH			3
> -#define OMAP24XX_CLKOUT_SOURCE_MASK			(0x3 << 0)
> -#define OMAP24XX_EMULATION_EN_SHIFT			0
> -#define OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT		5
> -#define OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT		2
> -#define OMAP24XX_EXTWMPU_RST_SHIFT			6
> -#define OMAP24XX_SECU_WD_RST_SHIFT			5
> -#define OMAP24XX_MPU_WD_RST_SHIFT			4
> -#define OMAP24XX_SECU_VIOL_RST_SHIFT			3
> -#endif
> diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
> deleted file mode 100644
> index 35a58f54b528..000000000000
> --- a/arch/arm/mach-omap2/prm2xxx.c
> +++ /dev/null
> @@ -1,229 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * OMAP2xxx PRM module functions
> - *
> - * Copyright (C) 2010-2012 Texas Instruments, Inc.
> - * Copyright (C) 2010 Nokia Corporation
> - * Benoît Cousson
> - * Paul Walmsley
> - * Rajendra Nayak <rnayak@ti.com>
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/err.h>
> -#include <linux/io.h>
> -#include <linux/irq.h>
> -
> -#include "powerdomain.h"
> -#include "clockdomain.h"
> -#include "prm2xxx.h"
> -#include "cm2xxx_3xxx.h"
> -#include "prm-regbits-24xx.h"
> -
> -/*
> - * OMAP24xx PM_PWSTCTRL_*.POWERSTATE and PM_PWSTST_*.LASTSTATEENTERED bits -
> - * these are reversed from the bits used on OMAP3+
> - */
> -#define OMAP24XX_PWRDM_POWER_ON			0x0
> -#define OMAP24XX_PWRDM_POWER_RET		0x1
> -#define OMAP24XX_PWRDM_POWER_OFF		0x3
> -
> -/*
> - * omap2xxx_prm_reset_src_map - map from bits in the PRM_RSTST_WKUP
> - *   hardware register (which are specific to the OMAP2xxx SoCs) to
> - *   reset source ID bit shifts (which is an OMAP SoC-independent
> - *   enumeration)
> - */
> -static struct prm_reset_src_map omap2xxx_prm_reset_src_map[] = {
> -	{ OMAP_GLOBALCOLD_RST_SHIFT, OMAP_GLOBAL_COLD_RST_SRC_ID_SHIFT },
> -	{ OMAP_GLOBALWARM_RST_SHIFT, OMAP_GLOBAL_WARM_RST_SRC_ID_SHIFT },
> -	{ OMAP24XX_SECU_VIOL_RST_SHIFT, OMAP_SECU_VIOL_RST_SRC_ID_SHIFT },
> -	{ OMAP24XX_MPU_WD_RST_SHIFT, OMAP_MPU_WD_RST_SRC_ID_SHIFT },
> -	{ OMAP24XX_SECU_WD_RST_SHIFT, OMAP_SECU_WD_RST_SRC_ID_SHIFT },
> -	{ OMAP24XX_EXTWMPU_RST_SHIFT, OMAP_EXTWARM_RST_SRC_ID_SHIFT },
> -	{ -1, -1 },
> -};
> -
> -/**
> - * omap2xxx_prm_read_reset_sources - return the last SoC reset source
> - *
> - * Return a u32 representing the last reset sources of the SoC.  The
> - * returned reset source bits are standardized across OMAP SoCs.
> - */
> -static u32 omap2xxx_prm_read_reset_sources(void)
> -{
> -	struct prm_reset_src_map *p;
> -	u32 r = 0;
> -	u32 v;
> -
> -	v = omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST);
> -
> -	p = omap2xxx_prm_reset_src_map;
> -	while (p->reg_shift >= 0 && p->std_shift >= 0) {
> -		if (v & (1 << p->reg_shift))
> -			r |= 1 << p->std_shift;
> -		p++;
> -	}
> -
> -	return r;
> -}
> -
> -/**
> - * omap2xxx_pwrst_to_common_pwrst - convert OMAP2xxx pwrst to common pwrst
> - * @omap2xxx_pwrst: OMAP2xxx hardware power state to convert
> - *
> - * Return the common power state bits corresponding to the OMAP2xxx
> - * hardware power state bits @omap2xxx_pwrst, or -EINVAL upon error.
> - */
> -static int omap2xxx_pwrst_to_common_pwrst(u8 omap2xxx_pwrst)
> -{
> -	u8 pwrst;
> -
> -	switch (omap2xxx_pwrst) {
> -	case OMAP24XX_PWRDM_POWER_OFF:
> -		pwrst = PWRDM_POWER_OFF;
> -		break;
> -	case OMAP24XX_PWRDM_POWER_RET:
> -		pwrst = PWRDM_POWER_RET;
> -		break;
> -	case OMAP24XX_PWRDM_POWER_ON:
> -		pwrst = PWRDM_POWER_ON;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return pwrst;
> -}
> -
> -/**
> - * omap2xxx_prm_dpll_reset - use DPLL reset to reboot the OMAP SoC
> - *
> - * Set the DPLL reset bit, which should reboot the SoC.  This is the
> - * recommended way to restart the SoC.  No return value.
> - */
> -static void omap2xxx_prm_dpll_reset(void)
> -{
> -	omap2_prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, WKUP_MOD,
> -				   OMAP2_RM_RSTCTRL);
> -	/* OCP barrier */
> -	omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTCTRL);
> -}
> -
> -/**
> - * omap2xxx_prm_clear_mod_irqs - clear wakeup status bits for a module
> - * @module: PRM module to clear wakeups from
> - * @regs: register offset to clear
> - * @wkst_mask: wakeup status mask to clear
> - *
> - * Clears wakeup status bits for a given module, so that the device can
> - * re-enter idle.
> - */
> -static int omap2xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
> -{
> -	u32 wkst;
> -
> -	wkst = omap2_prm_read_mod_reg(module, regs);
> -	wkst &= wkst_mask;
> -	omap2_prm_write_mod_reg(wkst, module, regs);
> -	return 0;
> -}
> -
> -int omap2xxx_clkdm_sleep(struct clockdomain *clkdm)
> -{
> -	omap2_prm_set_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
> -				   clkdm->pwrdm.ptr->prcm_offs,
> -				   OMAP2_PM_PWSTCTRL);
> -	return 0;
> -}
> -
> -int omap2xxx_clkdm_wakeup(struct clockdomain *clkdm)
> -{
> -	omap2_prm_clear_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
> -				     clkdm->pwrdm.ptr->prcm_offs,
> -				     OMAP2_PM_PWSTCTRL);
> -	return 0;
> -}
> -
> -static int omap2xxx_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
> -{
> -	u8 omap24xx_pwrst;
> -
> -	switch (pwrst) {
> -	case PWRDM_POWER_OFF:
> -		omap24xx_pwrst = OMAP24XX_PWRDM_POWER_OFF;
> -		break;
> -	case PWRDM_POWER_RET:
> -		omap24xx_pwrst = OMAP24XX_PWRDM_POWER_RET;
> -		break;
> -	case PWRDM_POWER_ON:
> -		omap24xx_pwrst = OMAP24XX_PWRDM_POWER_ON;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
> -				   (omap24xx_pwrst << OMAP_POWERSTATE_SHIFT),
> -				   pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
> -	return 0;
> -}
> -
> -static int omap2xxx_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
> -{
> -	u8 omap2xxx_pwrst;
> -
> -	omap2xxx_pwrst = omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -						       OMAP2_PM_PWSTCTRL,
> -						       OMAP_POWERSTATE_MASK);
> -
> -	return omap2xxx_pwrst_to_common_pwrst(omap2xxx_pwrst);
> -}
> -
> -static int omap2xxx_pwrdm_read_pwrst(struct powerdomain *pwrdm)
> -{
> -	u8 omap2xxx_pwrst;
> -
> -	omap2xxx_pwrst = omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -						       OMAP2_PM_PWSTST,
> -						       OMAP_POWERSTATEST_MASK);
> -
> -	return omap2xxx_pwrst_to_common_pwrst(omap2xxx_pwrst);
> -}
> -
> -struct pwrdm_ops omap2_pwrdm_operations = {
> -	.pwrdm_set_next_pwrst	= omap2xxx_pwrdm_set_next_pwrst,
> -	.pwrdm_read_next_pwrst	= omap2xxx_pwrdm_read_next_pwrst,
> -	.pwrdm_read_pwrst	= omap2xxx_pwrdm_read_pwrst,
> -	.pwrdm_set_logic_retst	= omap2_pwrdm_set_logic_retst,
> -	.pwrdm_set_mem_onst	= omap2_pwrdm_set_mem_onst,
> -	.pwrdm_set_mem_retst	= omap2_pwrdm_set_mem_retst,
> -	.pwrdm_read_mem_pwrst	= omap2_pwrdm_read_mem_pwrst,
> -	.pwrdm_read_mem_retst	= omap2_pwrdm_read_mem_retst,
> -	.pwrdm_wait_transition	= omap2_pwrdm_wait_transition,
> -};
> -
> -/*
> - *
> - */
> -
> -static struct prm_ll_data omap2xxx_prm_ll_data = {
> -	.read_reset_sources = &omap2xxx_prm_read_reset_sources,
> -	.assert_hardreset = &omap2_prm_assert_hardreset,
> -	.deassert_hardreset = &omap2_prm_deassert_hardreset,
> -	.is_hardreset_asserted = &omap2_prm_is_hardreset_asserted,
> -	.reset_system = &omap2xxx_prm_dpll_reset,
> -	.clear_mod_irqs = &omap2xxx_prm_clear_mod_irqs,
> -};
> -
> -int __init omap2xxx_prm_init(const struct omap_prcm_init_data *data)
> -{
> -	return prm_register(&omap2xxx_prm_ll_data);
> -}
> -
> -static void __exit omap2xxx_prm_exit(void)
> -{
> -	prm_unregister(&omap2xxx_prm_ll_data);
> -}
> -__exitcall(omap2xxx_prm_exit);
> diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xxx.h
> deleted file mode 100644
> index 659b917348f8..000000000000
> --- a/arch/arm/mach-omap2/prm2xxx.h
> +++ /dev/null
> @@ -1,128 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * OMAP2xxx Power/Reset Management (PRM) register definitions
> - *
> - * Copyright (C) 2007-2009, 2011-2012 Texas Instruments, Inc.
> - * Copyright (C) 2008-2010 Nokia Corporation
> - * Paul Walmsley
> - *
> - * The PRM hardware modules on the OMAP2/3 are quite similar to each
> - * other.  The PRM on OMAP4 has a new register layout, and is handled
> - * in a separate file.
> - */
> -#ifndef __ARCH_ARM_MACH_OMAP2_PRM2XXX_H
> -#define __ARCH_ARM_MACH_OMAP2_PRM2XXX_H
> -
> -#include "prcm-common.h"
> -#include "prm.h"
> -#include "prm2xxx_3xxx.h"
> -
> -#define OMAP2420_PRM_REGADDR(module, reg)				\
> -		OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
> -#define OMAP2430_PRM_REGADDR(module, reg)				\
> -		OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
> -
> -/*
> - * OMAP2-specific global PRM registers
> - * Use {read,write}l_relaxed() with these registers.
> - *
> - * With a few exceptions, these are the register names beginning with
> - * PRCM_* on 24xx.  (The exceptions are the IRQSTATUS and IRQENABLE
> - * bits.)
> - *
> - */
> -
> -#define OMAP2_PRCM_REVISION_OFFSET	0x0000
> -#define OMAP2420_PRCM_REVISION		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0000)
> -#define OMAP2_PRCM_SYSCONFIG_OFFSET	0x0010
> -#define OMAP2420_PRCM_SYSCONFIG		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0010)
> -
> -#define OMAP2_PRCM_IRQSTATUS_MPU_OFFSET	0x0018
> -#define OMAP2420_PRCM_IRQSTATUS_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0018)
> -#define OMAP2_PRCM_IRQENABLE_MPU_OFFSET	0x001c
> -#define OMAP2420_PRCM_IRQENABLE_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x001c)
> -
> -#define OMAP2_PRCM_VOLTCTRL_OFFSET	0x0050
> -#define OMAP2420_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0050)
> -#define OMAP2_PRCM_VOLTST_OFFSET	0x0054
> -#define OMAP2420_PRCM_VOLTST		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0054)
> -#define OMAP2_PRCM_CLKSRC_CTRL_OFFSET	0x0060
> -#define OMAP2420_PRCM_CLKSRC_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0060)
> -#define OMAP2_PRCM_CLKOUT_CTRL_OFFSET	0x0070
> -#define OMAP2420_PRCM_CLKOUT_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0070)
> -#define OMAP2_PRCM_CLKEMUL_CTRL_OFFSET	0x0078
> -#define OMAP2420_PRCM_CLKEMUL_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0078)
> -#define OMAP2_PRCM_CLKCFG_CTRL_OFFSET	0x0080
> -#define OMAP2420_PRCM_CLKCFG_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0080)
> -#define OMAP2_PRCM_CLKCFG_STATUS_OFFSET	0x0084
> -#define OMAP2420_PRCM_CLKCFG_STATUS	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0084)
> -#define OMAP2_PRCM_VOLTSETUP_OFFSET	0x0090
> -#define OMAP2420_PRCM_VOLTSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0090)
> -#define OMAP2_PRCM_CLKSSETUP_OFFSET	0x0094
> -#define OMAP2420_PRCM_CLKSSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0094)
> -#define OMAP2_PRCM_POLCTRL_OFFSET	0x0098
> -#define OMAP2420_PRCM_POLCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0098)
> -
> -#define OMAP2430_PRCM_REVISION		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0000)
> -#define OMAP2430_PRCM_SYSCONFIG		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0010)
> -
> -#define OMAP2430_PRCM_IRQSTATUS_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0018)
> -#define OMAP2430_PRCM_IRQENABLE_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x001c)
> -
> -#define OMAP2430_PRCM_VOLTCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0050)
> -#define OMAP2430_PRCM_VOLTST		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0054)
> -#define OMAP2430_PRCM_CLKSRC_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0060)
> -#define OMAP2430_PRCM_CLKOUT_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0070)
> -#define OMAP2430_PRCM_CLKEMUL_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0078)
> -#define OMAP2430_PRCM_CLKCFG_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0080)
> -#define OMAP2430_PRCM_CLKCFG_STATUS	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0084)
> -#define OMAP2430_PRCM_VOLTSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0090)
> -#define OMAP2430_PRCM_CLKSSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0094)
> -#define OMAP2430_PRCM_POLCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0098)
> -
> -/*
> - * Module specific PRM register offsets from PRM_BASE + domain offset
> - *
> - * Use prm_{read,write}_mod_reg() with these registers.
> - *
> - * With a few exceptions, these are the register names beginning with
> - * {PM,RM}_* on both OMAP2/3 SoC families..  (The exceptions are the
> - * IRQSTATUS and IRQENABLE bits.)
> - */
> -
> -/* Register offsets appearing on both OMAP2 and OMAP3 */
> -
> -#define OMAP2_RM_RSTCTRL				0x0050
> -#define OMAP2_RM_RSTTIME				0x0054
> -#define OMAP2_RM_RSTST					0x0058
> -#define OMAP2_PM_PWSTCTRL				0x00e0
> -#define OMAP2_PM_PWSTST					0x00e4
> -
> -#define PM_WKEN						0x00a0
> -#define PM_WKEN1					PM_WKEN
> -#define PM_WKST						0x00b0
> -#define PM_WKST1					PM_WKST
> -#define PM_WKDEP					0x00c8
> -#define PM_EVGENCTRL					0x00d4
> -#define PM_EVGENONTIM					0x00d8
> -#define PM_EVGENOFFTIM					0x00dc
> -
> -/* OMAP2xxx specific register offsets */
> -#define OMAP24XX_PM_WKEN2				0x00a4
> -#define OMAP24XX_PM_WKST2				0x00b4
> -
> -#define OMAP24XX_PRCM_IRQSTATUS_DSP			0x00f0	/* IVA mod */
> -#define OMAP24XX_PRCM_IRQENABLE_DSP			0x00f4	/* IVA mod */
> -#define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
> -#define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
> -
> -#ifndef __ASSEMBLER__
> -/* Function prototypes */
> -extern int omap2xxx_clkdm_sleep(struct clockdomain *clkdm);
> -extern int omap2xxx_clkdm_wakeup(struct clockdomain *clkdm);
> -
> -int __init omap2xxx_prm_init(const struct omap_prcm_init_data *data);
> -
> -#endif
> -
> -#endif
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> index d983efac6f4f..afaba7153ece 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> @@ -15,7 +15,6 @@
>   
>   #include "powerdomain.h"
>   #include "prm2xxx_3xxx.h"
> -#include "prm-regbits-24xx.h"
>   #include "clockdomain.h"
>   
>   /**
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index ee4588acda50..3546e7292bfb 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -26,7 +26,6 @@
>   
>   #include "soc.h"
>   #include "prm2xxx_3xxx.h"
> -#include "prm2xxx.h"
>   #include "prm3xxx.h"
>   #include "prm33xx.h"
>   #include "prm44xx.h"
> @@ -582,13 +581,6 @@ int prm_unregister(struct prm_ll_data *pld)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_ARCH_OMAP2
> -static struct omap_prcm_init_data omap2_prm_data __initdata = {
> -	.index = TI_CLKM_PRM,
> -	.init = omap2xxx_prm_init,
> -};
> -#endif
> -
>   #ifdef CONFIG_ARCH_OMAP3
>   static struct omap_prcm_init_data omap3_prm_data __initdata = {
>   	.index = TI_CLKM_PRM,
> @@ -670,9 +662,6 @@ static const struct of_device_id omap_prcm_dt_match_table[] __initconst = {
>   	{ .compatible = "ti,dm814-pllss", .data = &dm814_pllss_data },
>   	{ .compatible = "ti,dm816-prcm", .data = &am3_prm_data },
>   #endif
> -#ifdef CONFIG_ARCH_OMAP2
> -	{ .compatible = "ti,omap2-prcm", .data = &omap2_prm_data },
> -#endif
>   #ifdef CONFIG_ARCH_OMAP3
>   	{ .compatible = "ti,omap3-prm", .data = &omap3_prm_data },
>   #endif
> diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
> index 45b35422b587..c34fba4d2f1a 100644
> --- a/arch/arm/mach-omap2/sdrc.h
> +++ b/arch/arm/mach-omap2/sdrc.h
> @@ -90,17 +90,7 @@ struct memory_timings {
>   	u32 base_cs;		/* base chip select to use for calculations */
>   };
>   
> -extern void omap2xxx_sdrc_init_params(u32 force_lock_to_unlock_mode);
> -
> -u32 omap2xxx_sdrc_dll_is_unlocked(void);
> -u32 omap2xxx_sdrc_reprogram(u32 level, u32 force);
> -
> -
>   #else
> -#define OMAP242X_SDRC_REGADDR(reg)					\
> -			OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE + (reg))
> -#define OMAP243X_SDRC_REGADDR(reg)					\
> -			OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE + (reg))
>   #define OMAP34XX_SDRC_REGADDR(reg)					\
>   			OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE + (reg))
>   
> @@ -184,17 +174,6 @@ u32 omap2xxx_sdrc_reprogram(u32 level, u32 force);
>   #define SDRC_RFR_CTRL_BYPASS	(0x00005000 | 1) /* Need to calc */
>   
>   
> -/*
> - * SMS register access
> - */
> -
> -#define OMAP242X_SMS_REGADDR(reg)					\
> -		(void __iomem *)OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE + reg)
> -#define OMAP243X_SMS_REGADDR(reg)					\
> -		(void __iomem *)OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE + reg)
> -#define OMAP343X_SMS_REGADDR(reg)					\
> -		(void __iomem *)OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE + reg)
> -
>   /* SMS register offsets - read/write with sms_{read,write}_reg() */
>   
>   #define SMS_SYSCONFIG			0x010
> diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
> deleted file mode 100644
> index 5a275b4fd404..000000000000
> --- a/arch/arm/mach-omap2/sdrc2xxx.c
> +++ /dev/null
> @@ -1,164 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * SDRAM timing related functions for OMAP2xxx
> - *
> - * Copyright (C) 2005, 2008 Texas Instruments Inc.
> - * Copyright (C) 2005, 2008 Nokia Corporation
> - *
> - * Tony Lindgren <tony@atomide.com>
> - * Paul Walmsley
> - * Richard Woodruff <r-woodruff2@ti.com>
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/device.h>
> -#include <linux/list.h>
> -#include <linux/errno.h>
> -#include <linux/delay.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
> -
> -#include "soc.h"
> -#include "iomap.h"
> -#include "common.h"
> -#include "prm2xxx.h"
> -#include "clock.h"
> -#include "sdrc.h"
> -#include "sram.h"
> -
> -/* Memory timing, DLL mode flags */
> -#define M_DDR		1
> -#define M_LOCK_CTRL	(1 << 2)
> -#define M_UNLOCK	0
> -#define M_LOCK		1
> -
> -
> -static struct memory_timings mem_timings;
> -static u32 curr_perf_level = CORE_CLK_SRC_DPLL_X2;
> -
> -static u32 omap2xxx_sdrc_get_slow_dll_ctrl(void)
> -{
> -	return mem_timings.slow_dll_ctrl;
> -}
> -
> -static u32 omap2xxx_sdrc_get_fast_dll_ctrl(void)
> -{
> -	return mem_timings.fast_dll_ctrl;
> -}
> -
> -static u32 omap2xxx_sdrc_get_type(void)
> -{
> -	return mem_timings.m_type;
> -}
> -
> -/*
> - * Check the DLL lock state, and return tue if running in unlock mode.
> - * This is needed to compensate for the shifted DLL value in unlock mode.
> - */
> -u32 omap2xxx_sdrc_dll_is_unlocked(void)
> -{
> -	/* dlla and dllb are a set */
> -	u32 dll_state = sdrc_read_reg(SDRC_DLLA_CTRL);
> -
> -	if ((dll_state & (1 << 2)) == (1 << 2))
> -		return 1;
> -	else
> -		return 0;
> -}
> -
> -/*
> - * 'level' is the value to store to CM_CLKSEL2_PLL.CORE_CLK_SRC.
> - * Practical values are CORE_CLK_SRC_DPLL (for CORE_CLK = DPLL_CLK) or
> - * CORE_CLK_SRC_DPLL_X2 (for CORE_CLK = * DPLL_CLK * 2)
> - *
> - * Used by the clock framework during CORE DPLL changes
> - */
> -u32 omap2xxx_sdrc_reprogram(u32 level, u32 force)
> -{
> -	u32 dll_ctrl, m_type;
> -	u32 prev = curr_perf_level;
> -	unsigned long flags;
> -
> -	if ((curr_perf_level == level) && !force)
> -		return prev;
> -
> -	if (level == CORE_CLK_SRC_DPLL)
> -		dll_ctrl = omap2xxx_sdrc_get_slow_dll_ctrl();
> -	else if (level == CORE_CLK_SRC_DPLL_X2)
> -		dll_ctrl = omap2xxx_sdrc_get_fast_dll_ctrl();
> -	else
> -		return prev;
> -
> -	m_type = omap2xxx_sdrc_get_type();
> -
> -	local_irq_save(flags);
> -	/*
> -	 * XXX These calls should be abstracted out through a
> -	 * prm2xxx.c function
> -	 */
> -	if (cpu_is_omap2420())
> -		writel_relaxed(0xffff, OMAP2420_PRCM_VOLTSETUP);
> -	else
> -		writel_relaxed(0xffff, OMAP2430_PRCM_VOLTSETUP);
> -	omap2_sram_reprogram_sdrc(level, dll_ctrl, m_type);
> -	curr_perf_level = level;
> -	local_irq_restore(flags);
> -
> -	return prev;
> -}
> -
> -/* Used by the clock framework during CORE DPLL changes */
> -void omap2xxx_sdrc_init_params(u32 force_lock_to_unlock_mode)
> -{
> -	unsigned long dll_cnt;
> -	u32 fast_dll = 0;
> -
> -	/* DDR = 1, SDR = 0 */
> -	mem_timings.m_type = !((sdrc_read_reg(SDRC_MR_0) & 0x3) == 0x1);
> -
> -	/* 2422 es2.05 and beyond has a single SIP DDR instead of 2 like others.
> -	 * In the case of 2422, its ok to use CS1 instead of CS0.
> -	 */
> -	if (cpu_is_omap2422())
> -		mem_timings.base_cs = 1;
> -	else
> -		mem_timings.base_cs = 0;
> -
> -	if (mem_timings.m_type != M_DDR)
> -		return;
> -
> -	/* With DDR we need to determine the low frequency DLL value */
> -	if (((mem_timings.fast_dll_ctrl & (1 << 2)) == M_LOCK_CTRL))
> -		mem_timings.dll_mode = M_UNLOCK;
> -	else
> -		mem_timings.dll_mode = M_LOCK;
> -
> -	if (mem_timings.base_cs == 0) {
> -		fast_dll = sdrc_read_reg(SDRC_DLLA_CTRL);
> -		dll_cnt = sdrc_read_reg(SDRC_DLLA_STATUS) & 0xff00;
> -	} else {
> -		fast_dll = sdrc_read_reg(SDRC_DLLB_CTRL);
> -		dll_cnt = sdrc_read_reg(SDRC_DLLB_STATUS) & 0xff00;
> -	}
> -	if (force_lock_to_unlock_mode) {
> -		fast_dll &= ~0xff00;
> -		fast_dll |= dll_cnt;		/* Current lock mode */
> -	}
> -	/* set fast timings with DLL filter disabled */
> -	mem_timings.fast_dll_ctrl = (fast_dll | (3 << 8));
> -
> -	/* No disruptions, DDR will be offline & C-ABI not followed */
> -	omap2_sram_ddr_init(&mem_timings.slow_dll_ctrl,
> -			    mem_timings.fast_dll_ctrl,
> -			    mem_timings.base_cs,
> -			    force_lock_to_unlock_mode);
> -	mem_timings.slow_dll_ctrl &= 0xff00;	/* Keep lock value */
> -
> -	/* Turn status into unlock ctrl */
> -	mem_timings.slow_dll_ctrl |=
> -		((mem_timings.fast_dll_ctrl & 0xF) | (1 << 2));
> -
> -	/* 90 degree phase for anything below 133MHz + disable DLL filter */
> -	mem_timings.slow_dll_ctrl |= ((1 << 1) | (3 << 8));
> -}
> diff --git a/arch/arm/mach-omap2/sleep24xx.S b/arch/arm/mach-omap2/sleep24xx.S
> deleted file mode 100644
> index 84d8c43ad382..000000000000
> --- a/arch/arm/mach-omap2/sleep24xx.S
> +++ /dev/null
> @@ -1,91 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * linux/arch/arm/mach-omap2/sleep.S
> - *
> - * (C) Copyright 2004
> - * Texas Instruments, <www.ti.com>
> - * Richard Woodruff <r-woodruff2@ti.com>
> - *
> - * (C) Copyright 2006 Nokia Corporation
> - * Fixed idle loop sleep
> - * Igor Stoppa <igor.stoppa@nokia.com>
> - */
> -
> -#include <linux/linkage.h>
> -#include <asm/assembler.h>
> -
> -#include "omap24xx.h"
> -#include "sdrc.h"
> -
> -/* First address of reserved address space?  apparently valid for OMAP2 & 3 */
> -#define A_SDRC0_V		(0xC0000000)
> -
> -	.text
> -
> -/*
> - * omap24xx_cpu_suspend() - Forces OMAP into deep sleep state by completing
> - * SDRC shutdown then ARM shutdown.  Upon wake MPU is back on so just restore
> - * SDRC.
> - *
> - * Input:
> - * R0 :	DLL ctrl value pre-Sleep
> - * R1 : SDRC_DLLA_CTRL
> - * R2 : SDRC_POWER
> - *
> - * The if the DPLL is going to AutoIdle. It seems like the DPLL may be back on
> - * when we get called, but the DLL probably isn't.  We will wait a bit more in
> - * case the DPLL isn't quite there yet. The code will wait on DLL for DDR even
> - * if in unlocked mode.
> - *
> - * For less than 242x-ES2.2 upon wake from a sleep mode where the external
> - * oscillator was stopped, a timing bug exists where a non-stabilized 12MHz
> - * clock can pass into the PRCM can cause problems at DSP and IVA.
> - * To work around this the code will switch to the 32kHz source prior to sleep.
> - * Post sleep we will shift back to using the DPLL.  Apparently,
> - * CM_IDLEST_CLKGEN does not reflect the full clock change so you need to wait
> - * 3x12MHz + 3x32kHz clocks for a full switch.
> - *
> - * The DLL load value is not kept in RETENTION or OFF.	It needs to be restored
> - * at wake
> - */
> -	.align	3
> -ENTRY(omap24xx_cpu_suspend)
> -	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
> -	mov	r3, #0x0		@ clear for mcr call
> -	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, hope SDR/DDR finished
> -	nop
> -	nop
> -	ldr	r4, [r2]		@ read SDRC_POWER
> -	orr	r4, r4, #0x40		@ enable self refresh on idle req
> -	mov	r5, #0x2000		@ set delay (DPLL relock + DLL relock)
> -	str	r4, [r2]		@ make it so
> -	nop
> -	mcr	p15, 0, r3, c7, c0, 4	@ wait for interrupt
> -	nop
> -loop:
> -	subs	r5, r5, #0x1		@ awake, wait just a bit
> -	bne	loop
> -
> -	/* The DPLL has to be on before we take the DDR out of self refresh */
> -	bic	r4, r4, #0x40		@ now clear self refresh bit.
> -	str	r4, [r2]		@ write to SDRC_POWER
> -	ldr	r4, A_SDRC0		@ make a clock happen
> -	ldr	r4, [r4]		@ read A_SDRC0
> -	nop				@ start auto refresh only after clk ok
> -	movs	r0, r0			@ see if DDR or SDR
> -	strne	r0, [r1]		@ rewrite DLLA to force DLL reload
> -	addne	r1, r1, #0x8		@ move to DLLB
> -	strne	r0, [r1]		@ rewrite DLLB to force DLL reload
> -
> -	mov	r5, #0x1000
> -loop2:
> -	subs	r5, r5, #0x1
> -	bne	loop2
> -	/* resume*/
> -	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
> -
> -A_SDRC0:
> -	.word A_SDRC0_V
> -
> -ENTRY(omap24xx_cpu_suspend_sz)
> -	.word	. - omap24xx_cpu_suspend
> diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
> index 9e3dbb743e5c..9c9f56ca9142 100644
> --- a/arch/arm/mach-omap2/soc.h
> +++ b/arch/arm/mach-omap2/soc.h
> @@ -12,7 +12,6 @@
>    * Added DRA7xxx specific defines - Sricharan R<r.sricharan@ti.com>
>    */
>   
> -#include "omap24xx.h"
>   #include "omap34xx.h"
>   #include "omap44xx.h"
>   #include "ti81xx.h"
> @@ -62,9 +61,6 @@ static inline int soc_is_omap(void)
>   /*
>    * Macros to group OMAP into cpu classes.
>    * These can be used in most places.
> - * soc_is_omap24xx():	True for OMAP2420, OMAP2422, OMAP2423, OMAP2430
> - * soc_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
> - * soc_is_omap243x():	True for OMAP2430
>    * soc_is_omap343x():	True for OMAP3430
>    * soc_is_omap443x():	True for OMAP4430
>    * soc_is_omap446x():	True for OMAP4460
> @@ -137,7 +133,6 @@ static inline int is_dra ##subclass ##_ ##package (void)		\
>   	return (is_dra ##subclass () && GET_DRA_PACKAGE == id) ? 1 : 0;	\
>   }
>   
> -IS_OMAP_CLASS(24xx, 0x24)
>   IS_OMAP_CLASS(34xx, 0x34)
>   IS_OMAP_CLASS(44xx, 0x44)
>   IS_AM_CLASS(35xx, 0x35)
> @@ -148,8 +143,6 @@ IS_AM_CLASS(43xx, 0x43)
>   IS_TI_CLASS(81xx, 0x81)
>   IS_DRA_CLASS(7xx, 0x7)
>   
> -IS_OMAP_SUBCLASS(242x, 0x242)
> -IS_OMAP_SUBCLASS(243x, 0x243)
>   IS_OMAP_SUBCLASS(343x, 0x343)
>   IS_OMAP_SUBCLASS(363x, 0x363)
>   IS_OMAP_SUBCLASS(443x, 0x443)
> @@ -186,21 +179,6 @@ IS_DRA_SUBCLASS(72x, 0x72)
>   #define soc_is_dra74x()			0
>   #define soc_is_dra72x()			0
>   
> -#if defined(CONFIG_ARCH_OMAP2)
> -# define soc_is_omap24xx()		is_omap24xx()
> -#else
> -# define soc_is_omap24xx()		0
> -#endif
> -#if defined(CONFIG_SOC_OMAP2420)
> -# define soc_is_omap242x()		is_omap242x()
> -#else
> -# define soc_is_omap242x()		0
> -#endif
> -#if defined(CONFIG_SOC_OMAP2430)
> -# define soc_is_omap243x()		is_omap243x()
> -#else
> -# define soc_is_omap243x()		0
> -#endif
>   #if defined(CONFIG_ARCH_OMAP3)
>   # define soc_is_omap34xx()		is_omap34xx()
>   # define soc_is_omap343x()		is_omap343x()
> @@ -212,10 +190,6 @@ IS_DRA_SUBCLASS(72x, 0x72)
>   /*
>    * Macros to detect individual cpu types.
>    * These are only rarely needed.
> - * soc_is_omap2420():	True for OMAP2420
> - * soc_is_omap2422():	True for OMAP2422
> - * soc_is_omap2423():	True for OMAP2423
> - * soc_is_omap2430():	True for OMAP2430
>    * soc_is_omap3430():	True for OMAP3430
>    */
>   #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
> @@ -226,16 +200,8 @@ static inline int is_omap ##type (void)			\
>   	return (GET_OMAP_TYPE == (id)) ? 1 : 0;		\
>   }
>   
> -IS_OMAP_TYPE(2420, 0x2420)
> -IS_OMAP_TYPE(2422, 0x2422)
> -IS_OMAP_TYPE(2423, 0x2423)
> -IS_OMAP_TYPE(2430, 0x2430)
>   IS_OMAP_TYPE(3430, 0x3430)
>   
> -#define soc_is_omap2420()		0
> -#define soc_is_omap2422()		0
> -#define soc_is_omap2423()		0
> -#define soc_is_omap2430()		0
>   #define soc_is_omap3430()		0
>   #define soc_is_omap3630()		0
>   #define soc_is_omap5430()		0
> @@ -252,17 +218,6 @@ IS_OMAP_TYPE(3430, 0x3430)
>   #define cpu_class_is_omap1()		0
>   #define cpu_class_is_omap2()		1
>   
> -#if defined(CONFIG_ARCH_OMAP2)
> -# undef  soc_is_omap2420
> -# undef  soc_is_omap2422
> -# undef  soc_is_omap2423
> -# undef  soc_is_omap2430
> -# define soc_is_omap2420()		is_omap2420()
> -# define soc_is_omap2422()		is_omap2422()
> -# define soc_is_omap2423()		is_omap2423()
> -# define soc_is_omap2430()		is_omap2430()
> -#endif
> -
>   #if defined(CONFIG_ARCH_OMAP3)
>   # undef soc_is_omap3430
>   # undef soc_is_ti81xx
> @@ -326,13 +281,6 @@ IS_OMAP_TYPE(3430, 0x3430)
>   #endif
>   
>   /* Various silicon revisions for omap2 */
> -#define OMAP242X_CLASS		0x24200024
> -#define OMAP2420_REV_ES1_0	OMAP242X_CLASS
> -#define OMAP2420_REV_ES2_0	(OMAP242X_CLASS | (0x1 << 8))
> -
> -#define OMAP243X_CLASS		0x24300024
> -#define OMAP2430_REV_ES1_0	OMAP243X_CLASS
> -
>   #define OMAP343X_CLASS		0x34300034
>   #define OMAP3430_REV_ES1_0	OMAP343X_CLASS
>   #define OMAP3430_REV_ES2_0	(OMAP343X_CLASS | (0x1 << 8))
> @@ -400,7 +348,6 @@ IS_OMAP_TYPE(3430, 0x3430)
>   #define DRA722_REV_ES2_0	(DRA7XX_CLASS | (0x22 << 16) | (0x20 << 8))
>   #define DRA722_REV_ES2_1	(DRA7XX_CLASS | (0x22 << 16) | (0x21 << 8))
>   
> -void omap2xxx_check_revision(void);
>   void omap3xxx_check_revision(void);
>   void omap4xxx_check_revision(void);
>   void omap5xxx_check_revision(void);
> @@ -484,12 +431,6 @@ level(__##fn);
>   #define omap_late_initcall_sync(fn)	omap_initcall(late_initcall_sync, fn)
>   
>   /* Legacy defines, these can be removed when users are removed */
> -#define cpu_is_omap2420()	soc_is_omap2420()
> -#define cpu_is_omap2422()	soc_is_omap2422()
> -#define cpu_is_omap242x()	soc_is_omap242x()
> -#define cpu_is_omap2430()	soc_is_omap2430()
> -#define cpu_is_omap243x()	soc_is_omap243x()
> -#define cpu_is_omap24xx()	soc_is_omap24xx()
>   #define cpu_is_omap3430()	soc_is_omap3430()
>   #define cpu_is_omap343x()	soc_is_omap343x()
>   #define cpu_is_omap34xx()	soc_is_omap34xx()
> diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
> index 898b011ae8d9..8f980849f201 100644
> --- a/arch/arm/mach-omap2/sram.c
> +++ b/arch/arm/mach-omap2/sram.c
> @@ -28,15 +28,10 @@
>   #include "sdrc.h"
>   #include "sram.h"
>   
> -#define OMAP2_SRAM_PUB_PA	(OMAP2_SRAM_PA + 0xf800)
>   #define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0x8000)
>   
>   #define SRAM_BOOTLOADER_SZ	0x00
>   
> -#define OMAP24XX_VA_REQINFOPERM0	OMAP2_L3_IO_ADDRESS(0x68005048)
> -#define OMAP24XX_VA_READPERM0		OMAP2_L3_IO_ADDRESS(0x68005050)
> -#define OMAP24XX_VA_WRITEPERM0		OMAP2_L3_IO_ADDRESS(0x68005058)
> -
>   #define OMAP34XX_VA_REQINFOPERM0	OMAP2_L3_IO_ADDRESS(0x68012848)
>   #define OMAP34XX_VA_READPERM0		OMAP2_L3_IO_ADDRESS(0x68012850)
>   #define OMAP34XX_VA_WRITEPERM0		OMAP2_L3_IO_ADDRESS(0x68012858)
> @@ -120,18 +115,11 @@ static int is_sram_locked(void)
>   {
>   	if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
>   		/* RAMFW: R/W access to all initiators for all qualifier sets */
> -		if (cpu_is_omap242x()) {
> -			writel_relaxed(0xFF, OMAP24XX_VA_REQINFOPERM0); /* all q-vects */
> -			writel_relaxed(0xCFDE, OMAP24XX_VA_READPERM0);  /* all i-read */
> -			writel_relaxed(0xCFDE, OMAP24XX_VA_WRITEPERM0); /* all i-write */
> -		}
> -		if (cpu_is_omap34xx()) {
> -			writel_relaxed(0xFFFF, OMAP34XX_VA_REQINFOPERM0); /* all q-vects */
> -			writel_relaxed(0xFFFF, OMAP34XX_VA_READPERM0);  /* all i-read */
> -			writel_relaxed(0xFFFF, OMAP34XX_VA_WRITEPERM0); /* all i-write */
> -			writel_relaxed(0x0, OMAP34XX_VA_ADDR_MATCH2);
> -			writel_relaxed(0xFFFFFFFF, OMAP34XX_VA_SMS_RG_ATT0);
> -		}
> +		writel_relaxed(0xFFFF, OMAP34XX_VA_REQINFOPERM0); /* all q-vects */
> +		writel_relaxed(0xFFFF, OMAP34XX_VA_READPERM0);  /* all i-read */
> +		writel_relaxed(0xFFFF, OMAP34XX_VA_WRITEPERM0); /* all i-write */
> +		writel_relaxed(0x0, OMAP34XX_VA_ADDR_MATCH2);
> +		writel_relaxed(0xFFFFFFFF, OMAP34XX_VA_SMS_RG_ATT0);
>   		return 0;
>   	} else
>   		return 1; /* assume locked with no PPA or security driver */
> @@ -147,30 +135,17 @@ static void __init omap_detect_sram(void)
>   {
>   	omap_sram_skip = SRAM_BOOTLOADER_SZ;
>   	if (is_sram_locked()) {
> -		if (cpu_is_omap34xx()) {
> -			omap_sram_start = OMAP3_SRAM_PUB_PA;
> -			if ((omap_type() == OMAP2_DEVICE_TYPE_EMU) ||
> -			    (omap_type() == OMAP2_DEVICE_TYPE_SEC)) {
> -				omap_sram_size = 0x7000; /* 28K */
> -				omap_sram_skip += SZ_16K;
> -			} else {
> -				omap_sram_size = 0x8000; /* 32K */
> -			}
> +		omap_sram_start = OMAP3_SRAM_PUB_PA;
> +		if ((omap_type() == OMAP2_DEVICE_TYPE_EMU) ||
> +		    (omap_type() == OMAP2_DEVICE_TYPE_SEC)) {
> +			omap_sram_size = 0x7000; /* 28K */
> +			omap_sram_skip += SZ_16K;
>   		} else {
> -			omap_sram_start = OMAP2_SRAM_PUB_PA;
> -			omap_sram_size = 0x800; /* 2K */
> +			omap_sram_size = 0x8000; /* 32K */
>   		}
>   	} else {
> -		if (cpu_is_omap34xx()) {
> -			omap_sram_start = OMAP3_SRAM_PA;
> -			omap_sram_size = 0x10000; /* 64K */
> -		} else {
> -			omap_sram_start = OMAP2_SRAM_PA;
> -			if (cpu_is_omap242x())
> -				omap_sram_size = 0xa0000; /* 640K */
> -			else if (cpu_is_omap243x())
> -				omap_sram_size = 0x10000; /* 64K */
> -		}
> +		omap_sram_start = OMAP3_SRAM_PA;
> +		omap_sram_size = 0x10000; /* 64K */
>   	}
>   }
>   
> @@ -181,24 +156,20 @@ static void __init omap2_map_sram(void)
>   {
>   	unsigned long base;
>   	int pages;
> -	int cached = 1;
> -
> -	if (cpu_is_omap34xx()) {
> -		/*
> -		 * SRAM must be marked as non-cached on OMAP3 since the
> -		 * CORE DPLL M2 divider change code (in SRAM) runs with the
> -		 * SDRAM controller disabled, and if it is marked cached,
> -		 * the ARM may attempt to write cache lines back to SDRAM
> -		 * which will cause the system to hang.
> -		 */
> -		cached = 0;
> -	}
>   
>   	if (omap_sram_size == 0)
>   		return;
>   
>   	omap_sram_start = ROUND_DOWN(omap_sram_start, PAGE_SIZE);
> -	omap_sram_base = __arm_ioremap_exec(omap_sram_start, omap_sram_size, cached);
> +	/*
> +	 * SRAM must be marked as non-cached on OMAP3 since the
> +	 * CORE DPLL M2 divider change code (in SRAM) runs with the
> +	 * SDRAM controller disabled, and if it is marked cached,
> +	 * the ARM may attempt to write cache lines back to SDRAM
> +	 * which will cause the system to hang.
> +	 */
> +
> +	omap_sram_base = __arm_ioremap_exec(omap_sram_start, omap_sram_size, 0);
>   	if (!omap_sram_base) {
>   		pr_err("SRAM: Could not map\n");
>   		return;
> @@ -219,78 +190,6 @@ static void __init omap2_map_sram(void)
>   	set_memory_rox(base, pages);
>   }
>   
> -static void (*_omap2_sram_ddr_init)(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
> -			      u32 base_cs, u32 force_unlock);
> -
> -void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
> -		   u32 base_cs, u32 force_unlock)
> -{
> -	BUG_ON(!_omap2_sram_ddr_init);
> -	_omap2_sram_ddr_init(slow_dll_ctrl, fast_dll_ctrl,
> -			     base_cs, force_unlock);
> -}
> -
> -static void (*_omap2_sram_reprogram_sdrc)(u32 perf_level, u32 dll_val,
> -					  u32 mem_type);
> -
> -void omap2_sram_reprogram_sdrc(u32 perf_level, u32 dll_val, u32 mem_type)
> -{
> -	BUG_ON(!_omap2_sram_reprogram_sdrc);
> -	_omap2_sram_reprogram_sdrc(perf_level, dll_val, mem_type);
> -}
> -
> -static u32 (*_omap2_set_prcm)(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
> -
> -u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass)
> -{
> -	BUG_ON(!_omap2_set_prcm);
> -	return _omap2_set_prcm(dpll_ctrl_val, sdrc_rfr_val, bypass);
> -}
> -
> -#ifdef CONFIG_SOC_OMAP2420
> -static int __init omap242x_sram_init(void)
> -{
> -	_omap2_sram_ddr_init = omap_sram_push(omap242x_sram_ddr_init,
> -					omap242x_sram_ddr_init_sz);
> -
> -	_omap2_sram_reprogram_sdrc = omap_sram_push(omap242x_sram_reprogram_sdrc,
> -					    omap242x_sram_reprogram_sdrc_sz);
> -
> -	_omap2_set_prcm = omap_sram_push(omap242x_sram_set_prcm,
> -					 omap242x_sram_set_prcm_sz);
> -
> -	return 0;
> -}
> -#else
> -static inline int omap242x_sram_init(void)
> -{
> -	return 0;
> -}
> -#endif
> -
> -#ifdef CONFIG_SOC_OMAP2430
> -static int __init omap243x_sram_init(void)
> -{
> -	_omap2_sram_ddr_init = omap_sram_push(omap243x_sram_ddr_init,
> -					omap243x_sram_ddr_init_sz);
> -
> -	_omap2_sram_reprogram_sdrc = omap_sram_push(omap243x_sram_reprogram_sdrc,
> -					    omap243x_sram_reprogram_sdrc_sz);
> -
> -	_omap2_set_prcm = omap_sram_push(omap243x_sram_set_prcm,
> -					 omap243x_sram_set_prcm_sz);
> -
> -	return 0;
> -}
> -#else
> -static inline int omap243x_sram_init(void)
> -{
> -	return 0;
> -}
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -
>   void omap3_sram_restore_context(void)
>   {
>   	omap_sram_reset();
> @@ -303,24 +202,12 @@ static inline int omap34xx_sram_init(void)
>   	omap3_sram_restore_context();
>   	return 0;
>   }
> -#else
> -static inline int omap34xx_sram_init(void)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_ARCH_OMAP3 */
>   
>   int __init omap_sram_init(void)
>   {
>   	omap_detect_sram();
>   	omap2_map_sram();
> -
> -	if (cpu_is_omap242x())
> -		omap242x_sram_init();
> -	else if (cpu_is_omap2430())
> -		omap243x_sram_init();
> -	else if (cpu_is_omap34xx())
> -		omap34xx_sram_init();
> +	omap34xx_sram_init();
>   
>   	return 0;
>   }
> diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
> index 030cabc39821..2db2c4598cdb 100644
> --- a/arch/arm/mach-omap2/sram.h
> +++ b/arch/arm/mach-omap2/sram.h
> @@ -5,43 +5,12 @@
>   
>   #ifndef __ASSEMBLY__
>   
> -extern void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
> -				u32 base_cs, u32 force_unlock);
> -extern void omap2_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
> -				      u32 mem_type);
> -extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
> -
>   extern void omap3_sram_restore_context(void);
>   
>   extern int __init omap_sram_init(void);
>   
>   extern void *omap_sram_push(void *funcp, unsigned long size);
>   
> -extern void omap242x_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
> -						u32 base_cs, u32 force_unlock);
> -extern unsigned long omap242x_sram_ddr_init_sz;
> -
> -extern u32 omap242x_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
> -						int bypass);
> -extern unsigned long omap242x_sram_set_prcm_sz;
> -
> -extern void omap242x_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
> -						u32 mem_type);
> -extern unsigned long omap242x_sram_reprogram_sdrc_sz;
> -
> -
> -extern void omap243x_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
> -						u32 base_cs, u32 force_unlock);
> -extern unsigned long omap243x_sram_ddr_init_sz;
> -
> -extern u32 omap243x_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
> -						int bypass);
> -extern unsigned long omap243x_sram_set_prcm_sz;
> -
> -extern void omap243x_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
> -						u32 mem_type);
> -extern unsigned long omap243x_sram_reprogram_sdrc_sz;
> -
>   #ifdef CONFIG_PM
>   extern void omap_push_sram_idle(void);
>   #else
> @@ -54,5 +23,4 @@ static inline void omap_push_sram_idle(void) {}
>    * OMAP2+: define the SRAM PA addresses.
>    * Used by the SRAM management code and the idle sleep code.
>    */
> -#define OMAP2_SRAM_PA		0x40200000
>   #define OMAP3_SRAM_PA           0x40200000
> diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
> deleted file mode 100644
> index 92ef21ac2ac1..000000000000
> --- a/arch/arm/mach-omap2/sram242x.S
> +++ /dev/null
> @@ -1,317 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * linux/arch/arm/mach-omap2/sram242x.S
> - *
> - * Omap2 specific functions that need to be run in internal SRAM
> - *
> - * (C) Copyright 2004
> - * Texas Instruments, <www.ti.com>
> - * Richard Woodruff <r-woodruff2@ti.com>
> - *
> - * Richard Woodruff notes that any changes to this code must be carefully
> - * audited and tested to ensure that they don't cause a TLB miss while
> - * the SDRAM is inaccessible.  Such a situation will crash the system
> - * since it will cause the ARM MMU to attempt to walk the page tables.
> - * These crashes may be intermittent.
> - */
> -#include <linux/linkage.h>
> -
> -#include <asm/assembler.h>
> -
> -#include "soc.h"
> -#include "iomap.h"
> -#include "prm2xxx.h"
> -#include "cm2xxx.h"
> -#include "sdrc.h"
> -
> -	.text
> -
> -	.align	3
> -ENTRY(omap242x_sram_ddr_init)
> -	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
> -
> -	mov	r12, r2			@ capture CS1 vs CS0
> -	mov	r8, r3			@ capture force parameter
> -
> -	/* frequency shift down */
> -	ldr	r2, omap242x_sdi_cm_clksel2_pll	@ get address of dpllout reg
> -	mov	r3, #0x1		@ value for 1x operation
> -	str	r3, [r2]		@ go to L1-freq operation
> -
> -	/* voltage shift down */
> -	mov r9, #0x1			@ set up for L1 voltage call
> -	bl voltage_shift		@ go drop voltage
> -
> -	/* dll lock mode */
> -	ldr	r11, omap242x_sdi_sdrc_dlla_ctrl	@ addr of dlla ctrl
> -	ldr	r10, [r11]		@ get current val
> -	cmp	r12, #0x1		@ cs1 base (2422 es2.05/1)
> -	addeq	r11, r11, #0x8		@ if cs1 base, move to DLLB
> -	mvn	r9, #0x4		@ mask to get clear bit2
> -	and	r10, r10, r9		@ clear bit2 for lock mode.
> -	orr	r10, r10, #0x8		@ make sure DLL on (es2 bit pos)
> -	orr	r10, r10, #0x2		@ 90 degree phase for all below 133MHz
> -	str	r10, [r11]		@ commit to DLLA_CTRL
> -	bl	i_dll_wait		@ wait for dll to lock
> -
> -	/* get dll value */
> -	add	r11, r11, #0x4		@ get addr of status reg
> -	ldr	r10, [r11]		@ get locked value
> -
> -	/* voltage shift up */
> -	mov r9, #0x0			@ shift back to L0-voltage
> -	bl voltage_shift		@ go raise voltage
> -
> -	/* frequency shift up */
> -	mov	r3, #0x2		@ value for 2x operation
> -	str	r3, [r2]		@ go to L0-freq operation
> -
> -	/* reset entry mode for dllctrl */
> -	sub	r11, r11, #0x4		@ move from status to ctrl
> -	cmp	r12, #0x1		@ normalize if cs1 based
> -	subeq	r11, r11, #0x8		@ possibly back to DLLA
> -	cmp	r8, #0x1		@ if forced unlock exit
> -	orreq	r1, r1, #0x4		@ make sure exit with unlocked value
> -	str	r1, [r11]		@ restore DLLA_CTRL high value
> -	add	r11, r11, #0x8		@ move to DLLB_CTRL addr
> -	str	r1, [r11]		@ set value DLLB_CTRL
> -	bl	i_dll_wait		@ wait for possible lock
> -
> -	/* set up for return, DDR should be good */
> -	str r10, [r0]			@ write dll_status and return counter
> -	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
> -
> -	/* ensure the DLL has relocked */
> -i_dll_wait:
> -	mov	r4, #0x800		@ delay DLL relock, min 0x400 L3 clocks
> -i_dll_delay:
> -	subs	r4, r4, #0x1
> -	bne	i_dll_delay
> -	ret	lr
> -
> -	/*
> -	 * shift up or down voltage, use R9 as input to tell level.
> -	 * wait for it to finish, use 32k sync counter, 1tick=31uS.
> -	 */
> -voltage_shift:
> -	ldr	r4, omap242x_sdi_prcm_voltctrl	@ get addr of volt ctrl.
> -	ldr	r5, [r4]		@ get value.
> -	ldr	r6, prcm_mask_val	@ get value of mask
> -	and	r5, r5, r6		@ apply mask to clear bits
> -	orr	r5, r5, r9		@ bulld value for L0/L1-volt operation.
> -	str	r5, [r4]		@ set up for change.
> -	mov	r3, #0x4000		@ get val for force
> -	orr	r5, r5, r3		@ build value for force
> -	str	r5, [r4]		@ Force transition to L1
> -
> -	ldr	r3, omap242x_sdi_timer_32ksynct_cr	@ get addr of counter
> -	ldr	r5, [r3]		@ get value
> -	add	r5, r5, #0x3		@ give it at most 93uS
> -volt_delay:
> -	ldr	r7, [r3]		@ get timer value
> -	cmp	r5, r7			@ time up?
> -	bhi	volt_delay		@ not yet->branch
> -	ret	lr			@ back to caller.
> -
> -omap242x_sdi_cm_clksel2_pll:
> -	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL2)
> -omap242x_sdi_sdrc_dlla_ctrl:
> -	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
> -omap242x_sdi_prcm_voltctrl:
> -	.word OMAP2420_PRCM_VOLTCTRL
> -prcm_mask_val:
> -	.word 0xFFFF3FFC
> -omap242x_sdi_timer_32ksynct_cr:
> -	.word OMAP2_L4_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
> -ENTRY(omap242x_sram_ddr_init_sz)
> -	.word	. - omap242x_sram_ddr_init
> -
> -/*
> - * Reprograms memory timings.
> - * r0 = [PRCM_FULL | PRCM_HALF] r1 = SDRC_DLLA_CTRL value r2 = [DDR | SDR]
> - * PRCM_FULL = 2, PRCM_HALF = 1, DDR = 1, SDR = 0
> - */
> -	.align	3
> -ENTRY(omap242x_sram_reprogram_sdrc)
> -	stmfd	sp!, {r0 - r10, lr}	@ save registers on stack
> -	mov	r3, #0x0		@ clear for mrc call
> -	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, finish ARM SDR/DDR
> -	nop
> -	nop
> -	ldr	r6, omap242x_srs_sdrc_rfr_ctrl	@ get addr of refresh reg
> -	ldr	r5, [r6]		@ get value
> -	mov	r5, r5, lsr #8		@ isolate rfr field and drop burst
> -
> -	cmp	r0, #0x1		@ going to half speed?
> -	movne	r9, #0x0		@ if up set flag up for pre up, hi volt
> -
> -	blne	voltage_shift_c		@ adjust voltage
> -
> -	cmp	r0, #0x1		@ going to half speed (post branch link)
> -	moveq	r5, r5, lsr #1		@ divide by 2 if to half
> -	movne	r5, r5, lsl #1		@ mult by 2 if to full
> -	mov	r5, r5, lsl #8		@ put rfr field back into place
> -	add	r5, r5, #0x1		@ turn on burst of 1
> -	ldr	r4, omap242x_srs_cm_clksel2_pll	@ get address of out reg
> -	ldr	r3, [r4]		@ get curr value
> -	orr	r3, r3, #0x3
> -	bic	r3, r3, #0x3		@ clear lower bits
> -	orr	r3, r3, r0		@ new state value
> -	str	r3, [r4]		@ set new state (pll/x, x=1 or 2)
> -	nop
> -	nop
> -
> -	moveq	r9, #0x1		@ if speed down, post down, drop volt
> -	bleq	voltage_shift_c
> -
> -	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier
> -	str	r5, [r6]		@ set new RFR_1 value
> -	add	r6, r6, #0x30		@ get RFR_2 addr
> -	str	r5, [r6]		@ set RFR_2
> -	nop
> -	cmp	r2, #0x1		@ (SDR or DDR) do we need to adjust DLL
> -	bne	freq_out		@ leave if SDR, no DLL function
> -
> -	/* With DDR, we need to take care of the DLL for the frequency change */
> -	ldr	r2, omap242x_srs_sdrc_dlla_ctrl	@ addr of dlla ctrl
> -	str	r1, [r2]		@ write out new SDRC_DLLA_CTRL
> -	add	r2, r2, #0x8		@ addr to SDRC_DLLB_CTRL
> -	str	r1, [r2]		@ commit to SDRC_DLLB_CTRL
> -	mov	r1, #0x2000		@ wait DLL relock, min 0x400 L3 clocks
> -dll_wait:
> -	subs	r1, r1, #0x1
> -	bne	dll_wait
> -freq_out:
> -	ldmfd	sp!, {r0 - r10, pc}	@ restore regs and return
> -
> -    /*
> -     * shift up or down voltage, use R9 as input to tell level.
> -     *	wait for it to finish, use 32k sync counter, 1tick=31uS.
> -     */
> -voltage_shift_c:
> -	ldr	r10, omap242x_srs_prcm_voltctrl	@ get addr of volt ctrl
> -	ldr	r8, [r10]		@ get value
> -	ldr	r7, ddr_prcm_mask_val	@ get value of mask
> -	and	r8, r8, r7		@ apply mask to clear bits
> -	orr	r8, r8, r9		@ bulld value for L0/L1-volt operation.
> -	str	r8, [r10]		@ set up for change.
> -	mov	r7, #0x4000		@ get val for force
> -	orr	r8, r8, r7		@ build value for force
> -	str	r8, [r10]		@ Force transition to L1
> -
> -	ldr	r10, omap242x_srs_timer_32ksynct	@ get addr of counter
> -	ldr	r8, [r10]		@ get value
> -	add	r8, r8, #0x2		@ give it at most 62uS (min 31+)
> -volt_delay_c:
> -	ldr	r7, [r10]		@ get timer value
> -	cmp	r8, r7			@ time up?
> -	bhi	volt_delay_c		@ not yet->branch
> -	ret	lr			@ back to caller
> -
> -omap242x_srs_cm_clksel2_pll:
> -	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL2)
> -omap242x_srs_sdrc_dlla_ctrl:
> -	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
> -omap242x_srs_sdrc_rfr_ctrl:
> -	.word OMAP242X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
> -omap242x_srs_prcm_voltctrl:
> -	.word OMAP2420_PRCM_VOLTCTRL
> -ddr_prcm_mask_val:
> -	.word 0xFFFF3FFC
> -omap242x_srs_timer_32ksynct:
> -	.word OMAP2_L4_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
> -
> -ENTRY(omap242x_sram_reprogram_sdrc_sz)
> -	.word	. - omap242x_sram_reprogram_sdrc
> -
> -/*
> - * Set dividers and pll. Also recalculate DLL value for DDR and unlock mode.
> - */
> -	.align	3
> -ENTRY(omap242x_sram_set_prcm)
> -	stmfd	sp!, {r0-r12, lr}	@ regs to stack
> -	adr	r4, pbegin		@ addr of preload start
> -	adr	r8, pend		@ addr of preload end
> -	mcrr	p15, 1, r8, r4, c12	@ preload into icache
> -pbegin:
> -	/* move into fast relock bypass */
> -	ldr	r8, omap242x_ssp_pll_ctl	@ get addr
> -	ldr	r5, [r8]		@ get val
> -	mvn	r6, #0x3		@ clear mask
> -	and	r5, r5, r6		@ clear field
> -	orr	r7, r5, #0x2		@ fast relock val
> -	str	r7, [r8]		@ go to fast relock
> -	ldr	r4, omap242x_ssp_pll_stat	@ addr of stat
> -block:
> -	/* wait for bypass */
> -	ldr	r8, [r4]		@ stat value
> -	and	r8, r8, #0x3		@ mask for stat
> -	cmp	r8, #0x1		@ there yet
> -	bne	block			@ loop if not
> -
> -	/* set new dpll dividers _after_ in bypass */
> -	ldr	r4, omap242x_ssp_pll_div	@ get addr
> -	str	r0, [r4]		@ set dpll ctrl val
> -
> -	ldr	r4, omap242x_ssp_set_config	@ get addr
> -	mov	r8, #1			@ valid cfg msk
> -	str	r8, [r4]		@ make dividers take
> -
> -	mov	r4, #100		@ dead spin a bit
> -wait_a_bit:
> -	subs	r4, r4, #1		@ dec loop
> -	bne	wait_a_bit		@ delay done?
> -
> -	/* check if staying in bypass */
> -	cmp	r2, #0x1		@ stay in bypass?
> -	beq	pend			@ jump over dpll relock
> -
> -	/* relock DPLL with new vals */
> -	ldr	r5, omap242x_ssp_pll_stat	@ get addr
> -	ldr	r4, omap242x_ssp_pll_ctl	@ get addr
> -	orr	r8, r7, #0x3		@ val for lock dpll
> -	str	r8, [r4]		@ set val
> -	mov	r0, #1000		@ dead spin a bit
> -wait_more:
> -	subs	r0, r0, #1		@ dec loop
> -	bne	wait_more		@ delay done?
> -wait_lock:
> -	ldr	r8, [r5]		@ get lock val
> -	and	r8, r8, #3		@ isolate field
> -	cmp	r8, #2			@ locked?
> -	bne	wait_lock		@ wait if not
> -pend:
> -	/* update memory timings & briefly lock dll */
> -	ldr	r4, omap242x_ssp_sdrc_rfr	@ get addr
> -	str	r1, [r4]		@ update refresh timing
> -	ldr	r11, omap242x_ssp_dlla_ctrl	@ get addr of DLLA ctrl
> -	ldr	r10, [r11]		@ get current val
> -	mvn	r9, #0x4		@ mask to get clear bit2
> -	and	r10, r10, r9		@ clear bit2 for lock mode
> -	orr	r10, r10, #0x8		@ make sure DLL on (es2 bit pos)
> -	str	r10, [r11]		@ commit to DLLA_CTRL
> -	add	r11, r11, #0x8		@ move to dllb
> -	str	r10, [r11]		@ hit DLLB also
> -
> -	mov	r4, #0x800		@ relock time (min 0x400 L3 clocks)
> -wait_dll_lock:
> -	subs	r4, r4, #0x1
> -	bne	wait_dll_lock
> -	nop
> -	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
> -
> -omap242x_ssp_set_config:
> -	.word OMAP2420_PRCM_CLKCFG_CTRL
> -omap242x_ssp_pll_ctl:
> -	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKEN)
> -omap242x_ssp_pll_stat:
> -	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_IDLEST)
> -omap242x_ssp_pll_div:
> -	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL1)
> -omap242x_ssp_sdrc_rfr:
> -	.word OMAP242X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
> -omap242x_ssp_dlla_ctrl:
> -	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
> -
> -ENTRY(omap242x_sram_set_prcm_sz)
> -	.word	. - omap242x_sram_set_prcm
> diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
> deleted file mode 100644
> index faf03b7f08f5..000000000000
> --- a/arch/arm/mach-omap2/sram243x.S
> +++ /dev/null
> @@ -1,317 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * linux/arch/arm/mach-omap2/sram243x.S
> - *
> - * Omap2 specific functions that need to be run in internal SRAM
> - *
> - * (C) Copyright 2004
> - * Texas Instruments, <www.ti.com>
> - * Richard Woodruff <r-woodruff2@ti.com>
> - *
> - * Richard Woodruff notes that any changes to this code must be carefully
> - * audited and tested to ensure that they don't cause a TLB miss while
> - * the SDRAM is inaccessible.  Such a situation will crash the system
> - * since it will cause the ARM MMU to attempt to walk the page tables.
> - * These crashes may be intermittent.
> - */
> -#include <linux/linkage.h>
> -
> -#include <asm/assembler.h>
> -
> -#include "soc.h"
> -#include "iomap.h"
> -#include "prm2xxx.h"
> -#include "cm2xxx.h"
> -#include "sdrc.h"
> -
> -	.text
> -
> -	.align	3
> -ENTRY(omap243x_sram_ddr_init)
> -	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
> -
> -	mov	r12, r2			@ capture CS1 vs CS0
> -	mov	r8, r3			@ capture force parameter
> -
> -	/* frequency shift down */
> -	ldr	r2, omap243x_sdi_cm_clksel2_pll	@ get address of dpllout reg
> -	mov	r3, #0x1		@ value for 1x operation
> -	str	r3, [r2]		@ go to L1-freq operation
> -
> -	/* voltage shift down */
> -	mov r9, #0x1			@ set up for L1 voltage call
> -	bl voltage_shift		@ go drop voltage
> -
> -	/* dll lock mode */
> -	ldr	r11, omap243x_sdi_sdrc_dlla_ctrl	@ addr of dlla ctrl
> -	ldr	r10, [r11]		@ get current val
> -	cmp	r12, #0x1		@ cs1 base (2422 es2.05/1)
> -	addeq	r11, r11, #0x8		@ if cs1 base, move to DLLB
> -	mvn	r9, #0x4		@ mask to get clear bit2
> -	and	r10, r10, r9		@ clear bit2 for lock mode.
> -	orr	r10, r10, #0x8		@ make sure DLL on (es2 bit pos)
> -	orr	r10, r10, #0x2		@ 90 degree phase for all below 133MHz
> -	str	r10, [r11]		@ commit to DLLA_CTRL
> -	bl	i_dll_wait		@ wait for dll to lock
> -
> -	/* get dll value */
> -	add	r11, r11, #0x4		@ get addr of status reg
> -	ldr	r10, [r11]		@ get locked value
> -
> -	/* voltage shift up */
> -	mov r9, #0x0			@ shift back to L0-voltage
> -	bl voltage_shift		@ go raise voltage
> -
> -	/* frequency shift up */
> -	mov	r3, #0x2		@ value for 2x operation
> -	str	r3, [r2]		@ go to L0-freq operation
> -
> -	/* reset entry mode for dllctrl */
> -	sub	r11, r11, #0x4		@ move from status to ctrl
> -	cmp	r12, #0x1		@ normalize if cs1 based
> -	subeq	r11, r11, #0x8		@ possibly back to DLLA
> -	cmp	r8, #0x1		@ if forced unlock exit
> -	orreq	r1, r1, #0x4		@ make sure exit with unlocked value
> -	str	r1, [r11]		@ restore DLLA_CTRL high value
> -	add	r11, r11, #0x8		@ move to DLLB_CTRL addr
> -	str	r1, [r11]		@ set value DLLB_CTRL
> -	bl	i_dll_wait		@ wait for possible lock
> -
> -	/* set up for return, DDR should be good */
> -	str r10, [r0]			@ write dll_status and return counter
> -	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
> -
> -	/* ensure the DLL has relocked */
> -i_dll_wait:
> -	mov	r4, #0x800		@ delay DLL relock, min 0x400 L3 clocks
> -i_dll_delay:
> -	subs	r4, r4, #0x1
> -	bne	i_dll_delay
> -	ret	lr
> -
> -	/*
> -	 * shift up or down voltage, use R9 as input to tell level.
> -	 * wait for it to finish, use 32k sync counter, 1tick=31uS.
> -	 */
> -voltage_shift:
> -	ldr	r4, omap243x_sdi_prcm_voltctrl	@ get addr of volt ctrl.
> -	ldr	r5, [r4]		@ get value.
> -	ldr	r6, prcm_mask_val	@ get value of mask
> -	and	r5, r5, r6		@ apply mask to clear bits
> -	orr	r5, r5, r9		@ bulld value for L0/L1-volt operation.
> -	str	r5, [r4]		@ set up for change.
> -	mov	r3, #0x4000		@ get val for force
> -	orr	r5, r5, r3		@ build value for force
> -	str	r5, [r4]		@ Force transition to L1
> -
> -	ldr	r3, omap243x_sdi_timer_32ksynct_cr	@ get addr of counter
> -	ldr	r5, [r3]		@ get value
> -	add	r5, r5, #0x3		@ give it at most 93uS
> -volt_delay:
> -	ldr	r7, [r3]		@ get timer value
> -	cmp	r5, r7			@ time up?
> -	bhi	volt_delay		@ not yet->branch
> -	ret	lr			@ back to caller.
> -
> -omap243x_sdi_cm_clksel2_pll:
> -	.word OMAP2430_CM_REGADDR(PLL_MOD, CM_CLKSEL2)
> -omap243x_sdi_sdrc_dlla_ctrl:
> -	.word OMAP243X_SDRC_REGADDR(SDRC_DLLA_CTRL)
> -omap243x_sdi_prcm_voltctrl:
> -	.word OMAP2430_PRCM_VOLTCTRL
> -prcm_mask_val:
> -	.word 0xFFFF3FFC
> -omap243x_sdi_timer_32ksynct_cr:
> -	.word OMAP2_L4_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
> -ENTRY(omap243x_sram_ddr_init_sz)
> -	.word	. - omap243x_sram_ddr_init
> -
> -/*
> - * Reprograms memory timings.
> - * r0 = [PRCM_FULL | PRCM_HALF] r1 = SDRC_DLLA_CTRL value r2 = [DDR | SDR]
> - * PRCM_FULL = 2, PRCM_HALF = 1, DDR = 1, SDR = 0
> - */
> -	.align	3
> -ENTRY(omap243x_sram_reprogram_sdrc)
> -	stmfd	sp!, {r0 - r10, lr}	@ save registers on stack
> -	mov	r3, #0x0		@ clear for mrc call
> -	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, finish ARM SDR/DDR
> -	nop
> -	nop
> -	ldr	r6, omap243x_srs_sdrc_rfr_ctrl	@ get addr of refresh reg
> -	ldr	r5, [r6]		@ get value
> -	mov	r5, r5, lsr #8		@ isolate rfr field and drop burst
> -
> -	cmp	r0, #0x1		@ going to half speed?
> -	movne	r9, #0x0		@ if up set flag up for pre up, hi volt
> -
> -	blne	voltage_shift_c		@ adjust voltage
> -
> -	cmp	r0, #0x1		@ going to half speed (post branch link)
> -	moveq	r5, r5, lsr #1		@ divide by 2 if to half
> -	movne	r5, r5, lsl #1		@ mult by 2 if to full
> -	mov	r5, r5, lsl #8		@ put rfr field back into place
> -	add	r5, r5, #0x1		@ turn on burst of 1
> -	ldr	r4, omap243x_srs_cm_clksel2_pll	@ get address of out reg
> -	ldr	r3, [r4]		@ get curr value
> -	orr	r3, r3, #0x3
> -	bic	r3, r3, #0x3		@ clear lower bits
> -	orr	r3, r3, r0		@ new state value
> -	str	r3, [r4]		@ set new state (pll/x, x=1 or 2)
> -	nop
> -	nop
> -
> -	moveq	r9, #0x1		@ if speed down, post down, drop volt
> -	bleq	voltage_shift_c
> -
> -	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier
> -	str	r5, [r6]		@ set new RFR_1 value
> -	add	r6, r6, #0x30		@ get RFR_2 addr
> -	str	r5, [r6]		@ set RFR_2
> -	nop
> -	cmp	r2, #0x1		@ (SDR or DDR) do we need to adjust DLL
> -	bne	freq_out		@ leave if SDR, no DLL function
> -
> -	/* With DDR, we need to take care of the DLL for the frequency change */
> -	ldr	r2, omap243x_srs_sdrc_dlla_ctrl	@ addr of dlla ctrl
> -	str	r1, [r2]		@ write out new SDRC_DLLA_CTRL
> -	add	r2, r2, #0x8		@ addr to SDRC_DLLB_CTRL
> -	str	r1, [r2]		@ commit to SDRC_DLLB_CTRL
> -	mov	r1, #0x2000		@ wait DLL relock, min 0x400 L3 clocks
> -dll_wait:
> -	subs	r1, r1, #0x1
> -	bne	dll_wait
> -freq_out:
> -	ldmfd	sp!, {r0 - r10, pc}	@ restore regs and return
> -
> -    /*
> -     * shift up or down voltage, use R9 as input to tell level.
> -     *	wait for it to finish, use 32k sync counter, 1tick=31uS.
> -     */
> -voltage_shift_c:
> -	ldr	r10, omap243x_srs_prcm_voltctrl	@ get addr of volt ctrl
> -	ldr	r8, [r10]		@ get value
> -	ldr	r7, ddr_prcm_mask_val	@ get value of mask
> -	and	r8, r8, r7		@ apply mask to clear bits
> -	orr	r8, r8, r9		@ bulld value for L0/L1-volt operation.
> -	str	r8, [r10]		@ set up for change.
> -	mov	r7, #0x4000		@ get val for force
> -	orr	r8, r8, r7		@ build value for force
> -	str	r8, [r10]		@ Force transition to L1
> -
> -	ldr	r10, omap243x_srs_timer_32ksynct	@ get addr of counter
> -	ldr	r8, [r10]		@ get value
> -	add	r8, r8, #0x2		@ give it at most 62uS (min 31+)
> -volt_delay_c:
> -	ldr	r7, [r10]		@ get timer value
> -	cmp	r8, r7			@ time up?
> -	bhi	volt_delay_c		@ not yet->branch
> -	ret	lr			@ back to caller
> -
> -omap243x_srs_cm_clksel2_pll:
> -	.word OMAP2430_CM_REGADDR(PLL_MOD, CM_CLKSEL2)
> -omap243x_srs_sdrc_dlla_ctrl:
> -	.word OMAP243X_SDRC_REGADDR(SDRC_DLLA_CTRL)
> -omap243x_srs_sdrc_rfr_ctrl:
> -	.word OMAP243X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
> -omap243x_srs_prcm_voltctrl:
> -	.word OMAP2430_PRCM_VOLTCTRL
> -ddr_prcm_mask_val:
> -	.word 0xFFFF3FFC
> -omap243x_srs_timer_32ksynct:
> -	.word OMAP2_L4_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
> -
> -ENTRY(omap243x_sram_reprogram_sdrc_sz)
> -	.word	. - omap243x_sram_reprogram_sdrc
> -
> -/*
> - * Set dividers and pll. Also recalculate DLL value for DDR and unlock mode.
> - */
> -	.align	3
> -ENTRY(omap243x_sram_set_prcm)
> -	stmfd	sp!, {r0-r12, lr}	@ regs to stack
> -	adr	r4, pbegin		@ addr of preload start
> -	adr	r8, pend		@ addr of preload end
> -	mcrr	p15, 1, r8, r4, c12	@ preload into icache
> -pbegin:
> -	/* move into fast relock bypass */
> -	ldr	r8, omap243x_ssp_pll_ctl	@ get addr
> -	ldr	r5, [r8]		@ get val
> -	mvn	r6, #0x3		@ clear mask
> -	and	r5, r5, r6		@ clear field
> -	orr	r7, r5, #0x2		@ fast relock val
> -	str	r7, [r8]		@ go to fast relock
> -	ldr	r4, omap243x_ssp_pll_stat	@ addr of stat
> -block:
> -	/* wait for bypass */
> -	ldr	r8, [r4]		@ stat value
> -	and	r8, r8, #0x3		@ mask for stat
> -	cmp	r8, #0x1		@ there yet
> -	bne	block			@ loop if not
> -
> -	/* set new dpll dividers _after_ in bypass */
> -	ldr	r4, omap243x_ssp_pll_div	@ get addr
> -	str	r0, [r4]		@ set dpll ctrl val
> -
> -	ldr	r4, omap243x_ssp_set_config	@ get addr
> -	mov	r8, #1			@ valid cfg msk
> -	str	r8, [r4]		@ make dividers take
> -
> -	mov	r4, #100		@ dead spin a bit
> -wait_a_bit:
> -	subs	r4, r4, #1		@ dec loop
> -	bne	wait_a_bit		@ delay done?
> -
> -	/* check if staying in bypass */
> -	cmp	r2, #0x1		@ stay in bypass?
> -	beq	pend			@ jump over dpll relock
> -
> -	/* relock DPLL with new vals */
> -	ldr	r5, omap243x_ssp_pll_stat	@ get addr
> -	ldr	r4, omap243x_ssp_pll_ctl	@ get addr
> -	orr	r8, r7, #0x3		@ val for lock dpll
> -	str	r8, [r4]		@ set val
> -	mov	r0, #1000		@ dead spin a bit
> -wait_more:
> -	subs	r0, r0, #1		@ dec loop
> -	bne	wait_more		@ delay done?
> -wait_lock:
> -	ldr	r8, [r5]		@ get lock val
> -	and	r8, r8, #3		@ isolate field
> -	cmp	r8, #2			@ locked?
> -	bne	wait_lock		@ wait if not
> -pend:
> -	/* update memory timings & briefly lock dll */
> -	ldr	r4, omap243x_ssp_sdrc_rfr	@ get addr
> -	str	r1, [r4]		@ update refresh timing
> -	ldr	r11, omap243x_ssp_dlla_ctrl	@ get addr of DLLA ctrl
> -	ldr	r10, [r11]		@ get current val
> -	mvn	r9, #0x4		@ mask to get clear bit2
> -	and	r10, r10, r9		@ clear bit2 for lock mode
> -	orr	r10, r10, #0x8		@ make sure DLL on (es2 bit pos)
> -	str	r10, [r11]		@ commit to DLLA_CTRL
> -	add	r11, r11, #0x8		@ move to dllb
> -	str	r10, [r11]		@ hit DLLB also
> -
> -	mov	r4, #0x800		@ relock time (min 0x400 L3 clocks)
> -wait_dll_lock:
> -	subs	r4, r4, #0x1
> -	bne	wait_dll_lock
> -	nop
> -	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
> -
> -omap243x_ssp_set_config:
> -	.word OMAP2430_PRCM_CLKCFG_CTRL
> -omap243x_ssp_pll_ctl:
> -	.word OMAP2430_CM_REGADDR(PLL_MOD, CM_CLKEN)
> -omap243x_ssp_pll_stat:
> -	.word OMAP2430_CM_REGADDR(PLL_MOD, CM_IDLEST)
> -omap243x_ssp_pll_div:
> -	.word OMAP2430_CM_REGADDR(PLL_MOD, CM_CLKSEL1)
> -omap243x_ssp_sdrc_rfr:
> -	.word OMAP243X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
> -omap243x_ssp_dlla_ctrl:
> -	.word OMAP243X_SDRC_REGADDR(SDRC_DLLA_CTRL)
> -
> -ENTRY(omap243x_sram_set_prcm_sz)
> -	.word	. - omap243x_sram_set_prcm
> diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
> deleted file mode 100644
> index b46c254c2bc4..000000000000
> --- a/arch/arm/mach-omap2/usb-tusb6010.c
> +++ /dev/null
> @@ -1,217 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * linux/arch/arm/mach-omap2/usb-tusb6010.c
> - *
> - * Copyright (C) 2006 Nokia Corporation
> - */
> -
> -#include <linux/err.h>
> -#include <linux/string.h>
> -#include <linux/types.h>
> -#include <linux/errno.h>
> -#include <linux/delay.h>
> -#include <linux/platform_device.h>
> -#include <linux/export.h>
> -#include <linux/platform_data/usb-omap.h>
> -
> -#include <linux/usb/musb.h>
> -
> -#include "usb-tusb6010.h"
> -#include "gpmc.h"
> -
> -static u8		async_cs, sync_cs;
> -static unsigned		refclk_psec;
> -
> -static struct gpmc_settings tusb_async = {
> -	.wait_on_read	= true,
> -	.wait_on_write	= true,
> -	.device_width	= GPMC_DEVWIDTH_16BIT,
> -	.mux_add_data	= GPMC_MUX_AD,
> -};
> -
> -static struct gpmc_settings tusb_sync = {
> -	.burst_read	= true,
> -	.burst_write	= true,
> -	.sync_read	= true,
> -	.sync_write	= true,
> -	.wait_on_read	= true,
> -	.wait_on_write	= true,
> -	.burst_len	= GPMC_BURST_16,
> -	.device_width	= GPMC_DEVWIDTH_16BIT,
> -	.mux_add_data	= GPMC_MUX_AD,
> -};
> -
> -/* NOTE:  timings are from tusb 6010 datasheet Rev 1.8, 12-Sept 2006 */
> -
> -static int tusb_set_async_mode(unsigned sysclk_ps)
> -{
> -	struct gpmc_device_timings dev_t;
> -	struct gpmc_timings	t;
> -	unsigned		t_acsnh_advnh = sysclk_ps + 3000;
> -
> -	memset(&dev_t, 0, sizeof(dev_t));
> -
> -	dev_t.t_ceasu = 8 * 1000;
> -	dev_t.t_avdasu = t_acsnh_advnh - 7000;
> -	dev_t.t_ce_avd = 1000;
> -	dev_t.t_avdp_r = t_acsnh_advnh;
> -	dev_t.t_oeasu = t_acsnh_advnh + 1000;
> -	dev_t.t_oe = 300;
> -	dev_t.t_cez_r = 7000;
> -	dev_t.t_cez_w = dev_t.t_cez_r;
> -	dev_t.t_avdp_w = t_acsnh_advnh;
> -	dev_t.t_weasu = t_acsnh_advnh + 1000;
> -	dev_t.t_wpl = 300;
> -	dev_t.cyc_aavdh_we = 1;
> -
> -	gpmc_calc_timings(&t, &tusb_async, &dev_t);
> -
> -	return gpmc_cs_set_timings(async_cs, &t, &tusb_async);
> -}
> -
> -static int tusb_set_sync_mode(unsigned sysclk_ps)
> -{
> -	struct gpmc_device_timings dev_t;
> -	struct gpmc_timings	t;
> -	unsigned		t_scsnh_advnh = sysclk_ps + 3000;
> -
> -	memset(&dev_t, 0, sizeof(dev_t));
> -
> -	dev_t.clk = 11100;
> -	dev_t.t_bacc = 1000;
> -	dev_t.t_ces = 1000;
> -	dev_t.t_ceasu = 8 * 1000;
> -	dev_t.t_avdasu = t_scsnh_advnh - 7000;
> -	dev_t.t_ce_avd = 1000;
> -	dev_t.t_avdp_r = t_scsnh_advnh;
> -	dev_t.cyc_aavdh_oe = 3;
> -	dev_t.cyc_oe = 5;
> -	dev_t.t_ce_rdyz = 7000;
> -	dev_t.t_avdp_w = t_scsnh_advnh;
> -	dev_t.cyc_aavdh_we = 3;
> -	dev_t.cyc_wpl = 6;
> -
> -	gpmc_calc_timings(&t, &tusb_sync, &dev_t);
> -
> -	return gpmc_cs_set_timings(sync_cs, &t, &tusb_sync);
> -}
> -
> -/* tusb driver calls this when it changes the chip's clocking */
> -static int tusb6010_platform_retime(unsigned is_refclk)
> -{
> -	static const char	error[] =
> -		KERN_ERR "tusb6010 %s retime error %d\n";
> -
> -	unsigned	sysclk_ps;
> -	int		status;
> -
> -	if (!refclk_psec)
> -		return -ENODEV;
> -
> -	sysclk_ps = is_refclk ? refclk_psec : TUSB6010_OSCCLK_60;
> -
> -	status = tusb_set_async_mode(sysclk_ps);
> -	if (status < 0) {
> -		printk(error, "async", status);
> -		goto done;
> -	}
> -	status = tusb_set_sync_mode(sysclk_ps);
> -	if (status < 0)
> -		printk(error, "sync", status);
> -done:
> -	return status;
> -}
> -
> -static struct resource tusb_resources[] = {
> -	/* Order is significant!  The start/end fields
> -	 * are updated during setup..
> -	 */
> -	{ /* Asynchronous access */
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	{ /* Synchronous access */
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -static u64 tusb_dmamask = ~(u32)0;
> -
> -static struct platform_device tusb_device = {
> -	.name		= "musb-tusb",
> -	.id		= -1,
> -	.dev = {
> -		.dma_mask		= &tusb_dmamask,
> -		.coherent_dma_mask	= 0xffffffff,
> -	},
> -	.num_resources	= ARRAY_SIZE(tusb_resources),
> -	.resource	= tusb_resources,
> -};
> -
> -
> -/* this may be called only from board-*.c setup code */
> -int __init tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
> -		unsigned int ps_refclk, unsigned int waitpin,
> -		unsigned int async, unsigned int sync,
> -		unsigned int dmachan)
> -{
> -	int		status;
> -	static char	error[] __initdata =
> -		KERN_ERR "tusb6010 init error %d, %d\n";
> -
> -	/* ASYNC region, primarily for PIO */
> -	status = gpmc_cs_request(async, SZ_16M, (unsigned long *)
> -				&tusb_resources[0].start);
> -	if (status < 0) {
> -		printk(error, 1, status);
> -		return status;
> -	}
> -	tusb_resources[0].end = tusb_resources[0].start + 0x9ff;
> -	tusb_async.wait_pin = waitpin;
> -	async_cs = async;
> -
> -	status = gpmc_cs_program_settings(async_cs, &tusb_async);
> -	if (status < 0)
> -		return status;
> -
> -	/* SYNC region, primarily for DMA */
> -	status = gpmc_cs_request(sync, SZ_16M, (unsigned long *)
> -				&tusb_resources[1].start);
> -	if (status < 0) {
> -		printk(error, 2, status);
> -		return status;
> -	}
> -	tusb_resources[1].end = tusb_resources[1].start + 0x9ff;
> -	tusb_sync.wait_pin = waitpin;
> -	sync_cs = sync;
> -
> -	status = gpmc_cs_program_settings(sync_cs, &tusb_sync);
> -	if (status < 0)
> -		return status;
> -
> -	/* set up memory timings ... can speed them up later */
> -	if (!ps_refclk) {
> -		printk(error, 4, status);
> -		return -ENODEV;
> -	}
> -	refclk_psec = ps_refclk;
> -	status = tusb6010_platform_retime(1);
> -	if (status < 0) {
> -		printk(error, 5, status);
> -		return status;
> -	}
> -
> -	/* finish device setup ... */
> -	if (!data) {
> -		printk(error, 6, status);
> -		return -ENODEV;
> -	}
> -	tusb_device.dev.platform_data = data;
> -
> -	/* so far so good ... register the device */
> -	status = platform_device_register(&tusb_device);
> -	if (status < 0) {
> -		printk(error, 7, status);
> -		return status;
> -	}
> -	return 0;
> -}
> diff --git a/arch/arm/mach-omap2/usb-tusb6010.h b/arch/arm/mach-omap2/usb-tusb6010.h
> deleted file mode 100644
> index d210ff6238c2..000000000000
> --- a/arch/arm/mach-omap2/usb-tusb6010.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -
> -#ifndef __USB_TUSB6010_H
> -#define __USB_TUSB6010_H
> -
> -extern int __init tusb6010_setup_interface(
> -		struct musb_hdrc_platform_data *data,
> -		unsigned int ps_refclk, unsigned int waitpin,
> -		unsigned int async_cs, unsigned int sync_cs,
> -		unsigned int dmachan);
> -
> -#endif /* __USB_TUSB6010_H */
> diff --git a/arch/arm/mach-omap2/voltagedomains2xxx_data.c b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
> deleted file mode 100644
> index 9bc116fe3ba9..000000000000
> --- a/arch/arm/mach-omap2/voltagedomains2xxx_data.c
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * OMAP3 voltage domain data
> - *
> - * Copyright (C) 2011 Texas Instruments, Inc.
> - */
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -
> -#include "voltage.h"
> -
> -static struct voltagedomain omap2_voltdm_core = {
> -	.name = "core",
> -};
> -
> -static struct voltagedomain omap2_voltdm_wkup = {
> -	.name = "wakeup",
> -};
> -
> -static struct voltagedomain *voltagedomains_omap2[] __initdata = {
> -	&omap2_voltdm_core,
> -	&omap2_voltdm_wkup,
> -	NULL,
> -};
> -
> -void __init omap2xxx_voltagedomains_init(void)
> -{
> -	voltdm_init(voltagedomains_omap2);
> -}
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 0189dfdcbbe1..a383ff8f446c 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -337,7 +337,7 @@ config CRYPTO_DEV_OMAP_SHAM
>   
>   config CRYPTO_DEV_OMAP_AES
>   	tristate "Support for OMAP AES hw engine"
> -	depends on ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP2PLUS
> +	depends on ARCH_OMAP3 || ARCH_OMAP2PLUS
>   	select CRYPTO_AES
>   	select CRYPTO_SKCIPHER
>   	select CRYPTO_ENGINE
> diff --git a/drivers/media/platform/ti/omap/Kconfig b/drivers/media/platform/ti/omap/Kconfig
> index a9dbe1097775..c41812b324ad 100644
> --- a/drivers/media/platform/ti/omap/Kconfig
> +++ b/drivers/media/platform/ti/omap/Kconfig
> @@ -9,9 +9,9 @@ config VIDEO_OMAP2_VOUT
>   	depends on V4L_PLATFORM_DRIVERS
>   	depends on MMU
>   	depends on FB_OMAP2 || (COMPILE_TEST && FB_OMAP2=n)
> -	depends on ARCH_OMAP2 || ARCH_OMAP3 || COMPILE_TEST
> +	depends on ARCH_OMAP3 || COMPILE_TEST
>   	depends on VIDEO_DEV
>   	select VIDEOBUF2_DMA_CONTIG
> -	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
> +	select OMAP2_VRFB if ARCH_OMAP3
>   	help
>   	  V4L2 Display driver support for OMAP2/3 based boards.
> diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
> index 7d57836bf32f..8a362fd5bfc4 100644
> --- a/drivers/mtd/nand/onenand/Kconfig
> +++ b/drivers/mtd/nand/onenand/Kconfig
> @@ -23,8 +23,8 @@ config MTD_ONENAND_GENERIC
>   	  Support for OneNAND flash via platform device driver.
>   
>   config MTD_ONENAND_OMAP2
> -	tristate "OneNAND on OMAP2/OMAP3 support"
> -	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && ARM)
> +	tristate "OneNAND on OMAP3 support"
> +	depends on ARCH_OMAP3 || (COMPILE_TEST && ARM)
>   	depends on OF
>   	depends on OMAP_GPMC
>   	help
> diff --git a/drivers/video/fbdev/omap2/omapfb/Kconfig b/drivers/video/fbdev/omap2/omapfb/Kconfig
> index 2d20e79adefc..d8227f4326bd 100644
> --- a/drivers/video/fbdev/omap2/omapfb/Kconfig
> +++ b/drivers/video/fbdev/omap2/omapfb/Kconfig
> @@ -8,7 +8,7 @@ menuconfig FB_OMAP2
>   	depends on DRM_OMAP = n
>   	depends on GPIOLIB
>   	select FB_OMAP2_DSS
> -	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
> +	select OMAP2_VRFB if ARCH_OMAP3
>   	select FB_IOMEM_HELPERS
>   	help
>   	  Frame buffer driver for OMAP2+ based boards.
> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
> index 54a3fa370004..ca151152da19 100644
> --- a/include/linux/clk/ti.h
> +++ b/include/linux/clk/ti.h
> @@ -265,12 +265,6 @@ int omap2_clk_disable_autoidle_all(void);
>   int omap2_clk_enable_autoidle_all(void);
>   int omap2_clk_allow_idle(struct clk *clk);
>   int omap2_clk_deny_idle(struct clk *clk);
> -unsigned long omap2_dpllcore_recalc(struct clk_hw *hw,
> -				    unsigned long parent_rate);
> -int omap2_reprogram_dpllcore(struct clk_hw *clk, unsigned long rate,
> -			     unsigned long parent_rate);
> -void omap2xxx_clkt_dpllcore_init(struct clk_hw *hw);
> -void omap2xxx_clkt_vps_init(void);
>   unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
>   
>   void ti_dt_clk_init_retry_clks(void);
> @@ -322,8 +316,6 @@ void omap3_noncore_dpll_restore_context(struct clk_hw *hw);
>   int omap3_core_dpll_save_context(struct clk_hw *hw);
>   void omap3_core_dpll_restore_context(struct clk_hw *hw);
>   
> -extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
> -
>   #ifdef CONFIG_ATAGS
>   int omap3430_clk_legacy_init(void);
>   int omap3430es1_clk_legacy_init(void);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


