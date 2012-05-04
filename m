From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Problems with 3.4-rc5
Date: Fri, 04 May 2012 17:01:12 +0300
Message-ID: <1336140072.2552.6.camel@deskari>
References: <WC20120502115251.8503FF@terrafix.co.uk>
	 <4FA12775.1090206@ti.com> <WC20120502124638.320406@terrafix.co.uk>
	 <1336033721.14378.2.camel@deskari> <WC20120503084938.900446@terrafix.co.uk>
	 <1336050442.14378.10.camel@deskari>
	 <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-fEG8awKamnCAAKX73c+Y"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:59755 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751748Ab2EDOBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 10:01:20 -0400
Received: by lagj5 with SMTP id j5so1940954lag.3
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 07:01:15 -0700 (PDT)
In-Reply-To: <1336139415.2552.4.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-fEG8awKamnCAAKX73c+Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 16:50 +0300, Tomi Valkeinen wrote:
> On Fri, 2012-05-04 at 10:19 +0100, Joe Woodward wrote:
> > -----Original Message-----
> >  From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >  To: Joe Woodward <jw@terrafix.co.uk>
> >  Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org
> >  Date: Thu, 03 May 2012 16:07:22 +0300
> >  Subject: Re: Problems with 3.4-rc5
> > =20
> > > On Thu, 2012-05-03 at 09:49 +0100, Joe Woodward wrote:
> >  >=20
> > > > Both patches together results in slightly different behaviour, the
> >  > display is still broken-=20
> > > > it flickers on and off with occassional underflows before breaking
> >  > completely.
> >  >=20
> > > Beagle works fine for me with omap2plus based config, and I think ove=
ro
> >  > also although I can't test it now as I broke my micro mmc adapter.
> >  >=20
> > > Can you send your panel definition? Any other things that could affec=
t
> >  > display? Do you have PM enabled? Can you share your kernel config?
> >  >=20
> > >  Tomi
> >  >=20
> >=20
> > I've gone back to a test setup others can replicate.
>=20
> Ok, I can replicate it now. It seems to be somehow PM related. I
> normally have USB gadget stuff compiled into kernel so that I can boot
> via nfsroot with usb. After disabling USB support from the kernel, I can
> see synclosts.
>=20
> I have no idea yet what could be causing this. I've also tried adding
> the couple of DSS patches which are in queue for next merge window, that
> force OPP100 when DSS is enabled. They don't seem to help.

Also, at least on my setup, the sync lost doesn't happen very quickly
after starting the video output, but (I think) only when the system
starts to idle. My init scripts generate keys for sshd and some other
stuff, and no sync lost there, only just before the shell prompt do I
get a sync lost.

 Tomi


--=-fEG8awKamnCAAKX73c+Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPo+EoAAoJEPo9qoy8lh71UWAP/2TK8QBIAPlK3Pvn+zDANZ6/
ZxDa9hCNfUtzIsUNU/MOlyemreqV00m+6HTCXHc3bn6kyVuxgMws/VKboW9r4RmQ
fCgKK8qi9kPi94OOEaTa5+wNdnvYuO0qnvzWym/tgjgrCe+7Sw3hUC7U9hrN3YMb
LkuMtxq1PWcLt1PgGTleYCvNAchJUfthY2vfmgL4nAMcL/2ZFdmsOSsTrShvym8S
UUADk/XGgL5ty78BG13tG1yfw55gAX6zARmbJmEumnku8eeqS7QbonSdXxq9G1xM
NmsS/RXpeVuxDxpHV0FQYOIGjFCPzdfc9rx3RlO8Ej8l4krfBUQhInm4qZLf6xW5
ROHzTDfyeXweiPErXGQ3S7rHn5YxwtKVvpdcYStM3SVPQuSod2kBeGj4Pf5yGPp1
41pyYHXcd2yhWzy2HIQ/SAL2utXMGxqdx13CXaablihS88/edHIHgBFhek6h/WRd
sYW539qwZNi2BM33Mooip8G1JttGGBcyaBPOWl4Qxr2OWne02lGn8diPVDdMLUEv
3sPCj5+yvhM8wdrHaN33LBxGOthV+pCNH9I2YOJfci41z+V3vVGEnQHNU3rsIB1n
u9wThzbzfnX87AKMG0zK1DAI/idqqfonQbcWHfjmxmtCXyhrGKRsGjsuomC3NiVl
1hQnLIzg/mkeq+PusRSx
=SQye
-----END PGP SIGNATURE-----

--=-fEG8awKamnCAAKX73c+Y--

