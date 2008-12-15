From: green <greenfreedom10@gmail.com>
Subject: Re: N810 suspend
Date: Mon, 15 Dec 2008 16:51:16 -0700
Message-ID: <20081215235116.GC25056@swansys>
References: <20081215210823.GD5334@swansys> <20081215211430.GJ10664@atomide.com> <87prjt9jwy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:37046 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbYLPAGF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 19:06:05 -0500
Received: by qyk4 with SMTP id 4so2920449qyk.13
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 16:06:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87prjt9jwy.fsf@deeprootsystems.com>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2008.12.15, 350, Kevin Hilman wrote:
> Tony Lindgren <tony@atomide.com> writes:
> > * green <greenfreedom10@gmail.com> [081215 13:08]:
> >> What are the chances of getting suspend (resume from) working on the N=
810?  Are=20
> >> there any patches or branches around that I can test (I'm slowly learn=
ing how=20
> >> to use git)?
> >
> > Well you need to make sure the serial clocks are not enabled. Kevin
> > has some patches for that in his pm branch. So you'll most likely want
> > to use his whole pm branch.
>=20
> Suspend/resume on n810 is currently broken in linux-omap.  I submitted
> a patch a week or so ago to fix an assembly bug which was crashing the
> suspend, but it is still not resuming.
>=20
> Most likely a simple fix needed to init the proper wakeup sources, but
> I haven't tested further.

I'll be looking for any progress ;) and will test it when I can.

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklG7XQACgkQ682C+dBP+oQesQCghzdw4mk6CKfiUtk1ZL6Wc7iC
C0oAoOk/NUhgEodAvqJr0YolucsxQNEw
=PswR
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
