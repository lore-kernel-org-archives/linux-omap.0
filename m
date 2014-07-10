From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH 00/16] i2c: drop class based instantiaion for selected
 drivers
Date: Thu, 10 Jul 2014 14:38:37 +0200
Message-ID: <20140710143837.558c1d07@ipc1.ka-ro>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404992799-3705-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Wolfram Sang wrote:
> Some drivers were flagged to remove class based instantiation soon to=
 improve
> boot-up time. Originally, I was planning for a longer deprecation tim=
e so users
> could switch over to some other kind of instantiation. However, the d=
emand for
> the speed up is high enough and class based instantiation is used rar=
ely, so
> the removal takes place now. To make up for the deprecation time, ano=
ther
> warning is added to the i2c core pointing out that the behaviour has =
now
> changed:
>=20
> +	/* Warn that the adapter lost class based instantiation */
> +	if (adapter->class =3D=3D I2C_CLASS_DEPRECATED) {
> +		dev_dbg(&adapter->dev,
> +			"This adapter dropped support for I2C classes and "
> +			"won't auto-detect %s devices anymore. If you need it, check "
> +			"'Documentation/i2c/instantiating-devices' for alternatives.\n",
>
It's usually a bad idea to split kernel messages across source lines
because it makes searching for the corresponding source line for a
message found in the log difficult.
You could at least do the split at the sentence boundary.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
