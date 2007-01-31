From: "Krishna Prasad Herur" <kherur@nextwave.com>
Subject: RE: DMA transfer using McSPI driver
Date: Wed, 31 Jan 2007 09:10:34 -0800
Message-ID: <E6CCDC65B8C522458685D8D1F145FEA818909A@CA2-MSX-C01.nw.net>
References: <46149.192.168.10.89.1170250434.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <46149.192.168.10.89.1170250434.squirrel@dbdmail.itg.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: girishsg@ti.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks Girish,
	I had made a "Linux newbie" mistake. I was passing in an address
in virtual memory, which caused a DMA transaction error.
Works much better when I pass the physical address. I may need to do a
few cache flushes to get the actual data out, but I do not see the
resets anymore.
Thanks again.
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
