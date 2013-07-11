From: Felipe Balbi <balbi@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Thu, 11 Jul 2013 12:26:12 +0300
Message-ID: <20130711092612.GG23892@arwen.pp.htv.fi>
References: <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com>
 <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com>
 <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <87mwpuakod.fsf@linaro.org>
 <20130710142633.GV5523@atomide.com>
 <20130710160704.GH18966@arwen.pp.htv.fi>
 <51DE780C.2070701@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43276 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879Ab3GKJ0z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 05:26:55 -0400
Content-Disposition: inline
In-Reply-To: <51DE780C.2070701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 11, 2013 at 02:47:00PM +0530, Rajendra Nayak wrote:
> On Wednesday 10 July 2013 09:37 PM, Felipe Balbi wrote:
> > how about something like below ? It makes omap_device/hwmod and
> > pm_runtime agree on the initial state of the device and will prevent
> > ->runtime_resume() from being called on first pm_runtime_get*() done
> > during probe.
> >=20
> > This is similar to what PCI bus does (if you look at pci_pm_init()).
>=20
> I tried something similar [1] but what I found is that the serial
> runtime resume was called despite it being marked as active using
> pm_runtime_set_active().
>=20
> That seems to be because of the pm_runtime_set_autosuspend_delay()
> because we have the autosuspend_delay =3D -1
>=20
> -----
> static void update_autosuspend(struct device *dev, int old_delay, int old=
_use)
> {
>         int delay =3D dev->power.autosuspend_delay;
>=20
>         /* Should runtime suspend be prevented now? */
>         if (dev->power.use_autosuspend && delay < 0) {
>=20
>                 /* If it used to be allowed then prevent it. */
>                 if (!old_use || old_delay >=3D 0) {
>                         atomic_inc(&dev->power.usage_count);
>                         rpm_resume(dev, 0); <----------------------------=
--- calls serial runtime resume.
>                 }
>         }
> -----
>=20
> So we end up with the same issue with serial resume being called before s=
et_termios()

yeah, that part I figured out after I started testing today. It seems
like my latest version is getting closer but I still see problems, diff
below:

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_d=
evice.c
index e6d2307..0cc2da9 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -181,6 +181,26 @@ odbfd_exit:
 	return ret;
 }
=20
+static void omap_device_pm_init(struct platform_device *pdev)
+{
+	omap_device_enable(pdev);
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	device_enable_async_suspend(&pdev->dev);
+}
+
+static void omap_device_pm_allow(struct platform_device *pdev)
+{
+	pm_runtime_allow(&pdev->dev);
+}
+
+static void omap_device_pm_exit(struct platform_device *pdev)
+{
+	device_disable_async_suspend(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	omap_device_idle(pdev);
+}
+
 static int _omap_device_notifier_call(struct notifier_block *nb,
 				      unsigned long event, void *dev)
 {
@@ -192,16 +212,31 @@ static int _omap_device_notifier_call(struct notifier=
_block *nb,
 		if (pdev->archdata.od)
 			omap_device_delete(pdev->archdata.od);
 		break;
+	case BUS_NOTIFY_BIND_DRIVER:
+		if (pdev->archdata.od)
+			omap_device_pm_init(pdev);
+		break;
+	case BUS_NOTIFY_BOUND_DRIVER:
+		if (pdev->archdata.od)
+			omap_device_pm_allow(pdev);
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		if (pdev->archdata.od)
+			omap_device_pm_exit(pdev);
+		break;
 	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdev->dev.of_node)
 			omap_device_build_from_dt(pdev);
-		/* fall through */
+		break;
 	default:
-		od =3D to_omap_device(pdev);
-		if (od)
-			od->_driver_status =3D event;
+		/* nothing */
+		break;
 	}
=20
+	od =3D to_omap_device(pdev);
+	if (od)
+		od->_driver_status =3D event;
+
 	return NOTIFY_DONE;
 }
=20

--=20
balbi

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3nozAAoJEIaOsuA1yqREhEUP/1GbpRMg3LAihZwyeg6fVxz9
h/u4SHPqUQjs4goFjRSoLLc2cgZr8zf59/bYGSb9E1G1Trcd9mJXtPXIj4GEZie1
FE+BosaGUWG/QAD8RlkHFDIPHYRajpWbSyoLqPAuEI0dPI+sNPmssM6++2vUSmhE
77/x6FR5JhpD2mrNPnTOxWpY+1/Z0p6KzhwS+WmYXZ/OjjSR1l6g+dcL94r9caKw
mUbYCF2m9+jjmoa2EkY/t+mruRRRLU3YDZBvX3S62U66wAFDOaLjHKDlree+tLgZ
hhhpNLU9n54LXfljHgJsdByrbsrfZsik3Ma1vnv2+B+85KzXm0vYSz78CaSqvIXp
YQBx8bNYK8Se/AjI7QaHBA4ZppapBBYyBuEgJMW7blaTPISy7DgSH8LkwcCpJM9G
hp2wbxbW+GVIBb2gNKbN6hNAAbjq9sjv5fRwhX6e6ozQrrnIiIw5eGsf2pkTAgwQ
zQ5yTRHSg7vyKtl7IOunIxUtg8NUuKM2U3EhGw0TDnphJbTyAagJEVgpy9MLK5ts
Co6gnSCCNx7KkwCrwTki5x0eOO0iGZ/E81bFeVNssqkLxBfzFVWf92jkoS9Myvep
pGE1wOWYnYqbr0dzkeNrufy7nNGSGiqz4C5E8+j+ZUFotlctks8p6NSIiwd0YWaG
YNlASrT5osHF+u/2/z4A
=Cfq/
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--
