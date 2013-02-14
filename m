From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Thu, 14 Feb 2013 19:56:50 +0200
Message-ID: <20130214175650.GA25891@arwen.pp.htv.fi>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52428 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761499Ab3BNR5A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 12:57:00 -0500
Content-Disposition: inline
In-Reply-To: <20130214171253.GC7144@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 14, 2013 at 09:12:53AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130214 03:19]:
> > Currently the omap-serial driver will not
> > work properly if booted via DT with CPUIDLE
> > enabled because it depends on function pointers
> > provided by hwmod to change its own SYSCONFIG
> > register.
> >=20
> > Remove that relyance on hwmod by moving SYSCONFIG
> > handling to driver itself. Note that this also
> > fixes a possible corner case bug where we could
> > be putting UART in Force Idle mode if we called
> > omap_serial_enable_wakeup(up, false) after setting
> > NOIDLE to the idle mode. This is because hwmod
> > has no protection against that situation.

Any comments to these last two sentences ?

> I agree the sysconfig stuff should be handled in the drivers.
> But considering that we need to also reset or idle hardware
> that may not have a driver loaded, it's best to put the
> reset/idle function in to the driver specific header as
> an inline function.

that is likely to cause quite a few isues, don't you think?

hwmod depending on driver code to reset particular IPs ? Seems like we
need a generic device_reset() hook which can be called by platform code,
no ? Not sure if that would help a lot though.

> This way the hwmod code can idle or reset the unclaimed
> hardware in a late_initcall.

The problem with this:

my_driver.h:

static inline void my_driver_reset(struct my_driver *drv)
{
	writel(drv->regs, SYSS, RESET);
}

how will hwmod provide drv pointer ? Even if we use void __iomem * it
would mean that hwmod would have to a) access driver's ioremaped area or
b) ioremap() the same area again.

Note sure if any of those are acceptable.

> And probably the handling of sysconfig bits should be
> done using a common header in include/linux/omap-hwmod.h
> or something so it can be shared between drivers.

That could be done, though I think the header name could be different.
Maybe it could match the document which define those registers, let me
just check if we're allowed to use that publicly :-p

--=20
balbi

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHSViAAoJEIaOsuA1yqRE0qEP/R/krP1xoOMwPDPTPFVI/cei
GFpFOiFkQTnmnzml1+rR+lAeSxNdvCgemKMziehHyynGlpraoeatQYcVDK/KR3mM
1+6WNkeJVL6XlaP9zqIgN99VSd5X87dXRvjbClzRLtTSAH7GSwQWzyn9NuvixpmG
8e3/Vu1qenVOLl8FYhxJZy/lpDyMwjOh3IYCcFEbIBKPwWhj9S08eytyD429ltoL
0xHm/uzlaqyeQ+3GSCFOYNTvXMUsA9sivytm1xzUoNfIckjYucHUp4fxcD7W7zmq
0WqaxFhLHUfxWnwuSH70XldTNjXrxB1GtFpfekyZIMva5idG9GomSN42VU6S+82e
QnRvuFflX7Fq3oJaSdEs7G9Ts0VjvQL+7nbeMbLhC/2WbFGOZ3+iUQ6/Eh8smtji
IpnOicpvdnLSCmD8fPBcHqxJ9BV8Kf0d8QfR9cuwSrSEPdUpdtoLfZrUwnGdks/z
/1PNgNKwfR5RTX+JSKzmqD2s3jeOSY4QHOc5hnuq17tMH1EjzXVa58i+i9qSuYve
DMCtpcSqWTD50O3jyglUz1AVLKOU6LA7o7eVBxP2Xzs59QSUY9DoLL/1aWx6nuYY
dFzaAFGb6lHCAue5AREOc7ed2uiewXAr/FgLO2UyE92UIwVzJLrSyZMKfAoZ6qIU
iW37zYkW1c5ix1M3AY+L
=JnFz
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
