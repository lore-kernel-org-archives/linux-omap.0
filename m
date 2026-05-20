Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089E1F09AD
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2026 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779254865; cv=none; b=JbFVpjjM5KK8Cy/PFvzEixbP5EF2tFjfOhNMr8EGkZpn9Vx54Aq016sgXKIWJ+uci1LSEcCcqmHrMKpU2bFMCbw8FhD5Rz1V+XUlBvNMD/W0ePqxTCTdxEjQ19tYXluPbS9tBtU2yRc/OXAkVLppRhDme1Lil33o6RYvrxaXmEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779254865; c=relaxed/simple;
	bh=l0zRM2r+AQUNnb8A268apqaIB3mS80ht+d+1M1KKNFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDNqGjBCuktV5i7mIPLJ6frR60iMWEPfPX6dBHOQhjSDaeW/9Hxp2QX4TWLGsuy/NTO+2cUNTXXnzDesXqQfUFUn41FNVHxik0DfJ79ma1cu4VJWa4DO+SmV6NZLH4tJg2XbUr4AWon5vLLG9wZ/b38kHP+HQwqrcHSy04hsFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYNJtPac; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYNJtPac"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1332772f6b3so5527321c88.1
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2026 22:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779254862; x=1779859662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWnObvvYz2jxVvNJZ4O4Otjd3qRMPJxYo5uUEck8zsM=;
        b=VYNJtPacffiX92QpyrOU3Lyjiq8y8ThCuoAAkgBCYCptHiXE1n9o72gsaMSUmdzi+C
         3RCRowkltdAC1/1x2ZA5jwW6rbRQYvxJ9x1v0xrJMOqh7uLemCY5uJH8ve7LsEjNnGlx
         oV0KNVE0D9y9v/fOltAdg2TFCxTy/Q8GoUQ4QhZld4mXawtyqQkdnTakHz5gIEfuZOd4
         do6LRUIsh+oDtslTnLsjYvUQC6neJwikmm40m8oCBmcDcJv1ZGZmLZrldMqY33lxxRQQ
         laXNIk/ukJBcX2qLKsBrLmT/XTSnOB99uU5iOuZZS8ZGXpoL05YHG1w6L/BoiN7/7QIn
         rjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779254862; x=1779859662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWnObvvYz2jxVvNJZ4O4Otjd3qRMPJxYo5uUEck8zsM=;
        b=DxWkA06t5YXLK/VJ4HpMN0s5mLunlnRUmfZYBVdD/SMgI59HryZ5Dzl+8gemGzx9cf
         pmiRaSzrtqA+Vjo+I25nyk+ou3htaKxTJZ+hpmj/4lM8DhoKQWRB0YCmtN30JrC+oc03
         OyTdm2uXEaoIqMR9qDb5hWJVew1sjZUQP7n66xFcsGdV3PChZTyErSS/ILgTq6lxg3jb
         tALhtBjvWkxyGgERPkkaHRslo+qByGYui9eULUwgMPN61RatawkEZNONzYEfJZhmfRMr
         VaTlu5PDMe5zf3cqOlR4kFYKzEN82oossD5v/TiDuMWowQLwjyhThrqKoSPe8TkqYFEo
         X0Rg==
X-Forwarded-Encrypted: i=1; AFNElJ+y46jfUmSziT63uP4Bj8uDM72wB6JBGyqgUtn6S4SfJsWnGo3C2ckK2TsxIyuxjuyLlq7AgBBnA002@vger.kernel.org
X-Gm-Message-State: AOJu0YyBgboB4Xtt4Rd7zUsPSBx83PmmTymPF4Nq4pVSTc3hXyqH8Xie
	xUGCDGQY140orJw/tZ9gtwsMNxVhKCLvyOe16eWUIR8Dt/t51JKe5G/F
