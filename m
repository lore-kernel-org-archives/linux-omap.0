From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix compillation error in
 mach-omap2/timer.c
Date: Wed, 19 Dec 2012 08:38:56 -0800
Message-ID: <20121219163856.GN4989@atomide.com>
References: <1355910609-31336-1-git-send-email-peter.ujfalusi@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC9A56D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19250 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751721Ab2LSQi6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 11:38:58 -0500
Content-Disposition: inline
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC9A56D@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Bedia, Vaibhav <vaibhav.bedia@ti.com> [121219 02:18]:
> Hi Peter, Tony
>=20
> On Wed, Dec 19, 2012 at 15:20:09, Ujfalusi, Peter wrote:
> > prom_add_property() has been renamed to of_add_property()
> > This patch fixes the following comilation error:
> >=20
> > arch/arm/mach-omap2/timer.c: In function =E2=80=98omap_get_timer_dt=
=E2=80=99:
> > arch/arm/mach-omap2/timer.c:178:3: error: implicit declaration of f=
unction =E2=80=98prom_add_property=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
> > cc1: some warnings being treated as errors
> > make[1]: *** [arch/arm/mach-omap2/timer.o] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> >=20
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> > Hi Tony,
> >=20
> > today's mainline does not compile due to this API rename in of core=
=2E
> > Not sure if we alreasy have fix for this pending.
> >=20

Thanks applying.
=20
> There following patches for needed to get omap2plus_defconfig build w=
orking
>=20
> https://patchwork.kernel.org/patch/1810481/ - address the build break=
age due to header file cleanup
> https://patchwork.kernel.org/patch/1810441/ - address the prom_add_pr=
operty() issue
> http://marc.info/?l=3Dlinux-arm-kernel&m=3D135589966017628&w=3D2 - th=
is crept in during a merge commit.

Thanks all these should be queued up somewhere now.

Regards,

Tony=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
