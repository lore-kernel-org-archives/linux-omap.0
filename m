From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/3] Drop more omap3 legacy board-*.c files for v4.2
Date: Fri, 15 May 2015 21:52:39 +0200
Message-ID: <201505152152.39471@pali>
References: <1430769717-4088-1-git-send-email-tony@atomide.com> <20150506085204.GE30910@pali> <20150506144239.GH21061@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1563767.eJGD6N7Uev";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:36396 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934413AbbEOTwm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2015 15:52:42 -0400
Received: by wgbhc8 with SMTP id hc8so91719718wgb.3
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2015 12:52:41 -0700 (PDT)
In-Reply-To: <20150506144239.GH21061@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

--nextPart1563767.eJGD6N7Uev
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 06 May 2015 16:42:39 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150506 01:53]:
> > On Tuesday 05 May 2015 10:00:21 Tony Lindgren wrote:
> > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150505 09:41]:
> > > > On Tuesday 05 May 2015 17:06:38 Tony Lindgren wrote:
> > > > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150505 07:55]:
> > > > > > On Tuesday 05 May 2015 07:43:08 Tony Lindgren wrote:
> > > > > > > * Arnd Bergmann <arnd@arndb.de> [150505 03:56]:
> > > > > > > > On Monday 04 May 2015 13:01:54 Tony Lindgren wrote:
> > > > > > > > > For dropping the remaining omap3 legacy boot support,
> > > > > > > > > we still have the following board-*.c files:
> > > > > > > > >=20
> > > > > > > > > BOARD                   REASON NEEDED
> > > > > > > > > board-ldp.c             Still used in RMKs boot test
> > > > > > > > > system board-omap3logic.c      Getting a .dts file
> > > > > > > > > for v4.2 board-omap3pandora.c    Got a .dts file for
> > > > > > > > > v4.1 board-rx51-*.c          Needs /proc/atags
> > > > > > > > > support for user space
> > > > > > > > >=20
> > > > > > > > > I'm hoping we can drop those for v4.3 merge window,
> > > > > > > > > then keep the platform data around for one more merge
> > > > > > > > > window in case of reverting needed, then drop the
> > > > > > > > > platform data too for v4.4 if no issues needing
> > > > > > > > > reverting are found.
> > > > > > > >=20
> > > > > > > > Sounds great. Has there been a conclusion about what to
> > > > > > > > do for the rx51 /proc/atags support?
> > > > > > >=20
> > > > > > > I believe we just need to enable /proc/atags also for
> > > > > > > device tree based booting if CONFIG_ARM_ATAG_DTB_COMPAT.
> > > > > > > Pali may have more info on that.
> > > > > > >=20
> > > > > > > Then looks like Pali's two patches for showing the
> > > > > > > revision are still pending in thread "[PATCH v2 0/2] ARM:
> > > > > > > /proc/cpuinfo: DT: Add support for Revision":
> > > > > > >=20
> > > > > > > http://www.spinics.net/lists/arm-kernel/msg401535.html
> > > > > >=20
> > > > > > I think I already sent all need patches to ML. But I did
> > > > > > not check if you merged them or not. I did not get any new
> > > > > > comments for them for a while and right now I do not have
> > > > > > time for looking at it again.
> > > > >=20
> > > > > Oh OK, do you have link to the /proc/atags patch somewhere?
> > > > >=20
> > > > > Maybe Arnd and Nico can pick them up and sort out how we
> > > > > should queue them with Russell?
> > > >=20
> > > > https://lkml.org/lkml/2015/1/26/648
> > >=20
> > > Hmm looks like you should resend all your pending four patches
> > > properly with the people mentioned above in Cc to the LAKML
> > > and linux-omap.. Assuming something will happen to them when
> > > the patches are buried into a middle of some old threads does
> > > not work well.. Best to just follow das protokoll und whine and
> > > follow up until the patches get merged :)
> > >=20
> > > Regards,
> > >=20
> > > Tony
> >=20
> > Now I resent "ARM: /proc/cpuinfo: DT: Add support for Revision"
> > patches to MLs again without in-reply-to header.
>=20
> OK thanks.
>=20
> > Patches for /proc/atags I do not have currently in git format-patch
> > mbox format, so cannot resent it right now...
>=20
> Well presumably you'll resend those once you find them then :)
>=20
> Regards,
>=20
> Tony

Now I sent them. Now you (or anybody else) can review all 4 patches :-)

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1563767.eJGD6N7Uev
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlVWTocACgkQi/DJPQPkQ1IYtACgo649lzd9UI034csz1es1PDXx
5yIAoIurJQE6vP6pQZiwjjTlHUPneg9Q
=VgtV
-----END PGP SIGNATURE-----

--nextPart1563767.eJGD6N7Uev--
