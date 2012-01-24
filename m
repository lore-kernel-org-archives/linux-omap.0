From: NeilBrown <neilb@suse.de>
Subject: OMAP HDQ: was Re: DSS2/PM on 3.2 broken?
Date: Tue, 24 Jan 2012 21:37:05 +1100
Message-ID: <20120124213705.49f042bf@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	<20120113222045.37f9b4ec@notabene.brown>
	<alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com>
	<20120114100915.01c96727@notabene.brown>
	<20120118082410.48262777@notabene.brown>
	<alpine.DEB.2.00.1201211704430.26641@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/mp/yL1Cw2_2__6nuyz+g4Tj"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40039 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007Ab2AXKhT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:37:19 -0500
In-Reply-To: <alpine.DEB.2.00.1201211704430.26641@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

--Sig_/mp/yL1Cw2_2__6nuyz+g4Tj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Jan 2012 17:07:18 -0700 (MST) Paul Walmsley <paul@pwsan.com> wro=
te:

> On Wed, 18 Jan 2012, NeilBrown wrote:
>=20
> > Oh - another thing.
> > Sometimes during early boot I get:
> >=20
> > [    0.158447] omap_hwmod: usbtll_fck: missing clockdomain for usbtll_f=
ck.
> > [    0.176879] omap_hwmod: hdq: softreset failed (waited 10000 usec)
>=20
> This latter bug just got fixed, it's updated in the new HDQ series that I=
=20
> sent out:
>=20
> http://marc.info/?l=3Dlinux-omap&m=3D132719073710874&w=3D2
>=20
> BTW, if you could give that a spin for us at some point, it would be=20
> greatly appreciated; I don't think I have a board with a 1-wire device on=
=20
> it (at least, not that I know of).

Yes, the patch series seems to work OK - at least it doesn't break anything:
I can still access my battery charge meter.

It doesn't fix the problem I am having where HDQ gets confused when CPUIDLE
kicks in, but I think I might have a handle on that now.

Unlike other modules, HDQ doesn't have SIDLEMODE.
According to 18.4.5 (AM/DM37x Multimedia Device Silicon Revision) it acts as
though SIDLEMODE were set to SIDLE_FORCE so if the clock-domain trys to
switch off, HDQ lets it.

Normally UART has SIDLEMODE set to SIDLE_NO so that keeps the necessary clo=
ck
domain active.  But if I let the UARTs sleep, SIDLEMODE changes to
SIDLE_SMART which can allow the clockdomain to be stopped, which affects HD=
Q.

However I'm not sure how PRCM.CM_AUTOIDLE1_CORE fits into this. if AUTO_HDQ
is clear - which it is by default and I cannot see code that changes it -
then the clock for HDQ should be independent of .... something.

I definitely see behaviour that looks like the HDQ clock stopping
when the UART allows SIDLE_SMART or when I explicitly deny idling of the
clockdomains.

Should there be special handling of HDQ because it doesn't have SIDLEMODE??

Thanks,
NeilBrown

--Sig_/mp/yL1Cw2_2__6nuyz+g4Tj
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTx6J0Tnsnt1WYoG5AQIooQ//fbmcVhcScK23WiRiU5kcJba6W98sp+Jc
DcC/7Q70Ze/+KjxE07qHJCi/3ZTu4+epp7eIagZeTJ5OtyYKJFsykA/c9vUx2HWx
TJ4bEvSFdHl+997wulwfd5Q1EK53LSvpWssCZ34BlQWujOG9zh96k+sB0px0pRdk
Nu8dp7+YSMK69wOd8Dxp2WrXsha4roFdZeVeMDXML3wm15hGTde+bc89pf7br8Ks
/T1rRy2yI8LWH4LFOUxiJc3bjIP7wCEQs0J94pd+IR9e8dxDyF/YAuHXwYJFRVQO
zRTcE/3MXq1Cq5kHHXKpe9EkBpuDz3ozWcF9aJroOC3xVlA11LG4MPjW5y5YDE78
l7naqV4SnoMAzNXiiyZRxqB9RGVGEdmHQQWTSMzR3t9E/6+BanXADoCIBkJmAnH0
xM171osJ1Kg9ogOlFRzG4URL7Kt83zpGBUsydQt0SGF/1VY0kWzzmfJW7HJJok8p
Vu69GQ6J8htwnkzSFxkNPmFg0dK2Rf2w4tb/BfZTeOCxSIFLfC6tXfnWqrtRt1fK
zn/f08xEYwvrDF3n89maNe47R4QF/cllKHs5Ndth/u7Cupo8UyWCB5nsPKmxSK7J
rvumqCnC7NtlPPOzTdhfMZK9Fw6M1fzL54oMM5TZLCccsuzf4HSPDJaHl0ezLpkz
m85babv3TzA=
=M8X4
-----END PGP SIGNATURE-----

--Sig_/mp/yL1Cw2_2__6nuyz+g4Tj--
