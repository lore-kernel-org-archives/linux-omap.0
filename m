From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Fri, 19 Oct 2012 20:01:49 +0300
Message-ID: <20121019170149.GG1493@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59070 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820Ab2JSRHZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Oct 2012 13:07:25 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2012 at 04:55:38PM +0000, Paul Walmsley wrote:
> On Thu, 18 Oct 2012, Paul Walmsley wrote:
>=20
> > Here are some basic OMAP test results for Linux v3.7-rc1.
> > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-=
rc1/
>=20
> And here's two more.
>=20
> > Failing tests: needing investigation
> > ------------------------------------
> >=20
> >
> > Boot tests:
> >
> > * 2420n800: boot hangs during UART initialization
> >  - http://lkml.org/lkml/2012/9/11/454
> >  - Various attempts at fixes posted; etiology known; issue still unreso=
lved
> >
> > * CM-T3517: L3 in-band error with IPSS during boot
> >  - Cause unknown but see http://marc.info/?l=3Dlinux-omap&m=3D134833869=
730129&w=3D2
> >  - Longstanding issue; does not occur on the 3517EVM
> >
> > * 3517EVM & CM-T3517: boot hangs with NFS root
> >  - Likely some Kconfig, board file, and PM issues with EMAC
> >
> > * CM-T3517: boot hangs with MMC boot
> >  - Due to missing MMC setup in board file
>=20
> * 3530ES3 Beagle: I2C timeouts during userspace init
>   - May be related to the threaded IRQ conversion of the I2C driver
>   - Unknown cause

Doesn't seem like it's related to threaded IRQ. It says:

[   23.673858] omap_i2c omap_i2c.1: timeout waiting for bus ready

at that time we didn't even program the transfer yet, meaning we're not
even on wait_for_completion_timeout() inside omap_i2c_xfer_msg(). This
happens before:

> static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
> {
> 	unsigned long timeout;
>=20
> 	timeout =3D jiffies + OMAP_I2C_TIMEOUT;
> 	while (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
> 		if (time_after(jiffies, timeout)) {
> 			dev_warn(dev->dev, "timeout waiting for bus ready\n");

it' stopping here. And that's called...

> 			return -ETIMEDOUT;
> 		}
> 		msleep(1);
> 	}
>=20
> 	return 0;
> }

[...]

> static int
> omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> {
> 	struct omap_i2c_dev *dev =3D i2c_get_adapdata(adap);
> 	int i;
> 	int r;
>=20
> 	r =3D pm_runtime_get_sync(dev->dev);
> 	if (IS_ERR_VALUE(r))
> 		goto out;
>=20
> 	r =3D omap_i2c_wait_for_bb(dev);

right here. For whatever reason, the bus is kept busy (or at least the
driver thinks so).

Looking closely at the logs I see that definitely I2C was working during
early boot (we managed to mount file system on SD card and twl got
initialized properly). But then we have a long time where I2C isn't
used, so it probably suspended in between.

Then RTC wanted to read a register, I2C woke up, restored context, but
bus was kept busy, for whatever reason.

Does it happen all the time on multiple boots or is it ramdom ?

> 	if (r < 0)
> 		goto out;
>=20
> 	/*
> 	 * When waiting for completion of a i2c transfer, we need to
> 	 * set a wake up latency constraint for the MPU. This is to
> 	 * ensure quick enough wakeup from idle, when transfer
> 	 * completes.
> 	 */
> 	if (dev->latency)
> 		pm_qos_add_request(&dev->pm_qos_request,
> 				   PM_QOS_CPU_DMA_LATENCY,
> 				   dev->latency);
>=20
> 	for (i =3D 0; i < num; i++) {
> 		r =3D omap_i2c_xfer_msg(adap, &msgs[i], (i =3D=3D (num - 1)));
> 		if (r !=3D 0)
> 			break;
> 	}
>=20
> 	if (dev->latency)
> 		pm_qos_remove_request(&dev->pm_qos_request);
>=20
> 	if (r =3D=3D 0)
> 		r =3D num;
>=20
> 	omap_i2c_wait_for_bb(dev);
> out:
> 	pm_runtime_mark_last_busy(dev->dev);
> 	pm_runtime_put_autosuspend(dev->dev);
> 	return r;
> }

--=20
balbi

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgYd9AAoJEIaOsuA1yqREO8MQAIOalZWOJpTmEQbfg2QJCNJq
IlZLIfv+V1kF6jje5IyvTcYkToh64U/0rEw2n8ksGyI8bKkKcqr4/wlVcbDns0lG
U75rEu5SiUAB6hqfFdNlWzESETkdThTQ+1KR9MjS2MUmODwROvw6WHAJvNXDY78l
RcmGvDrlCZhsYPU3kCC4i1/x4njDwLkaKvfLgL5tjrMzKuhRAUdxoioUrJt68p4f
zjebezwatouE1uLvX7aeWhla/OHrXiQiP2tzyQjHC3vU68qy6mdRq6wuvZQY/oJu
Sb8Q6pl6GM3Izqr8q3uivNW3e+MjEvSMLmbzw/t68gk/W9Io040ofI/Dta+7lMGA
9aNlqzx7UZSuodHIVAWvHpHqfLcVMLr4vfAxx4sjeA4RvCEGybisSZDmoThs1sX9
IUoMEbrF6EA23Mv3xwe0ADtHG3wxQImQAbXl8kVm5SkMGD2lLkN0DDlAhiXVPtYz
7PynAN+Ge3695py5CrZFb14m2KFVgQSq13wU9cJCUmRw98poTbP+90h+qKG3FzlK
yrrgi6goYXUBdS6l2Bv7jk9wp7OrBixXsApeOmsiP9u+vjQG8oPy8N5V3OGxWmv4
PCQrxmme9JhJXeY4HOeC/SRozaWoh+Kr456fXiKB87cW7lBXUS80wePGlfhtdR5N
VLQOSQiwjV8jQ9LkgUSn
=slpK
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
