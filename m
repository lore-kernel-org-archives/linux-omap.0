From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH] arm: omap3: pm: do not clear power states twice
Date: Fri, 3 Feb 2012 10:19:32 +0200
Message-ID: <20120203081931.GF24297@legolas.emea.dhcp.ti.com>
References: <1328254094-13978-1-git-send-email-balbi@ti.com>
 <CAMQu2gwtXyLzPNk2_4O+EAWyZaQs+wY_cK4pm_=yJj6ARXnhAw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:45145 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752860Ab2BCITi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Feb 2012 03:19:38 -0500
Received: by lagw12 with SMTP id w12so2509165lag.21
        for <linux-omap@vger.kernel.org>; Fri, 03 Feb 2012 00:19:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMQu2gwtXyLzPNk2_4O+EAWyZaQs+wY_cK4pm_=yJj6ARXnhAw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2012 at 01:34:55PM +0530, Shilimkar, Santosh wrote:
> On Fri, Feb 3, 2012 at 12:58 PM, Felipe Balbi <balbi@ti.com> wrote:
> > The way the code is written, pwrdm_pre_transion()
> > calls _pwrdm_pre_transition_cb() (for each powerdomain)
> > which, in turn, calls pwrdm_clear_all_prev_pwrst().
> >
> > It looks unnecessary to clear all previous power
> > states twice, so drop the initial set.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >
> > Hasn't been tested yet. Compile tested only. It looks
> > like we can safely remove those calls, but I would
> > like to hear from the PM folks first :-)
> >
> Bit late :)
>=20
> Paul already cleaned this up.
> http://www.spinics.net/lists/linux-omap/msg63602.html

that's too bad. Missed an oportunity to have a commit on pm code, heh.
Anyway, thanks

--=20
balbi

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPK5iSAAoJEIaOsuA1yqREJFwP/1eXdLoaZhEdk7jTcr5lXpJP
zi6vbr1/0TAKyt9k/5oG4JbSDrIVHVJ7ecTUW2HwqkBIZa+59HqejleluLRmf0EP
ei6uesb8/q88MEozT/f71DGEFNhgjZbThs5pQ1M+CG5lBS03JuU0u2tp25eTaIQ9
Dtxaxh2Cy6KLoOX5xvr9IlZBdEr3oo/9BqO2cVYs+HNaSI15RD94m70vY/BZX6c1
oqQ5LUFrPvHM8chkSQP2yZnNAmznlb8eZWT2bHyWRsh7G2Bx0TqxnZ+DN1agxjki
/xwcZwVyYXzPLtzZEKfxu0XGSTaEmcU9ontLXL27q3nTCGvL+A9RaxBtBntUOv+I
x6xVE7bhccwkLf2BBDv2IiMaPfMGAytmaAxVj1yWYCTxh+5QBe0aglpDOqaBIKhR
mq9C+aPbfYPk8RVh6HSp9Au2RE2WPkjy13axbkh7tNrhxq0fJckID24sjQ1EfK8U
pO8JXDhqPAUx8/apu84iMyJ97uO7aozuyuYdoGVGvRkQfEJlFylasRitEJUStWIY
zSrDwseoBTshTrj/9cd8TPvRJ++ik1hmeOr7LHTxB/wlofO+8XFwBn/91pf1QLQ+
+kSI8ibPPHb8tAyjDgnZvD3vcCDwMY6GWuHdwtoAxmZwIoajYlTAkwyIZwK49Slt
PlO2LyY+87Y/R6c6RmLd
=CpeD
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
