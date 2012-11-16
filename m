From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch
 data
Date: Fri, 16 Nov 2012 15:39:30 -0700
Message-ID: <20121116223930.GA25182@animalcreek.com>
References: <20121018222046.GA28541@animalcreek.com>
 <20121018225540.GB28061@n2100.arm.linux.org.uk>
 <20121018232405.GA29064@animalcreek.com>
 <20121018233335.GC28061@n2100.arm.linux.org.uk>
 <50814B83.7090203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:55971 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab2KPWjb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 17:39:31 -0500
Content-Disposition: inline
In-Reply-To: <50814B83.7090203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

On Fri, Oct 19, 2012 at 02:45:55PM +0200, P=E9ter Ujfalusi wrote:
> Hi,
>=20
> On 10/19/2012 01:33 AM, Russell King - ARM Linux wrote:
> > I would suggest getting some feedback from the ASoC people first, b=
efore
> > trying to invent new APIs to work around this stuff.  If they can l=
ive
> > with having prefetch enabled on OMAP then there isn't an issue here=
=2E  If
> > not, we need a solution to this.
> >=20
> > I do not believe that precisely stopping and starting playback acro=
ss a
> > suspend/resume event is really necessary (it's desirable but the wo=
rld
> > doesn't collapse if you miss a few samples.)  It could be more of a=
n
> > issue for pause/resume though, but as I say, that's for ASoC people=
 to
> > comment on.
>=20
> There is another issue with the prefetch in audio:
> we tend to like to know the position of the DMA and also to know how =
much data
> we have stored in buffers, FIFOs. This information is used by userspa=
ce to do
> echo cancellation and also used by PA for example to do runtime mixin=
g
> directly in the audio buffer. We have means to extract this informati=
on from
> McBSP for example (and from tlv320dac33 codec) but AFAIK this informa=
tion can
> not be retrieved from sDMA.
> We could assume that the sDMA FIFO is kept full and report that as a =
'delay'
> or do not account this information.
>=20
> For now I think the cyclic mode should not set the prefetch. If I rec=
all right
> the cyclic mode is only used by audio at the moment.
>=20
> > I'm merely pointing out here that we need their feedback here befor=
e
> > deciding if there's anything further that needs to happen.
>=20
> Thanks Russell, I'll take a look at the implication of the prefetch f=
or audio.

So how about enabling prefetch for just non-cyclic?


---
=46rom 04b4d7b2d940822af501ea8a6bf265098d2c1810 Mon Sep 17 00:00:00 200=
1
=46rom: "Mark A. Greer" <mgreer@animalcreek.com>
Date: Wed, 17 Oct 2012 18:12:21 -0700
Subject: [PATCH] dmaengine: omap-dma: Allow DMA controller to prefetch =
data
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Enable DMA prefetching for non-cyclic DMAs by setting the
'OMAP_DMA_DST_SYNC_PREFETCH' flag when there is a destination
synchronized DMA transfer.  Prefetching is not allowed on
source synchronized DMA transfers.  It is not allowed on
cyclic DMAs either since that can cause issues with some
users (e.g., suspending/resuming audio).

CC: rmk+kernel@arm.linux.org.uk
CC: P=E9ter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 drivers/dma/omap-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index bb2d8e7..e660f94 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -310,7 +310,7 @@ static struct dma_async_tx_descriptor *omap_dma_pre=
p_slave_sg(
 		dev_addr =3D c->cfg.dst_addr;
 		dev_width =3D c->cfg.dst_addr_width;
 		burst =3D c->cfg.dst_maxburst;
-		sync_type =3D OMAP_DMA_DST_SYNC;
+		sync_type =3D OMAP_DMA_DST_SYNC | OMAP_DMA_DST_SYNC_PREFETCH;
 	} else {
 		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
 		return NULL;
--=20
1.7.12

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
