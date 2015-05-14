From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Thu, 14 May 2015 16:25:42 -0500
Message-ID: <20150514212542.GA3466@saruman.tx.rr.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <1431560196-5722-3-git-send-email-tony@atomide.com>
 <20150514020634.GB20006@saruman.tx.rr.com>
 <20150514155945.GL15563@atomide.com>
 <20150514211501.GO15563@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38415 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964836AbbENV1x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 May 2015 17:27:53 -0400
Content-Disposition: inline
In-Reply-To: <20150514211501.GO15563@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 14, 2015 at 02:15:01PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150514 09:01]:
> > * Felipe Balbi <balbi@ti.com> [150513 19:09]:
> > > > +void dev_pm_enable_wake_irq(struct device *dev)
> > > > +{
> > > > +	struct wake_irq *wirq =3D dev->power.wakeirq;
> > > > +
> > > > +	if (wirq && wirq->manage_irq)
> > > > +		enable_irq(wirq->irq);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dev_pm_enable_wake_irq);
> > >=20
> > > you probably want to enable dev_pm_enable_wake_irq() automatically for
> > > from rpm_suspend(). According to runtime_pm documentation, wakeup sho=
uld
> > > always be enabled for runtime suspended devices. I didn't really look
> > > through the whole thing yet to know if you did call it or not.
> >=20
> > Yes I think we can also automate that part, I've been playing with an
> > additional patch doing that for pm runtime. Been still thinking if
> > there's any need to manage that in the consomer driver, I guess not.
>=20
> Here's what that would roughly look and now I also remember why
> I did not include it. It adds currently extra checks also for
> devices not using dedicated wakeirqs. But basically this would
> allow leaving out the enable/disable PM runtime calls from drivers.

hey cool, the only requirement now is that drivers attach and detach
wakeirq :-)

--=20
balbi

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVVRLVAAoJEIaOsuA1yqRE2xYP/2lcBMW11rqxabOdAIkH/pQv
DbTBOiWB5igv5/e0/cx6ewTqsfHWfJ8KzkromHLShk1nG7aEq8T13b3VPUDVofG+
D7nkxawH/A3rekojm5LIp5bLbgTQikC36FanGDjvNC2krYE/JKY+IUKyN+jlVpUi
zfnqrRsT8jcEWglJIhHtcp0MAFt3gRel12b4klrxo+tqlLnjbpMxVTsihmW7PN/F
UYNGt6m7DsTYSFt+jo77r9NM/4glwRkr1ugAx2s6gCAzYAWiavzAACuSRilw/PU8
QR5wlDtp8eXZVn04x8pC2NGhksjoMgcWRethfheI1S1/QVCxFnSIroGOdwKAuCE4
0i/jQPb0O2M1+H5Dr0S07rriEqerWN3th6vHLkNvUTd7q12ntpciKNMeDaUnE39Z
8bZCxYwYJJ51ur03TXleoS2odF47M0bxI663mKWJgn9XIZrRxrTB1+rGXm7VbIVM
vqMto2hAWqrCdLMnjXeAiW26AcxR9f2vvGgb1nri9ZUdT+9OWvdwEaVBLS31/18W
8+dzwalbNLJNxoz4lQU5Zr7ShaUL263kbX5qau3dNac6H2nm5y5C3wlWbp0EsbMn
XQoR6HNifJCErPXzuBWxVWI5mqsW4Gdl+XLX9tLhDjMDb1q1to43GTjvf8a0+eek
oCqgvzjjNWouQULgv2IG
=70Lx
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
