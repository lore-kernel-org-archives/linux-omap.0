From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/5] dmaengine: Support for querying maximum trasnfer
 length (of an SG element)
Date: Wed, 11 Oct 2017 18:47:18 +0300
Message-ID: <faec0874-7321-c6ce-8201-f919aaeaf248@ti.com>
References: <20170912104424.18495-1-peter.ujfalusi@ti.com>
 <20170912104424.18495-4-peter.ujfalusi@ti.com>
 <20170921171451.GG30097@localhost>
 <02509904-4ae8-c6f8-3514-5f77d665c9a6@ti.com>
 <20170926165413.GQ30097@localhost>
 <11471508-b61c-7842-2080-7f5c2f292c2b@ti.com>
 <20171008052514.GG30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171008052514.GG30097@localhost>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

=EF=BB=BF
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 10/08/2017 08:25 AM, Vinod Koul wrote:
>>>> It is not really static, the size in bytes depends on the dev_width an=
d
>>>> the maxburst:
>>>> dev_width * burst * (SZ_64K - 1);
>>>
>>> well DMAengines work on FIFOs, in above you are giving length as SZ_64K=
 - 1
>>> 'items' which IIUC in DMAengine terms for bytes would always refer wrt =
width
>>> used and burst applied.
>>
>> I think we can live with this and let the user to figure out what to do
>> with this information.
>=20
> Right, plus a macro for conversion :) SO that users dont code buggy
> conversions all over the place

OK, but still the naming... ;)

>> But I'm having hard time to figure out a good name for this. It is not
>> the number of SGs we can support, but the number of 'items' within one
>> SG that we have the limit. It could be:
>> u32 max_bursts_per_sg;
>=20
> this looks fine, another candidate I would use is words_per_sg and while =
at
> it why tie it to sg? should we make it words_per_txn but then people shou=
ld not
> confuse with txn represented by a descriptor which can have multiple ....

Yes, this limit is not only per SG as the same limit actually applies to
cyclic's period_len in a same way.

words_per_txn does not sound right as for me the words would refer to
dev_width number of bytes and I'm seeking on limit on the number of (dev_wi=
dth
* bursts) sub-chunks.

bursts_per_chunk? With a long comment?

Which would apply to sg_dma_len in slave_sg(), period_len in cyclic() and l=
en
in slave_single().

>>
>> which would also apply to period length (for cyclic) in a similar way.
>>
>>> Return length in bytes does make sense (from user PoV), but then you ne=
ed to
>>> "know" the applied  width and burst. How do you decide those?
>>
>> The number of items works eDMA and sDMA, but we also have the cpp41. It
>> is a packet DMA and it has no understanding of bursts, address widths or
>> any of the 'traditional' things. It only cares about the number of bytes
>> we want to transfer and it has limitation of 4194303 bytes (21bits for
>> length). This is again per SG. How this could report the
>> 'max_bursts_per_sg' ?
>=20
> hmmm that is intresting case, is this number coming from USB side?

No, it is coming from cppi4.1's descriptor. The maximum length of a packet =
is
stored in 21bits.

But this is a bit more complicated ;) The whole packet have 21bits size lim=
it,
but at the same time the whole sg_dma_len() also have this as we can link a
several host buffer descriptors to one host packet descriptor. Each have
21bits for length, but at the same time the sum of the hpd and the linked h=
bd
length can not be more than what we can store in 21bits...

>=20
>> This was one of the reasons that I have settled with the callback.
>>
>> What we can also do is to code this within the DMA drivers itself.
>>
>> When setting up the transfer and we realize that one of the SG will not
>> going to fit, we destroy what we have done so far, pass the sg list
>> along with length/sg limit to create a new sg list where all sg item's
>> length is under the limit. Then using this new sg list we can set up the
>> transfer.
>>
>> I'm not sure how hard is to do the sg list optimization, I see that
>> sg_split() is not what we want so we might need to code this in
>> dmaengine or in the scatterlist code.
>>
>> We certainly don't want to verify all slave_sg transfers proactively to
>> avoid adding latency when it is not necessary.
>=20
> latency would be added at prepare, not when submitting..

Yes, but you submit transfers all the time, and added latency would be cruc=
ial.

But this could be done with a DMAengine internal helper, I think.
If a DMA driver figures out that one of the SG length is over the supported
limit, then it could clean up everything and call something like:

struct dma_async_tx_descriptor *dmaengine_fixup_and_prep_slave_sg(
	struct dma_chan *chan, struct scatterlist *sgl,
	unsigned int sg_len, enum dma_transfer_direction dir,
	unsigned long flags, size_t max_sg_dma_len)

and this would split up the original SG list to a temp one meeting the
max_sg_dma_len and call chan->device->device_prep_slave_sg()

In this round the setup would succeed and the caller and I would be happy.

But if the caller already aware of the sg_dma_len limit it can prepare the =
SG
list correctly and we save time to recreate the list.

--=20
P=C3=A9ter
