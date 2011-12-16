From: Felipe Balbi <balbi@ti.com>
Subject: Re: problem with twl4030 GPIO irqs
Date: Fri, 16 Dec 2011 03:36:08 +0200
Message-ID: <20111216013607.GA2344@legolas.emea.dhcp.ti.com>
References: <CANOLnON1-vg45KWZ7Rp+jL1n-jwBiTA2Qmkr_z1XnDKQ0XBPJw@mail.gmail.com>
 <20111216115032.4c4dfbb5@notabene.brown>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:35631 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759960Ab1LPBgO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 20:36:14 -0500
Received: by lags15 with SMTP id s15so1833635lag.18
        for <linux-omap@vger.kernel.org>; Thu, 15 Dec 2011 17:36:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111216115032.4c4dfbb5@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 16, 2011 at 11:50:32AM +1100, NeilBrown wrote:
> On Fri, 16 Dec 2011 02:03:51 +0200 Grazvydas Ignotas <notasas@gmail.com>
> wrote:
>=20
> > Hi,
> >=20
> > I'm running 3.2-rc5 on pandora with Neil's twl patches on top, and
> > omap_hsmmc driver fails to probe:
> > [    3.491394] omap_hsmmc omap_hsmmc.0: context was not lost
> > [    3.497161] omap_hsmmc omap_hsmmc.0: enabled
> > [    3.715270] omap_hsmmc omap_hsmmc.0: Unable to grab MMC CD IRQ
> >=20
> > Pandora is using twl4030 GPIOs for card detect. From what I tried to
> > debug, omap_hsmmc is failing after call to request_irq() on card
> > detect irq with -EINVAL, irq number is 384 which is in range of other
> > twl4030 irqs. It looks like request_irq() is calling
> > request_threaded_irq() on ARM with NULL thread_fn, which in turn calls
> > __setup_irq() that calls irq_settings_is_nested_thread() that results
> > with true. As this nested flag is set it checks thread_fn, but that is
> > NULL causing -EINVAL final result.
> >=20
> > Could someone who knows irq code better look at this? I think this
> > should reproduce on beagle too.
> >=20
> >=20
>=20
> Try this.
>=20
> I wrote it for a slightly different reason, but I think it applies here.
>=20
> NeilBrown
>=20
> From f7f05b87364d0316f1f6ddad0d7387b25f5d21b9 Mon Sep 17 00:00:00 2001
> From: NeilBrown <neilb@suse.de>
> Date: Fri, 2 Dec 2011 15:35:16 +1100
> Subject: [PATCH] omap_hsmmc - use threaded irq handler for card-detect.
>=20
> The the card-detect irq handler just schedules work to be done by
> a thread, we can use request_threaded_irq to do much of the work for
> us.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

