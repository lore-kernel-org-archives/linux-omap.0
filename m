From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5] spi: spi-ti-qspi: Add DMA support for QSPI mmap read
Date: Tue, 9 Aug 2016 18:20:01 +0530
Message-ID: <13e676c2-7e2f-d1c5-5312-bc2e11a6b6a1@ti.com>
References: <20160809110311.13521-1-vigneshr@ti.com>
 <20160809113329.GA9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160809113329.GA9347-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 09 August 2016 05:03 PM, Mark Brown wrote:
> On Tue, Aug 09, 2016 at 04:33:11PM +0530, Vignesh R wrote:
> 
>> +static int ti_qspi_map_buf(struct ti_qspi *qspi, void *buf,
>> +			   unsigned int len, struct sg_table *sgt)
>> +{
>> +	unsigned int max_seg_size =
>> +		dma_get_max_seg_size(qspi->rx_chan->device->dev);
>> +	unsigned int desc_len = min_t(int, max_seg_size, PAGE_SIZE);
>> +	int sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
>> +	struct page *vm_page;
>> +	size_t min;
>> +	int i, ret;
>> +
>> +	ret = sg_alloc_table(sgt, sgs, GFP_KERNEL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < sgs; i++) {
>> +		min = min_t(size_t, len, desc_len -
>> +			    offset_in_page(buf));
>> +		vm_page = kmap_to_page(buf);
>> +		if (!vm_page) {
>> +			sg_free_table(sgt);
>> +			return -ENOMEM;
>> +		}
>> +		sg_set_page(&sgt->sgl[i], vm_page, min,
>> +			    offset_in_page(buf));
>> +		buf += min;
>> +		len -= min;
> 
> This looks a lot like the core code for mapping the buffers - why is
> this open coded rather than reused?

According to this thread[1], converting virtual address
pointer into scatterlist which is then DMA mapped is unsafe on systems
with certain cache architecture. Hence, I added code to handle kmap
buffers inside the driver rather than updating generic spi-core code.
If its okay to update the spi_map_buf() to handle kmap buffers as above
then I can submit the patch accordingly.

[1]https://patchwork.kernel.org/patch/8712161/

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
