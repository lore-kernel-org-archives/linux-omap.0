From: "Girish. S. G." <girishsg@ti.com>
Subject: RE: DMA transfer using McSPI driver
Date: Fri, 2 Feb 2007 19:25:05 +0530 (IST)
Message-ID: <48612.192.168.10.88.1170424505.squirrel@dbdmail.itg.ti.com>
References: <46149.192.168.10.89.1170250434.squirrel@dbdmail.itg.ti.com>
	<E6CCDC65B8C522458685D8D1F145FEA81897AD@CA2-MSX-C01.nw.net>
Reply-To: girishsg@ti.com
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <E6CCDC65B8C522458685D8D1F145FEA81897AD@CA2-MSX-C01.nw.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Krishna Prasad Herur <kherur@nextwave.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

After doing RAW mode transfer and then configuring to DMA mode transfer, =
I
never tried this combination though but still there shouldn=92t be any pr=
oblem.

May be you can try doing a soft reset of the module(after RAW mode transf=
er)
before switching to DMA mode transfer.

regards,
girish


> If I understand the McSPI spec correctly, I should be able to enable a
> channel, and then do a mcspi_transmit_buf. Also, the McSpi driver code
> talks about the client/user maintaining the RAW/DMA mode. I do not see
> any functions or variables that retain such info. (other than the
> omap2_mcspi_set_dma_write macro)
>
> In my case, I see the DMA data only when I configure the channel, do a
> dma_transmit, and then enable the McSpi channel. This seems very weird,
> and DMA transfers fail after switching from RAW mode to DMA mode. I hav=
e
> tried many combinations of reserving, releasing the channels before
> switching from RAW to DMA mode.
>
> Can someone shed light on the procedure to switch from raw mode to DMA
> mode?
>
> Here is how I got DMA to work.
> <Call all config macros>
> 	omap2_mcspi_set_dma_write(mySpiDev, OMAP2_McSPI_CHAN_DMA_WRITE);
> 	omap2_mcspi_request_interface(devPtr);
> 	omap2_mcspi_get(devPtr);
> 	omap2_mcspi_config_channel(devPtr);
> 	omap2_mcspi_dma_writereq(devPtr,OMAP2_McSPI_DMAW_ENABLE);
> 	omap2_mcspi_transmit_buf(devPtr,virt_to_phys((u32
> *)dmaBuf),256);
> 	omap2_mcspi_enable_channel(devPtr);
>
> Thanks,
> -Prasad
>
>
> -----Original Message-----
> From: Girish. S. G. [mailto:girishsg@ti.com]
> Sent: Wednesday, January 31, 2007 5:34 AM
> To: Krishna Prasad Herur
> Cc: linux-omap-open-source@linux.omap.com
> Subject: RE: DMA transfer using McSPI driver
>
> hi prasad,
>
> If you have called all config macros correctly (like, set and get
> transmission
> enable on line 1/0 etc,.) then there shoudn't b any problem.
>
> Just check once if you are allocating memory for DMA buf properly.
>
> regards,
> girish
>
>> I think I know the reason for the soft lockup.
>>
>> The omap 2430 errata says that the DMA Tx complete interrupt continues
>> to be asserted after a transaction error. I found this to be the
> reason
>> for the soft lockup. I am still unsure as to why there is a
> transaction
>> error!
>>
>>
>>
>> The McSpi driver configuration for DMA transfer seems to be
>> straightforward. The McSpi driver seems to be calling all the Dma
> driver
>> functions with the right parameters.
>>
>>
>>
>> Does anyone had success doing DMA transfers to/from McSpi channels
> using
>> the Omap McSpi driver?
>>
>> Regards,
>>
>> -Prasad
>>
>>
>>
>> ________________________________
>>
>> From: Krishna Prasad Herur
>> Sent: Tuesday, January 23, 2007 12:02 PM
>> To: linux-omap-open-source@linux.omap.com
>> Subject: DMA transfer using McSPI driver
>>
>>
>>
>> Hi Gurus,
>>
>>             I was able to get raw data transfers over the McSPI bus on
>> an Omap 2430 based platform running Linux 2.6. I am trying to do the
>> same transmit using DMA. Is it possible to use DMA in polling mode? I
>> have not registered interrupt handlers or dma handlers.  Below is the
>> programming sequence I followed, after calling all the config macros.
>>
>>
>>
>>       omap2_mcspi_request_interface(devPtr);
>>
>>       omap2_mcspi_interface_reset(devPtr);
>>
>>       omap2_mcspi_get(devPtr);
>>
>>       omap2_mcspi_config_channel(devPtr);
>>
>>       omap2_mcspi_enable_channel(devPtr);
>>
>>       omap2_mcspi_dma_writereq(devPtr,OMAP2_McSPI_DMAW_ENABLE);
>>
>>       omap2_mcspi_transmit_buf(devPtr,dmaBuf,8);
>>
>>
>>
>> I get a DMA transaction error, and a soft lockup.
>>
>>
>>
>> DMA transaction error occurred with device 35
>>
>> BUG: soft lockup detected on CPU#0!
>>
>>
>>
>> Regards,
>>
>> -Prasad
>>
>> _______________________________________________
>> Linux-omap-open-source mailing list
>> Linux-omap-open-source@linux.omap.com
>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
>
>
>
>
