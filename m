From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Add D2D clockdomain on OMAP3 ES2+
Date: Wed, 28 May 2008 13:42:16 -0700
Message-ID: <20080528204216.GK8845@atomide.com>
References: <20080522173035.1292.74243.stgit@localhost.localdomain> <87wsllmt6q.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:65202 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbYE1UmV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 16:42:21 -0400
Content-Disposition: inline
In-Reply-To: <87wsllmt6q.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>
Cc: ext Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

* H=F6gander Jouni <jouni.hogander@nokia.com> [080522 23:27]:
> "ext Paul Walmsley" <paul@pwsan.com> writes:
>=20
> > Hello,
> >
> > This patch series adds D2D (die-to-die) clockdomain handling into
> > OMAP3 ES2+ builds.  It seems the D2D clockdomain logic is still
> > present on the chip and must be manually programmed to allow the
> > CORE_D2D clockdomain to go inactive.
> >
> > For this to work, the pm34xx.c code also had to be modified to use =
the
> > pwrdm_for_each_clkdm() iterator, lest the existing for-loop fall of=
f
> > the end of pwrdm->pwrdm_clkdms[].  This also should fix an oops wit=
h
> > CONFIG_PM on any 3430ES1 boards out there.
>=20
> That loop was a good catch, thanks.
>=20
> Both patches acked.

Pushing both today.

Tony

>=20
> >
> > Tested on 3430SDP ES2.0.
> >
> >
> > - Paul
> >
> >
> > diffstat:
> >  arch/arm/mach-omap2/clockdomains.h |    9 ++++++++-
> >  arch/arm/mach-omap2/pm34xx.c       |   23 ++++++++++++++++++-----
> >  2 files changed, 26 insertions(+), 6 deletions(-)
> >
> > size:
> >    text    data     bss     dec     hex filename
> > 3280225  155416   98792 3534433  35ee61 vmlinux.3430sdp.orig
> > 3280305  155416   98792 3534513  35eeb1 vmlinux.3430sdp.patched
> >
>=20
> --=20
> Jouni H=F6gander
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
