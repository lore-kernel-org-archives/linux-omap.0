From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: Re: [PATCH] arm: omap2: rx51-peripherals: fix build warning
Date: Thu, 4 Dec 2014 15:00:12 -0200
Message-ID: <20141204150012.2fb75907@recife.lan>
References: <1417033655-32332-1-git-send-email-balbi@ti.com>
	<20141204152411.GF18045@saruman>
	<3261416.DL88JFJXUF@wuerfel>
	<20141204154835.GH18045@saruman>
	<20141204163930.GF2817@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:39248 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932313AbaLDRAS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2014 12:00:18 -0500
In-Reply-To: <20141204163930.GF2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Em Thu, 04 Dec 2014 08:39:31 -0800
Tony Lindgren <tony@atomide.com> escreveu:

> * Felipe Balbi <balbi@ti.com> [141204 07:50]:
> > Hi,
> >=20
> > On Thu, Dec 04, 2014 at 04:41:13PM +0100, Arnd Bergmann wrote:
> > > On Thursday 04 December 2014 09:24:11 Felipe Balbi wrote:
> > > > On Wed, Nov 26, 2014 at 02:27:35PM -0600, Felipe Balbi wrote:
> > > > > commit 68a3c04 ([media] ARM: OMAP2: RX-51: update
> > > > > si4713 platform data) updated board-rx51-peripherals.c
> > > > > so that si4713 could be easily used on DT boot, but
> > > > > it ended up introducing a build warning whenever
> > > > > si4713 isn't enabled.
> > > > >=20
> > > > > This patches fixes that warning:
> > > > >=20
> > > > > arch/arm/mach-omap2/board-rx51-peripherals.c:1000:36: warning=
: \
> > > > > 	=E2=80=98rx51_si4713_platform_data=E2=80=99 defined but not =
used [-Wunused-variable]
> > > > >  static struct si4713_platform_data rx51_si4713_platform_data=
 =3D {
> > > > >=20
> > > > > Cc: Sebastian Reichel <sre@kernel.org>
> > > > > Cc: Tony Lindgren <tony@atomide.com>
> > > > > Cc: Hans Verkuil <hans.verkuil@cisco.com>
> > > > > Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > >=20
> > > > a gentle reminder on this one.
> > > >=20
> > >=20
> > > Let me add my
> > >=20
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >=20
> > > You didn't say who you expect to pick up the patch. I assume Maur=
o
> >=20
> > patch author now decides who takes the patch ? That's new :-)

Well, for patches that cross subsystem boundaries, like this one,
the best is to give a hint about whom you expect to pick it.

In this specific case, as commit 68a3c04 is in my tree, the best is
to merge the patch on it, as the patch may not even apply at Tony's
tree.

> >=20
> > > should take it because he took the patch that caused the problem,
> > > but he might not be aware that he should look at this now.
> >=20
> > He is in Cc, let's ask him :-)
>=20
> Best that this one goes in along with the other si4713 patches
> to avoid dependencies between trees:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks! I'll merge it via my tree.

Regards,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
