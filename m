From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] OMAP3: wdtimer: fix wdtimer blocking CORE idle
Date: Thu, 10 Mar 2011 06:08:25 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100604460.15132@utopia.booyaka.com>
References: <1299749569-22673-1-git-send-email-kalle.jokiniemi@nokia.com> <alpine.DEB.2.00.1103100247190.15132@utopia.booyaka.com> <9D0D31AA57AAF5499AFDC63D6472631B065E79@008-AM1MPN1-036.mgdnok.nokia.com> <4D78B290.7070905@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-344658483-1299762505=:15132"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58124 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab1CJNI0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 08:08:26 -0500
In-Reply-To: <4D78B290.7070905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "kalle.jokiniemi@nokia.com" <kalle.jokiniemi@nokia.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ilkka.koskinen@nokia.com" <ilkka.koskinen@nokia.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-344658483-1299762505=:15132
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

On Thu, 10 Mar 2011, Cousson, Benoit wrote:

> On 3/10/2011 11:28 AM, kalle.jokiniemi@nokia.com wrote:
> >=20
> >=20
> > > -----Original Message-----
> > > From: ext Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: 10. maaliskuuta 2011 11:50
> > > To: Jokiniemi Kalle (Nokia-MS/Tampere)
> > > Cc: khilman@ti.com; linux-omap@vger.kernel.org; Koskinen Ilkka (Nokia=
-
> > > MS/Tampere); jhnikula@gmail.com; b-cousson@ti.com
> > > Subject: Re: [PATCH 0/2] OMAP3: wdtimer: fix wdtimer blocking CORE id=
le
> > >=20
> > >=20
> > > Thanks Kalle for tracking this down,
> > >=20
> > > could you try this patch along with the patch from this message:
> > >=20
> > >    http://www.spinics.net/lists/linux-omap/msg48115.html
>=20
> I have some question with that patch.
> By using pm_runtime API, you are suppose to idle the whole IP.
> In this case, just because you cannot idle a wdt that is running, it work=
s,
> but the point is that the pm_runtime state will not reflect the HW state.
> For pm_runtime point of view, the wdt is supposed to be fully idle (both =
fclk
> and iclk). Whereas in that case, only the iclk will be gated.
>=20
> Did I miss something?

Looking at it, I don't know how the old driver managed to work at all. =20
Commit 7ec5ad0f3c1e28b693185c35f768953c5db32291 ("OMAP: WDT: Use PM=20
runtime APIs instead of clk FW APIs") removed this from omap_wdt_probe():

-       /* autogate OCP interface clock */
-       __raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);

This would put the WDTIMER into force-idle, and nothing ever took it out=20
of force-idle.  So I don't quite understand why the PRCM wouldn't just=20
turn off the functional clock to the WDTIMER at this point.  Any thoughts=
=20
on this?


- Paul
--155748971-344658483-1299762505=:15132--
