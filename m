Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FDE361DA0
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846349; cv=pass; b=Qe6RhQD/DOEXNXpGqA1m+JErRUi7S+A15lYTyLjuwht8CfKmIPHSkxxd+lyNI75CjJOhnI568X2yt5Wdqan8+qmvTdhMxrUkJCEgGoEe+HJvboIZcinPRm1XAHNe++E/RTnzdHiMbHweNCXkkfuZa5y53UGsnnbrBXchpkzfNLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846349; c=relaxed/simple;
	bh=uHtxhZgqkvvhkDixZGvThzOeJrJuPZvcOjfb03f5dzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8HbyFHh9z75yfjGkYhKGaZXOnTMFLIq1oag19G39oQ3CldD3emLcRw5l+SKxIcFZGqcQc3J7IV6EDoYOCu0F3tZmv9eXRIOnclioOnJGGEFGe24IvqLOOG4HE+d+1otqQpVKjMIfGgkxaQ2G40dxWz82uirFNqqXzGw48e7QKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=jtvUPGtb; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="jtvUPGtb"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64aedd812baso3884937d50.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 03:32:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771846345; cv=none;
        d=google.com; s=arc-20240605;
        b=MWtW/FFj816Ifp2BrH/lYN28mKgAAduuT5I83b/j1GizYXyBjTj2W85vax+rEQKqz7
         F3ZVhBYsQ0mVdp9f6Mn/yqybmKOAR9O+X/L7HbP8w9SekSWdn7LcQKfyf4VqvZVFS/+q
         34XLacb6OnoC+FiX0Zq2ihvJ4RNEYBpPEmez/2n67M+foWyOYZUY3AQ1Xec3EzsPs2ZN
         0pHLjnZEhD4EhjaLjZov6n9fv6200WTx8PJLwXrnM3b8KCgOlxwASDhbDPUR8uSMUXIc
         6IwS0RSiVibCHHF3G4tqCO3aY6jyZb+EtRv3rzDJakQ3L7XSDP7JCA5kF/RLCFAPVLA1
         ZxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JV6MMROodIfNHs5yZIiROnA2XT+gIEtvvO+RXDqEFEw=;
        fh=A4NqkSvm5wDzagsw6aATiLYCfeqdhg7IoFuzFhxtXXI=;
        b=CVuT/uc8l9r+qI2S/yXPrtV60nEihGxZOeEjj59CyMgmtJvmPDlcH+rApx6AtzkQBr
         q9w38u/hJSbH3KTl0iL4e+f5YiAcpZ72qxCV4U2v0LA6MJkvAV0Z2QkfJQOW040/kfMs
         ydiXGrWfEM5HC5qnfmepRRuUaGhAfATmbkOobHPUpHHDgneOEyTt4nX4DFbVxHh1aPeh
         TdKqgvdeA2PObb9Z6V3Hp+0rZGvaB/aJ2A2ajcIaaW2rwB9sy9mLW+aqZRP8K+15acFw
         jFa7aepVmAL9+LakozYVk5KqdT9dUiBLSgXESp5uPlFXP2f9U7MMTIElQk8PqYIoEjFz
         F7ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1771846345; x=1772451145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JV6MMROodIfNHs5yZIiROnA2XT+gIEtvvO+RXDqEFEw=;
        b=jtvUPGtbU2Wj3IxSdHVfaI7AQSst6+thnd2ba2zTb/HK23eB0wcplM4TJf5noWT8j1
         ge8ldNisA1GAvbE06Pm7tTe59J+DICve1TZzAcm+hcDMBSbqidGhRGyoChKHP5qz0N94
         6lPKDePnGkuhwYSW4jfj5UxApMpW6AVdVO3pHkW3BdL8kRZ+nZu6JbCIi6Dg3KAfr9c1
         NteUpZJJ/x71K8cFUedwQDypq1yxKjEGLc4tOKm9MCsZYKOPt72K70b+vt9xb7x1CYy6
         SElcFIvERsf7RiLwck3t7NjFJolmQ3rbFhdthU0HhXs5EfxgOnQXYv/T53AlWotxAmvu
         y7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771846345; x=1772451145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV6MMROodIfNHs5yZIiROnA2XT+gIEtvvO+RXDqEFEw=;
        b=poEklz4coKuwRVmdegF3iMWlhb5Bovx+WJIqbkHi7m2qAPs2NuOEzH/NGMwn9/IrPq
         D5MVsWs8zcf+OT143RXNu9hqYxM6sPpX+jhBIWnjqdqWK4bFqk43w9HaBLR+Bx0T8Xu0
         HqNeDIXxGCXV+x7MmAjcitDRD2BZ009Ub7fLvHs/qxzJPOej0bRuLbl+bRDbr9/7IOsl
         RTD//Iz0PvS5VAHF3/D+19JrH6YH7XrLsvd30RKjNi9SQa10g+VexxmlpgP4FSboD8sS
         SVspYNsIN3XUWwBGO8gsyEZfqJbmWJv9o/0g9xNt3qom3XSifFbhwtHgm+v15yJbLfny
         6YBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUIrT4kjWlL6X57rsQNSyNJ0XCbz/evJZL3C6FtX5K4NAuFzLKqUMGIjyLLyKu1H2pyYKqNRTfr5cL@vger.kernel.org
