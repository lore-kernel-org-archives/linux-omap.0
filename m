From: "Hingkwan Huen" <hkh@cypress.com>
Subject: RE: DMA omap
Date: Fri, 26 Oct 2007 09:58:40 -0700
Message-ID: <000601c817f1$7a7d7a60$ed8410ac@mis.cypress.com>
References: <ae36f8040710241228i25b7a2dy73585f7bd2491191@mail.gmail.com>
	<47213585.5020702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <47213585.5020702@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Nishanth Menon' <menon.nishanth@gmail.com>, lvcargnini@gmail.com
Cc: 'OMAP' <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Nishanth,
I am working on the DMA implementation of our device driver on OMAP5912 =
as
well. In a), what function can I use to flush the cache before passing =
the
buffer to DMA?
Thanks,
kwan


-----Original Message-----
From: linux-omap-open-source-bounces+hkh=3Dcypress.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+hkh=3Dcypress.com@linux.omap.com] =
On
Behalf Of Nishanth Menon
Sent: Thursday, October 25, 2007 5:32 PM
To: lvcargnini@gmail.com
Cc: OMAP
Subject: Re: DMA omap

Lu=EDs Cargnini stated on 10/24/2007 2:28 PM:
> Dear fellows,
> I want to use DMA on my driver, please someone can help me,
> how could I use the functions omap_mcbsp_xmit_buffer,
omap_mcbsp_recv_buffer
> and how to obtain the DMA addres that  could be used as the parameter
> dma_addr_t buffer in both functions
I am a bit rusty around this now a days, so please correct me if I am =
wrong:

There used to be dma_alloc_coherent when I used to work on audio driver.
you could check up again.. there are two ways you can use this buffer:
a) cached memory: this is the general form when u do a kalloc and use
memory.. Some recommend this esp if you are doing a mmap and there is
large amoung of user space processing required-cached memory speeds up
things for u. the trouble is that when u give it to DMA, it tends to
read what is directly in SDRAM as it does not know what is in MPU Cache.
so the trick is that before you give it to dma, u need to flush the
cache.. this is a tricky business, if you have small memory buffers and
u flush often.. u will kill system performance.
b) uncached memory: u might on the other hand not want any flushing to
be done, instead allocate memory in which all accesses are done straight
to the SDRAM. This is called write-through mode. in this any access to
allocated memory will go straight to the SDRAM instead of being cached..
some folks consider this as not optimal, but again it is use case
dependent. this kind of memory can be got using dma_alloc_coherent or
it's equivalent.
Regards,
Nishanth Menon
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
