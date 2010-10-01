From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not finish
Date: Fri, 1 Oct 2010 11:51:52 +0300
Message-ID: <201010011151.52547.peter.ujfalusi@nokia.com>
References: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com> <1285915146-18511-3-git-send-email-peter.ujfalusi@nokia.com> <4CA59188.5020904@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29721 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab0JAIwH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 04:52:07 -0400
In-Reply-To: <4CA59188.5020904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Friday 01 October 2010 10:45:12 ext Nishanth Menon wrote:
=2E..
> > -	l &=3D ~OMAP_DMA_CCR_EN;
> > -	dma_write(l, CCR(lch));
> > +	/* OMAP3 Errata: sDMA FIFO draining does not finish */
>=20
> would be informative to give the iXYZ id as well for some of these
> erratas might scale across processors.

In TI's site I was only able to find this public ERRATA:
OMAP3530/25/15/03 Applications Processor Silicon Errata-Revs 3.1, 3.0, =
2.1,&2.0=20
(Rev. E)
In that document it is under: Advisory 3.1.1.192, but no iXYZ is associ=
ated with=20
it. However I have another ERRATA document, which has the iXYZ associat=
ed with=20
this advisory, but the first page tells that it is confidential, and un=
der NDA=20
restriction. I'm not really sure, if I should refere to that number...
But if you have the iXYZ number, which I can use, than I'm more than ha=
ppy to=20
add that.

> > +	if (cpu_is_omap34xx() && (l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
>=20
> does it make sense to use an dma_errata variable and populate it?

Hmmm, the errata handling via dma_errata shall be done separately IMHO,
since if we do that, than we need to revisit other parts of the code as=
 well,=20
and replace the existing errata handling.

But yes, it would make the code much more readable, and we can easily t=
rack,=20
which errata has been already addressed.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
