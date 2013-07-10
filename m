From: Felipe Balbi <balbi@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Wed, 10 Jul 2013 19:07:04 +0300
Message-ID: <20130710160704.GH18966@arwen.pp.htv.fi>
References: <20130705115959.GQ5523@atomide.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com>
 <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com>
 <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <87mwpuakod.fsf@linaro.org>
 <20130710142633.GV5523@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54862 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab3GJQHs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jul 2013 12:07:48 -0400
Content-Disposition: inline
In-Reply-To: <20130710142633.GV5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@linaro.org>, balbi@ti.com, Rajendra Nayak <rnayak@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2013 at 07:26:34AM -0700, Tony Lindgren wrote:
> * Kevin Hilman <khilman@linaro.org> [130710 01:29]:
> > Felipe Balbi <balbi@ti.com> writes:
> > >>=20
> > >> Right, but calling serial_omap_restore_context() even when the conte=
xt
> > >> is not lost, should not ideally cause an issue.
> > >
> > > it does in one condition. If context hasn't been saved before. And th=
at
> > > can happen in the case of wrong pm runtime status for that device.
> > >
> > > Imagine the device is marked as suspended even though it's fully enab=
led
> > > (it hasn't been suspended by hwmod due to NO_IDLE flag). In that case
> > > your context structure is all zeroes (context has never been saved
> > > before) then when you call pm_runtime_get_sync() on probe() your
> > > ->runtime_resume() will get called, which will restore context,
> > > essentially undoing anything which was configured by u-boot.
> > >
> > > Am I missing something ?
> >=20
> > You're right, the _set_active() is crucial in the case when we prevent
> > the console UART from idling during boot (though that shouldn't be
> > happening in mainline unless the fix for "Issue 1" is done.)
>=20
> Felipe is right, looks like all we need is to check if context is
> initialized or not. So no need for mach-omap2/serial.c or hwmod tinkering.
>=20
> After that having DEBUG_LL and cmdline with earlyprintk console=3DttyO..
> works for me. We could also check for some combination of the context
> save registers being NULL if somebody has a good idea which ones
> should never be 0.
>=20
> Regards,
>=20
> Tony
>=20
>=20
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -161,6 +161,7 @@ struct uart_omap_port {
>  	u32			calc_latency;
>  	struct work_struct	qos_work;
>  	struct pinctrl		*pins;
> +	bool			initialized;
>  	bool			is_suspending;
>  };
> =20
> @@ -1523,6 +1524,8 @@ static int serial_omap_probe(struct platform_device=
 *pdev)
> =20
>  	pm_runtime_mark_last_busy(up->dev);
>  	pm_runtime_put_autosuspend(up->dev);
> +	up->initialized =3D true;
> +
>  	return 0;
> =20
>  err_add_port:
> @@ -1584,6 +1587,9 @@ static void serial_omap_mdr1_errataset(struct uart_=
omap_port *up, u8 mdr1)
>  #ifdef CONFIG_PM_RUNTIME
>  static void serial_omap_restore_context(struct uart_omap_port *up)
>  {
> +	if (!up->initialized)
> +		return;
> +
>  	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
>  		serial_omap_mdr1_errataset(up, UART_OMAP_MDR1_DISABLE);
>  	else

how about something like below ? It makes omap_device/hwmod and
pm_runtime agree on the initial state of the device and will prevent
->runtime_resume() from being called on first pm_runtime_get*() done
during probe.

This is similar to what PCI bus does (if you look at pci_pm_init()).

commit 59108a500b4ab4b1a5102648a3360276dbf7df6f
Author: Felipe Balbi <balbi@ti.com>
Date:   Wed Jul 10 18:50:16 2013 +0300

    arm: omap2plus: unidle devices which are about to probe
   =20
    in order to make HWMOD and pm_runtime agree on the
    initial state of the device, we will unidle the device
    and call pm_runtime_set_active() to tell pm_runtime
    that the device is really active.
   =20
    By the time driver's probe() is reached, a call to
    pm_runtime_get_sync() will not cause driver's
    ->runtime_resume() method to be called at first, only
    after a successful ->runtime_suspend().
   =20
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_d=
evice.c
index e6d2307..1cedf3a 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -181,6 +181,26 @@ odbfd_exit:
 	return ret;
 }
=20
+static void omap_device_pm_init(struct platform_device *pdev);
+{
+	/*
+	 * if we reach this function, it's because the device is about to be
+	 * probed. In such cases, we will enable the device, and call
+	 * pm_runtime_set_active() so that the device driver and runtime PM
+	 * framework agree on initial state of the device.
+	 */
+	omap_device_enable(pdev);
+	pm_runtime_set_active(&pdev->dev);
+	device_enable_async_suspend(&pdev->dev);
+}
+
+static void omap_device_pm_exit(struct platform_device *pdev);
+{
+	device_disable_async_suspend(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	omap_device_idle(pdev);
+}
+
 static int _omap_device_notifier_call(struct notifier_block *nb,
 				      unsigned long event, void *dev)
 {
@@ -192,6 +212,12 @@ static int _omap_device_notifier_call(struct notifier_=
block *nb,
 		if (pdev->archdata.od)
 			omap_device_delete(pdev->archdata.od);
 		break;
+	case BUS_NOTIFY_BIND_DRIVER:
+		omap_device_pm_init(pdev);
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		omap_device_pm_exit(pdev);
+		break;
 	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdev->dev.of_node)
 			omap_device_build_from_dt(pdev);

--=20
balbi

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3YaoAAoJEIaOsuA1yqRE/2UP/05qzF5EYfRQjG0YDvGeh3iM
CUDz2BjL/WutXDtEAWba6JHmVA/1WcXoHdbJiQxwdqehlaDmyqzF2jjyXaqfbRbd
EX1eat7P7ThLYU+d/UC8s+QAqqSTSIF2Dew+v9lfvC9sWHh6O/ErqvZoHg+goDfu
FJMBuDsdRC82rCD/fxHzOuavp9JW0I8Abjdlh8ecui5xh8j+OP/8LLk9YwK2QIh6
OcCYE0nN9ITGNKzH5ul1o8G1wuz7wAA8RuiQX0F4acBppCq4WwTYIlKyt2OAsxhU
9Y7eo/09tktJGg/3caK+MmoeeBbdsaNdaTBE7aFjZ3QUbUkkxvWbdgNpAnjfyzH9
MDT3Y1bBkasJnG9IIEOa9MfJ0koR4yOHKyLBxvncGy3UsDR3/6/xi+Tl1W823Knf
UXXzpCYhSvYnFbF7up+OH9EtiEyeh+aI1dtPD9UwX0bJinT2CdPtHibcMQQ7nJ72
RWtzYRkj0Ix0N6r+1LRWbtXlc3rtswW7XJuh1ycx8KJM9KU4+sXFWKSEhCLHjCTt
u1DvxV/N7uz6n+txLgFSIo2h3F9m4HKAXvpxdfNKYBrDhEFqTHGD1t1jfAlZAfKu
QWyzG6ns56TUn3Oa6NKSofnCjbfSx+9vN8Uh1V9bT/V0krqdMosWhnUcrHLETs4V
nFInUfMhEi75w3QZGaDq
=i0Cw
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--
