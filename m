From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v3 5/7] mtd: onenand: omap2: Unify OMAP2 and OMAP3 DMA
 implementation
Date: Fri, 10 Nov 2017 11:04:44 +0100
Message-ID: <20171110100443.zqk7uzxoaq4eyntk@lenoch>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
 <20171109091529.x3pqqvbiywj5aulo@lenoch>
 <3d33265a-2520-2298-6068-f76a7257bfd0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3d33265a-2520-2298-6068-f76a7257bfd0@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 10, 2017 at 10:25:24AM +0200, Peter Ujfalusi wrote:
> Hi,
> =

> On 2017-11-09 11:15, Ladislav Michl wrote:
> > Since the very first commit (36cd4fb5d277: "[MTD] [OneNAND] Add OMAP2 /=
 OMAP3
> > OneNAND driver") DMA is disabled for OMAP2. Later fixes thus went only =
into
> > OMAP3 specific DMA functions which turned out not to be so OMAP3 specif=
ic.
> > Therefore replace open coded timeout waiting for completion in OMAP3
> > functions with API call and merge those two implementations.
> > =

> > Note that currently the is no single DMA user, so this change is basica=
lly
> > no-op. Those interested will have to find DMA configuration in the
> > linux-omap.git history.
> =

> fwiw I have two patches for some time to convert the omap2 onenand
> driver to DMAengine:
> https://github.com/omap-audio/linux-audio/commits/peter/linux-next-wip/dr=
ivers/mtd/onenand/omap2.c

That is incredible! I was thinking about it as a next step and you already
did all the work.

> I can wait for your series and rebase mine or if you have time can test
> them and see if they can be included in your update series.

I run out of time few days ago already, but this looks so good that it is
worth to delay other work. I'll include it in next version of patch serie.

Also it will allow us to dump 'dma-channel' and use DMA if gpio pin
is configured which was intended logic of original driver. 'dma-channel'
was introduced during mechanical conversion to DT and fortunately it is
not used yet, so we can safely remove it again.

Thanks,
	ladis

> - P=E9ter
> =

> > =

> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > ---
> >  Changes:
> >  -v3: new patch
> > =

> >  drivers/mtd/onenand/omap2.c | 165 +++---------------------------------=
--------
> >  1 file changed, 10 insertions(+), 155 deletions(-)
> > =

> > diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> > index 883993bbe40b..5760e40be008 100644
> > --- a/drivers/mtd/onenand/omap2.c
> > +++ b/drivers/mtd/onenand/omap2.c
> > @@ -289,9 +289,7 @@ static inline int omap2_onenand_bufferram_offset(st=
ruct mtd_info *mtd, int area)
> >  	return 0;
> >  }
> >  =

