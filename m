Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC83F4DEB
	for <linux-omap@vger.kernel.org>; Wed,  9 Sep 2026 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985088; cv=pass; b=EC+Sho6/sJvfSQDn5b94Diya0L5U+e206kIBe5Le2mIsP+9H5YjdH89JmfB7lEzjaBi6yzGCqJJylPXXxbhCgU1M+gkf2YEDB3F209pbr6BAPMl0Lqg6goZ3uxmS/4aLSg7SKUEkqnNNzoAp5cqG4dBF70pu/HNEB9UqUvz1xL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985088; c=relaxed/simple;
	bh=r0SYPe6/MLvVhiIoMkAkIXOuQ6dRGOznaSyuFqfT4PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o531/BTfNrsRbvif6IFm6lS/4iyz/kApsULZy7cdkLL27LOrtM2hruKy6BpT7ZUP24ma0J10jPg+0+32F+3rdTgPFf4vpPbU+t0duS6eggrzQJXZlBMX5b0LkmTCi/t1Ofp72Ibw3DWWoKGRvY9uFl+f4qhkXbtlra0Hz7CPeGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smJQALHJ; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smJQALHJ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a2b4743936so50611881fa.0
        for <linux-omap@vger.kernel.org>; Wed, 09 Sep 2026 13:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788985078; cv=none;
        d=google.com; s=arc-20260327;
        b=PKcx4ksqOg4Lq5fqgV5DpxesSbxeaQAq65kxEpMTDqjioE7AqWoww283sfE3Fjj3qJ
         Y8ZXQaFEP7DCd+q06ii54xs93+R3xPuVah62Pc/6KIZOdllJPzP4tNj9NQlH6+IUFjmK
         ameqtkwfjP/eEo6NbgUzye1wHzbQQhzzTmQwDaxGNR2V56SVWWIU8MKRwNCuVdRaT62H
         jaua98kuMQ7BbX1plfMsX7CMX6f/HdQoMdgXRleoeMV2eOOHAX6TgWA4z5NAuqcuP67O
         EQCkGwjbtNM7zBO0TskLVr5CP40l4u7mbO5Avkh/wOI49HdXLr69SW4c0LJvD1gUJ7tD
         BEFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rU/edVWvN0al2QuqioTnSDLV4+asJJGA8jcDggwnG3A=;
        fh=hLMo+7pWRC+vInlK9qbd1r1u5cxxj+tZTenleFNmUts=;
        b=r++ViCgbj51uvd5pJ7D6uSUbuTDjE5VZQThsbJBpfQgxL1GSE6wwjWB56sG+yKcR+X
         FfG6TFRjsjmVVgBVhLk6mzAO7L1DJ1OzV/CYxQWEaR9SgUTA/kNSfZauB6d9o4AwIVUR
         L1t1NVyHgrxuI0uBe31rhY6oBdhDigH66XkZfMqUBCIo60YYYlZGdfuf15S3UWP2JBgY
         CvS83ZJSLLmpPGklr1O9EQtC+7CdrK4qHw7hGNLE17tXH3Yr84eM9EU8mPZaSX/qfF/Z
         qklYvS4zOgNop/hNPTH0fzEis4+r0BeoE+4aZM2W70GtzHqiVNc4FT2j6eFle7IupCBI
         1Tlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788985078; x=1789589878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rU/edVWvN0al2QuqioTnSDLV4+asJJGA8jcDggwnG3A=;
        b=smJQALHJEKLggOAUE3JHMc4GrHnhEz7kBOpoYZ+TN9qx1gucc9icC6ZGkjkY25N0Hc
         hwOKnXbTnOmQlCMiX8WY7Wbjwvsib1tfB2qyB6MqkouZEUe5OjkyThv3qA5myAKF01PX
         BmLKDkjM5hOjVkYHLAanr63ETq0E9LC2GSoZqoox6EZvrQR6uYEu/UVdyTXh2zgSk1V2
         M024205Bv8hrlzM4HVPzmnPrUR/+dlNMyqZLhQMLQvjtwdq7uJLqGI2km027Yh8QgtFu
         7WIf3RmVmKLsaxk6qGoIS24SCB7zbMPTLBu8TI43Ok91YY3/KlWDJj6JYoMwuHjkDq5x
         NhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788985078; x=1789589878;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rU/edVWvN0al2QuqioTnSDLV4+asJJGA8jcDggwnG3A=;
        b=SkeUkMyZJvnWRgfO5KWBZzxZr4olFwdXu8X2NLNvntaY3fxp1Cxvtg5iZQVFLyIN72
         veBokXcbQjISnKowQI+e1EeR1G+0gFwAsn2cWEou0OEOBgwNDFgcV7L66daQDkUcPVuU
         GlnX6nwZuWehnRCpiEwWHfTp5L2b4SHfVV8ejk7iW/2ernbkZx1qrFHV8ftdJ3YUIL0j
         EJBOV3jalPh1sZyV3XFQ4W7bbbSpBRg20evk/FEGFjwYulciRJh2m/RSfJ9s+04Hkkqy
         SDQW+m/ZRhnwei5gzckJ+LEIYSWmprqW0ewDz+4GbOU6okkQqzhZsH7+8pHLXrv/ru0A
         rbLA==