X-Gm-Gg: Acq92OE2Bh687jjEZHpgFki8w0M+c3wsxgi3Cyp9d/NFGRGSiK91IAY4HvZyMYQieUo
	0jMDjQV4yQoIOJkYyPNma0c3Vx+56mciFDaDiY/UGBiDRVbNpfwVi+nMUgdSyeP3sQirV7cD4Ep
	2C22jhVjq+k3sXKpsFnZ1yiboqIbzotU80sWNzK8rRoc2SZB2ScMlDKt6HgntZG7TbD+lWiYGzy
	5v12G8m0ZYfiFodl7C3ISksvaARVuK1K+iRkCWPFOKahsJh8iLwFAeUpSRYTJ0q+a2FDBapOTke
	b6mWvzFnqB4Hw8gCFczfyV7/v3iqPOmISR3+c6HzaPe+NzdE9SAArE2P18RbRcEx4kGuhNwtgFr
	rhC4i9r03UGMBwiNxS2Pq65mYSXt9s1SCz8uDTljO/Lwz/uSvFB9HXJ1PRs/5jpVu/E+onPhT7J
	PpMXNNxmisKS6V+QBG163cJC3muyuXXBASRKRcNAHFY//2sBwV3r0+NUkwAAFKY/D4
X-Received: by 2002:a05:7022:e14:b0:135:d5d1:514 with SMTP id a92af1059eb24-135d5d1061cmr2290514c88.14.1779254861871;
        Tue, 19 May 2026 22:27:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7677:c3e6:c92a:e780])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdcf140sm25863329c88.5.2026.05.19.22.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 22:27:41 -0700 (PDT)
Date: Tue, 19 May 2026 22:27:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 5/6] gpio: remove machine hogs
Message-ID: <ag1GJygtLgngKQqj@google.com>
References: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com>
 <20260309-gpio-hog-fwnode-v2-5-4e61f3dbf06a@oss.qualcomm.com>
 <ag0Dn66ZVnbTc7J2@google.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag0Dn66ZVnbTc7J2@google.com>

On Tue, May 19, 2026 at 05:46:50PM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 09, 2026 at 01:42:41PM +0100, Bartosz Golaszewski wrote:
> > With no more users, remove legacy machine hog API from the kernel.
> > 
> > Reviewed-by: Linus Walleij <linusw@kernel.org>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
> Argh! What is the replacement for this? I have patches for rsk7203 to
> use them to get rid of legacy gpio use, like this:
> 
> diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mach-rsk/devices-rsk7203.c
> index f8760a91e2f1..5bbd3b31cffb 100644
> --- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
> +++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
> @@ -12,7 +12,7 @@
>  #include <linux/smsc911x.h>
>  #include <linux/input.h>
>  #include <linux/io.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/gpio/property.h>
>  #include <asm/machvec.h>
> @@ -165,6 +165,19 @@ static const struct platform_device_info rsk7203_devices[] __initconst = {
>  	},
>  };
>  
> +/* The base of the function GPIOs in the flat enum */
> +#define SH7203_FN_BASE GPIO_FN_PINT7_PB
> +
> +static struct gpiod_hog rsk7203_gpio_hogs[] = {
> +	GPIO_HOG("sh7203_pfc-fn", GPIO_FN_TXD0 - SH7203_FN_BASE,
> +		 "TXD0", GPIO_ACTIVE_HIGH, GPIOD_ASIS),
> +	GPIO_HOG("sh7203_pfc-fn", GPIO_FN_RXD0 - SH7203_FN_BASE,
> +		 "RXD0", GPIO_ACTIVE_HIGH, GPIOD_ASIS),
> +	GPIO_HOG("sh7203_pfc-fn", GPIO_FN_IRQ0_PB - SH7203_FN_BASE,
> +		 "IRQ0_PB", GPIO_ACTIVE_HIGH, GPIOD_ASIS),
> +	{ }
> +};
> +
>  static int __init rsk7203_devices_setup(void)
>  {
>  	struct platform_device *pd;
> @@ -172,12 +185,10 @@ static int __init rsk7203_devices_setup(void)
>  	int i;
>  
>  	/* Select pins for SCIF0 */
> -	gpio_request(GPIO_FN_TXD0, NULL);
> -	gpio_request(GPIO_FN_RXD0, NULL);
> +	gpiod_add_hogs(rsk7203_gpio_hogs);
>  
>  	/* Setup LAN9118: CS1 in 16-bit Big Endian Mode, IRQ0 at Port B */
>  	__raw_writel(0x36db0400, 0xfffc0008); /* CS1BCR */
> -	gpio_request(GPIO_FN_IRQ0_PB, NULL);
>  
>  	error = software_node_register_node_group(rsk7203_swnodes);
>  	if (error) {
> 
> 
> If there is no replacement maybe we can resurrect this? Or shoudl we
> have add swnode support for hogs?

Hmm, I guess it is already there so I should simply switch. Sorry about
the noise.

Thanks.

-- 
Dmitry
