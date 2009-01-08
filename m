From: green <greenfreedom10@gmail.com>
Subject: Re: using git with linux-omap
Date: Thu, 8 Jan 2009 11:02:04 -0600
Message-ID: <20090108170204.GK1916@swansys>
References: <20081224032419.GG4080@swansys> <20081224041903.GD10240@frodo> <20081225004631.GH4080@swansys> <20081225195450.GF10240@frodo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z9t8O/5YJLB6LEUl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f17.google.com ([209.85.219.17]:55682 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbZAHTnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 14:43:15 -0500
Received: by ewy10 with SMTP id 10so9819819ewy.13
        for <linux-omap@vger.kernel.org>; Thu, 08 Jan 2009 11:43:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081225195450.GF10240@frodo>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--Z9t8O/5YJLB6LEUl
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
> answer. But there are two other easier ways to do it:
>=20
> a. with git cherry-pick:
> $ git checkout -b newbranch v2.6.27-omap1
> $ git cherry-pick <commit id for your Makefile change>

This works.

> b. symlink: just create a symbolic link from arm-none-linux-gnueabi-* to
> arm-linux-*, something like:
>=20
> $ cd /path/to/compiler
> $ for i in `ls`; do ln -s $i ${i/none-linux-gnueabi/linux}; done
>=20
> this might help. To be sure the command is right before really executing
> it, change ln -s to echo and see if the paths are ok.

And yes, this would work too.

Thanks!

--Z9t8O/5YJLB6LEUl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklmMYwACgkQ682C+dBP+oSK5QCg8bp1QOdj1isA5UTqBn7ySK0+
U7gAniP8cOrGntlsm+lsB3HzJSHRRdjE
=9Ek2
-----END PGP SIGNATURE-----

--Z9t8O/5YJLB6LEUl--
