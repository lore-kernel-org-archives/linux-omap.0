From: "Keppler Alecrim" <alecrim@gmail.com>
Subject: Re: OMAP MMC multiport support
Date: Wed, 19 Mar 2008 20:53:48 +0200
Message-ID: <309201e0803191153j600503eflbf6dc8845bc4205b@mail.gmail.com>
References: <814dfab70803180547i37859e48o5bdf33212ff7cd51@mail.gmail.com>
	 <20080318115247.GE7843@atomide.com>
	 <7EAD1AEEA7621C45899FE99123E124A0017B21ED@dbde01.ent.ti.com>
	 <20080318134637.GA24660@ubuntu-workstation>
	 <7EAD1AEEA7621C45899FE99123E124A0017B2202@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:28686 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504AbYCSTxX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 15:53:23 -0400
Received: by py-out-1112.google.com with SMTP id u52so742575pyb.10
        for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 12:53:20 -0700 (PDT)
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0017B2202@dbde01.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: Seth Forshee <seth.forshee@gmail.com>, Remith Ravi <remithmailinglist@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

What about DMA channel? Isn't it necessary?

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 3d4a7d1..262d846 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -514,10 +514,18 @@ mmc_omap_start_dma_transfer(struct mmc_omap_host
*host, struct mmc_request *req)

 	if (!(data->flags & MMC_DATA_WRITE)) {
 		host->dma_dir = DMA_FROM_DEVICE;
-		sync_dev = OMAP24XX_DMA_MMC1_RX;
+		if (host->id == OMAP_MMC1_DEVID)
+			sync_dev = OMAP24XX_DMA_MMC1_RX;
+		else
+			sync_dev = OMAP24XX_DMA_MMC2_RX;
+
 	} else {
 		host->dma_dir = DMA_TO_DEVICE;
-		sync_dev = OMAP24XX_DMA_MMC1_TX;
+		if (host->id == OMAP_MMC1_DEVID)
+			sync_dev = OMAP24XX_DMA_MMC1_TX;
+		else
+			sync_dev = OMAP24XX_DMA_MMC2_TX;
+
 	}



On Tue, Mar 18, 2008 at 3:57 PM, Syed Mohammed, Khasim <khasim@ti.com> wrote:
>
>
>  > -----Original Message-----
>  > From: Seth Forshee [mailto:seth.forshee@gmail.com]
>  > Sent: Tuesday, March 18, 2008 7:17 PM
>  > To: Syed Mohammed, Khasim; Remith Ravi
>  > Cc: Tony Lindgren; linux-omap@vger.kernel.org
>  > Subject: Re: OMAP MMC multiport support
>  >
>
> > The current code needs a little bit of updating to support the second
>  > MMC controller on the 2430.  Below is a rough patch with the changes
>  > that get it working for me (on a custom board), but it is not based
>  > off of the git repo so it's not likely to apply directly.  Hopefully
>  > it will be helpful as a reference though.
>  >
>  > Cheers,
>  > Seth
>  >
>  Seth,
>
>  This looks ok to me, can you please do some cleanups and submit this patch to Tony for getting it onto tree?
>
>  Thanks for the patch.
>
>  Regards,
>  Khasim
>
>
> --
>  To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
-- 
Francisco Keppler Silva Alecrim
OSMRC - INdT - Manaus
http://franciscoalecrim.com/