X-Gm-Message-State: AOJu0YxHbnk/wIwpdDarXTqYV0pyzLEqcHZu2D+hCaX7HYKrhVa2vWf3
	OiuNEJlq/y/5wf4CbX77Vm71tvzX8ItHPD9TpXD1His4W4VLTQL+RK9KkLvM2rUqTm9tbkJUvby
	lxB16mjAG9qQHH1Tqt06bJKMMql2/SQMzurhutC0/bA==
X-Gm-Gg: ATEYQzy92gkITWLsseikLoqvx+6tGvVEncTfWLEU+j7ylsc6SacALZPexmu8A2oPyVY
	ecYS+H4uP23UURu36acw9tHX6PSf7FPP35QNr3Pp8tjJqM2OfAg8CYmQF4HWWWziltLpwTZAbsh
	kyP1hRh9Rd5zH5kYo16n/woTZmV6EoXS9KFpuT21GpWlskXWRhcHjqKhpKaY7jWMVR5Y/qOBS0a
	d5V2Hd8TVxn03WpkMQNcfqqEtfir2pYq0t2jtOHP7U7R/zfuExvO6XOYjl+zTrN22241SP3KQ+B
	v9Tv6+M3tXIsU/F7paRmWnY2smlQogP6qemy7g==
X-Received: by 2002:a05:690e:1601:b0:63f:a7dc:5661 with SMTP id
 956f58d0204a3-64c789c7e4dmr4751859d50.12.1771846345547; Mon, 23 Feb 2026
 03:32:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com> <20260223-i2c-adap-dev-config-v2-12-d78db0a6fcf7@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adap-dev-config-v2-12-d78db0a6fcf7@oss.qualcomm.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 23 Feb 2026 11:32:11 +0000
X-Gm-Features: AaiRm53g18kb_D8a8Rz5gsK9_gN4L3-bPSeoZhzvicFe1V_X2f1sAQaShwQ_SAw
Message-ID: <CAPY8ntDgMHgjX65ZW8dFvo5jb+yZDUQq6cEJuw=zP6DddmTPrQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] i2c: bcm2835: set device parent and of_node
 through the adapter struct
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Feb 2026 at 09:07, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Configure the parent device and the OF-node using dedicated fields in
> struct i2c_adapter and avoid dereferencing the internal struct device.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

When used alongside [PATCH v2 01/12] i2c: allow setting the parent
device and OF node through the adapter struct:

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/i2c/busses/i2c-bcm2835.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> index 0d7e2654a534e92a529f27fdc049812359678522..4f7e4a178b33fdd172657cc625a34018b18f88ca 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -474,8 +474,8 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>         snprintf(adap->name, sizeof(adap->name), "bcm2835 (%s)",
>                  of_node_full_name(pdev->dev.of_node));
>         adap->algo = &bcm2835_i2c_algo;
> -       adap->dev.parent = &pdev->dev;
> -       adap->dev.of_node = pdev->dev.of_node;
> +       adap->parent = &pdev->dev;
> +       adap->of_node = pdev->dev.of_node;
>         adap->quirks = of_device_get_match_data(&pdev->dev);
>
>         /*
>
> --
> 2.47.3
>
>
