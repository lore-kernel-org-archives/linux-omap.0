Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1433648D860
	for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003776; cv=pass; b=fMeOls6i6U5+xFANeJC0mQ4C9qs+pKreGHkGeAHteXhBIW/UeUbnWg9eoeIufZ6fRTy9AAMI6dLu1HNiFl3MOmbE/RTLFM8S2VIc9tT13K8Yeu7xN8MEuzl6JgJMt667/FsZ2rKNSOuGLWoV4EhusJ8qeF49K6ixaXSieYk/GMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003776; c=relaxed/simple;
	bh=XHPO43iPwGf/8rDqm86qoTqT4DK9heTLxM81CKZvxYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKn0fBQKYDiBO3orMSqsuHD0n6glfY5Kslk+nAJ/PY8Mxd5JJOHnWt4hjcCYLfHZjiJBVao+QlvDNyVCnfToMNMcY04XIpXSD3yhmrwq+mmRec5AJ4ie/ph4AZrSPwqZLUzEbN8sNNkQYxM1CBCjYZs3ci7QIFP52ksOUjUh7R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=MlAuWMAw; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="MlAuWMAw"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a64c7cdb46so4694962a12.3
        for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2026 08:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790003772; cv=none;
        d=google.com; s=arc-20260327;
        b=PQG5Jsr6Jcftk5W+jVxIYkS7PhPAsQtHFrRB2DAb+39fS2UR5TmUI6M1wEG/iOdhst
         y7qGLsPSq2p1L60AcqlrT5evBdItjPy/QD5CyDsIyRsLISuvKGpvpPmLurVcZ1OUO9q0
         Z0sgt0IFT9cbPTgySF6YGJIevUY4zRBxRrqY5ASdtAf5z+wY191hEKZysqzU0o2yIteR
         v+aIO3FqZNSpSkcb16/5UOxC5GUARYbPOtE9gEldLDOuk8txaNA6XN1t17IT+e2H9mW+
         N8FWjNXFo7Y10Aubvd4PyKzJ83PEqQ+/WaaFJu5QqSKfdmrjGAosLmW5MmbqTXU3Mw+s
         Fxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HX8wdI5S2tl2VsV0b3cC7CFvQKR8NtMSXQBbxVkBhOM=;
        fh=dRHwXzzY+nsOQ4/DpNggsm57iDNP5KnNGMC53MAOjTA=;
        b=NQHBMyYR9KgX5/NG0pNRHM6vZpcnywaNJduFyyHhbktmLdIcsYKjl1GAecha76ndEU
         t853hADlLTFgSCIiNcxTQ78a+B6sunKQqBxASD1enHCFH3j/jzKaQ+E8aHDGDqSBrAzK
         /ARVdhL7naSyljw8/xvlclO4q+F6/XRP6zWtgIhwrfWmBTQGlMwGdSItHVYxc3j1ehk0
         wYrZRXQbgdOO93/KdYYmT4T/qAL7clRNKchnI68OEV8J9c2BR4frwQFZswwl8Ku83gLs
         8T6wbjJNjYESuXcBz0Pe9AlMUdvRbXjddO5FW5IM6chHW8sii6m5FCf68IuLxe+KGEsf
         Tnrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1790003772; x=1790608572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HX8wdI5S2tl2VsV0b3cC7CFvQKR8NtMSXQBbxVkBhOM=;
        b=MlAuWMAwbjpYzJtw6TBu52HvGXYbcslY8xaCfxUrYPzU9bDyOjDbHfqEDIRVacsDeM
         /tFHlhXgsaAHLTTlwW7qwpnV+mXH0JoJFS11M4+u1Qk6N+/T2VW4aNM1Q/Zt5E75Vs76
         lEaufwQgwsnvCEJtKfNGrtVb6H2pOmFnQP8V9g497VHGXsdCBlOnWgUlka1Yuoz0/j4t
         iSINgCEg3C2FvVOlvEyHlNYjkyszX75D0C4LdyZrBfZDK8rIZKwFfeBTZ8vKTa6Ejg9A
         1RF+io1ZIWhI764yfnveupU0Gn+H5XYZF1GKyHO74vOyfszv4mHxOKzmaycIchooOZ1i
         08GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790003772; x=1790608572;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HX8wdI5S2tl2VsV0b3cC7CFvQKR8NtMSXQBbxVkBhOM=;
        b=Ey7yk6Wxqa/pYZ8xqNEFOx4+p8U8+SZNW0Mwa5pxoRwO7QezJcQjPv7w9SeBfP0nDp
         i8x9EqW0taEd/HvI2+9/DhT1IiriB0bwErANxcuzFLIBk/1wjtvy0V1mzRvetpcTcLJF
         UiZGIW1lBuf9N5NjRCCwQGyc9F4RF1YGuPraCIfXeDxeAptWD2SVad4HYivVAgA4HrI5
         BPggVl9Io6XCpZCY/7/Mi31/cwKTIG01EN69TrHfFJoRRjuz3u6mKiNEUkXol0SYfwM9
         kA2UJDeA8pVqIlpGssoY/fN9EzRO1sw3IysaOYvkZzZtOdBNfvKTiCawifaQq0KYchIg
         CRqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHU2Pxo2Z7bmwzeb5YIShSCMPrFWc6qPHp+bvcNZd0PKVThZjZCFWIypKUEMAH99u37rpJ9YUzCmJY@vger.kernel.org
