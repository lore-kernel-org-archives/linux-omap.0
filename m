From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm: omap2: rx51-peripherals: fix build warning
Date: Thu, 04 Dec 2014 16:41:13 +0100
Message-ID: <3261416.DL88JFJXUF@wuerfel>
References: <1417033655-32332-1-git-send-email-balbi@ti.com> <20141204152411.GF18045@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:62374 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691AbaLDPlc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2014 10:41:32 -0500
In-Reply-To: <20141204152411.GF18045@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, balbi@ti.com
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thursday 04 December 2014 09:24:11 Felipe Balbi wrote:
> On Wed, Nov 26, 2014 at 02:27:35PM -0600, Felipe Balbi wrote:
> > commit 68a3c04 ([media] ARM: OMAP2: RX-51: update
> > si4713 platform data) updated board-rx51-peripherals.c
> > so that si4713 could be easily used on DT boot, but
> > it ended up introducing a build warning whenever
> > si4713 isn't enabled.
> >=20
> > This patches fixes that warning:
> >=20
> > arch/arm/mach-omap2/board-rx51-peripherals.c:1000:36: warning: \
> > 	=E2=80=98rx51_si4713_platform_data=E2=80=99 defined but not used [=
-Wunused-variable]
> >  static struct si4713_platform_data rx51_si4713_platform_data =3D {
> >=20
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Hans Verkuil <hans.verkuil@cisco.com>
> > Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
> a gentle reminder on this one.
>=20

Let me add my

Acked-by: Arnd Bergmann <arnd@arndb.de>

You didn't say who you expect to pick up the patch. I assume Mauro
should take it because he took the patch that caused the problem,
but he might not be aware that he should look at this now.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
