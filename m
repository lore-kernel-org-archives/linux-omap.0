From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Subject: Re: problem with n810 boot up
Date: Thu, 7 Jan 2010 02:33:30 +0200
Message-ID: <201001070233.36120.siarhei.siamashka@gmail.com>
References: <200912290152.16357.luke@dashjr.org> <20100106224520.GA29239@gandalf> <4B45167F.8020605@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7706782.y0DziGGMCy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:33496 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab0AGAdl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:33:41 -0500
Received: by fxm25 with SMTP id 25so11259977fxm.21
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 16:33:39 -0800 (PST)
In-Reply-To: <4B45167F.8020605@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <alecrim@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--nextPart7706782.y0DziGGMCy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 07 January 2010, Francisco Alecrim wrote:
> Hi/Ol=E1 Balbi, :)
>
> Felipe Balbi wrote:
> > Hi,
> >
> > On Wed, Jan 06, 2010 at 06:11:10PM -0400, Francisco Alecrim wrote:
> >> Thanks! Now it goes to rootfs and continue the boot, but device
> >> power-off after 10-20 seconds. There is no error message to help. :(
> >
> > watchdog ?
> >
> > how about disabling watchdog with flasher ??
>
> I'm using the flags (no-omap-wd,no-retu-wd,no-lifeguard-reset)
> recommended by Kalle[1]. This's not the problem. :(

If I read these recommendations correctly, they tell to *clear* these R&D
flags. So probably it's better not to have them enabled.

Moreover, based on the following post, watchdog is hardwired and just can't=
 be
disabled by any software methods:
http://lists.maemo.org/pipermail/maemo-developers/2007-June/010650.html

Your powerdown problem is exactly caused by a watchdog. Earlier a solution =
was=20
to have a script which would kick watchdog periodically. But right now it is
kicked automatically in the kernel if CONFIG_CBUS_RETU_WDT option is enable=
d.
You also need to enable CONFIG_WATCHDOG, CONFIG_CBUS and probably some other
stuff.

This all also means that CBUS is critical for correct N8x0 operation and th=
ese
devices simply can't work without it at all.

Hope this information helps.

=2D-=20
Best regards,
Siarhei Siamashka

--nextPart7706782.y0DziGGMCy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBLRSvgvyB/CfYEEt4RAu9ZAJ9GRJcLJ783y+1ab3L3DQMFIny6UQCgsB5X
bdR4ZOOqHYsetnxH+K5XxFs=
=PKCJ
-----END PGP SIGNATURE-----

--nextPart7706782.y0DziGGMCy--
