From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 05/10] omap1: Fix DSP public peripherals support for ams-delta
Date: Sat, 24 Oct 2009 01:11:07 +0200
Message-ID: <200910240111.10604.jkrzyszt@tis.icnet.pl>
References: <20091022221013.27408.443.stgit@localhost> <4AE0E938.7080305@ti.com> <20091023191939.GJ16230@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:47241 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbZJWXOY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 19:14:24 -0400
In-Reply-To: <20091023191939.GJ16230@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

=46riday 23 October 2009 21:19:40 Tony Lindgren napisa=C5=82(a):
> * Jon Hunter <jon-hunter@ti.com> [091022 16:22]:
> >
> > Tony Lindgren wrote:
> >> From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> >>
> >> DSP public peripherals used to work on OMAP1510 based (or all OMAP=
1 class?)
> >> machines as long as old dspgateway code were present in the l-o tr=
ee. For
> >> several months it is no longer included, breaking support for McBS=
P1 based
> >> audio on Amstrad Delta, for example.
> >>
> >> This patch, derived from the old dspgateway code, corrects the pro=
blem for the
> >> board by simply taking the DSP out of reset state, I guess. That w=
ay, things
> >> should not break when a new dsp code is added to the tree, and the=
 change can
> >> be reverted then.
> >
> > A minor comment/correction here. Although this bit is called "DSP_R=
ST" =20
> > this does not actually release the DSP from reset. This bit actuall=
y =20
> > releases the reset for the "priority registers (TIPB module), EMIF =
=20
> > configuration registers, and the MPUI control logic (partially) in =
the =20
> > DSP", thus allowing you to access the DSP peripherals via the MPUI.=
 Bit =20
> > 1 of the same register, called "DSP_EN", actually releases the DSP =
reset.
>=20
> Thanks for clarifying that.

=46orgive me my ignorance: do you think that there is still an option o=
f putting any related piece of hardware in an idle state, as you, Tony,=
 has suggested before for the DSP itslef?

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