X-Gm-Message-State: AFuF++lwytuLPWWZJ75eszV70hx0KRQZRDYuLDBA+PMbupaJiz983QxR
	A+9K2mdUyay7nvIerILZPZkXrW/QGHNYC5zdKbKG6Vp4yNA4B1ZHQbtQa2aNmc5BD3CvuTl4kc/
	njHXLKEWXOBoQDqf2ifIu5guqjwOypfb/uqUTyA4lFl97YiTpxJ0=
X-Gm-Gg: AYBFou2DBQgXSuKCZOQW+4uJLhtetu6B4Rb88NFNqFe16TVrE6snKXW8GBSMdoi0UyL
	Zn4luTDnXHdfHX8qYr1a0V/FpDu5rRRl7FRO0z+YEoyjHRa8MMkAi+1sC7WIGQ/gAjdJ9slwaUK
	o+Fjun39LKek0d6j+ypb5HhGHnHd2wCZQU8/k1LDR0TemYWqsnCMLWnqOs1TDG2xGJG6o47gSEN
	tCl7jBpabFR91ORVxw+BkSIfdTAKJZXcBQWCrA9X2y+sTQWxFbJV4eiOcZ8ILlY6M5OEFISsuAr
	fvz/9Q6400ozGGPZebd6iwnXmZIbOXCGROv4hsZ/W7kQXmRu4Kbwig==
X-Received: by 2002:a05:6402:4382:b0:6a9:6944:57f2 with SMTP id
 4fb4d7f45d1cf-6aa564ce3c7mr7698906a12.10.1790003772167; Mon, 21 Sep 2026
 08:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919171100.90430-1-kmehltretter@gmail.com> <20260919171100.90430-2-kmehltretter@gmail.com>
In-Reply-To: <20260919171100.90430-2-kmehltretter@gmail.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Mon, 21 Sep 2026 11:15:59 -0400
X-Gm-Features: AcwNN1XBrxH6m24bVAE90lwMgAyLcIq43xhby1tZife3cbQ2oW2ZxE_IChsMK9A
Message-ID: <CADL8D3bOOK0ER+rk3kGLaRKH0LBpTYj64SX57OCzZo4WeTZCHg@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: tps65219: Fix GPIO input value reads
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jerome Neanne <jneanne@baylibre.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Shree Ramamoorthy <s-ramamoorthy@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 1:11=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> TPS65219_MFP_GPIO_STATUS_MASK is already BIT(4). Passing it to BIT()
> again tests bit 16, which cannot be set in the 8-bit MFP_CTRL register,
> so GPIO0 is always reported low when configured as an input.
>
> Test the register value with the mask directly.
>
> Fixes: 57e30e00bd5b ("gpio: tps65219: add GPIO support for TPS65219 PMIC"=
)
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Testing:
>
>   - A temporary KUnit test instantiated the driver with a RAM-backed
>     regmap under x86_64 QEMU 10.2.1.  The TPS65219 input-high test
>     failed on the base commit and passes with this series.
>   - This has not been tested on real hardware; testing on affected
>     hardware is welcome.
>
>  drivers/gpio/gpio-tps65219.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-tps65219.c b/drivers/gpio/gpio-tps65219.c
> index 457fd8a589e89..b25c6f7277680 100644
> --- a/drivers/gpio/gpio-tps65219.c
> +++ b/drivers/gpio/gpio-tps65219.c
> @@ -79,7 +79,7 @@ static int tps65219_gpio_get(struct gpio_chip *gc, unsi=
gned int offset)
>         if (ret)
>                 return ret;
>
> -       ret =3D !!(val & BIT(TPS65219_MFP_GPIO_STATUS_MASK));
> +       ret =3D !!(val & TPS65219_MFP_GPIO_STATUS_MASK);
>         dev_warn(dev, "GPIO%d =3D %d, MULTI_DEVICE_ENABLE, not a standard=
 GPIO\n", offset, ret);
>
>         /*
> --
> 2.53.0

Makes sense to me, our hardware has this pin connected as an input so
I must not have tested this case.
Reviewed-by: Jonathan Cormier <jcormier@criticallink.com>


--=20
Jonathan Cormier
Senior Software Engineer

Office:  315.425.4045 x222

http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
