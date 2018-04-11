From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [Bug]: mtd: onenand: omap2plus: kernel panic with OneNAND on OMAP3 (DM3730) device GTA04A5
Date: Wed, 11 Apr 2018 11:44:32 +0200
Message-ID: <33C4B5C7-FAD5-4CA4-A901-6605D9A4C0CE@goldelico.com>
References: <5D496D5C-4E3E-47B4-9981-E8F4C348DE00@goldelico.com> <20180410205643.GA2228@lenoch> <20180411065836.7e1bfc3f@aktux> <20180411062607.GA9179@lenoch> <20180411091528.4e954c32@bbrezillon> <20180411073655.GA18273@lenoch> <20180411100806.3c09bafc@bbrezillon> <20180411082746.GA20164@lenoch> <20180411105201.5f126e94@bbrezillon> <20180411091224.GA24153@lenoch>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180411091224.GA24153@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Andreas Kemnade <andreas@kemnade.info>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org


> Am 11.04.2018 um 11:12 schrieb Ladislav Michl <ladis@linux-mips.org>:
>=20
> On Wed, Apr 11, 2018 at 10:52:01AM +0200, Boris Brezillon wrote:
>> On Wed, 11 Apr 2018 10:27:46 +0200
>> Ladislav Michl <ladis@linux-mips.org> wrote:
>>=20
>>> On Wed, Apr 11, 2018 at 10:08:06AM +0200, Boris Brezillon wrote:
>>>> On Wed, 11 Apr 2018 09:36:56 +0200
>>>> Ladislav Michl <ladis@linux-mips.org> wrote:
>>>>=20
>>>>> Hi Boris,
>>>>>=20
>>>>> On Wed, Apr 11, 2018 at 09:15:28AM +0200, Boris Brezillon wrote: =20=

>>> [...]
>>>>>> Not sure this approach is safe on all archs: if the cache is VIVT =
or
>>>>>> VIPT, you may have several entries pointing to the same phys =
page, and
>>>>>> then, when dma_map_page() does its cache maintenance operations, =
it's
>>>>>> only taking one of these entries into account.   =20
>>>>>=20
>>>>> Hmm, I used the same approach Samsung OneNAND driver does since =
commit
>>>>> dcf08227e964a53a2cb39130b74842c7dcb6adde.
>>>>> Both TI OMAP3630 and Samsung S5PC110 are using Cortex-A8 which
>>>>> is VIPT. In that case samsung's driver code has the same problem.
>>>>>=20
>>>>>> In other parts of the MTD subsystem, we tend to not do DMA on =
buffers
>>>>>> that have been vmalloc-ed.
>>>>>>=20
>>>>>> You can do something like
>>>>>>=20
>>>>>> 		if (virt_addr_valid(buf))
>>>>>> 			/* Use DMA */
>>>>>> 		else
>>>>>> 			/*
>>>>>> 			 * Do not use DMA, or use a bounce buffer
>>>>>> 			 * allocated with kmalloc
>>>>>> 			 */   =20
>>>>>=20
>>>>> Okay, I'll use this approach then, but first I'd like to be sure =
above is
>>>>> correct. Anyone? =20
>>>>=20
>>>> See this discussion [1]. The problem came up a few times already, =
so
>>>> might find other threads describing why it's not safe.
>>>>=20
>>>> =
[1]https://lists.linuxfoundation.org/pipermail/iommu/2016-March/016240.htm=
l =20
>>>=20
>>> Question was more likely whenever there might exist more that one =
mapping
>>> of the same page.
>>=20
>> I'm clearly not an expert, so I might be wrong, but I think a =
physical
>> page can be both in the identity mapping and mapped in the vmalloc
>> space. Now, is there a real risk that both ends are accessed in
>> parallel thus making different cache entries pointing to the same =
phys
>> page dirty, I'm not sure. Or maybe there are other corner case, but
>> you'll have to ask Russell (or any other ARM expert) to get a clearer
>> answer.
>=20
> Thank you anyway. As DMA was disabled completely for all DT enabled =
boards
> until 4.16 let's play safe and disable it for HIGHMEM case as you =
suggested.
> Later, we might eventually use the same {read,write}_bufferram for =
both
> OMAP and S5PC110.
>=20
>>> But okay, I'll disable DMA for highmem. Patch will follow.
>>>=20
>>> 	ladis
>=20
> Andreas, Nikolaus, could you please test patch bellow? It is against
> linux.git and should apply also against 4.16 once you modify path.

Works with v4.16!

I have done "tar cf /dev/null /mnt/nand" and have only
got some fixable bit flips. Writing a test file to OneNAND
also worked and doing a sync did move the weak block to a new PEB.

So I think read & write works again.

>=20
> Thank you,
> 	ladis

BR and thanks,
Nikolaus

