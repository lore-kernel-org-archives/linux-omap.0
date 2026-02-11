Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9622127E
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815975; cv=none; b=DO2Q4JM/VLvgCFggmTtRgNl62JFHHswQeiwGqpgRcF8WIQ7eYvrllqsVZnZ38c1jiJfOWYAnSeaRoyrpCVaUkQh+aaDzfkH7IKVpfMhb1qstJ8hasV/KbjfGYWLYfRE6CQbAKq+k4a0ikoPQE/SBTGrwhXQfw4oUjDHJk64FQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815975; c=relaxed/simple;
	bh=pEWU38l5Vz50R5z6wyDS7+8ixxHxST12htbs23d8t2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxdxgucYS+B+ISPU5IrIR02UdqyOpHGSMbDYyZve3WGiZVEU+NVcc45PxHrBmOlJeiWEX3TRxD5PmmunyH1eWkBZtP/Ib+ObiRXRyaykeGqjGFSF6s1mFEB5Dm+FseGgY0mYRavogwqVD1OkV8vuQQLCn8oHGKtM29fEbc20ePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DigU6Isd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DigU6Isd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A0FC2BC87
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770815975;
	bh=pEWU38l5Vz50R5z6wyDS7+8ixxHxST12htbs23d8t2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DigU6IsdqAF5P0vrUTunXSwLLmnbLmEKtYuRBE/AHIZl09QREOjf1921Lw9PN1TDp
	 /QF8wgAwovulPbvlaWwFu7MbeoQ7FH5p3yiGyHjRzKGUJVAERGaPfNu8mJpg7B/aA0
	 Gc/dEMy0SnDRTYHnhHVdM+Zi2ZWoy6N7O30VlRJ7zAFar796igBR8IFFB7EEnjnLJh
	 56XBW2YWoC9T9hO/VTHHBiMGXHkaDlhO42hnXs9AX6n7rR5+utHBe4msq3QYHpvFYr
	 x3bhelwTB7P6TFDraUksfxeCmQj04DwrLxGKOZffTU6QAc0SzQofvDUShJAZ6OnsQj
	 Ui90asQbXjbFg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38709eaf012so3258111fa.0
        for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 05:19:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrpZVB4ftJi87oOMbw6Lu+EYoGArO9LYGFbLEnU2UuTouNgIxcySTwQrn/27ye5m+aeZ1lWVk5RTwh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7QGfohv3YsPMAPrV4ixZsPjZdLag666/Pp6LBpBh0NLcQf649
	cxgdGqdFGTDBQ84f0bxiv0V/Gwgzt4EkvLXcz1JF0s1WcaAJ5R4DmrSBPJ8xwuFkvmUo9TmaIrk
	EnqR+oEBoFAsBU9RK3UBkaG+gLMJmFi/1uPMRVZSFUA==
X-Received: by 2002:a05:651c:4185:b0:37b:9e27:89f with SMTP id
 38308e7fff4ca-386b5144cbbmr48730171fa.37.1770815973681; Wed, 11 Feb 2026
 05:19:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211131350.126966-1-bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260211131350.126966-1-bartosz.golaszewski@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 11 Feb 2026 14:19:20 +0100
X-Gmail-Original-Message-ID: <CAMRc=McWjUrm-EBFZJO=K1TNQ4c3QMPQNESAg9v1RqoVexAaZg@mail.gmail.com>
X-Gm-Features: AZwV_QhSQMg4-Uk9ADIBVghl8ldlT9h2oSgD3Nzqu9hAZs_M8IMSHSh_b3wnJ0g
Message-ID: <CAMRc=McWjUrm-EBFZJO=K1TNQ4c3QMPQNESAg9v1RqoVexAaZg@mail.gmail.com>
Subject: Re: [RFT PATCH v2] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@kernel.org>, 
	Hans de Goede <hansg@kernel.org>, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 2:14=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Currently the board file for Nokia 770 creates dummy software nodes not
> attached in any way to the actual GPIO controller devices and uses the
> fact that GPIOLIB matching swnode's name to the GPIO chip's label during
> software node lookup. This behavior is wrong and we want to remove it.
> To that end, we need to first convert all existing users to creating
> actual fwnode links.
>
> Create real software nodes for GPIO controllers on OMAP16xx and
> reference them from the software nodes in the nokia board file.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Changes in v2:
> - fix build with CONFIG_I2C_CBUS_GPIO
> - only export the two symbols that are actually required by the nokia
>   board file
>
> @@ -225,9 +206,9 @@ static inline void nokia770_mmc_init(void)
>  #if IS_ENABLED(CONFIG_I2C_CBUS_GPIO)
>
>  static const struct software_node_ref_args nokia770_cbus_gpio_refs[] =3D=
 {
> -       SOFTWARE_NODE_REFERENCE(&nokia770_mpuio_gpiochip_node, 9, 0),
> -       SOFTWARE_NODE_REFERENCE(&nokia770_mpuio_gpiochip_node, 10, 0),
> -       SOFTWARE_NODE_REFERENCE(&nokia770_mpuio_gpiochip_node, 11, 0),
> +       SOFTWARE_NODE_REFERENCE(omap16xx_mpu_gpio_swnode, 9, 0),
> +       SOFTWARE_NODE_REFERENCE(omap16xx_mpu_gpio_swnode, 10, 0),
> +       SOFTWARE_NODE_REFERENCE(omap16xx_mpu_gpio_swnode, 11, 0),
>  };
>

I'm sorry, this is still wrong but it builds, so I didn't notice. It
should be `&omap16xx_mpu_gpio_swnode`.

Will send v3 tomorrow.

Bartosz