Didn't test myself, but looks like the right approach:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 101cd31..d72c181 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -24,7 +24,6 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_device.h>
> -#include <linux/workqueue.h>
>  #include <linux/timer.h>
>  #include <linux/clk.h>
>  #include <linux/mmc/host.h>
> @@ -163,7 +162,6 @@ struct omap_hsmmc_host {
>  	 */
>  	struct	regulator	*vcc;
>  	struct	regulator	*vcc_aux;
> -	struct	work_struct	mmc_carddetect_work;
>  	void	__iomem		*base;
>  	resource_size_t		mapbase;
>  	spinlock_t		irq_lock; /* Prevent races with irq handler */
> @@ -1279,17 +1277,16 @@ static void omap_hsmmc_protect_card(struct omap_h=
smmc_host *host)
>  }
> =20
>  /*
> - * Work Item to notify the core about card insertion/removal
> + * irq handler to notify the core about card insertion/removal
>   */
> -static void omap_hsmmc_detect(struct work_struct *work)
> +static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
>  {
> -	struct omap_hsmmc_host *host =3D
> -		container_of(work, struct omap_hsmmc_host, mmc_carddetect_work);
> +	struct omap_hsmmc_host *host =3D dev_id;
>  	struct omap_mmc_slot_data *slot =3D &mmc_slot(host);
>  	int carddetect;
> =20
>  	if (host->suspended)
> -		return;
> +		return IRQ_HANDLED;
> =20
>  	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
> =20
> @@ -1304,19 +1301,6 @@ static void omap_hsmmc_detect(struct work_struct *=
work)
>  		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
>  	else
>  		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
> -}
> -
> -/*
> - * ISR for handling card insertion and removal
> - */
> -static irqreturn_t omap_hsmmc_cd_handler(int irq, void *dev_id)
> -{
> -	struct omap_hsmmc_host *host =3D (struct omap_hsmmc_host *)dev_id;
> -
> -	if (host->suspended)
> -		return IRQ_HANDLED;
> -	schedule_work(&host->mmc_carddetect_work);
> -
>  	return IRQ_HANDLED;
>  }
> =20
> @@ -1916,7 +1900,6 @@ static int __init omap_hsmmc_probe(struct platform_=
device *pdev)
>  	host->next_data.cookie =3D 1;
> =20
>  	platform_set_drvdata(pdev, host);
> -	INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
> =20
>  	mmc->ops	=3D &omap_hsmmc_ops;
> =20
> @@ -2044,10 +2027,11 @@ static int __init omap_hsmmc_probe(struct platfor=
m_device *pdev)
> =20
>  	/* Request IRQ for card detect */
>  	if ((mmc_slot(host).card_detect_irq)) {
> -		ret =3D request_irq(mmc_slot(host).card_detect_irq,
> -				  omap_hsmmc_cd_handler,
> -				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -				  mmc_hostname(mmc), host);
> +		ret =3D request_threaded_irq(mmc_slot(host).card_detect_irq,
> +					   NULL,
> +					   omap_hsmmc_detect,
> +					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +					   mmc_hostname(mmc), host);
>  		if (ret) {
>  			dev_dbg(mmc_dev(host->mmc),
>  				"Unable to grab MMC CD IRQ\n");
> @@ -2126,7 +2110,6 @@ static int omap_hsmmc_remove(struct platform_device=
 *pdev)
>  		free_irq(host->irq, host);
>  		if (mmc_slot(host).card_detect_irq)
>  			free_irq(mmc_slot(host).card_detect_irq, host);
> -		flush_work_sync(&host->mmc_carddetect_work);
> =20
>  		pm_runtime_put_sync(host->dev);
>  		pm_runtime_disable(host->dev);
> @@ -2173,7 +2156,6 @@ static int omap_hsmmc_suspend(struct device *dev)
>  				return ret;
>  			}
>  		}
> -		cancel_work_sync(&host->mmc_carddetect_work);
>  		ret =3D mmc_suspend_host(host->mmc);
> =20
>  		if (ret =3D=3D 0) {



--=20
balbi

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO6qCHAAoJEIaOsuA1yqREabgQAKNwNBYQGylVZ1dCvq/LANIM
2djb63Pn6BsMD66XiI62UlZhQy1+SCoRa2g4RzV+zIdokhXxbOTJU4zEyxv+a45L
PgKreuqe0unylG6h9UwxJ42+x93c/Tc79/b/8u6MDFlSxww5teygBU7y0A/wgvKb
J98F7gtgSifVeh7aheuRMrNGfTLvo7cFYFqJO3K/LR3lHSfka4+KYeOiAjCQFCpZ
SJQaUTG8w2+4k+xhDyhAq2rtdYEOaEA0cZEC732CnoJ05DFQMDqYWVZF2IMqipR7
8Marb26loxcVGT7l0zAZvG400bOuGePAThifJroufq0joX5pizlvBST+zHio327i
fm1qbAk+tj4zo0O98ZGhkjKijW/FVIJmW5e2TLFVRr/nstUzgfNaHkNC+0cFKp1M
FzHUemIX8iWFvM8o/eOCNi71oSsXeaQ581QA11rEJxAmSVYzz2cwoOUMUrB3WCI6
y95TchlPHMi8zHuksjTq1VIpt64Sc8ByHENMxgOrXqTcrINltAxTLOLk62/VLAqR
pY2uLnx9PJIZlZYec+UYEsEfMkI4iLmFkfQWRWGUlqk6uPwmL7CQWVsmpWV3uLj6
RN7X+KiX9IMGOy1OhSiwdqowC4t93rsA5Z4sR59uHenQAd0ah8ebAwHS1bClVhRZ
+VqvsMjHJbRG/Nb2T++z
=g5lI
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
