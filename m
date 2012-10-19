From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Fri, 19 Oct 2012 21:10:37 +0300
Message-ID: <20121019181037.GA3036@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
 <20121019170149.GG1493@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210191752210.14522@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33905 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680Ab2JSSQQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Oct 2012 14:16:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210191752210.14522@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2012 at 05:56:48PM +0000, Paul Walmsley wrote:
> Hi Felipe,
>=20
> On Fri, 19 Oct 2012, Felipe Balbi wrote:
>=20
> > On Fri, Oct 19, 2012 at 04:55:38PM +0000, Paul Walmsley wrote:
> > > On Thu, 18 Oct 2012, Paul Walmsley wrote:
> > >=20
> > > > Here are some basic OMAP test results for Linux v3.7-rc1.
> > > > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v=
3.7-rc1/
> > >=20
> > > > Failing tests: needing investigation
> > > > ------------------------------------
> > > >
> > > > Boot tests:
> > >=20
> > > * 3530ES3 Beagle: I2C timeouts during userspace init
> > >   - May be related to the threaded IRQ conversion of the I2C driver
> > >   - Unknown cause
> >=20
> > Doesn't seem like it's related to threaded IRQ. It says:
> >=20
> > [   23.673858] omap_i2c omap_i2c.1: timeout waiting for bus ready
> >=20
> > at that time we didn't even program the transfer yet, meaning we're not
> > even on wait_for_completion_timeout() inside omap_i2c_xfer_msg(). This
> > happens before:
> >=20
> > > static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
> > > {
> > > 	unsigned long timeout;
> > >=20
> > > 	timeout =3D jiffies + OMAP_I2C_TIMEOUT;
> > > 	while (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB)=
 {
> > > 		if (time_after(jiffies, timeout)) {
> > > 			dev_warn(dev->dev, "timeout waiting for bus ready\n");
> >=20
> > it' stopping here. And that's called...
> >=20
> > > 			return -ETIMEDOUT;
> > > 		}
> > > 		msleep(1);
> > > 	}
> > >=20
> > > 	return 0;
> > > }
> >=20
> > [...]
> >=20
> > > static int
> > > omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int nu=
m)
> > > {
> > > 	struct omap_i2c_dev *dev =3D i2c_get_adapdata(adap);
> > > 	int i;
> > > 	int r;
> > >=20
> > > 	r =3D pm_runtime_get_sync(dev->dev);
> > > 	if (IS_ERR_VALUE(r))
> > > 		goto out;
> > >=20
> > > 	r =3D omap_i2c_wait_for_bb(dev);
> >=20
> > right here. For whatever reason, the bus is kept busy (or at least the
> > driver thinks so).
> >=20
> > Looking closely at the logs I see that definitely I2C was working during
> > early boot (we managed to mount file system on SD card and twl got
> > initialized properly). But then we have a long time where I2C isn't
> > used, so it probably suspended in between.
> >=20
> > Then RTC wanted to read a register, I2C woke up, restored context, but
> > bus was kept busy, for whatever reason.
> >=20
> > Does it happen all the time on multiple boots or is it ramdom ?
>=20
> Just ran six boot tests here; it occurred in five of them.  Then tried=20
> five boot tests on v3.6 and the error didn't show up in any of them. =20
> Abbreviated log at the bottom.
>=20
> Would be happy to send along a copy of the userspace that was used if it=
=20
> would be useful to you.

no need for the userspace, I don't believe it will matter as the problem
happens when RTC is used somehow. I'll see if I can reproduce it here in
any way possible on my beagleXM (different OMAP, I know, but still.
Hopefully I'll trigger it, which means it's not a missing workaround).

cheers

--=20
balbi

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgZedAAoJEIaOsuA1yqREzBQP/jELsY3OAwJV68vFe9dnvwAZ
9v3iXegxPX9/+RAmMR6j89L884J00+SJ3ol4FuHBUpT3EagKW3ZyG1bilWxie1jM
w3qCtHnebhLKG20aa6vP8kU9fhOQaTtJchrZvibQvb0eavZBaW1MLB7ZUm7+YiOW
4mYOGarR86H3L1DX2SbRo1MtSXFMBUVJPQKCFxaIAzetSg+I8toFnHcJEXWKozY8
k4T7l3yfutTglQ8sJMj8XLu7d5a13bJIc7Z1XdLqIOOyglQ1VVCCYaGSw8KsrF1l
aMhVU9lJ+OQAwpS5rT3Hn8veqYePC1ZLD/9MwA+lzOMRTJwTI6iwo/7K5tk3PAaf
hiv+TCUV/lbLbijHNBznLwwFvNb7BO6W+Hmgww0ZedBHJXw5FkdDLrgFsxmv4D/n
YgmdyerrU1gj1ZJ+otowY5kUVFdDtuQzRkvTJXdFvFWuYMPcLYYYKAfLVc4F9D/1
xicKteVnSEteA1FoULrvRDzEqPLp/DEmj49YtVe2Lx//OXNE3uczq2rzin8+8lok
fIOCUZAB2pY9JyXUOAxdwwdvq1tdgbIFOl937K+HRxRp1uwWQZuD+OIbKK83UTTl
6oZp6tkDyIKiwgcnGHVdQsnKzMTrTG0q2+z9aqoHO6pCLonIq8LT3qPG/nwAxwGm
m4fQqB5beQSxU6hgh6qb
=uw6y
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
