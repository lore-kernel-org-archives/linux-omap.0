From: "Krishna Prasad Herur" <kherur@nextwave.com>
Subject: RE: DMA transfer using McSPI driver
Date: Fri, 9 Feb 2007 17:44:12 -0800
Message-ID: <E6CCDC65B8C522458685D8D1F145FEA81EB42B@CA2-MSX-C01.nw.net>
References: <E6CCDC65B8C522458685D8D1F145FEA8189B06@CA2-MSX-C01.nw.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <E6CCDC65B8C522458685D8D1F145FEA8189B06@CA2-MSX-C01.nw.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Ghongadematt, Girish" <girishsg@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
	Does anyone know if there are plans for McSpi driver to support
the generic spi interface provided in Linux kernel 2.6.17 onwards?
Regards,
-Prasad


-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Krishna Prasad Herur
Sent: Friday, February 02, 2007 5:00 PM
To: Guruswamy, Senthilvadivu
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: DMA transfer using McSPI driver

Hi Senthil & Girish,
	I appreciate your answers.=20

I am not sure if I understand you completely. I have been able to raw
reads and writes outside the IRQ handler.

Are you saying, I need to do a raw write followed by a dma transmit in
the IRQ context?

Here is another weird thing I see. After loading the McSPI driver
module, I configure, and enable the channel. I have not called the
mcspi_transmit_buf function. I already see the interrupt happening. Is
this normal? Below is the Debug log.
---------------------------------------------------------
MCSPI: exiting omap2_mcspi_register_isr ret: 0
MCSPI: entering omap2_mcspi_dma_writereq
MCSPI INFO: R[0xd8098000+0x2c]=3D0x12fc8
MCSPI INFO: W[0xd8098000+0x2c]=3D0x12fc8
MCSPI: entering omap2_mcspi_enable_channel
MCSPI INFO: R[0xd8098000+0x34]=3D0x0
MCSPI INFO: W[0xd8098000+0x34]=3D0x1
MCSPI INFO: R[0xd8098000+0x18]=3D0x1
MCSPI INFO: W[0xd8098000+0x34]=3D0x0
MCSPI INFO: W[0xd8098000+0x18]=3D0x3
McSpi Intr status =3D 3
MCSPI: exiting omap2_mcspi_enable_channel ret: 0
MCSPI: entering omap2_mcspi_transmit_buf
MCSPI INFO: R[0xd8098000+0x2c]=3D0x12fc8
MCSPI INFO: W[0xd8098000+0x2c]=3D0x16fc8
MCSPI: entering spi_dma_write_channel
MCSPI: exiting omap2_mcspi_transmit_buf ret: 0
--------------------------------------------------------

When I do not register dma_tx_callback function, and do a
mcspi_transmit_buf, I see 2words of garbage, followed by good data. Do
you know what could be causing this?

Thanks,
-Prasad


-----Original Message-----
From: Guruswamy, Senthilvadivu [mailto:svadivu@ti.com]=20
Sent: Friday, February 02, 2007 12:20 AM
To: Krishna Prasad Herur
Cc: linux-omap-open-source@linux.omap.com; Ghongadematt, Girish
Subject: RE: DMA transfer using McSPI driver

Hi,

Mcspi transfer with raw mode can be done using the APIs
omap2_mcspi_raw_writetochannel(), omap2_mcspi_raw_readfromchannel().
Since it is a serial peripheral, you shall call these APIs in the tx/rx
IRQ handlers registered by you.

Regards,
Senthil.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Krishna Prasad Herur
Sent: Friday, February 02, 2007 7:50 AM
To: Ghongadematt, Girish
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: DMA transfer using McSPI driver

If I understand the McSPI spec correctly, I should be able to enable a
channel, and then do a mcspi_transmit_buf. Also, the McSpi driver code
talks about the client/user maintaining the RAW/DMA mode. I do not see
any functions or variables that retain such info. (other than the
omap2_mcspi_set_dma_write macro)

In my case, I see the DMA data only when I configure the channel, do a
dma_transmit, and then enable the McSpi channel. This seems very weird,
and DMA transfers fail after switching from RAW mode to DMA mode. I have
tried many combinations of reserving, releasing the channels before
switching from RAW to DMA mode.=20

Can someone shed light on the procedure to switch from raw mode to DMA
mode?

Here is how I got DMA to work.
<Call all config macros>
	omap2_mcspi_set_dma_write(mySpiDev, OMAP2_McSPI_CHAN_DMA_WRITE);
	omap2_mcspi_request_interface(devPtr);=09
	omap2_mcspi_get(devPtr);
	omap2_mcspi_config_channel(devPtr);
	omap2_mcspi_dma_writereq(devPtr,OMAP2_McSPI_DMAW_ENABLE);
	omap2_mcspi_transmit_buf(devPtr,virt_to_phys((u32
*)dmaBuf),256);
	omap2_mcspi_enable_channel(devPtr);

Thanks,
-Prasad


-----Original Message-----
From: Girish. S. G. [mailto:girishsg@ti.com]=20
Sent: Wednesday, January 31, 2007 5:34 AM
To: Krishna Prasad Herur
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: DMA transfer using McSPI driver

hi prasad,

If you have called all config macros correctly (like, set and get
transmission
enable on line 1/0 etc,.) then there shoudn't b any problem.

Just check once if you are allocating memory for DMA buf properly.

regards,
girish

> I think I know the reason for the soft lockup.
>
> The omap 2430 errata says that the DMA Tx complete interrupt continues
> to be asserted after a transaction error. I found this to be the
reason
> for the soft lockup. I am still unsure as to why there is a
transaction
> error!
>
>
>
> The McSpi driver configuration for DMA transfer seems to be
> straightforward. The McSpi driver seems to be calling all the Dma
driver
> functions with the right parameters.
>
>
>
> Does anyone had success doing DMA transfers to/from McSpi channels
using
> the Omap McSpi driver?
>
> Regards,
>
> -Prasad
>
>
>
> ________________________________
>
> From: Krishna Prasad Herur
> Sent: Tuesday, January 23, 2007 12:02 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: DMA transfer using McSPI driver
>
>
>
> Hi Gurus,
>
>             I was able to get raw data transfers over the McSPI bus on
> an Omap 2430 based platform running Linux 2.6. I am trying to do the
> same transmit using DMA. Is it possible to use DMA in polling mode? I
> have not registered interrupt handlers or dma handlers.  Below is the
> programming sequence I followed, after calling all the config macros.
>
>
>
>       omap2_mcspi_request_interface(devPtr);
>
>       omap2_mcspi_interface_reset(devPtr);
>
>       omap2_mcspi_get(devPtr);
>
>       omap2_mcspi_config_channel(devPtr);
>
>       omap2_mcspi_enable_channel(devPtr);
>
>       omap2_mcspi_dma_writereq(devPtr,OMAP2_McSPI_DMAW_ENABLE);
>
>       omap2_mcspi_transmit_buf(devPtr,dmaBuf,8);
>
>
>
> I get a DMA transaction error, and a soft lockup.
>
>
>
> DMA transaction error occurred with device 35
>
> BUG: soft lockup detected on CPU#0!
>
>
>
> Regards,
>
> -Prasad
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>



_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
