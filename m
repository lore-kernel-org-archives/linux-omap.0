Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BB238CFE9
	for <linux-omap@vger.kernel.org>; Mon,  2 Mar 2026 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441718; cv=none; b=UvpdQvWs/g/himqU2g7EVW7g/Ym9RFOP9oMDOAjdRKJ9ac6NF6ElBcmQxRa7EYGIkzfQRwz6nga4u2ySXYqbjjDBYRvXgoEJrcYJ/MTXcW/ZPTk63mJZ5+YMgAeBXTma8r4aqWMycutU0IJ5bWtSaUK8xW9PpDwncXJKyPUsRNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441718; c=relaxed/simple;
	bh=Wr4tlDRl6oPSAmOvngxm+4SQmIJt0rroCHEQsJvSNW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYDYYwCtusK8zDxfhKv+EGkalTGNZvtLXrlKmJG5ngtHkBUQFkyl3q9iT7B1SZ8OB0S4WGwOWtS/Dbxlunp15ijplg8C8fjwH0SjX4v5Fg3jIQ8v8cVEF4O6lOqgnu8RopgHW2T6ZHqgoHribDNfw/JcFaPRDB6RiS165UOr55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7IHob1+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7IHob1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EE6C19423
	for <linux-omap@vger.kernel.org>; Mon,  2 Mar 2026 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772441718;
	bh=Wr4tlDRl6oPSAmOvngxm+4SQmIJt0rroCHEQsJvSNW8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g7IHob1+IzRdb3Ba3Pk+09VevGbac/nukyJetgEzow3LvsVGBRr2GWZSYzAVyEixs
	 ac3l2GXU1eUawjled3yUp4PoNyyrlKE57fpscvbPswRQwrhTPAPRpAHsdX9bF8uk50
	 21jJn2KzvJeyTiJuTXVv0hiYE2z8fXJETbsxslXwRsYLOGz/2Kro8o6YYy/sT/iMd3
	 h4C3bDJyZ2i2tuFP1LXYD5Zl4yd82hXh/zrKP2aaXT/oXnZlK7bHcDDayF8+uL3oRV
	 pftYGsXRPj1AcBS5eQH/dOGu/3O0/AgCbdo2akwVvBTGmS61EOEj/hBvmS2wOH80Y/
	 rAnN69Swn4ukg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3870dec27f4so2869261fa.1
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2026 00:55:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUM40LqQwzyD7g3J4I8gl3d2pcb+GbHr0JVFokQwpWoIOcUylPxEL6PSATI+NggQ7kxhGC5C6/Rak6N@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZGcX+RdnwzX9EvRFplLfZpJTawv4YadgJ+6bGw+3gF1JqIae
	P7N/L3ilf+zrc7iCmvbh/a5B/h4dobM36orjfNwj+1eIR7BkD0YWRuvsdzcQc+eqRM1kId552op
	1rDklN9yqJLgO7LGf8Ylhaqfce/ArB5jU8r8XWuD9GQ==
X-Received: by 2002:a2e:b018:0:b0:37f:d9ba:747 with SMTP id
 38308e7fff4ca-389f1d73cecmr65334241fa.5.1772441715946; Mon, 02 Mar 2026
 00:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
 <20260223-i2c-adap-dev-config-v2-1-d78db0a6fcf7@oss.qualcomm.com> <ac23aec1-6dce-4dd5-8990-9fad40998478@gmail.com>
In-Reply-To: <ac23aec1-6dce-4dd5-8990-9fad40998478@gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 2 Mar 2026 09:55:04 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mf7vQYosm7ViZRg31EdPipfuD=wboMtEneGDCXc20tweQ@mail.gmail.com>
X-Gm-Features: AaiRm53-Jiy54KH5rFLuIQyxPw_sYDt2pmqB7mKXc8_Bgm_qwPjbm9X-evfdjaM
Message-ID: <CAMRc=Mf7vQYosm7ViZRg31EdPipfuD=wboMtEneGDCXc20tweQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] i2c: allow setting the parent device and OF node
 through the adapter struct
To: Kalle Niemi <kaleposti@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Vignesh R <vigneshr@ti.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, 
	Matti Vaittinen <mazziesaccount@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 8:47=E2=80=AFAM Kalle Niemi <kaleposti@gmail.com> wr=
ote:
>
> On 2/23/26 11:05, Bartosz Golaszewski wrote:
> > In order to stop i2c bus drivers from dereferencing the struct device
> > embedded in struct i2c_adapter, let's allow configuring the parent
> > device and OF-node of the adapter directly through dedicated fields.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
> > ---
> >
>
> Hello,
>
> Automated driver test system bisected this commit to be the first bad
> commit, linux-next next-20260227 was tested. Failed tests include driver
> tests for ROHM PMIC and accelerometers, which are connected to
> BeagleBone Black.
>
> The failed driver tests all fail to first i2cget and the tests stop
> there: "Could not open file '/dev/i2c-2' or 'dev/i2c/2': No such file or
> directory".
>

Wolfram: well, now it would actually be useful to know which commit
exactly is the culprit so maybe splitting the changes is not a bad
idea after all.

Kalle: which i2c bus driver fails here? Any errors in kernel log?

Bart
