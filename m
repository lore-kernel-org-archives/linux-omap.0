From: "Nemakal, Vijaya" <xnemakal@ti.com>
Subject: RE: Question about DMA on omap2420
Date: Thu, 11 May 2006 15:19:57 -0500
Message-ID: <520AB2AD990DC04082102F77CA172638016D1909@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kyungmin.park@samsung.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi,=20
The parameters you are using seem to be fine except, the block size you
are configuring.
Typically the (element x frame cnt x block cnt) will be the buffer size.
Hope you are ensuring that.

Also, apart from the virt to phy conversion of the buffer, you have to
make sure that the address falls under the non cachable address space.
You can use the consistent_sync option for that.
Pasted below is the chunk of code which worked for me.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

+static inline int omap_onenand_dma_transfer(struct mtd_info *mtd, void
*addr,
+                                         void *src, unsigned int
u32_count, int is_write)
+{
+       const int block_size =3D 16;
+       unsigned int block_count, len;
+
+       block_count =3D u32_count * 4 / block_size;
+       if (is_write) {
+               omap_set_dma_dest_params(dma_ch,
OMAP_DMA_AMODE_POST_INC, src,
+                                        0, 0);
+               omap_set_dma_src_params(dma_ch, OMAP_DMA_AMODE_POST_INC,
+                                       virt_to_phys(addr),
+                                       0, 0);
+               omap_set_dma_dest_burst_mode(dma_ch,
OMAP_DMA_DATA_BURST_32);
+               omap_set_dma_src_burst_mode(dma_ch,
OMAP_DMA_DATA_BURST_32);
+       } else {
+
+               omap_set_dma_src_params(dma_ch, OMAP_DMA_AMODE_POST_INC,
src,
+                                       0, 0);
+               omap_set_dma_dest_params(dma_ch,
OMAP_DMA_AMODE_POST_INC,
+                                        virt_to_phys(addr),
+                                        0, 0);
+               omap_set_dma_dest_burst_mode(dma_ch,
OMAP_DMA_DATA_BURST_32);
+               omap_set_dma_src_burst_mode(dma_ch,
OMAP_DMA_DATA_BURST_32);
+       }
+       omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S32,
block_size / 4,
+                                    block_count, OMAP_DMA_SYNC_BLOCK,
+                                    0, 0);
+       init_completion(&comp);
+
+       len =3D u32_count << 2;
+       consistent_sync(addr, len, PCI_DMA_TODEVICE);
+       omap_start_dma(dma_ch);
+       wait_for_completion(&comp);
+       if (!is_write)
+               consistent_sync(addr, len, PCI_DMA_FROMDEVICE);
+       return 0;
+}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Regards
vijaya

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com=20
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On=20
> Behalf Of Kyungmin Park
> Sent: Thursday, May 11, 2006 4:21 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: Question about DMA on omap2420
>=20
> Hi
>=20
> I have a problem with DMA transfer on OMAP2420.
>=20
> As previous mail the MMC with DMA is working well.
> Data is copied from MMC to SDRAM wirh dedicated MMC DMA.
> So I think DMA routine has no problem to use
>=20
> But the problem is happended when copy from GPMC (OneNAND) to SDRAM
>=20
> In my understanding
>=20
> DMA programming as follow.
>=20
> 1. omap_request_dma(OMAP24XX_DMA_NO_DEVICE, ..., dma_callback, ...);
>=20
> 2. dma mapping & translate virt to phys
>=20
> 3. set src & dest configurations
> 	omap_set_dma_src_params(dma->ch, 0,=20
> OMAP_DMA_AMODE_POST_INC, src_phys, 0, 0);
> 	omap_set_dma_dest_params(dma->ch, 0,=20
> OMAP_DMA_AMODE_POST_INC, dest_phys, 0, 0);
> 	omap_set_dma_transfer_params(dma->ch, OMAP_DMA_DATA_TYPE_S16,
>                                 1, count >> 1, OMAP_DMA_SYNC_ELEMENT,
>                                 0, 0);
> 	or
> 	omap_set_dma_transfer_params(dma->ch, OMAP_DMA_DATA_TYPE_S32,
>                                 1, count >> 2, OMAP_DMA_SYNC_ELEMENT,
>                                 0, 0);
>=20
> 4. start dma
> 	omap_start_dma(dma->ch);
>=20
> 5. wait until work done=20
> 	dma_callback send wakeup
>=20
> In this sequence. DMA go works well but some time later it failed.
>=20
> I think data copy from GPMC to SDRAM is memory copy. so I set=20
> GPMC part as SDRAM does
>=20
> Are there any other configurations for GPMC for DMA?
> E.g., I need to set OMAP24XX_DMA_GPMC instead of=20
> OMAP24XX_DMA_NO_DEVICE.
>        or need to set dma_trigger?
>=20
> Thanks you
> Kyungmin Park
>=20
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
