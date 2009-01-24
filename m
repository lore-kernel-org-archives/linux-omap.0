From: green <greenfreedom10@gmail.com>
Subject: Re: using git with linux-omap
Date: Sat, 24 Jan 2009 15:20:08 -0700
Message-ID: <20090124222008.GA6457@swansys>
References: <20081224032419.GG4080@swansys> <20081224041903.GD10240@frodo> <20081225004631.GH4080@swansys> <20081225195450.GF10240@frodo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:26980 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbZAXWUh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2009 17:20:37 -0500
Received: by qw-out-2122.google.com with SMTP id 3so2511769qwe.37
        for <linux-omap@vger.kernel.org>; Sat, 24 Jan 2009 14:20:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081225195450.GF10240@frodo>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-12-25, 360, Felipe Balbi wrote:
> On Wed, Dec 24, 2008 at 06:46:31PM -0600, green wrote:
> > On Wed, 2008.12.24, 359, Felipe Balbi wrote:
> > > On Tue, Dec 23, 2008 at 09:24:19PM -0600, green wrote:
> > > > I have cloned linux-omap-2.6 and created a local branch.  In the lo=
cal branch I=20
> > > > have made one very simple commit with a single line change to Makef=
ile for use=20
> > > > when cross-compiling (arm-linux-gnueabi-).  I would like to be able=
 to rebase=20
> > > > that branch (just the 1 commit) onto any commit in the master branc=
h so that I=20
> > > > can test N810 builds using git-bisect without modifying the Makefil=
e every=20
> > > > time.  I can easily move the branch forward to the latest commit wi=
th 'git=20
> > > > rebase master' (with the local branch active) but something like 'g=
it rebase=20
> > > > v2.6.27-omap1' returns merge errors.  Of course that 1 commit will =
apply easily=20
> > > > to that specific tree.
> > >=20
> > > hmmm, something like git rebase --onto HEAD v2.6.27-omap1 <your_branc=
h>
> > > should work.
> >=20
> > I got a bunch of merge conflicts this way.
>=20
> maybe I got the parameters wrong. git help rebase will have the correct
> answer.

Hey, I got it to work:
git rebase --onto v2.6.27-omap1 master <my_branch>

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl7lBcACgkQ682C+dBP+oQeCACfT8BydiXTmZgX9Wzcbuq5ksID
GwwAnRPzO0fWreI9ZI5ybHNjxw4nqDAT
=/eRj
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
