From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not finish
Date: Fri, 1 Oct 2010 13:41:21 +0300
Message-ID: <201010011341.22238.peter.ujfalusi@nokia.com>
References: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com> <201010011151.52547.peter.ujfalusi@nokia.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C2C0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38891 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723Ab0JAKlb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 06:41:31 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C2C0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Friday 01 October 2010 12:29:54 ext G, Manjunath Kondaiah wrote:
> > But yes, it would make the code much more readable, and we
> > can easily track, which errata has been already addressed.
>=20
> This is already done as a part of dma hwmod which is under review.

OK, so we shall not bother with this in the 'legacy' code, right?

>=20
> -Manjunath

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
