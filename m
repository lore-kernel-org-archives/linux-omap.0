From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv9 8/8] ARM: OMAP4: USB: power down MUSB PHY if not used
Date: Mon, 22 Oct 2012 12:07:24 +0300
Message-ID: <20121022090723.GE14033@arwen.pp.htv.fi>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <1350552010-28760-9-git-send-email-t-kristo@ti.com>
 <20121018103334.GA1449@arwen.pp.htv.fi>
 <1350562684.2143.52.camel@sokoban>
 <20121018135352.GC2739@arwen.pp.htv.fi>
 <1350571199.2143.53.camel@sokoban>
 <508509C6.10708@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oplxJGu+Ee5xywIT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52163 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990Ab2JVJNE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 05:13:04 -0400
Content-Disposition: inline
In-Reply-To: <508509C6.10708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon <kishon@ti.com>
Cc: t-kristo@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

--oplxJGu+Ee5xywIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2012 at 02:24:30PM +0530, kishon wrote:
> Hi,
>=20
> On Thursday 18 October 2012 08:09 PM, Tero Kristo wrote:
> >On Thu, 2012-10-18 at 16:53 +0300, Felipe Balbi wrote:
> >>hi,
> >>
> >>On Thu, Oct 18, 2012 at 03:18:04PM +0300, Tero Kristo wrote:
> >>>>>+static int __init omap4430_phy_power_down(void)
> >>>>>+{
> >>>>>+	void __iomem *ctrl_base;
> >>>>>+
> >>>>>+	if (!cpu_is_omap44xx())
> >>>>>+		return 0;
> >>>>>+
> >>>>>+	ctrl_base =3D ioremap(OMAP443X_SCM_BASE, SZ_1K);
> >>>>>+	if (!ctrl_base) {
> >>>>>+		pr_err("control module ioremap failed\n");
> >>>>>+		return -ENOMEM;
> >>>>>+	}
> >>>>>+
> >>>>>+	/* Power down the phy */
> >>>>>+	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
> >>>>>+
> >>>>>+	iounmap(ctrl_base);
> >>>>>+
> >>>>>+	return 0;
> >>>>>+}
> >>>>>+early_initcall(omap4430_phy_power_down);
> >>>>>+#endif
> >>>>
> >>>>I think you could do it even if the driver is enabled.
> >>>
> >>>Actually not at least now, it looks like the driver is not controlling
> >>>this bit at all, so the driver would fail if we do this.
> >>
> >>then we can consider that a bug in the driver. Kishon, I thought you had
> >>added SCM address space to PHY driver for this particular reason until
> >>we get SCM driver, wasn't it ??
> >
> >Yes, I would say its a bug in the driver.
>=20
> No. It's done in the driver (omap_usb_phy_power() in
> drivers/usb/phy/omap-usb2.c). We explicitly power off the phy during
> probe in the driver.

so you also handle enabling the IP later when you need ? That's great,
it means we can do the above unconditionally, driver enabled or not.

--=20
balbi

--oplxJGu+Ee5xywIT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhQzLAAoJEIaOsuA1yqREmncQAJVOgnM4ckm67NeA3ci7Cqyg
BuqInO0TNVD+Rx13Iu5wEScfZG3iycmQwQwEGT7XwjqpYDp+6XafdAFs38r7rmu4
8dd8RsqIowr6VE16rsgO/EYuBeTQu+9BLjjGTJ2ZZghMZ24TPdJ1+sgtYombryJw
Sk4LRut4EC88w+JrREbYVccdZ6+dB35nrML/FAiepIHbMwaKgzjyXKDmHAy/k186
2Rh7jg/UZZXw6cCZvMsI2d1WzDUE83GcCpv21Pv1hzk5v97WZ2Tjzq0hqX3YQSw+
3tpfskgNEt5BApdZAoS6LnQ5VRb0HDTCCb8IKqV5qQsH3RHSXlN5m3vccDn5LFDP
ekXe45YtMsFZhZ2cLTZFDaVqrd9UurVLHnSHi/4rRXlKDdFG2fZYFNIkBCE+dThF
pc1xklaK5itCJY8ynIn1Ef8l5xB0f8dBWz0g/9W/JGqac6omXQzJ8DqV7j5D53dj
367PWBYAJiMH8nFdhfMiANHxeLs1BSfcbg7Fs7DfHivt6BBO3SBbS3nAJvsELfU1
EqLd/XoCWdeSjrc9rJR4F1yH3hKOXJFUBG67QdT5wbQR/Jn23/pw5kKvhWzN8pEl
0ncHyJ8bptt+N8Z0x7Ppi/lWyLf1bTbq3KdP/WdzDunaBOvQBxmR4l5NriyOC0P4
t0NpcAEzSuWjbXvqhp8T
=wftm
-----END PGP SIGNATURE-----

--oplxJGu+Ee5xywIT--
