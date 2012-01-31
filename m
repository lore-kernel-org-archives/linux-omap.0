From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] staging: tidspbridge: fix bridge_open memory leaks
Date: Tue, 31 Jan 2012 21:40:11 +0300
Message-ID: <20120131184011.GN3356@mwanda>
References: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
 <1327972818-30993-2-git-send-email-omar.ramirez@ti.com>
 <20120131081751.GB3294@mwanda>
 <CAJ6Av5NRnSax1aXT6fLg5GVRy+c+Xb9CXOXNn-2H4zprHKTi_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pnwJnpr18esoRWH7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:30627 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab2AaSjc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 13:39:32 -0500
Content-Disposition: inline
In-Reply-To: <CAJ6Av5NRnSax1aXT6fLg5GVRy+c+Xb9CXOXNn-2H4zprHKTi_A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@copitl.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org


--pnwJnpr18esoRWH7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2012 at 12:09:17PM -0600, Omar Ramirez Luna wrote:
> On Tue, Jan 31, 2012 at 2:17 AM, Dan Carpenter <dan.carpenter@oracle.com>=
 wrote:
> > On Mon, Jan 30, 2012 at 07:20:17PM -0600, Omar Ramirez Luna wrote:
> >> There are two members of pr_ctxt allocated during bridge_open that
> >> are never freed resulting in memory leaks, these are stream_id and
> >> node_id, they are now freed on release of the handle (bridge_release)
> >> right before freeing pr_ctxt.
> >>
> >> Error path for bridge_open was also fixed since the same variables
> >> could result in memory leaking due to missing handling of failure
> >> scenarios. While at it, the indentation changes were introduced to
> >> avoid interleaved goto statements inside big if blocks.
> >>
> >
> > You mentioned in the cover letter email that you wanted these to go
> > into stable. =A0I don't think that is needed here. =A0These are tiny
> > leaks that we aren't going to hit in real life.
>=20
> They are hit each time an app opens a handle e.g.:
>=20
> gst-launch <something>
>=20
> So after 'X' number of playbacks there won't be memory left.
>=20

Ah.  That sounds worth while then.

regards,
dan carpenter


--pnwJnpr18esoRWH7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKDWLAAoJEOnZkXI/YHqR0+IQAJfXNM8gYbWjPQqc0PqpJo58
eKPko+kx2efhLoQFIR+10KsBNCMFwTk1CpG0nIB0PsroLzs0jtptgnMdESrKT4nA
ePvZZjo+ExX1bRM0960bmEqdYFyPujzIWKiU+1x5J4RBbS7qVith3z8FtH8tR6Ko
AuzNrn0bKDNxA7DbEwW5ksojX/bkz6gqsP4S81M8DDys/UfcDksXMJbFYotuOcwF
NzRHfhQnJFgBnOhFNfXNkcipKdgmrTotrLcSdlZufKFIFMo1nRPx43VOF+jm9QIX
3gX55xE2aw1eOGf2PmN6o0CSgcQGxxednz9TlR2L0+bk/05OelaFdxKeTfYPuFXu
dkVck8y7ahCMdPwdNsJPMYzpF+wzpcvdwDyXRMSM7R/G8Qrs1FA1aK4cX2kE0HPq
PtPm5h9AJ/fuX9WH3NcCg/HGvuCQHGTAp1YBERHnGtjwvVGsD1fA7FjiyLEwn0rH
1B1RCcbyWj+sFdHPIKrTVYS4VLPc2iA4A4r+fdMCa0ZeKfh4yuEBLHDAEGGfgWWs
dEUIPAao1rifTNlHW5Q1RbpyTTou1EPX7+psLVL/5weRLd8puKXpC6MF+n4NByzt
C/t659uZbaddnwRk981C06/7MLJlP+RHXm2DZ+L/rvcsJFRek/jHkM1cSHTaPsKm
+gO5e7COMObqjbTBsMwH
=eHFJ
-----END PGP SIGNATURE-----

--pnwJnpr18esoRWH7--
