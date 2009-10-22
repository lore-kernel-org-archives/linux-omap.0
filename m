From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH resend] OMAP1: AMS_DELTA: Fix DSP public peripherals
	support
Date: Thu, 22 Oct 2009 12:22:26 -0700
Message-ID: <20091022192225.GT16230@atomide.com>
References: <200910220222.55900.jkrzyszt@tis.icnet.pl> <200910221421.33875.jkrzyszt@tis.icnet.pl> <20091022180659.GP16230@atomide.com> <200910222115.27719.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62368 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662AbZJVTW0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 15:22:26 -0400
Content-Disposition: inline
In-Reply-To: <200910222115.27719.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jonathan McDowell <noodles@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091022 12:15]:
> Thursday 22 October 2009 20:06:59 Tony Lindgren napisa=C5=82(a):
> > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091022 05:22]:
> > > DSP public peripherals used to work on OMAP1510 based (or all OMA=
P1 class?)
> > > machines as long as old dspgateway code were present in the l-o t=
ree. For
> > > several months it is no longer included, breaking support for McB=
SP1 based
> > > audio on Amstrad Delta, for example.
> > >=20
> > > This patch, derived from the old dspgateway code, corrects the pr=
oblem for the
> > > board by simply taking the DSP out of reset state, I guess. That =
way, things
> > > should not break when a new dsp code is added to the tree, and th=
e change can
> > > be reverted then.
> >=20
> > Seems like a good fix.
>=20
> Tony,
> Does it mean that you can push it as a fix for 2.6.32? That would be =
great if my successfull efforts on getting audio support for Amstrad De=
lta included in the mainline tree would result in a fully functional so=
lution!

Yeah we should be able to merge those as fixes.
=20
> I start preparing a new ams_delta_defconfig then.

Cool :)

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
