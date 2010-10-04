From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v4 4/4] OMAP3: DMA: Errata i541: sDMA FIFO draining does not finish
Date: Mon, 4 Oct 2010 13:42:32 +0300
Message-ID: <201010041342.33238.peter.ujfalusi@nokia.com>
References: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com> <1286180294-32618-5-git-send-email-peter.ujfalusi@nokia.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CA49@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:54240 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab0JDKmp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 06:42:45 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CA49@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Monday 04 October 2010 12:17:41 ext G, Manjunath Kondaiah wrote:
>=20
> ...
>=20
> > +	/* OMAP3 Errata i541: sDMA FIFO draining does not finish */
>=20
> This logic is required for multiple erratas.

As Tony requested, I have added a variable for flags to handle the diff=
erent=20
erratas. I even added a macro to check that the errata applies, so one =
can use:
if (IS_DMA_ERRATA(DMA_ERRATA_XXXXX))

> Can we have seperate
> function for handling this logic. More details at:
> https://patchwork.kernel.org/patch/126271/

I see. That patch is for hwmod converted dma code, right?
We need this fix without the hwmod to applied, and than backport it to =
earlier=20
kernel releases.

> As I mentioned in other mail, if you are introducing this feature,
> it is better to convert existing erratas also to use this feature.

The upcoming hwmod conversion will take care of the cleanup.
We _need_ these two small fixes ASAP, since it is fixing serious proble=
m in=20
audio (and the same issue might bite other areas as well).
It is not the intention of this series to clean up the arc/arm/plat-oma=
p/dma.c.

I have added the dma_errata variable, since Tony asked for it, but even=
 that=20
addition is a bigger change than what I was planning to do here.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
