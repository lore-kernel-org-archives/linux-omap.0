From: "Hald, Ulrik Bech" <ubh@ti.com>
Subject: RE: [PATCH 1/1] OMAP3:WDT:Enable clk in probe, trigger timer reload
Date: Tue, 16 Jun 2009 16:13:36 +0200
Message-ID: <00695C9C8F8B4448856F48142B4AA201BD8D7E32@dnce02.ent.ti.com>
References: <1244822737-20446-1-git-send-email-ubh@ti.com>
	 <87my8dig6e.fsf@deeprootsystems.com>
 <5a7b8b7b0906122057k48f2d16au63adba5278cee04c@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301D810C2A2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35635 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674AbZFPONm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 10:13:42 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301D810C2A2@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Hugo Vincent <hugo.vincent@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev
> Sent: Tuesday, June 16, 2009 8:01 AM
> To: Hugo Vincent; Kevin Hilman
> Cc: Hald, Ulrik Bech; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 1/1] OMAP3:WDT:Enable clk in probe, trigger timer
> reload
>=20
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hugo Vincent
> > Sent: Saturday, June 13, 2009 9:28 AM
> > To: Kevin Hilman
> > Cc: Hald, Ulrik Bech; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 1/1] OMAP3:WDT:Enable clk in probe,
> > trigger timer reload
> >
> > On Sat, Jun 13, 2009 at 4:13 AM, Kevin
> > Hilman<khilman@deeprootsystems.com> wrote:
> > > Ulrik Bech Hald <ubh@ti.com> writes:
> > >
> > >> This patch contains two bugfixes:
> > >>
> > >> 1)In omap_wdt_probe() the watchdog is reset and disabled. This
> > >> requires register access and the clks needs to be enabled
> > temporarily
> > >>
> > >> 2)In omap_wdt_open() the timer register needs to be reloaded
> > >> to trigger a new timer value (the default of 60s)
> > >>
> > >> Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
> > >
> > > Can you change the subject slightly to something like:
> > >
> > > =A0watchdog: OMAP fixes: enable clock in probe, trigger timer rel=
oad
> > >
> > > Also add which OMAP platforms you have tested on since this affec=
ts
> > > OMAP2, OMAP3 and presuably OMAP4.
> >
> > Tested on OMAP3 (OMAP3503, Gumstix Overo).
> >
> > > After that, you can add
> > >
> > > Reviewed-by: Kevin Hilman <khilman@ti.deeprootsystems.com>
> > >
> > > And sent to watchdog maintiner, and CC linux-omap, here's
> > excerpt from
> > > MAINTAINERS:
> > >
> > > WATCHDOG DEVICE DRIVERS
> > > P: =A0 =A0 =A0Wim Van Sebroeck
> > > M: =A0 =A0 =A0wim@iguana.be
> > > T: =A0 =A0 =A0git
> > git://git.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-wa
> tchdog.git
> > > S: =A0 =A0 =A0Maintained
> > > F: =A0 =A0 =A0Documentation/watchdog/
> > > F: =A0 =A0 =A0drivers/watchdog/
> > > F: =A0 =A0 =A0include/linux/watchdog.h
> > >
> > >> ---
> > >> =A0drivers/watchdog/omap_wdt.c | =A0 =A07 +++++++
> > >> =A01 files changed, 7 insertions(+), 0 deletions(-)
> > >> =A0mode change 100644 =3D> 100755 drivers/watchdog/omap_wdt.c
> > >>
> > >> diff --git a/drivers/watchdog/omap_wdt.c
> > b/drivers/watchdog/omap_wdt.c
>=20
> > >> old mode 100644
> > >> new mode 100755
>=20
> This change is also unnecessary.
> Can be avoided in the follow-up submission.
>=20
> ~sanjeev
Thanks for pointing it out Sanjeev. I am submitting a version 3 with th=
e correction now.

/Ulrik

>=20
> > >> index f271385..3ed571a
> > >> --- a/drivers/watchdog/omap_wdt.c
> > >> +++ b/drivers/watchdog/omap_wdt.c
> > >> @@ -159,6 +159,7 @@ static int omap_wdt_open(struct inode
> > *inode, struct file *file)
> > >> =A0 =A0 =A0 file->private_data =3D (void *) wdev;
> > >>
> > >> =A0 =A0 =A0 omap_wdt_set_timeout(wdev);
> > >> + =A0 =A0 omap_wdt_ping(wdev); /* trigger loading of new
> > timeout value */
> > >> =A0 =A0 =A0 omap_wdt_enable(wdev);
> > >>
> > >> =A0 =A0 =A0 return nonseekable_open(inode, file);
> > >> @@ -313,6 +314,9 @@ static int __devinit
> > omap_wdt_probe(struct platform_device *pdev)
> > >>
> > >> =A0 =A0 =A0 platform_set_drvdata(pdev, wdev);
> > >>
> > >> + =A0 =A0 clk_enable(wdev->ick);
> > >> + =A0 =A0 clk_enable(wdev->fck);
> > >> +
> > >> =A0 =A0 =A0 omap_wdt_disable(wdev);
> > >> =A0 =A0 =A0 omap_wdt_adjust_timeout(timer_margin);
> > >>
> > >> @@ -332,6 +336,9 @@ static int __devinit
> > omap_wdt_probe(struct platform_device *pdev)
> > >> =A0 =A0 =A0 /* autogate OCP interface clock */
> > >> =A0 =A0 =A0 __raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CO=
NFIG);
> > >>
> > >> + =A0 =A0 clk_disable(wdev->ick);
> > >> + =A0 =A0 clk_disable(wdev->fck);
> > >> +
> > >> =A0 =A0 =A0 omap_wdt_dev =3D pdev;
> > >>
> > >> =A0 =A0 =A0 return 0;
> > >> --
> > >> 1.5.4.3
> > >>
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" in
> > >> the body of a message to majordomo@vger.kernel.org
> > >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
