Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443991;
	b=zczdRU7MAiSEk5eYqFRhjqby9D6x5Tmq/9bnPDqmaqY+dGsTYrz2/n14hOQihyYMst/M
	 Nwr1kmNWaceS/y0mhq4rPKm89I7tlTSC6owEg9iWGerLdjmxsbJC1vKPYtUaGdL8EGDtC
	 vm8usGQ151DxX/lgtot2BGsPCROZGMO6J28Q4x3lz3ZOXT57pLisENVc08fOcR5Tc/ncg
	 +Iq4HGwJyVSAS4VN0HLTMD0wBJS7lcBjKNedRT/P01ZNxefS0BsqmFxpjdD5+lotyAnHU
	 UhR+3LUd9fed4hF3eQ+jxr4Yl2vLN/At5RkfuaxtNOhos7yqpPxX4Bdk91aqEujZD7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MpBy4DQUeAY3YB4hP8JJP2A0Pzqf+41bgmSv+sbuZU8=;
	b=RscT9N6nULOpHmMh4bChaEujRHMHz5Ogg9ZfjZeie5u5WMAkdGcL7uIOhjFaW1AVDzcW
	 WkXulCyRl6yrqvTRhbrsOwh2yTFekP08uzZIh1+mWRgFxLkPs9sWkLe5a3GMpJJbPW2AF
	 rZLTGBDaumZwEjEaP4fGIWVxJUHTPKBgn1SC8uL4SLRVtOp5fAd/Ee4hIJMnVxhNpE0bn
	 SRf3huEjKJH48FPSO1/Nyku2HKyBlSXwDsGarvT4ytX6go9cxow2WU71aNIfJsceO452G
	 QVzE00bB67yOkZY1UIo7NBZzCP6ov573kzzRMp6Kere23OaGt1o0TD9CJpeZ+i89y4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RUIY67PM;
	arc=none smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A2606A31A
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 14:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F1A2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RUIY67PM
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ae81ae52ffso22823471fa.2
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 06:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443988; x=1796048788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpBy4DQUeAY3YB4hP8JJP2A0Pzqf+41bgmSv+sbuZU8=;
        b=RUIY67PMq1SQpC96Na5nTl3jAyRwEebw/mDWGod9yXt8IsGlmlTbbsyWn7X2cSb73L
         dB/FORW/5mTkaB2haIysp91S+cFrM2WzVocyIJDpnJKRCsMAZh+2AMPv+Cb9qzJmnN/p
         xVhtvboIzZKmLZuxYSV+bp9jXmGt/XGLsa3NkwIEjKhmnT/FmPcIYkZmo9USpV0+DVld
         +T7wajOC1ZKDFwX45AVhUhuQXPjUbPPbDrQCtLMD5NyK6n3BloDQGZVPITo+qylDu4KF
         qxWCPUIvWmu9AImsOgfgoOsXo6JqMQLDHrQeoNb3vm5Ivrwtz3Ew4LzO8OTKYYbraeQ+
         bbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443988; x=1796048788;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MpBy4DQUeAY3YB4hP8JJP2A0Pzqf+41bgmSv+sbuZU8=;
        b=ukkh6PkhOZ62AyMvJoIOsGDBfZVAXOTWBVNaAyhCiszlxzdjfjiXZI0IVSwlUBB1pA
         g0qYPqfs2JT+0dmsGaZau7vTzHXflJuKaG/fr2TXUJjziKt9eOq2zAakPrz4RzrLrX+B
         uaxHT2D4Wn+Xv2RuMacPtTbu/Vpm3ot1+Z7y63Zh2DRcdl272i8ksqajHemtLQN8/tRi
         be5XgNeG2ozztxBOj+cvyBL7heDXV7U411yYCIYB5IiOUhtXa4QvQ32pJvvlBWG+D2pR
         yM6p6MVtvjldb4Z3f6y/YUxxLFJHAswe6aNE1UiIMYJtUwZ1dl4kfDRXJDHFtAVndfa/
         0PoQ==
X-Forwarded-Encrypted: i=1; AL+hErH2zae5/eMJcih/ZWcq1k6rzD6Gdub4Ji1JLw564UbHJRpUxvN7cHIiR1qbA4zrzpJnUzNb2l4o7fRO@vger.kernel.org
X-Gm-Message-State: APuU4Z/CcS7QRXs4XLz9Q8Ju/wvuztiXjXU0bOe7qiUnCgSvrVfUfG8Z
	aXZAsQkAAYsK0pgpPJ6kcMxXDxKZzvwCg9+97rLdOWeCAiYce3aM7M6E
X-Gm-Gg: AZFdTZfE+B377dY6D4Hb49/MKRXEshtAv7uC+xHe5XfENHS5JMs9pVLL89t7p+rUACC
	U9mGZQjJJp9QbqaMM0/4YGp6oQ1QC1K9rlPDfTX4C3X+bKhMpYBsRZxIcLrCmDaQs5jEx1Yn579
	r69pLZZg0UfYt0QyFDV6W1D0AMj2Fa9ljIgO3dZsA7fim14z0QkNOD0ZGPbrdrNgbLFqNo5b/X7
	vHOvdGpUe133hsHVq7UymK+1LPRafmXenK7GXH+hmVqpMc7hNhcpFGdegrBRVBOhYSbykaHEQWE
	wfIiNCvgKGKiTzAoxgVIfdTjrmJCayoXBruSraPSUPA6h9G7WUErYnhlkNqU479v7AFM71KRoRn
	eyQkT5LDu3WJj5kzXUoj3W71FyaG5OUblP7AtkvKzcvq1bvLWfmcW+A1+hkyPARB/6D1cFNQnlL
	MjzryMjojrR4XtP1soUz16VN9+u3zT6/HkDTfdUqy5ImiV1cPPesz+xcXVFFZpsf3q7UdQBmz2f
	cNm7FMTtthQmya2s3zGsWghLbfqtUogyCrO9LrEEAa1ixAHXmoMdevXRLC0jdX5OgfzvHFnldWU
	WmM09rPOaewGsBXK2vFPNlIwdLaRHalQArrgiD+1aHsNWMPjpDuoSl+TTIS6KchBoMPbp3Ebpe8
	9AbIM1Gvo6Q==
X-Received: by 2002:a2e:ab0a:0:b0:3ac:e4b6:b93d with SMTP id 38308e7fff4ca-3ae7f9a072fmr31420641fa.8.1795443988058;
        Mon, 23 Nov 2026 06:26:28 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae80536529sm33679491fa.27.2026.11.23.06.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 06:26:27 -0800 (PST)
Message-ID: <bc178673-54dd-4811-acdf-cb6327ec2417@gmail.com>
Date: Mon, 23 Nov 2026 16:26:25 +0200
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
Subject: Re: [PATCH v5 16/17] mfd: Unify style of of_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Lee Jones <lee@kernel.org>
Cc: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
 Linus Walleij <linusw@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Chen-Yu Tsai <wens@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
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
References: <cover.1795431460.git.u.kleine-koenig@baylibre.com>
 <b69bcdcc394e46e0eb60947f23923e6241d24ff4.1795431460.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <b69bcdcc394e46e0eb60947f23923e6241d24ff4.1795431460.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/11/2026 13:18, Uwe Kleine-König wrote:
> From: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> 
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

Reviewed-by: Matti Vaittinen <mazziesaccountw@gmail.com> # rohm

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductor
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