X-Forwarded-Encrypted: i=1; AKwUvBxGKixPscCkdw69y+D6SYVR0W+cNxkrKBr2tDwgErxHcb+wzzEQH/6+zJtuG6ALzpRA+vTK9SXrM77T@vger.kernel.org
X-Gm-Message-State: AFuF++lIffvwpy3/ekt6kO/wzzS2HCT/iCgBPV1+uzmzGIcNTSaOhUBi
	Er6ltOmGbjBpymrB42WVMwdsJpopqQxG1/cHz1mnpq3ftYCi+l58PPFiknrNKacSzSlpd/On70G
	OJrYtPpFEsS3pLGMEvxP2oe6nZyEz228=
X-Gm-Gg: AYBFou1u7K8gayM1bCa0ZymwQVIw3ObJ8+QNDt4lBNnWaribH9SstERskcFCxQngDn4
	PAHRmT4loi74p8Cvp9Hc2bSLfRnYm19YEdsheU+ZgO8OyNvDKOP/CqtfixaQ0ODJnty9B2kJlY/
	JucuUaCrKAXnvoZy61eAlmWX7T3WHWdM7+IJyOqBK9U0Igos8feXJmdTSDllc+e3l7B/libY2Ax
	jbfijB8Ic4GpAPm7vY0Bixrr0rQeQlECR15K7KheWiltMZ67jaXEKgz4KRL6mGdcEcgvEaCibwX
	e+aJncfipx6/ZAcerP+N06e3CRqfp5Vzu0qHNrTdeax/8Jw/d+0BcHB07jvmXn0q3O93rBOxm3I
	a/ezayciGV29hACMmhsdDfvQw75rtrILxMb1A9dJDvM3A
X-Received: by 2002:a05:6512:acd:b0:5b6:1a7c:fd86 with SMTP id
 2adb3069b0e04-5b61a7cfdb9mr6159278e87.44.1788985077633; Wed, 09 Sep 2026
 13:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-9-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-9-arnd@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 9 Sep 2026 17:17:46 -0300
X-Gm-Features: AcwNN1WKZQyaGADU6lkE-GsXnisq5MVghkNUlNC3CqrQiDAXJmgIgXPSi_5sivU
Message-ID: <CAOMZO5B4q01XRGRfK_LoR1SWkvdP-_fbSHrE4BYq7gVf7k0Xwg@mail.gmail.com>
Subject: Re: [PATCH 08/13] ARM: imx: remove nommu support
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
	Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Giulio Benetti <giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 12:29=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The i.MX platform has grown support for three separate product
> lines using Cortex-M based microcontrollers over the years:
>
>  - i.MX RT1050, a high-end microcontroller
>  - Vybrid vf610 suppors running Linux on either the Cortex-A5
>    CPU or the Cortex-M4 MCU
>  - i.MX7D similarly can run Linux on the Cortex-A7 or the
>    Cortex-M4
>
> There are no known upstream users of any of those three, so
> drop support and simplify the platform to assume that an MMU
> is present.
>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Cc: devicetree@vger.kernel.org
> Cc: imx@lists.linux.dev
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/boot/dts/nxp/imx/Makefile            |    2 -
>  arch/arm/boot/dts/nxp/imx/imxrt1050-evk.dts   |   72 -
>  arch/arm/boot/dts/nxp/imx/imxrt1050-pinfunc.h |  993 -----------
>  arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi      |  160 --
>  arch/arm/boot/dts/nxp/imx/imxrt1170-pinfunc.h | 1561 -----------------
