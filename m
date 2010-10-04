From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v3 1/2] omap: dma: Fix buffering disable bit setting for omap24xx
Date: Mon, 4 Oct 2010 10:41:47 +0300
Message-ID: <201010041041.47991.peter.ujfalusi@nokia.com>
References: <1285936577-14881-1-git-send-email-peter.ujfalusi@nokia.com> <201010041015.35457.peter.ujfalusi@nokia.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C95A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:62549 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab0JDHlt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 03:41:49 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C95A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>

On Monday 04 October 2010 10:36:16 ext G, Manjunath Kondaiah wrote:
> > are going to have:
> > DMA_ERRATA_i541_OMAP2, and DMA_ERRATA_i541_OMAP3 to
>=20
> For OMAP2, you should use "DMA_ERRATA_IFRAME_BUFFERING" since it is
> different type of issue.

Thanks!
I'll do that.

>=20
> -Manjunath

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
