From: Felipe Balbi <balbi@ti.com>
Subject: Re: serial-omap regression?
Date: Fri, 21 Sep 2012 12:28:24 +0300
Message-ID: <20120921092822.GE15115@arwen.pp.htv.fi>
References: <87wqzofgms.fsf@deeprootsystems.com>
 <87obl0fga1.fsf@deeprootsystems.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:58256 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138Ab2IUJdN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Sep 2012 05:33:13 -0400
Received: by lbbgj3 with SMTP id gj3so3590944lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 02:33:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87obl0fga1.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Sourav Poddar <sourav.poddar@ti.com>


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 20, 2012 at 04:03:50PM -0700, Kevin Hilman wrote:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
>=20
> > Hi Felipe,
> >
> > I just noticed today that one of my boards (3530/Overo) was not making
> > it to the console when using an Debian rootfs (nfsroot) but works fine
> > with my basic busybox initramfs.  Basically, it hangs somewhere between
> > finishing the userspace init and launching the login shell.
> >
> > git bisect ended up pointing the finger at a patch in the OMAP serial
> > series[1].  I didn't debug this any further.  Any ideas?
> >
>=20
> I forgot to add, this was first noticed when testing with
> arm-soc/for-next which has the serial-omap changes pulled in as a
> dependency.

hmmm, Shubhro had written a patch to fix some mistakes on rlsi handler.
Maybe it fixes this problem ?

Shubhro, can you send your patch ?

--=20
balbi

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQXDM2AAoJEIaOsuA1yqRE0IQP/0uxR5qDDrbdUIFK/+IPsrFA
l3VYpUIchRPRotkBrOmaSpjnbDeSRvHVM7R5d1MLzS9s92cDVuLtcjBElX6AUDu/
WtxKjtZSO337pbdMjzy6sRH0kGCqq4ffUxXsfef0QTZQzzQKxIDHiwv7vkMJIOA/
EKeiExubX/jh5nnzPdZingWdT9wu2b/mZ2LKmSZQ3gQqWO9q0e15KttXAiJ9g57O
MlqsMWnqiKFcBREpXEGQDvyKv954EycoChNXinVhakYYA+0Kdxsv+h9vTwQ0yEH/
TblQVTvwpH+wogjGIiyvypqURwNqj35Q1IyEJ1AZceWSIl1t1uYpq0RpGWZDB6kZ
AVtJIN/nh6BA1gOtBg29VhVos5QlG79ceVsC7hkkHyKo0AGlYH2oQSD3SPQ8ju6S
td3lHaA3XNPEjx9RjTuafmFGr60Tfv9yJTcEbbe0Hh4E2eyvkKpkefySPaD3aaac
X4G9q1QqSaQSirtOT4N4qUBFbk4fk6Pwo28SLtdUhsi8LtB7mijg5KlHS5Nus7zU
oteg0yJLCnJfWZ6h/J7AX3rzCa72DxVvgCP1Ni+djYZ9t5PUr8vcpNCle/l9DArd
ZTOZ0PVyxnCI7zM5E6Q/KzSm8lCG02yDA5v/Z4tI+8GDWKmMuEk5KHy5nj7ZOvy7
lkO6Q7ZYWMOsmsZxTwCy
=gq8w
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