>=20
> --- >8 ---
>=20
> From: Ladislav Michl <ladis@linux-mips.org>
> Subject: [PATCH] mtd: onenand: omap2: Disable DMA for HIGHMEM buffers
>=20
> dma_map_single doesn't get the proper DMA address for vmalloced area,
> so disable DMA in this case.
>=20
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Reported-by: "H. Nikolaus Schaller" <hns@goldelico.com>
> ---
> drivers/mtd/nand/onenand/omap2.c | 105 +++++++++++--------------------
> 1 file changed, 38 insertions(+), 67 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/onenand/omap2.c =
b/drivers/mtd/nand/onenand/omap2.c
> index 9c159f0dd9a6..321137158ff3 100644
> --- a/drivers/mtd/nand/onenand/omap2.c
> +++ b/drivers/mtd/nand/onenand/omap2.c
> @@ -375,56 +375,42 @@ static int omap2_onenand_read_bufferram(struct =
mtd_info *mtd, int area,
> {
> 	struct omap2_onenand *c =3D container_of(mtd, struct =
omap2_onenand, mtd);
> 	struct onenand_chip *this =3D mtd->priv;
> -	dma_addr_t dma_src, dma_dst;
> -	int bram_offset;
> +	struct device *dev =3D &c->pdev->dev;
> 	void *buf =3D (void *)buffer;
> +	dma_addr_t dma_src, dma_dst;
> +	int bram_offset, err;
> 	size_t xtra;
> -	int ret;
>=20
> 	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area =
+ offset;
> -	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
> -		goto out_copy;
> -
> -	/* panic_write() may be in an interrupt context */
> -	if (in_interrupt() || oops_in_progress)
> +	/*
> +	 * If the buffer address is not DMA-able, len is not long enough =
to make
> +	 * DMA transfers profitable or panic_write() may be in an =
interrupt
> +	 * context fallback to PIO mode.
> +	 */
> +	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 =
||
> +	    count < 384 || in_interrupt() || oops_in_progress )
> 		goto out_copy;
>=20
> -	if (buf >=3D high_memory) {
> -		struct page *p1;
> -
> -		if (((size_t)buf & PAGE_MASK) !=3D
> -		    ((size_t)(buf + count - 1) & PAGE_MASK))
> -			goto out_copy;
> -		p1 =3D vmalloc_to_page(buf);
> -		if (!p1)
> -			goto out_copy;
> -		buf =3D page_address(p1) + ((size_t)buf & ~PAGE_MASK);
> -	}
> -
> 	xtra =3D count & 3;
> 	if (xtra) {
> 		count -=3D xtra;
> 		memcpy(buf + count, this->base + bram_offset + count, =
xtra);
> 	}
>=20
> +	dma_dst =3D dma_map_single(dev, buf, count, DMA_FROM_DEVICE);
> 	dma_src =3D c->phys_base + bram_offset;
> -	dma_dst =3D dma_map_single(&c->pdev->dev, buf, count, =
DMA_FROM_DEVICE);
> -	if (dma_mapping_error(&c->pdev->dev, dma_dst)) {
> -		dev_err(&c->pdev->dev,
> -			"Couldn't DMA map a %d byte buffer\n",
> -			count);
> -		goto out_copy;
> -	}
>=20
> -	ret =3D omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
> -	dma_unmap_single(&c->pdev->dev, dma_dst, count, =
DMA_FROM_DEVICE);
> -
> -	if (ret) {
> -		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> +	if (dma_mapping_error(dev, dma_dst)) {
> +		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", =
count);
> 		goto out_copy;
> 	}
>=20
> -	return 0;
> +	err =3D omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
> +	dma_unmap_single(dev, dma_dst, count, DMA_FROM_DEVICE);
> +	if (!err)
> +		return 0;
> +
> +	dev_err(dev, "timeout waiting for DMA\n");
>=20
> out_copy:
> 	memcpy(buf, this->base + bram_offset, count);
> @@ -437,49 +423,34 @@ static int omap2_onenand_write_bufferram(struct =
mtd_info *mtd, int area,
> {
> 	struct omap2_onenand *c =3D container_of(mtd, struct =
omap2_onenand, mtd);
> 	struct onenand_chip *this =3D mtd->priv;
> -	dma_addr_t dma_src, dma_dst;
> -	int bram_offset;
> +	struct device *dev =3D &c->pdev->dev;
> 	void *buf =3D (void *)buffer;
> -	int ret;
> +	dma_addr_t dma_src, dma_dst;
> +	int bram_offset, err;
>=20
> 	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area =
+ offset;
> -	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
> -		goto out_copy;
> -
> -	/* panic_write() may be in an interrupt context */
> -	if (in_interrupt() || oops_in_progress)
> +	/*
> +	 * If the buffer address is not DMA-able, len is not long enough =
to make
> +	 * DMA transfers profitable or panic_write() may be in an =
interrupt
> +	 * context fallback to PIO mode.
> +	 */
> +	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 =
||
> +	    count < 384 || in_interrupt() || oops_in_progress )
> 		goto out_copy;
>=20
> -	if (buf >=3D high_memory) {
> -		struct page *p1;
> -
> -		if (((size_t)buf & PAGE_MASK) !=3D
> -		    ((size_t)(buf + count - 1) & PAGE_MASK))
> -			goto out_copy;
> -		p1 =3D vmalloc_to_page(buf);
> -		if (!p1)
> -			goto out_copy;
> -		buf =3D page_address(p1) + ((size_t)buf & ~PAGE_MASK);
> -	}
> -
> -	dma_src =3D dma_map_single(&c->pdev->dev, buf, count, =
DMA_TO_DEVICE);
> +	dma_src =3D dma_map_single(dev, buf, count, DMA_TO_DEVICE);
> 	dma_dst =3D c->phys_base + bram_offset;
> -	if (dma_mapping_error(&c->pdev->dev, dma_src)) {
> -		dev_err(&c->pdev->dev,
> -			"Couldn't DMA map a %d byte buffer\n",
> -			count);
> -		return -1;
> -	}
> -
> -	ret =3D omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
> -	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
> -
> -	if (ret) {
> -		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> +	if (dma_mapping_error(dev, dma_src)) {
> +		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", =
count);
> 		goto out_copy;
> 	}
>=20
> -	return 0;
> +	err =3D omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
> +	dma_unmap_page(dev, dma_src, count, DMA_TO_DEVICE);
> +	if (!err)
> +		return 0;
> +
> +	dev_err(dev, "timeout waiting for DMA\n");
>=20
> out_copy:
> 	memcpy(this->base + bram_offset, buf, count);
> --=20
> 2.17.0
>=20
