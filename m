From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: spi-ti-qspi: Use bounce buffer if read buffer is
 not DMA'ble
Date: Mon, 3 Apr 2017 11:52:27 +0530
Message-ID: <f16fb10d-a659-a9e3-d48c-9350f7656421@ti.com>
References: <201704030704.3H2aUqA0%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201704030704.3H2aUqA0%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Monday 03 April 2017 05:03 AM, kbuild test robot wrote:
> Hi Vignesh,
> 
> [auto build test WARNING on spi/for-next]
> [also build test WARNING on v4.11-rc4 next-20170331]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Vignesh-R/spi-ti-qspi-Handle-vmalloc-d-buffers/20170403-030332
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):

Thanks for the report. I will fix below warnings in the next version.

> 
>    include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
>    drivers/spi/spi-ti-qspi.c:449:35: sparse: incompatible types in comparison expression (different type sizes)
>    drivers/spi/spi-ti-qspi.c: In function 'ti_qspi_dma_bounce_buffer':
>>> drivers/spi/spi-ti-qspi.c:440:20: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      unsigned int to = (unsigned int)msg->buf;
>                        ^
>    In file included from drivers/spi/spi-ti-qspi.c:16:0:
>    include/linux/kernel.h:755:16: warning: comparison of distinct pointer types lacks a cast
>      (void) (&min1 == &min2);   \
>                    ^
>    include/linux/kernel.h:758:2: note: in expansion of macro '__min'
>      __min(typeof(x), typeof(y),   \
>      ^~~~~
>>> drivers/spi/spi-ti-qspi.c:449:21: note: in expansion of macro 'min'
>       size_t xfer_len = min(QSPI_DMA_BUFFER_SIZE, readsize);
>                         ^~~
>>> drivers/spi/spi-ti-qspi.c:455:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>       memcpy((void *)to, qspi->rx_bb_addr, xfer_len);
>              ^
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
>>> drivers/spi/spi-ti-qspi.c:449:35: sparse: incompatible types in comparison expression (different type sizes)
>    drivers/spi/spi-ti-qspi.c: In function 'ti_qspi_dma_bounce_buffer':
>    drivers/spi/spi-ti-qspi.c:440:20: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      unsigned int to = (unsigned int)msg->buf;
>                        ^
>    In file included from drivers/spi/spi-ti-qspi.c:16:0:
>    include/linux/kernel.h:755:16: warning: comparison of distinct pointer types lacks a cast
>      (void) (&min1 == &min2);   \
>                    ^
>    include/linux/kernel.h:758:2: note: in expansion of macro '__min'
>      __min(typeof(x), typeof(y),   \
>      ^~~~~
>    drivers/spi/spi-ti-qspi.c:449:21: note: in expansion of macro 'min'
>       size_t xfer_len = min(QSPI_DMA_BUFFER_SIZE, readsize);
>                         ^~~
>    drivers/spi/spi-ti-qspi.c:455:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>       memcpy((void *)to, qspi->rx_bb_addr, xfer_len);
>              ^
> 
> vim +440 drivers/spi/spi-ti-qspi.c
> 
>    434	}
>    435	
>    436	static int ti_qspi_dma_bounce_buffer(struct ti_qspi *qspi,
>    437					     struct spi_flash_read_message *msg)
>    438	{
>    439		size_t readsize = msg->len;
>  > 440		unsigned int to = (unsigned int)msg->buf;
>    441		dma_addr_t dma_src = qspi->mmap_phys_base + msg->from;
>    442		int ret = 0;
>    443	
>    444		/*
>    445		 * Use bounce buffer as FS like jffs2, ubifs may pass
>    446		 * buffers that does not belong to kernel lowmem region.
>    447		 */
>    448		while (readsize != 0) {
>  > 449			size_t xfer_len = min(QSPI_DMA_BUFFER_SIZE, readsize);
>    450	
>    451			ret = ti_qspi_dma_xfer(qspi, qspi->rx_bb_dma_addr,
>    452					       dma_src, xfer_len);
>    453			if (ret != 0)
>    454				return ret;
>  > 455			memcpy((void *)to, qspi->rx_bb_addr, xfer_len);
>    456			readsize -= xfer_len;
>    457			dma_src += xfer_len;
>    458			to += xfer_len;
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
