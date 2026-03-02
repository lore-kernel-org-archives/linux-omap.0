Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F433263A
	for <linux-omap@vger.kernel.org>; Mon,  2 Mar 2026 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447922; cv=none; b=KnQelhfflL+JlIWZ0+d/9UcbAekPiZ0OMIbspDxX3tUHEYcl1le4MidrVfIsGBNfp5fl08ANplyRqc7L5Oo1cNY/jjodz2cTU+uZHKPJ+nLMNI4tLTBoEElW2k25KStWTZMuVZ8omMKd20xJqQHEmv7w9WBUA9C4mwtJRn0De7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447922; c=relaxed/simple;
	bh=+dPP0pKLmuyRQWGO2igjZ68hfj2TtOyctwG0bH8SJm4=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=MkWDX5jmUn59BmShLppHjGeC8rq43ZdIj+tx0wIdZ10+777ETSmRbdCbTYH6hW+QY+8o8mJORFhhmQNrfuua/JI/NtkCGggNSjZlaqJqekXxp/a6YHCgkGmnLV5X/7CWXcwFDM+rYhiJZZMPsjH7u/iODFfj+sikEuYIuKCQ/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4naTIpw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4naTIpw"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-389e2950f54so3972911fa.0
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2026 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772447919; x=1773052719; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dPP0pKLmuyRQWGO2igjZ68hfj2TtOyctwG0bH8SJm4=;
        b=N4naTIpwcuC/qx5sfNFTxitY68Caq14zq82+r0fa4bspB+RVdfAkTmN1qL/74nlshO
         mPnbQK9OXtyqewDgg0ffLhxkkLEOvtM6TyHdesDRA2nceA6I43RCI7SDQRIxIEso2+qi
         Q4rlDkYmAsvIhjc4YMpAbU84RSQt/ZofK0kiEef++PK4VkNbkU+stXzKWCSihkdDDSfb
         UjQ2izI7vQbm14WiqniUM5cBLxgl51H2wM0VXtVn5EW4nsPtPqTF5y169vDimbIYbs6x
         sf0n6+NQCmYA6xXxxLcsnmY21g7rzxKAgrsHXNqrqxVwnSjMFuvJ7eYdvutr0UKxT/C+
         3TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772447919; x=1773052719;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dPP0pKLmuyRQWGO2igjZ68hfj2TtOyctwG0bH8SJm4=;
        b=VgFcLORSQKRyJhRBvuPB8t1YRSAXL+IHk7GmCcz63FZkNaxeQLB6oaSVT2PDoDAJdr
         Jkr+lTZoI6OV8Dx9akAEL+azGrP6cxEz++qRT8p7wTBzI9NpQGJi+LaSxYNYrKeJuXjy
         B/BBVwT7mBvND6UbcNv2CcKfb/eBcZYsvxEBjbBrD8A8dUiPf8kMXVFC81+IFAPGepAs
         VBdVm7wWKzv3yawwOEhmy0yw4FApgYtONKaWIriJVtUviUYP2iQVgjJnteX0ySIe96kS
         1DhIdGd/2ckd9oYDFCT3K9vGoJlS1Msw/qv23UVsGFJ5JMHDZBINm02ZMfZEaKK4XiP4
         hfQg==
X-Forwarded-Encrypted: i=1; AJvYcCXmzXgEtAl+IZ7zE0F9g354uO6PhvArUh0SkxFQnBoLFTUL+mZ7P5Y7lxIEG+u65XvhH5BurHiFKpTl@vger.kernel.org
X-Gm-Message-State: AOJu0YwbrLNk9wWSjOpYJSaYjPkd7etrKZg4r5F4KWxDBAgPMFlvlZaU
	yilxDK9mOt2wUVuVynPSFoyteMkoBFZrv9zK2pO9qobNPGiUK1CGJOhW
X-Gm-Gg: ATEYQzx4WBaVq6dgVBN5ixEPdkQ3FHjrRAByFd8u06H3Utlg4rT0hy1NsEKSyO8v0MB
	xQHt2bOroWYVmAB9R11Ypo5RvdNcYlT5VY6OqTON06v58E74HKwKaNx6756wI2y2TCnTfVVIDMD
	QMs3IKyNyITCeVh3hvUCc2hdiJ6/yo/1D8LARTbCtjm3R/NWQfMUO3vxa/dVDC01FDA8KtftYuS
	hMEe7AR+upLXeBYv8kZyJxVXRImPMsVlQCqduxlnJFkiGZowiEIM+wOi+D3m8bIUVR0XlrUh7LB
	MSR7tPXY8jaDu0KNnmRfCP3OcQcplwBkGruQfpMpaxOe9tI4e6IZBZtTEqXGVa/qdxnt4dItAOm
	T02aHIVwQOJaH4GMjmKIUQGBAb6sAgMxF6dX9OCflIqwLK4qPfAx5AD0PpHfZPrhbkeY27/cihi
	vSTtKcLCaYIj0FjFQJxioA9/Xk2RcndpWTYo1NYtwX1yMW8VjmqQwEyba47UG8CCQtjTsw32Io5
	1A3E+sRn69u
X-Received: by 2002:a2e:b018:0:b0:37f:d9ba:747 with SMTP id 38308e7fff4ca-389f1d73cecmr67253571fa.5.1772447918848;
        Mon, 02 Mar 2026 02:38:38 -0800 (PST)
Received: from smtpclient.apple (mobile-access-2e8433-189.dhcp.inet.fi. [46.132.51.189])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a116de019esm1424664e87.3.2026.03.02.02.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:38:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Kalle Niemi <kaleposti@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 01/12] i2c: allow setting the parent device and OF node through the adapter struct
Message-Id: <EDF3FB58-4747-442E-8463-6F1C6E568962@gmail.com>
Date: Mon, 2 Mar 2026 12:38:27 +0200
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Branden Scott <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Vignesh R <vigneshr@ti.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org,
 Matti Vaittinen <mazziesaccount@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Mailer: iPhone Mail (23D127)

=EF=BB=BFOn 3/2/26 10:55, Bartosz Golaszewski wrote:
> On Mon, Mar 2, 2026 at 8:47=E2=80=AFAM Kalle Niemi <kaleposti@gmail.com> w=
rote:
>> On 2/23/26 11:05, Bartosz Golaszewski wrote:
>>> In order to stop i2c bus drivers from dereferencing the struct device
>>> embedded in struct i2c_adapter, let's allow configuring the parent
>>> device and OF-node of the adapter directly through dedicated fields.
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com=
>
>>> ---
>> Hello,
>> Automated driver test system bisected this commit to be the first bad
>> commit, linux-next next-20260227 was tested. Failed tests include driver
>> tests for ROHM PMIC and accelerometers, which are connected to
>> BeagleBone Black.
>> The failed driver tests all fail to first i2cget and the tests stop
>> there: "Could not open file '/dev/i2c-2' or 'dev/i2c/2': No such file or
>> directory".
> Wolfram: well, now it would actually be useful to know which commit
> exactly is the culprit so maybe splitting the changes is not a bad
> idea after all.
> Kalle: which i2c bus driver fails here? Any errors in kernel log?
> Bart

Hello Bart,

i2c-1 and i2c-2 are failing. I am not seeing any i2c errors in kernel log. I=
 got two failures without the dmesg available (this is bugged test sequence,=
 and not a kernel crash), but those got the same stdout message "Could not o=
pen file ...." as all others.

-Kalle
