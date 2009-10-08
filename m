From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for v2.6.32-rc3
Date: Thu, 8 Oct 2009 14:41:41 -0700
Message-ID: <20091008214140.GJ7417@atomide.com>
References: <20091007185112.GJ7899@atomide.com> <94a0d4530910081429m7ad88b43q38245109f3252078@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59923 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023AbZJHVm2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 17:42:28 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530910081429m7ad88b43q38245109f3252078@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Felipe Contreras <felipe.contreras@gmail.com> [091008 14:29]:
> On Wed, Oct 7, 2009 at 9:51 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> > Linus,
> >
> > Please pull omap fixes from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6=
=2Egit omap-fixes-for-linus
> >
> > Regards,
> >
> > Tony
> >
> >
> > The following changes since commit 374576a8b6f865022c0fd1ca62396889=
b23d66dd:
> > =A0Linus Torvalds (1):
> > =A0 =A0 =A0 =A0Linux 2.6.32-rc3
> >
> > are available in the git repository at:
> >
> > =A0git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-=
2.6.git omap-fixes-for-linus
> >
> > Artem Bityutskiy (1):
> > =A0 =A0 =A0OMAP3: PM: introduce a new powerdomain walk helper
> >
> > Daniel Walker (1):
> > =A0 =A0 =A0omap: iovmm: Add missing mutex_unlock
> >
> > Hiroshi DOYU (1):
> > =A0 =A0 =A0omap: iovmm: Fix incorrect spelling
> >
> > Jon Hunter (1):
> > =A0 =A0 =A0OMAP3: PM: Prevent hang in prcm_interrupt_handler
> >
> > Kevin Hilman (1):
> > =A0 =A0 =A0OMAP3: PM: Enable GPIO module-level wakeups
> >
> > Paul Walmsley (2):
> > =A0 =A0 =A0OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
> > =A0 =A0 =A0OMAP3: PM: PRCM interrupt: only handle selected PRCM int=
errupts
> >
> > Rajendra Nayak (1):
> > =A0 =A0 =A0omap: Lock DPLL5 at boot
> >
> > Sergio Aguirre (1):
> > =A0 =A0 =A0omapfb: Condition mutex acquisition
> >
> > Tommi Rantala (2):
> > =A0 =A0 =A0omapfb: Blizzard: fix pointer to be const
> > =A0 =A0 =A0omapfb: Blizzard: constify register address tables
> >
> > Tony Lindgren (2):
> > =A0 =A0 =A0omap: Fix incorrect 730 vs 850 detection
> > =A0 =A0 =A0Merge branch 'pm-fixes-32' of git://git.kernel.org/.../k=
hilman/linux-omap-pm into omap-fixes-for-linus
> >
> > Vikram Pandita (1):
> > =A0 =A0 =A0OMAP3: PM: USBHOST: clear wakeup events on both hosts
> >
> > ye janboe (1):
> > =A0 =A0 =A0omap: SRAM: flush the right address after memcpy in omap=
_sram_push
>=20
> The beagleboard is still not booting for me with this branch, I need
> to add these two patches:
>=20
> * http://patchwork.kernel.org/patch/50721/
>=20

This should go to the mainline kernel via Samuel as it's
drivers/mfd related.

> This one is needed because the defconfig has:
> CONFIG_TWL4030_USB=3Dy
>=20
> * http://patchwork.kernel.org/patch/50970/
>=20
> This is needed because most people boot from an MMC.

And this should go in via the mmc list.

So little more patience is still needed :)

Cheers,

Tony

>=20
> You can add my 'tested-by' line if you want.
>=20
> Cheers.
>=20
> --=20
> Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
