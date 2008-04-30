From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PRCM: Combine 34xx l3_icks and l4_icks
Date: Tue, 29 Apr 2008 17:32:14 -0700
Message-ID: <20080430003214.GF8981@atomide.com>
References: <873ap69ybi.fsf@trdhcp146196.ntc.nokia.com> <alpine.DEB.1.00.0804290057130.5853@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:60221 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002AbYD3AcR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 20:32:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804290057130.5853@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org, igor.stoppa@nokia.com

* Paul Walmsley <paul@pwsan.com> [080428 23:58]:
> On Mon, 28 Apr 2008, H=F6gander Jouni wrote:
>=20
> > E.g dss_l3_ick and dss_l4_ick have same gating control. Having own
> > clock for both of them causes race condition between enable / disab=
le.
> >=20
> > This patch combines this kind of clocks and names new clock as <mod=
ule>_ick.
> >=20
> > Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>=20
> Acked-by: Paul Walmsley <paul@pwsan.com>
>=20
> although it's less of a race issue, than it is a convenience issue fo=
r=20
> OMAP2/3 device driver folks...

Pushing today, with Felipe's fix merged into this.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
