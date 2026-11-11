Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378658;
	b=uvNFLKJZjSBo3U3+PoZ/gdwNq28bP8FE+QvMKuhjt1xslCuUrIZf3T7eevb3xV2XX4yU
	 5sFNCNO60JBpQd/GuBnt2rPQw2Zao47JsGKtzHmwVjCXtmcbGVcSa7Cd0v+rVC/5JSHHv
	 tQNs7zCjjm923iMrW++PLZz6TWVfF+gdUr5836q417SVhFB9sehhsXvfCl8KjZovIcwF5
	 VQ4FYKOpNG4PN8PQ+V+QJklu+8uxeDiBhPGZmVbMhktkuE+7M4QCm0BHO/Y0T/rNYNqOr
	 M/E9UuOHsbR0BG4D7J+77+haWzOQizneRHTRnz8Xl4DiMlwgDepA34gvveZaHT43Q0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UkJcxjLHhm0Y+CDL9JRRl5rrZMoXUbMeNekZv0BizMY=;
	b=tZYbB6WAC2VNWAgvgXHfKljZjOUbbUJQks6m9M2DpnoH9Tgz60rv5kjE6Z9qh7Q/SjOi
	 +1PuKBRfVDHsF3zdBz9LhOfPE97a6ZqpKfWs+50tHrqIRwXrRmkN33++BBFzMeL7nqiwk
	 2UcTkQHqSTN8hcl988Tot/Fc8awobbFgoJJoeYGLqAoquFbH2C9k00ChNk2SQ4HViFuq9
	 WhFK/TrTQ2R2zkvS8KrjPEdQ7FHFnOFzS4G/b9JekE/wc4AQNSchysie2Jkd5Iuf31SQD
	 zER/1pZjLrs3OeDxMHzdhWoW8/LH4kZpXpWAusVmR/m1Sg1mkyBlza9EOeNUk5f7s/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8MfenWJ;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23F606A324
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2026 06:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B23F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8MfenWJ
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso2661151e87.3
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 22:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794378656; x=1794983456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UkJcxjLHhm0Y+CDL9JRRl5rrZMoXUbMeNekZv0BizMY=;
        b=q8MfenWJx5XY+TGwTQqOMA9IioS/+jQFrJaSOqEj2B2Nw0EST+CsNCV/0H0YPfNEL9
         nHqE3QYt1KORTKw1S86eT58Z4jXoa6fAXerpgL7M43F/OOJwDBM3pGqrF83epX2NtvOj
         /cghsAKcKAg75f47lM8eZWkNHCzqBzn8OusFM26vIo8157GDB336VSbC3kqoOOx21AG6
         65Hkl3s/ajLT/mG1GuuyfqGwlxPeqbPCPKN3Q9u+Biz5EinXSwBWEdeBuzsmiYfa0juK
         SiwD/4+l1X+DWBP5foJhYz73lqI0X0pkWnNvgjIe9fM5na0OecKldRa7exDPBQvTZr0d
         GswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794378656; x=1794983456;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UkJcxjLHhm0Y+CDL9JRRl5rrZMoXUbMeNekZv0BizMY=;
        b=dlA3pmEFOsHPMO6DOGK+V/0UL/pvzqSfoP0aCZQ34pODvtSWEAFv2Ejne1CuxusQlS
         FdooecHlVwMigYCTqtJix6gF8lS6K5kz119cxZGPA4NxKAyLJQgnv/10TN0x/oG4zYgY
         6XBE0O5B+pOVAoZkz0TPaYUNFIrRK56wQ24QSbg4YV231isWBM2L+tS+OY69a4LmIoEg
         PliwEae0NCHoPphwmLbIRy7h5Ww76/qb/TcKnjd/iiT9xvnkM1biKmWBklKk1lkfTint
         dqw9imbomIpU6EqrArU1cxH4oJylkRpzApvRiYpbBDKlRUCUdcxFyrpMxnCH1SIix+cn
         Uvyw==
