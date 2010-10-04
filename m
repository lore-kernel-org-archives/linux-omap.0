From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v3 1/2] omap: dma: Fix buffering disable bit setting for omap24xx
Date: Mon, 4 Oct 2010 10:15:35 +0300
Message-ID: <201010041015.35457.peter.ujfalusi@nokia.com>
References: <1285936577-14881-1-git-send-email-peter.ujfalusi@nokia.com> <201010040915.27745.peter.ujfalusi@nokia.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C8C2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55682 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0JDHQA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 03:16:00 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C8C2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>

On Monday 04 October 2010 09:23:18 ext G, Manjunath Kondaiah wrote:
> No errata numbers numbers used with TI errata documents till omap2430=
=2E
> Errata numbers avaialable from omap3430 onwards.
>=20
> > For OMAP3 the errata number is i541, but I do not know the
> > iXYZ number for OMAP2 class.
>=20
> Being said that no errata numbers for omap2 class, it's ok to use
> omap3 errata numbers for common errata(like your patch 2/2)

Thanks,
we are going to use the same errata ID for OMAP2, and OMAP3, but going =
to use=20
different workaround for them:
OMAP2: disable buffering
OMAP3: implement the workaround as it is in the errata

So, as Tony suggested, I'll add the errata handling, and
we are going to have:
DMA_ERRATA_i541_OMAP2, and DMA_ERRATA_i541_OMAP3 to differentiate the d=
ifferent=20
workarounds. We can than experiment, and we might use the OMAP3 workaro=
und for=20
OMAP2 as well.

I'll send the v4 series shortly (after testing).

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
