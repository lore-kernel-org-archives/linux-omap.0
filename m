From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: DSS hwmods: Add OCPIF_SWSUP_IDLE to all
 DSS L3 slave interfaces
Date: Fri, 04 May 2012 11:51:42 +0300
Message-ID: <1336121502.2701.12.camel@deskari>
References: <1334304116-18872-1-git-send-email-archit@ti.com>
	 <1334304116-18872-3-git-send-email-archit@ti.com> <4F87E72A.2050104@ti.com>
	 <4F87E924.5040601@ti.com>
	 <alpine.DEB.2.00.1205040038510.20926@utopia.booyaka.com>
	 <4FA37F41.3070102@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-zj+VteFHapEONcr98MgC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:60844 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753997Ab2EDIvs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 04:51:48 -0400
Received: by lahe6 with SMTP id e6so2340877lah.32
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 01:51:45 -0700 (PDT)
In-Reply-To: <4FA37F41.3070102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--=-zj+VteFHapEONcr98MgC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 12:33 +0530, Archit Taneja wrote:
> Hi Paul,
>=20
> On Friday 04 May 2012 12:09 PM, Paul Walmsley wrote:
> > Hi Archit,
> >
> > On Fri, 13 Apr 2012, Archit Taneja wrote:
> >
> >> On Friday 13 April 2012 02:13 PM, Cousson, Benoit wrote:
> >>> On 4/13/2012 10:01 AM, Archit Taneja wrote:
> >>>> The clock for all DSS L3 slave interfaces had been recently changed =
to
> >>>> "dss_fck" from "l3_div_ck". "dss_fck" is an optional clock in DSS
> >>>> clock domain
> >>>> which can't autoidle when enabled.
> >>>>
> >>>> Add OCPIF_SWSUP_IDLE flag to all the L3 slave interfaces used by DSS
> >>>> hwmods so
> >>>> that clock is explicitly enabled and disabled by software. Without t=
his,
> >>>> "dss_fck" would be left as enabled and the OMAP4 device won't idle
> >>>> even when
> >>>> DSS is not in use.
> >>>
> >>> Yeah, that was done on purpose with Tomi knowning well that limitatio=
n.
> >>>
> >>> The issue was mainly due to the lack of proper parent / child
> >>> relationship between the DSS (the whole subsystem) and the DSS childr=
en
> >>> at that time.
> >>>
> >>> I think that Tomi posted a series to fix that for 3.4. So if we ensur=
e
> >>> that every DSS IPs are children of the DSS, then pm_runtime will alwa=
ys
> >>> ensure that the DSS will be enabled each time a submodule is used.
> >>>
> >>> So the right fix is to put back the proper iclk (l3_div) to the DSS
> >>> instead of the dss_fck.
> >>
> >> Ok, I get it now. Tomi's patch series ensured the parent-child
> >> dependency, but they didn't switch the iclks back to l3_div, I guess
> >> that should be a part of the series too.
> >
> > Just checking on this one.  Does this patch need to be updated ?
> >
>=20
> We were working on this, but we realised that only having a parent-child=
=20
> relation in dss platform devices won't be sufficient to remove "the use=
=20
> of dss_fck(or MODULEMODE bits) as a slave clock" hack.
>=20
> The issue is that during bootup(when omap_hwmod_setup_all() is called),=
=20
> all hwmods are enabled independently, so all dss hwmods need to enable=
=20
> the MODULEMODE bits for them to be setup correctly.
>=20
> With the parent-child relation in platform devices in DSS, only the=20
> parent platform device's hwmod("dss_core" in our case) should enable and=
=20
> disable the MODULEMODE bits. If the children also become capable of=20
> enabling/disabling it, then things wouldn't work.
>=20
> Hence, to go ahead with this approach, the hwmod's themselves need to=20
> have some sort of parent child relationship, or atleast some sort of use=
=20
> counting for MODULEMODE bits. Benoit and Tomi could comment more on this.
>=20
> Hence we are sort of stuck :)

Yes, this is my understanding also. I got the impression from Benoit
that adding such a parent-child relationship is not trivial.

 Tomi


--=-zj+VteFHapEONcr98MgC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPo5ieAAoJEPo9qoy8lh71nWEP/1wCzA1wVB1TKFVVNbcD9K7L
PPUuhNqtDvUehOdCVUbJFdvavIMvMOVoR/KheJf2lobVi4s0pMJr5Fqaxi9jEBZS
4ZO1GP4a7auG/hMKVmttCxbKe/ATszq50tAVMqoKDuTwzyqvRP4X62xDZayx9une
uqIxQKuHalcYL4JAquRfrAH3Y1Aw2AQTgRjVELsQphdl3lbidQortbByEW+GUREi
1TUIL+SMabPnY4GO1j7Yerr8S4oO5HSyZ1PS+ihMWTEwC+bHpyvgDN+tUjCWmPav
/KNuiVYx+awZbELNsufKvD6pLpgUgONDd7wJsW8dNsqe5R6KB8pQOmAKKqJvHV8V
yvybxCGYe70S3WF6zQY/3oVAwqYfpOfiBPtWzzQgHiP/apG7/jR4jAdKl9vwWhEK
6y/sG03KmC1mKMS1f/pTuABFfM7Qtoaj8pabzNQmjJnDz2Yd2cFDuvF2o981QPoa
jceKLXv4ALLSKjGJYzQY8CgV6SKRrfsZaIKkhpDtnz8jeHnBwIy5rnmmgP9VJvg+
9Gw2E6oZPhBbrIWUKdlY1TOF2YmgqrRz18/XCe+/z30fjQJ0oZEyKChvQ2BNjCpN
KcwunQeFwO2X5yjWVQksSaWfgA21oLuicdN1CnlTP7v7oHw0edKrWoRqq4QW1M4a
OubjNTu2/GMZtCMtEROc
=GRZX
-----END PGP SIGNATURE-----

--=-zj+VteFHapEONcr98MgC--

