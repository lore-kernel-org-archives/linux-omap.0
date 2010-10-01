From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not finish
Date: Fri, 1 Oct 2010 13:43:35 +0300
Message-ID: <201010011343.35293.peter.ujfalusi@nokia.com>
References: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com> <4CA5AD3A.50700@ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C2E2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50172 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab0JAKnw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 06:43:52 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C2E2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Friday 01 October 2010 12:45:47 ext G, Manjunath Kondaiah wrote:
> > Apologies, but does that mean:
> > a) the errata i541 is handled as well as part of hwmod series?
>=20
> No.
>=20
> > b) the patch needs to be ported ontop of hwmod series?
>=20
> Yes.

I think these fixes should be sent for 2.6.36, and I think it might be =
a good=20
idea to send it for .35, and .34 as well, since this problem most likel=
y can hit=20
those kernels as well.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
