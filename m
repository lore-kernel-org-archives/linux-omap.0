From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 09/12] ARM: OMAP2+: usb_host_fs: add custom
 setup_preprogram for usb_host_fs (fsusb)
Date: Mon, 11 Jun 2012 12:12:58 +0300
Message-ID: <20120611091257.GP6845@arwen.pp.htv.fi>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004617.20034.21714.stgit@dusk>
 <20120611063416.GT12766@atomide.com>
 <20120611071301.GC6845@arwen.pp.htv.fi>
 <20120611074133.GZ12766@atomide.com>
 <20120611074854.GG6845@arwen.pp.htv.fi>
 <20120611080341.GA12766@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V2tfspbppmK1TQo2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na6sys009bog028.obsmtp.com ([74.125.150.102]:52234 "EHLO
	na6sys009bog028.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752601Ab2FKJO5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 05:14:57 -0400
Received: by lahc1 with SMTP id c1so3343299lah.18
        for <linux-omap@vger.kernel.org>; Mon, 11 Jun 2012 02:14:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120611080341.GA12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>


--V2tfspbppmK1TQo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2012 at 01:03:42AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [120611 00:55]:
> > Hi,
> >=20
> > On Mon, Jun 11, 2012 at 12:41:33AM -0700, Tony Lindgren wrote:
> > > > > This should be "static inline int fsusb_reset_host_controller" as=
 it's
> > > > > in a header.
> > > >=20
> > > > why is it even in a header ? Only hwmod_fsusb_preprogram() will use=
 it
> > > > anyway.
> > >=20
> > > Well ideally it would be something that any OHCI driver can use for
> > > it's reset, and whatever bus code can also call to reset and idle
> > > for the unused devices that don't have the driver compiled in. Got
> > > any better suggestions where to place it? I could be a generic
> > > ohci_reset function in some header?
> >=20
> > maybe create <linux/usb/ohci.h> ? Then, while doing that, move register
> > definitions to this new header too... Something like:
> >=20
> > $ mv drivers/usb/host/ohci.h include/linux/usb/
> > $ sed -i 's/\"ohci.h\"/<linux/usb/ohci.h>/g' $(git ls-files)
> >=20
> > then add your ohci_reset() function...
>=20
> Hmm but then again it's pointless to export the all the ohci registers
> as that will lead to misuse outside drivers/usb.. Sounds like just
> defining the reset register is safest option here.

could be as well, but looks like we need to create <linux/usb/ohci.h>
anyway...

--=20
balbi

--V2tfspbppmK1TQo2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1baZAAoJEIaOsuA1yqRE+MgP/0j7B+30ZrHuwF10ku3sShk1
bmLq8toQjPcypD06P2SiflCT5uNjwsfqmdMXdW5T2JXXbhIjLyx9aU+BqPNEnrEj
2vA/f/ySHP+9FiI3VAm64sYpA5MgCnMvKE17mqEcw8sShWsr7jdtP6YeuNktgX5E
XS59MXj8FRQ7KY45hzS3iMdza3rtKqTF26zZubR6KfU7yImtDOvdC7aRpUVxkjEx
eenekMoB98P/EM29Wje9cgrSiyxBa5MlmFGVTl8KTaeeuw4ObDqFwq3mUwfTC2VV
DPekZ9pNwITtMX6HwvsN6H5DE6CyggnqU/iAgIgkBJddpKEk0kxfuM2jSUzhc61r
qgMvYoBDQ9OrGmUe0xeI+EDrAQevYtYwsEWYEv9Hr4Tr688ZeDE7hR+AOZ0QaliK
lsrp+VSeqWzcMpCXKQ8Cml0CN78OHU/3Jt2zGy61DmRwlB2aax1YStjxJHw11muy
lOjn/9EpiU9Yyc0KWCfHeSxu/x1BIQyaFBPfNvNIceMChv//9AFhPtH2Gn1KYyGk
n8IJrJG5TBbSIzJQYYm5q1TQbnpelC8dEfWC0eDUxE216gyNekO4ACx+VEWcRotl
q2XfoDkl/WfTILtvvikOIxoGqKCte5xrPFOy5qYAkpEjml6nigO95y0vDZwQAqzn
2OXCQsG+gnImVE+gA7t/
=baXf
-----END PGP SIGNATURE-----

--V2tfspbppmK1TQo2--
