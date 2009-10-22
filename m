From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] OMAP3: DVFS: No sdrc AC timing changes during core dvfs
Date: Thu, 22 Oct 2009 07:20:19 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B459718@dlee02.ent.ti.com>
References: <1254835224-19500-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.0910201918230.22645@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE8967162039B3CF012@dlee02.ent.ti.com>
 <74583B8642AB8841B30447520659FCA9DDD9D7E9@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54703 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754773AbZJVMVU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 08:21:20 -0400
In-Reply-To: <74583B8642AB8841B30447520659FCA9DDD9D7E9@dnce01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Beonit,

> From: Cousson, Benoit
> Sent: Thursday, October 22, 2009 3:59 AM
> To: Woodruff, Richard; Paul Walmsley; Nayak, Rajendra

> >It is not guaranteed safe to write actim registers on the fly to an =
active
> >part.  It is safe to do RFR as it is buffered and sent out at a safe=
 time.
>
> I think that what Paul is suggesting is to change the ACTIM after ens=
uring
> that the DDR is in self-refresh. In that case it is perfectly valid; =
it is
> just tricky to ensure that all initiators are in mute before doing th=
at.

Yes that is true, however, ...

That is not the way the code is setup and it=92s a long way from that. =
 Run time pause of drivers is a minefield.

With out a broad notifier they best you would hope for is some opportun=
istic change time (against full system).  You wouldn't have a guarantee=
d way to speed them up again where you need them most at high opp.

Some minimal kernel not using dma and the like could do it but that is =
probably more misleading to put in the tree than something useful for m=
ost.

Regards,
Richard W.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