> > -#if defined(CONFIG_ARCH_OMAP3) || defined(MULTI_OMAP2)
> > -
> > -static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> > +static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
> >  					unsigned char *buffer, int offset,
> >  					size_t count)
> >  {
> > @@ -299,10 +297,9 @@ static int omap3_onenand_read_bufferram(struct mtd=
_info *mtd, int area,
> >  	struct onenand_chip *this =3D mtd->priv;
> >  	dma_addr_t dma_src, dma_dst;
> >  	int bram_offset;
> > -	unsigned long timeout;
> > +	unsigned long t;
> >  	void *buf =3D (void *)buffer;
> >  	size_t xtra;
> > -	volatile unsigned *done;
> >  =

> >  	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area + of=
fset;
> >  	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
> > @@ -349,15 +346,11 @@ static int omap3_onenand_read_bufferram(struct mt=
d_info *mtd, int area,
> >  	reinit_completion(&c->dma_done);
> >  	omap_start_dma(c->dma_channel);
> >  =

> > -	timeout =3D jiffies + msecs_to_jiffies(20);
> > -	done =3D &c->dma_done.done;
> > -	while (time_before(jiffies, timeout))
> > -		if (*done)
> > -			break;
> > +	t =3D wait_for_completion_io_timeout(&c->dma_done, msecs_to_jiffies(2=
0));
> >  =

> >  	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
> >  =

> > -	if (!*done) {
> > +	if (!t) {
> >  		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> >  		goto out_copy;
> >  	}
> > @@ -369,7 +362,7 @@ static int omap3_onenand_read_bufferram(struct mtd_=
info *mtd, int area,
> >  	return 0;
> >  }
> >  =

> > -static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int are=
a,
> > +static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int are=
a,
> >  					 const unsigned char *buffer,
> >  					 int offset, size_t count)
> >  {
> > @@ -377,9 +370,8 @@ static int omap3_onenand_write_bufferram(struct mtd=
_info *mtd, int area,
> >  	struct onenand_chip *this =3D mtd->priv;
> >  	dma_addr_t dma_src, dma_dst;
> >  	int bram_offset;
> > -	unsigned long timeout;
> > +	unsigned long t;
> >  	void *buf =3D (void *)buffer;
> > -	volatile unsigned *done;
> >  =

> >  	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area + of=
fset;
> >  	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
> > @@ -420,15 +412,11 @@ static int omap3_onenand_write_bufferram(struct m=
td_info *mtd, int area,
> >  	reinit_completion(&c->dma_done);
> >  	omap_start_dma(c->dma_channel);
> >  =

> > -	timeout =3D jiffies + msecs_to_jiffies(20);
> > -	done =3D &c->dma_done.done;
> > -	while (time_before(jiffies, timeout))
> > -		if (*done)
> > -			break;
> > +	t =3D wait_for_completion_io_timeout(&c->dma_done, msecs_to_jiffies(2=
0));
> >  =

> >  	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
> >  =

> > -	if (!*done) {
> > +	if (!t) {
> >  		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> >  		goto out_copy;
> >  	}
> > @@ -440,134 +428,6 @@ static int omap3_onenand_write_bufferram(struct m=
td_info *mtd, int area,
> >  	return 0;
> >  }
> >  =

> > -#else
> > -
> > -static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> > -					unsigned char *buffer, int offset,
> > -					size_t count)
> > -{
> > -	return -ENOSYS;
> > -}
> > -
> > -static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int are=
a,
> > -					 const unsigned char *buffer,
> > -					 int offset, size_t count)
> > -{
> > -	return -ENOSYS;
> > -}
> > -
> > -#endif
> > -
> > -#if defined(CONFIG_ARCH_OMAP2) || defined(MULTI_OMAP2)
> > -
> > -static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
> > -					unsigned char *buffer, int offset,
> > -					size_t count)
> > -{
> > -	struct omap2_onenand *c =3D container_of(mtd, struct omap2_onenand, m=
td);
> > -	struct onenand_chip *this =3D mtd->priv;
> > -	dma_addr_t dma_src, dma_dst;
> > -	int bram_offset;
> > -
> > -	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area + of=
fset;
> > -	/* DMA is not used.  Revisit PM requirements before enabling it. */
> > -	if (1 || (c->dma_channel < 0) ||
> > -	    ((void *) buffer >=3D (void *) high_memory) || (bram_offset & 3) =
||
> > -	    (((unsigned int) buffer) & 3) || (count < 1024) || (count & 3)) {
> > -		memcpy(buffer, (__force void *)(this->base + bram_offset),
> > -		       count);
> > -		return 0;
> > -	}
> > -
> > -	dma_src =3D c->phys_base + bram_offset;
> > -	dma_dst =3D dma_map_single(&c->pdev->dev, buffer, count,
> > -				 DMA_FROM_DEVICE);
> > -	if (dma_mapping_error(&c->pdev->dev, dma_dst)) {
> > -		dev_err(&c->pdev->dev,
> > -			"Couldn't DMA map a %d byte buffer\n",
> > -			count);
> > -		return -1;
> > -	}
> > -
> > -	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
> > -				     count / 4, 1, 0, 0, 0);
> > -	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> > -				dma_src, 0, 0);
> > -	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> > -				 dma_dst, 0, 0);
> > -
> > -	reinit_completion(&c->dma_done);
> > -	omap_start_dma(c->dma_channel);
> > -	wait_for_completion(&c->dma_done);
> > -
> > -	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
> > -
> > -	return 0;
> > -}
> > -
> > -static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int are=
a,
> > -					 const unsigned char *buffer,
> > -					 int offset, size_t count)
> > -{
> > -	struct omap2_onenand *c =3D container_of(mtd, struct omap2_onenand, m=
td);
> > -	struct onenand_chip *this =3D mtd->priv;
> > -	dma_addr_t dma_src, dma_dst;
> > -	int bram_offset;
> > -
> > -	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area + of=
fset;
> > -	/* DMA is not used.  Revisit PM requirements before enabling it. */
> > -	if (1 || (c->dma_channel < 0) ||
> > -	    ((void *) buffer >=3D (void *) high_memory) || (bram_offset & 3) =
||
> > -	    (((unsigned int) buffer) & 3) || (count < 1024) || (count & 3)) {
> > -		memcpy((__force void *)(this->base + bram_offset), buffer,
> > -		       count);
> > -		return 0;
> > -	}
> > -
> > -	dma_src =3D dma_map_single(&c->pdev->dev, (void *) buffer, count,
> > -				 DMA_TO_DEVICE);
> > -	dma_dst =3D c->phys_base + bram_offset;
> > -	if (dma_mapping_error(&c->pdev->dev, dma_src)) {
> > -		dev_err(&c->pdev->dev,
> > -			"Couldn't DMA map a %d byte buffer\n",
> > -			count);
> > -		return -1;
> > -	}
> > -
> > -	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S16,
> > -				     count / 2, 1, 0, 0, 0);
> > -	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> > -				dma_src, 0, 0);
> > -	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> > -				 dma_dst, 0, 0);
> > -
> > -	reinit_completion(&c->dma_done);
> > -	omap_start_dma(c->dma_channel);
> > -	wait_for_completion(&c->dma_done);
> > -
> > -	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
> > -
> > -	return 0;
> > -}
> > -
> > -#else
> > -
> > -static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
> > -					unsigned char *buffer, int offset,
> > -					size_t count)
> > -{
> > -	return -ENOSYS;
> > -}
> > -
> > -static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int are=
a,
> > -					 const unsigned char *buffer,
> > -					 int offset, size_t count)
> > -{
> > -	return -ENOSYS;
> > -}
> > -
> > -#endif
> > -
> >  static struct platform_driver omap2_onenand_driver;
> >  =

> >  static void omap2_onenand_shutdown(struct platform_device *pdev)
> > @@ -691,13 +551,8 @@ static int omap2_onenand_probe(struct platform_dev=
ice *pdev)
> >  	this =3D &c->onenand;
> >  	if (c->dma_channel >=3D 0) {
> >  		this->wait =3D omap2_onenand_wait;
> > -		if (c->flags & ONENAND_IN_OMAP34XX) {
> > -			this->read_bufferram =3D omap3_onenand_read_bufferram;
> > -			this->write_bufferram =3D omap3_onenand_write_bufferram;
> > -		} else {
> > -			this->read_bufferram =3D omap2_onenand_read_bufferram;
> > -			this->write_bufferram =3D omap2_onenand_write_bufferram;
> > -		}
> > +		this->read_bufferram =3D omap2_onenand_read_bufferram;
> > +		this->write_bufferram =3D omap2_onenand_write_bufferram;
> >  	}
> >  =

> >  	if ((r =3D onenand_scan(&c->mtd, 1)) < 0)
> > =

> =

> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
