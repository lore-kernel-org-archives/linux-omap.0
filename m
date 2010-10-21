From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v5 0/3] OMAP2/3: DMA: FIFO drain errata fixes
Date: Thu, 21 Oct 2010 13:05:17 +0300
Message-ID: <201010211305.17559.peter.ujfalusi@nokia.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com> <20101005181525.GL3117@atomide.com> <20101008221746.GS7558@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:57515 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab0JUKFp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 06:05:45 -0400
In-Reply-To: <20101008221746.GS7558@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>

Sorry, I did missed this mail...

On Saturday 09 October 2010 01:17:46 ext Tony Lindgren wrote:

> Guys, as we're so late into getting 2.6.36 tagged, I'm thinking about=
 just
> queueing these for 2.6.37 for the following reasons:
>=20
> - The 24xx patch is a fix for commit c12abc0 that's was merged over a
>   year ago. We've lived with it for over a year now. What difference =
does
>   extra few more months make if we have it in 2.6.37 instead of 2.6.3=
6?
>=20
> - The second 34xx fix seems to happen only when disabling DMA on the =
fly.
>   Again, we've had support for 34xx in the mainline kernel for a few
>   years, and we're not seeing unrecoverable issues with MMC or USB or
>   any other code calling omap_dma_stop().
>=20
> Sure these fix major issues with the DMA, but are these really critic=
al
> for 2.6.36?
>=20
> So if you really want me to argue for merging these into 2.6.36, plea=
se let
> me know some oops causing cases or data corruption that happens witho=
ut
> these patches.

Well 2.6.36 is released.
I still would like to see this to be part of the 2.6.36.1 release. We c=
an=20
reproduce the DMA error in 2.6.36 with audio.

Tony: can you make sure it is going to part of 2.6.36.1?

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