X-Forwarded-Encrypted: i=1; AL+hErFw2Jp1nwwuOOqULHfSZzelOFd1RN+voopVOBIwDsmmzHP0y2kD9HXUuAARZiuc47N4lfmnwXCr219D@vger.kernel.org
X-Gm-Message-State: APuU4Z9czzbGCvVA69EudLHsMeB37RmQKGlc/2KPtHov9LjgAv8MwqQ2
	iOlPzc4J52R/AG168xq+ftTkAD7wMgMJPqlacg32MD25C347pfh9z+HX
X-Gm-Gg: AYBFou36HRXEcQvy64Bk7QM0DeitteswgmoEk0nXHj3oikGtZHJNjrr7r0R9k2ZXLUh
	JRyu+RO3YB6TYJudnDaVjt11Bw8Qj3BYgA51VCNohvTjRm8hjwIPMjYQLeKNxF1ghcIekQeat6s
	WjKdVxrWtJgtiCe6qCTQXbipk2dHfw6zpUDC+VO4dIcgGam+GOiWjK6KUge+B5fFWi3J/REUTKI
	ixneeCIc54v6cF6+4jh584M9vmlIlZImEoijloXbY/JuQQFRICdGlCpSdUQuKlwteWuUZs4bsP0
	wyh52FpbEIVLCBajLifoOD3ABly3ZkUcq8V+yx4V8wpdJxkaAj3nSyoc6RrLGo2Okt+HS7oeNLD
	cBQf62lJEf6A7/m10MtHuq1stEcXMBFHQWRZQ4Y++GnZ492lyBKYaFkujuieg/69kzQFw3wD31g
	6BghHjjbd7z7UPGJEMCcB9Urbx+RaBABNXZrOik0sRu6Os4gMQmHyF9PdptoP4kxsr6hAiSA+9y
	rBs42A4sEpwjIHUMSQH57DJ1mDVXfv52OLRYAgqPkFFW8YFePx67E2uFW84xeXtceOoZBYJ7/p/
	UfoPmpfBJYqeVSLoot+TYnKVm9893TXbUgVDSQ9E6V7o2ROwSMRvBvYYvgRJ9RK7n3NKwI2RKJa
	ghI3IkDFC6w==
X-Received: by 2002:ac2:51ce:0:b0:5c1:5974:8a54 with SMTP id 2adb3069b0e04-5c15d545536mr529421e87.5.1794378655623;
        Tue, 10 Nov 2026 22:30:55 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bb7529sm811767e87.66.2026.11.10.22.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:30:54 -0800 (PST)
Message-ID: <0a520efd-ac3a-47bc-b37b-11df8263fb5f@gmail.com>
Date: Wed, 11 Nov 2026 08:30:51 +0200
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/20] mfd: Unify style of of_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Chen-Yu Tsai <wens@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 James Ogletree <jogletre@opensource.cirrus.com>,
 Fred Treven <fred.treven@cirrus.com>, Ben Bright <ben.bright@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Tim Harvey <tharvey@gateworks.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, Sven Peter
 <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Saravanan Sekar <sravanhome@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 mfd@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com,
 linux-rpi-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-amlogic@lists.infradead.org, asahi@lists.linux.dev,
 linux-mediatek@lists.infradead.org, imx@lists.linux.dev,
 linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-rockchip@lists.infradead.org
References: <cover.1794347059.git.u.kleine-koenig@baylibre.com>
 <2cd7c4695edff6b711f8c77ae468d295bb910cdb.1794347059.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <2cd7c4695edff6b711f8c77ae468d295bb910cdb.1794347059.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/2026 23:54, Uwe Kleine-König (The Capable Hub) wrote:
> These arrays already mostly match the most used and generally
> recommended coding style. That is:
> 
>   - no comma after the list terminator;
>   - a comma after an initializer if (and only if) the closing } is not
>     directly following;
>   - no explicit zeros in the list terminator;
>   - a space after an opening { and before a closing }, a single space in
>     the list terminator;
> 
> Adapt the offenders accordingly.
> 
> Reviewed-by: André Draszik <andre.draszik@linaro.org> # for Maxim MAX77759
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
> Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com> # max7360
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
