From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Fwd: Re: Broken builds
Date: Wed, 13 Jun 2012 13:20:09 +0300
Message-ID: <1339582809.2637.20.camel@deskari>
References: <20120613095753.GA32099@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-DiFFX0dmNs1r6ctMdMR0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:46981 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242Ab2FMKUP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 06:20:15 -0400
Received: by lagv3 with SMTP id v3so293122lag.3
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 03:20:12 -0700 (PDT)
In-Reply-To: <20120613095753.GA32099@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, torvalds@linux-foundation.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>


--=-DiFFX0dmNs1r6ctMdMR0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-13 at 10:57 +0100, Russell King - ARM Linux wrote:
> Linus,
>=20
> Can you please apply the patch below.  I've been waiting 10 days so far
> for a fix for the build problem to get through the "normal" channels,
> and it seems to be stuck with the FBdev maintainer, who "missed -rc2"
> with his pull request - and still hasn't submitted it.

Note also that I sent the fix quite late, as I was on paternity leave.
So Florian didn't have many days to react.

> Tomi Valkeinen has a different fix to this, which is the one stuck in
> the fbdev maintainers tree.
>=20
> I'm fed up with waiting for this build breakage to get fixed, and to
> think how badly I get flamed if I do something even sneeze wrongly in
> the direction of any x86 code...

Here's also my pull request, perhaps it's easier to pull it instead of
applying the patch.


The following changes since commit e92a5b28f71aea01b281f9c89d97a4bc5b24748f=
:

  OMAPDSS: HDMI: OMAP4: Update IRQ flags for the HPD IRQ request (2012-05-2=
2 11:00:09 +0300)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.5-rc2

for you to fetch changes up to c3a21fc79b6bc097d8b0e47498903a649a111127:

  OMAPDSS: fix registration of DPI and SDI devices (2012-06-05 17:15:24 +03=
00)

----------------------------------------------------------------
Small fixes for omapdss driver. Most importantly, fixes a build problem whe=
n
debugfs or omapdss debug support is turned off, and fixes a suspend related
crash.

----------------------------------------------------------------
Archit Taneja (1):
      OMAPDSS: DSI: Fix bug when calculating LP command interleaving parame=
ters

Tomi Valkeinen (4):
      OMAPDSS: fix build when DEBUG_FS or DSS_DEBUG_SUPPORT disabled
      OMAPDSS: Taal: fix compilation warning
      OMAPDSS: fix bogus WARN_ON in dss_runtime_put()
      OMAPDSS: fix registration of DPI and SDI devices

 arch/arm/mach-omap2/display.c             |    4 ++--
 drivers/video/omap2/displays/panel-taal.c |    2 +-
 drivers/video/omap2/dss/core.c            |    3 +--
 drivers/video/omap2/dss/dsi.c             |    2 +-
 drivers/video/omap2/dss/dss.c             |    2 +-
 5 files changed, 6 insertions(+), 7 deletions(-)


--=-DiFFX0dmNs1r6ctMdMR0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIbBAABAgAGBQJP2GlZAAoJEPo9qoy8lh71H6cP+OeDhQEhrqPhgDiAaY1di5Ed
b/5mlUvd4gm6sJQO6VMiQ41Z7Qtl57xigGSAAI4ltIUJY1YRTw1RBMb94s4lqtL8
+tgOZPxXwD5f/8A1jNBQ2ikNtMueDx6oujoER856qru2A78XEWF2wjyU3Efpsi7R
hDS0UKx/iz0whBW3Krc1u3xqNA/6hvsnoi5O02Sgq2Ago7LjQ1htkLSQpslvr8a4
1MCchAOZwTogWzDe3M6NoTm7WrR1vWsbis9eZ0cMmrtbxWr72J5BjwlrQX2+of++
A9QRYaYiifucn3+0gZSda5C+voWShcmBkQaFVu82NKJh/3L41hUn0KVqKca8QuLL
0lvcNuSJcChenhSz0o7In8kGAXC29PldDqP/hY/CAEn/J5ffnNG7xatQepzOY1nr
d8RWktUVU6hk7zv5KFAa8BB77VPZdIKy9pR+HawEypfYttTOs9blYTxkgDfquGnB
fotKi8S5YK1bPAsksH68B8nf3adUChPsW7sS/IxYRTSP3ZsQt7YVj7ot8341iBDJ
fU7E9O/aoxY9AohszZTMGU52CVrEbJSrkPA0HCqS/JaIhF87wjIOu4fmjIEEf/a7
Lb7bsf+XBQY6lyClFZuKlyVtyQeM+zArRIDE6g29ZckO9plajmvX+oZ8/AOBWso6
my/ZjxuqBOF7S05R2Yo=
=mGI1
-----END PGP SIGNATURE-----

--=-DiFFX0dmNs1r6ctMdMR0--

