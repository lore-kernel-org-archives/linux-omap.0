From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 02/13] dmaengine: edma: Optimize memcpy operation
Date: Wed, 14 Oct 2015 18:02:18 +0300
Message-ID: <561E6E7A.6080408@ti.com>
References: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
 <1444828344-21378-3-git-send-email-peter.ujfalusi@ti.com>
 <20151014144105.GV27370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151014144105.GV27370@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On 10/14/2015 05:41 PM, Vinod Koul wrote:
> On Wed, Oct 14, 2015 at 04:12:13PM +0300, Peter Ujfalusi wrote:
>> @@ -1320,41 +1317,92 @@ static struct dma_async_tx_descriptor *edma_=
prep_dma_memcpy(
>>  	struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>>  	size_t len, unsigned long tx_flags)
>>  {
>> -	int ret;
>> +	int ret, nslots;
>>  	struct edma_desc *edesc;
>>  	struct device *dev =3D chan->device->dev;
>>  	struct edma_chan *echan =3D to_edma_chan(chan);
>> -	unsigned int width;
>> +	unsigned int width, pset_len;
>> =20
>>  	if (unlikely(!echan || !len))
>>  		return NULL;
>> =20
>> -	edesc =3D kzalloc(sizeof(*edesc) + sizeof(edesc->pset[0]), GFP_ATO=
MIC);
>> +	if (len < SZ_64K) {
>> +		/*
>> +		 * Transfer size less than 64K can be handled with one paRAM
>> +		 * slot. ACNT =3D length
>> +		 */
>> +		width =3D len;
>> +		pset_len =3D len;
>> +		nslots =3D 1;
>> +	} else {
>> +		/*
>> +		 * Transfer size bigger than 64K will be handled with maximum of
>> +		 * two paRAM slots.
>> +		 * slot1: ACNT =3D 32767, length1: (length / 32767)
>> +		 * slot2: the remaining amount of data.
>> +		 */
>> +		width =3D SZ_32K - 1;
>> +		pset_len =3D rounddown(len, width);
>> +		/* One slot is enough for lengths multiple of (SZ_32K -1) */
>=20
> Hmm so does this mean if I have 140K transfer, it will do two 64K for=
 1st
> slot and 12K in second slot ?

Not exactly. If the size is less than 64K it can be done with one 'burs=
t' but
if it is bigger we need to have two sets of transfer:
1. 32K blocks
2. the remaining data

so in case of 140K:
4 x 32K followed by 12K

>=20
> Is there a limit on 'blocks' of 64K we can do here?

32767 32K blocks is the limit.

The 64K burst is only possible if the whole transfer is less less than =
64K.
With the ACNT counter we can transfer 64K - 1 bytes, but if this is not=
 enough
we need to use the BCNT counter and for that to work the the distance b=
etween
the start of 'slot n' and the start of 'slot n+1' need to be less than =
32K,
this is the reason why we have 32K 'blocks' to transfer first followed =
by the
remaining.

--=20
P=E9ter
