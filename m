From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Patch: Init/shutdown correctness fixes for drivers/cbus/retu*
Date: Thu, 11 Jun 2009 12:33:28 +0300
Message-ID: <20090611093328.GA15374@nokia.com>
References: <20090526001856.117145k514vqy2kg@lidskialf.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33085 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758697AbZFKJgz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 05:36:55 -0400
Content-Disposition: inline
In-Reply-To: <20090526001856.117145k514vqy2kg@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Andrew de Quincey <adq@lidskialf.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, May 26, 2009 at 01:18:56AM +0200, ext Andrew de Quincey wrote:
> I noticed there were a number of problems with the init and shutdown =
=20
> routines for the code in drivers/cbus/retu*. This patch (for review) =
=20
> attempts to fix them.

please, next time make your patch inline, it's easier to reply to it.

Content-Description: retu-correctness.patch
> commit 59e589227131abbe5e07576f542cc35a8821c9d3
> Author: Andrew de Quincey <adq@lidskialf.net>
> Date:   Mon May 25 23:58:27 2009 +0100
>=20
>     Correctness fixes for the retu drivers
>=20
> diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.=
c
> index e798bc2..fe8266f 100644
> --- a/drivers/cbus/retu-headset.c
> +++ b/drivers/cbus/retu-headset.c
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (C) 2006 Nokia Corporation
>   *
> - * Written by Juha Yrj=F6l=E4
> + * Written by Juha Yrj=EF=BF=BDl=EF=BF=BD

revert this line.

> @@ -352,4 +355,4 @@ module_exit(retu_headset_exit);
> =20
>  MODULE_DESCRIPTION("Retu/Vilma headset detection");
>  MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Juha Yrj=F6l=E4");
> +MODULE_AUTHOR("Juha Yrj=EF=BF=BDl=EF=BF=BD");

and this

> diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbut=
ton.c
> index 38d7aa4..cc47691 100644
> --- a/drivers/cbus/retu-pwrbutton.c
> +++ b/drivers/cbus/retu-pwrbutton.c
> @@ -7,7 +7,7 @@
>   *
>   * Written by Ari Saastamoinen <ari.saastamoinen@elektrobit.com>
>   *
> - * Contact Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
> + * Contact Juha Yrj=EF=BF=BDl=EF=BF=BD <juha.yrjola@nokia.com>

and this

> @@ -75,29 +75,40 @@ static void retubutton_irq(unsigned long arg)
>   */
>  static int __init retubutton_init(void)
>  {
> -	int irq;
> -
> -	printk(KERN_INFO "Retu power button driver initialized\n");
> -	irq =3D RETU_INT_PWR;
> +	int ret;
> =20
>  	init_timer(&pwrbtn_timer);
>  	pwrbtn_timer.function =3D retubutton_timer_func;
> =20
> -	if (retu_request_irq(irq, &retubutton_irq, 0, "PwrOnX") < 0) {
> +	if (retu_request_irq(RETU_INT_PWR, &retubutton_irq, 0, "PwrOnX") < =
0) {
> +		del_timer_sync(&pwrbtn_timer);
>  		printk(KERN_ERR "%s@%s: Cannot allocate irq\n",
>  		       __FUNCTION__, __FILE__);
>  		return -EBUSY;
>  	}
> =20
>  	pwrbtn_dev =3D input_allocate_device();
> -	if (!pwrbtn_dev)
> +	if (!pwrbtn_dev) {
> +		retu_free_irq(RETU_INT_PWR);
> +		del_timer_sync(&pwrbtn_timer);
>  		return -ENOMEM;
> +	}
> =20
>  	pwrbtn_dev->evbit[0] =3D BIT_MASK(EV_KEY);
>  	pwrbtn_dev->keybit[BIT_WORD(KEY_POWER)] =3D BIT_MASK(KEY_POWER);
>  	pwrbtn_dev->name =3D "retu-pwrbutton";
> =20
> -	return input_register_device(pwrbtn_dev);
> +	ret =3D input_register_device(pwrbtn_dev);
> +	if (ret < 0) {
> +		retu_free_irq(RETU_INT_PWR);
> +		del_timer_sync(&pwrbtn_timer);
> +		input_free_device(pwrbtn_dev);
> +		return ret;
> +	}
> +
> +	printk(KERN_INFO "Retu power button driver initialized\n");

no printk(). boot is already noisy enough.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
