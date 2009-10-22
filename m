From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH resend] OMAP1: AMS_DELTA: Fix DSP public peripherals support
Date: Thu, 22 Oct 2009 21:15:24 +0200
Message-ID: <200910222115.27719.jkrzyszt@tis.icnet.pl>
References: <200910220222.55900.jkrzyszt@tis.icnet.pl> <200910221421.33875.jkrzyszt@tis.icnet.pl> <20091022180659.GP16230@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:46671 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756640AbZJVTPw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 15:15:52 -0400
In-Reply-To: <20091022180659.GP16230@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jonathan McDowell <noodles@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

Thursday 22 October 2009 20:06:59 Tony Lindgren napisa=C5=82(a):
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091022 05:22]:
> > DSP public peripherals used to work on OMAP1510 based (or all OMAP1=
 class?)
> > machines as long as old dspgateway code were present in the l-o tre=
e. For
> > several months it is no longer included, breaking support for McBSP=
1 based
> > audio on Amstrad Delta, for example.
> >=20
> > This patch, derived from the old dspgateway code, corrects the prob=
lem for the
> > board by simply taking the DSP out of reset state, I guess. That wa=
y, things
> > should not break when a new dsp code is added to the tree, and the =
change can
> > be reverted then.
>=20
> Seems like a good fix.

Tony,
Does it mean that you can push it as a fix for 2.6.32? That would be gr=
eat if my successfull efforts on getting audio support for Amstrad Delt=
a included in the mainline tree would result in a fully functional solu=
tion!

I start preparing a new ams_delta_defconfig then.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
