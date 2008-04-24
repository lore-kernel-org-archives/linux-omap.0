From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
Date: Thu, 24 Apr 2008 04:20:39 +0200
Message-ID: <197B4D64-5D0F-41C6-A3A4-703CBA3AE392@student.utwente.nl>
References: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl> <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com> <03879EA5-591C-4ED6-A3F5-8600F90CC8E7@student.utwente.nl> <200804220957.43599.david-b@pacbell.net> <E7D86ACF-575E-4A2B-8193-82A3A0B6FFCF@student.utwente.nl> <20080422170758.GB10347@kedavra.cpe.vivax.com.br> <BF39A517-6A64-4B10-B595-CBBF2F6BF5D0@student.utwente.nl> <F3AC19E99E5D024AB9E6FB2A01683D8A03EECE05@dlee10.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:38917 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbYDXCVo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Apr 2008 22:21:44 -0400
In-Reply-To: <F3AC19E99E5D024AB9E6FB2A01683D8A03EECE05@dlee10.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kridner, Jason" <jdk@ti.com>
Cc: linux-omap@vger.kernel.org, "Syed Mohammed, Khasim" <khasim@ti.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 24 apr 2008, om 03:56 heeft Kridner, Jason het volgende geschreven:
> Sorry in advance for the newbie question.  I noticed that
> arch/arm/configs/omap3_beagle_defconfig has nothing defined under
> "Device Drivers" between "Sound" and "CBUS support" where the "MMC/SD
> Card Drivers" should go.  Is this intentional?
>
> Since Koen's patch enables MMC/SD functionality, does it not make  
> sense
> to enable it in the defconfig such as below?
>
> diff --git a/arch/arm/configs/omap3_beagle_defconfig
> b/arch/arm/configs/omap3_beagle_defconfig
> index 9e4a4a5..7f57553 100644
> --- a/arch/arm/configs/omap3_beagle_defconfig
> +++ b/arch/arm/configs/omap3_beagle_defconfig
> @@ -678,12 +678,28 @@ CONFIG_DUMMY_CONSOLE=y
> # CONFIG_SOUND is not set
> # CONFIG_HID_SUPPORT is not set
> # CONFIG_USB_SUPPORT is not set
> -# CONFIG_MMC is not set
> # CONFIG_NEW_LEDS is not set
> CONFIG_RTC_LIB=y
> # CONFIG_RTC_CLASS is not set
>
> #
> +# MMC/SD Card Drivers
> +#
> +CONFIG_MMC=y
> +CONFIG_MMC_BLOCK=y
> +CONFIG_MMC_BLOCK_BOUNCE=y
> +# CONFIG_SDIO_UART is not set
> +
> +#
> +# MMC/SD Host Controller Drivers
> +#
> +CONFIG_MMC_OMAP_HS=y
> +# CONFIG_NEW_LEDS is not set
> +CONFIG_RTC_LIB=y
> +# CONFIG_RTC_CLASS is not set
> +# CONFIG_UIO is not set
> +
> +#
> # CBUS support
> #
> # CONFIG_CBUS is not set

That, and

CONFIG_MMC_UNSAFE_RESUME=y

otherwise you can't resume after suspend....

regards,

Koen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFID+55MkyGM64RGpERAvPBAKC278nWTuT9Ddqz31ZFUVxkVfURiACfcnlk
RyH6EE7PSBlRySbI6LAjpGQ=
=JsAT
-----END PGP SIGNATURE-----
