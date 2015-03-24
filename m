From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] EDMA: TI: fixed memory leak when terminating running
 transfers
Date: Tue, 24 Mar 2015 14:55:05 +0200
Message-ID: <55115EA9.5020000@ti.com>
References: <1427122812-22657-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41029 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbbCXMzT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 08:55:19 -0400
In-Reply-To: <1427122812-22657-1-git-send-email-petr@barix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Petr Kulhavy <petr@barix.com>, vinod.koul@intel.com
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, trivial@kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 03/23/2015 05:00 PM, Petr Kulhavy wrote:
> If edma_terminate_all() was called while a transfer was running (i.e.=
 after
> edma_execute() but before edma_callback()) the echan->edesc was not f=
reed.
>=20
> This was due to the fact that a running transfer is on none of the
> vchan lists: desc_submitted, desc_issued, desc_completed (edma_execut=
e()
> removes it from the desc_issued list), so the vchan_dma_desc_free_lis=
t()
> called at the end of edma_terminate_all() didn't find it and didn't f=
ree it.

It is another question if it is really correct to remove the the curren=
tly
running desc from the issued list in edma_execute().
Based on what I have seen some drivers using virt-dma does this while o=
thers not.

Russel, do you have any advice on this?

Will this work for you to fix the leak:
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 7b65633f495e..ea8544481245 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -162,7 +162,6 @@ static void edma_execute(struct edma_chan *echan)
 			echan->edesc =3D NULL;
 			return;
 		}
-		list_del(&vdesc->node);
 		echan->edesc =3D to_edma_desc(&vdesc->tx);
 	}
=20
@@ -760,6 +759,7 @@ static void edma_callback(unsigned ch_num, u16 ch_s=
tatus, void *data)
 				dev_dbg(dev, "Transfer complete, stopping channel %d\n", ch_num);
 				edesc->residue =3D 0;
 				edma_stop(echan->ch_num);
+				list_del(&edesc->vdesc.node);
 				vchan_cookie_complete(&edesc->vdesc);
 				edma_execute(echan);
 			} else {

> This bug was found on an AM1808 based hardware (very similar to da850=
evm,
> however using the second MMC/SD controller), where intense operations=
 on the SD
> card wasted the device 128MB RAM within a couple of days.
>=20
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---
>  drivers/dma/edma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 276157f..1465610 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -260,6 +260,14 @@ static int edma_terminate_all(struct dma_chan *c=
han)
>  	 */
>  	if (echan->edesc) {
>  		int cyclic =3D echan->edesc->cyclic;
> +
> +		/*
> +		 * free the running request descriptor
> +		 * since it is on none of the vchan lists
> +		 * desc_submitted, desc_issued, desc_completed
> +		 */
> +		kfree(echan->edesc);

If we do this I would prefer to have:
		edma_desc_free(&echan->edesc->vdesc);

> +
>  		echan->edesc =3D NULL;
>  		edma_stop(echan->ch_num);
>  		/* Move the cyclic channel back to default queue */
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
