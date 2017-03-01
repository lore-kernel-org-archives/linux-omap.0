From: Vignesh R <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/2] mtd: spi-nor: Introduce bounce buffer to handle
 vmalloc'd buffers
Date: Wed, 1 Mar 2017 10:43:24 +0530
Message-ID: <d42ef265-0328-d2f3-bcf2-f98d748c8e0c@ti.com>
References: <20170227120839.16545-1-vigneshr@ti.com>
 <20170227120839.16545-2-vigneshr@ti.com>
 <8e441369-5c15-d711-1789-b55eadf33c8f@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <8e441369-5c15-d711-1789-b55eadf33c8f@nod.at>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: Frode Isaksen <fisaksen@baylibre.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 01 March 2017 03:09 AM, Richard Weinberger wrote:
> Vignesh,
> 
> Am 27.02.2017 um 13:08 schrieb Vignesh R:
>> Filesystems like UBIFS may pass vmalloc'd buffers to SPI NOR layer which
>> will end up in SPI layer. SPI core does try to handle such buffers (see
>> spi_map_buf()) by doing vmalloc_to_page() and creating scatterlist. But,
>> its known that this does not work well with VIVT/aliasing cache
>> architectures.
>> This also fails when buffers are addressed using LPAE (buffers in region
>> higher than 32 bit addressable region), if DMA is 32bit only.
>>
>> Introduce bounce buffers support in SPI NOR framework to handle
>> vmalloc'd buffers. Use a pre-allocated per flash bounce buffer equal to
>> the sector size of the flash. Flash drivers can enable this feature by
>> setting SNOR_F_USE_BOUNCE_BUFFER flag.
>> This would also enable SPI NOR drivers to safely use DMA in their
>> read/write callbacks.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 30 +++++++++++++++++++++++++++---
>>  include/linux/mtd/spi-nor.h   |  4 ++++
>>  2 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 747645c74134..c241fefa5aff 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/mutex.h>
>>  #include <linux/math64.h>
>>  #include <linux/sizes.h>
>> +#include <linux/mm.h>
>>  
>>  #include <linux/mtd/mtd.h>
>>  #include <linux/of_platform.h>
>> @@ -1205,11 +1206,21 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>>  
>>  	while (len) {
>>  		loff_t addr = from;
>> +		bool use_bb = false;
>> +		u_char *dst_buf = buf;
>> +		size_t buf_len = len;
>>  
>>  		if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
>>  			addr = spi_nor_s3an_addr_convert(nor, addr);
>>  
>> -		ret = nor->read(nor, addr, len, buf);
>> +		if (!virt_addr_valid(buf) && nor->bounce_buf) {
>> +			use_bb = true;
>> +			dst_buf = nor->bounce_buf;
>> +			if (len > mtd->erasesize)
>> +				buf_len = mtd->erasesize;
> 
> Doesn't this degrade the read operation to a short read?
> Not sure whether this is harmless or not.

It would not be practical to allocate very large buffer using kmalloc as
that migh just take away significant chunk of contiguous kernel memory
(which may be idle when flash is not in use in case of pre-allocated
buffer). Also allocating and deallocating on demand might lead for
fragmentation.
I am trying to find a balance between performance and memory usage.
Whats the max read size we can expect here? Could you provide some
insight from UBIFS perspective?

>From my experiments of reading 20MB file from JFFS2/UBIFS, I haven't
seen read requests larger than mtd->erasesize that use vmalloc'd buffers.


> Cyrille?
> 
>> +		}
>> +
>> +		ret = nor->read(nor, from, buf_len, dst_buf);
>>  		if (ret == 0) {
>>  			/* We shouldn't see 0-length reads */
>>  			ret = -EIO;
>> @@ -1217,7 +1228,8 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>>  		}
>>  		if (ret < 0)
>>  			goto read_err;
>> -
>> +		if (use_bb)
>> +			memcpy(buf, dst_buf, ret);
>>  		WARN_ON(ret > len);
>>  		*retlen += ret;
>>  		buf += ret;
>> @@ -1329,6 +1341,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>>  		return ret;
>>  
>>  	for (i = 0; i < len; ) {
>> +		const u_char *src_buf = buf + i;
>>  		ssize_t written;
>>  		loff_t addr = to + i;
>>  
>> @@ -1354,8 +1367,13 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>>  		if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
>>  			addr = spi_nor_s3an_addr_convert(nor, addr);
>>  
>> +		if (!virt_addr_valid(buf) && nor->bounce_buf) {
>> +			memcpy(nor->bounce_buf, buf + i, page_remain);
>> +			src_buf = nor->bounce_buf;
>> +		}
>> +
>>  		write_enable(nor);
>> -		ret = nor->write(nor, addr, page_remain, buf + i);
>> +		ret = nor->write(nor, addr, page_remain, src_buf);
>>  		if (ret < 0)
>>  			goto write_err;
>>  		written = ret;
>> @@ -1720,6 +1738,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>>  		return -EINVAL;
>>  	}
>>  
>> +	if (nor->flags & SNOR_F_USE_BOUNCE_BUFFER) {
>> +		nor->bounce_buf = devm_kmalloc(dev, mtd->erasesize, GFP_KERNEL);
>> +		if (!nor->bounce_buf)
>> +			dev_err(dev, "unable to allocated bounce buffer\n");
> 
> I think we should return here and not continue.
> 

Agreed.

-- 
Regards
Vignesh

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
