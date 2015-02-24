From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/6] dmaengine: omap-dma: Take DMA request number from
 DT if it is available
Date: Tue, 24 Feb 2015 16:28:42 +0200
Message-ID: <54EC8A9A.5030005@ti.com>
References: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com> <1424787683-19151-5-git-send-email-peter.ujfalusi@ti.com> <20150224142557.GH8670@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224142557.GH8670@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On 02/24/2015 04:25 PM, Russell King - ARM Linux wrote:
> On Tue, Feb 24, 2015 at 04:21:21PM +0200, Peter Ujfalusi wrote:
>> Use the dma-requests property from DT to get the number of DMA reque=
sts.
>> In case of legacy boot or failure to find the property, use the defa=
ult
>> 127 as number of requests.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/omap-dma.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
>> index 56c33e93dd24..7def31c919f4 100644
>> --- a/drivers/dma/omap-dma.c
>> +++ b/drivers/dma/omap-dma.c
>> @@ -34,6 +34,7 @@ struct omap_dmadev {
>>  	const struct omap_dma_reg *reg_map;
>>  	struct omap_system_dma_plat_info *plat;
>>  	bool legacy;
>> +	unsigned dma_requests;
>>  	spinlock_t irq_lock;
>>  	uint32_t irq_enable_mask;
>>  	struct omap_chan *lch_map[OMAP_SDMA_CHANNELS];
>> @@ -1118,7 +1119,15 @@ static int omap_dma_probe(struct platform_dev=
ice *pdev)
>> =20
>>  	tasklet_init(&od->task, omap_dma_sched, (unsigned long)od);
>> =20
>> -	for (i =3D 0; i < OMAP_SDMA_REQUESTS; i++) {
>> +	if (!pdev->dev.of_node || of_property_read_u32(pdev->dev.of_node,
>> +						       "dma-requests",
>> +						       &od->dma_requests)) {
>> +		dev_info(&pdev->dev,
>> +			 "DMA request lines not specified, using 127\n");
>> +		od->dma_requests =3D 127;
>=20
> What happened to OMAP_SDMA_REQUESTS?
>=20
> If you're not going to use OMAP_SDMA_REQUESTS, then don't add it.  If
> you are going to use it, please also change the dev_info() line to us=
e
> that macro too.

Aargh, yes you are right. Will fix this up in v2.

--=20
P=E9ter
