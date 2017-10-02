From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/5] dmaengine: Support for querying maximum trasnfer
 length (of an SG element)
Date: Mon, 2 Oct 2017 14:24:12 +0300
Message-ID: <11471508-b61c-7842-2080-7f5c2f292c2b@ti.com>
References: <20170912104424.18495-1-peter.ujfalusi@ti.com>
 <20170912104424.18495-4-peter.ujfalusi@ti.com>
 <20170921171451.GG30097@localhost>
 <02509904-4ae8-c6f8-3514-5f77d665c9a6@ti.com>
 <20170926165413.GQ30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170926165413.GQ30097@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

=EF=BB=BF


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-09-26 19:54, Vinod Koul wrote:
>>>
>>> not another callback :)
>>>
>>> on a serious note, why shouldn't this be one more capability in
>>> dma_slave_caps. looking at next patch it seems static
>>
>> It is not really static, the size in bytes depends on the dev_width and
>> the maxburst:
>> dev_width * burst * (SZ_64K - 1);
>=20
> well DMAengines work on FIFOs, in above you are giving length as SZ_64K -=
 1
> 'items' which IIUC in DMAengine terms for bytes would always refer wrt wi=
dth
> used and burst applied.

I think we can live with this and let the user to figure out what to do
with this information.

But I'm having hard time to figure out a good name for this. It is not
the number of SGs we can support, but the number of 'items' within one
SG that we have the limit. It could be:
u32 max_bursts_per_sg;

which would also apply to period length (for cyclic) in a similar way.

> Return length in bytes does make sense (from user PoV), but then you need=
 to
> "know" the applied  width and burst. How do you decide those?

The number of items works eDMA and sDMA, but we also have the cpp41. It
is a packet DMA and it has no understanding of bursts, address widths or
any of the 'traditional' things. It only cares about the number of bytes
we want to transfer and it has limitation of 4194303 bytes (21bits for
length). This is again per SG. How this could report the
'max_bursts_per_sg' ?

This was one of the reasons that I have settled with the callback.

What we can also do is to code this within the DMA drivers itself.

When setting up the transfer and we realize that one of the SG will not
going to fit, we destroy what we have done so far, pass the sg list
along with length/sg limit to create a new sg list where all sg item's
length is under the limit. Then using this new sg list we can set up the
transfer.

I'm not sure how hard is to do the sg list optimization, I see that
sg_split() is not what we want so we might need to code this in
dmaengine or in the scatterlist code.

We certainly don't want to verify all slave_sg transfers proactively to
avoid adding latency when it is not necessary.


>>
>> The number of (dev_width * burst) is static, yes. Other DMA engines
>> might have similar interpretation, but returning the maximum length in
>> bytes sounded more generic for other engines to be able to adopt.
>>
>> Initially I had maxburst_cnt in struct dma_device for maximum burst
>> count within one SG, but it felt clumsy and not too intuitive either.
>=20
>>
>> - P=C3=A9ter
>>
>=20

- P=C3=A9ter
