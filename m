From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dma: omap-dma: Implement device_slave_caps callback
Date: Thu, 13 Mar 2014 09:48:49 +0200
Message-ID: <532162E1.8090608@ti.com>
References: <1394199404-7870-1-git-send-email-peter.ujfalusi@ti.com> <20140312173700.GA1996@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57074 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbaCMHtD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 03:49:03 -0400
In-Reply-To: <20140312173700.GA1996@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org

Hi Tony,

On 03/12/2014 07:37 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [140307 05:39]:
>> With the callback implemented omap-dma can provide information to cl=
ient
>> drivers regarding to supported address widths, directions, residue
>> granularity, etc.
>=20
> This may need some testing against linux next with Russell's
> omap-dma.c clean-up series merged there. Peter, care to check
> if this patch is still valid against linux next?

The patch applies cleanly on top of linux-next fetched yesterday and I =
see
Russell's patches underneath.

--=20
P=E9ter

>=20
> Regards,
>=20
> Tony
> =20
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/omap-dma.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
>> index 64ceca2920b8..b19f04f4390b 100644
>> --- a/drivers/dma/omap-dma.c
>> +++ b/drivers/dma/omap-dma.c
>> @@ -1088,6 +1088,23 @@ static void omap_dma_free(struct omap_dmadev =
*od)
>>  	}
>>  }
>> =20
>> +#define OMAP_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
>> +				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
>> +				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
>> +
>> +static int omap_dma_device_slave_caps(struct dma_chan *dchan,
>> +				      struct dma_slave_caps *caps)
>> +{
>> +	caps->src_addr_widths =3D OMAP_DMA_BUSWIDTHS;
>> +	caps->dstn_addr_widths =3D OMAP_DMA_BUSWIDTHS;
>> +	caps->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>> +	caps->cmd_pause =3D true;
>> +	caps->cmd_terminate =3D true;
>> +	caps->residue_granularity =3D DMA_RESIDUE_GRANULARITY_BURST;
>> +
>> +	return 0;
>> +}
>> +
>>  static int omap_dma_probe(struct platform_device *pdev)
>>  {
>>  	struct omap_dmadev *od;
>> @@ -1118,6 +1135,7 @@ static int omap_dma_probe(struct platform_devi=
ce *pdev)
>>  	od->ddev.device_prep_slave_sg =3D omap_dma_prep_slave_sg;
>>  	od->ddev.device_prep_dma_cyclic =3D omap_dma_prep_dma_cyclic;
>>  	od->ddev.device_control =3D omap_dma_control;
>> +	od->ddev.device_slave_caps =3D omap_dma_device_slave_caps;
>>  	od->ddev.dev =3D &pdev->dev;
>>  	INIT_LIST_HEAD(&od->ddev.channels);
>>  	INIT_LIST_HEAD(&od->pending);
>> --=20
>> 1.9.0
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
