From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCHv2 07/10] drivers: mtd: m25p80: Adapt driver to support
 memory mapped read.
Date: Thu, 12 Dec 2013 13:45:24 +0530
Message-ID: <52A9709C.4010606@ti.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com> <1386339891-32717-8-git-send-email-sourav.poddar@ti.com> <20131212075536.GA1596@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46392 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399Ab3LLIP6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 03:15:58 -0500
In-Reply-To: <20131212075536.GA1596@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Huang Shijie <shijie8@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, computersforpeace@gmail.com, marex@denx.de, devicetree@vger.kernel.org, balbi@ti.com, linux-mtd@lists.infradead.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, dwmw2@infradead.org

On Thursday 12 December 2013 01:25 PM, Huang Shijie wrote:
> On Fri, Dec 06, 2013 at 07:54:48PM +0530, Sourav Poddar wrote:
>> Adapt driver to do a memory mapped read.
>> @@ -109,6 +109,7 @@ struct m25p {
>>   	u8			program_opcode;
>>   	u8			*command;
>>   	enum read_type		flash_read;
>> +	void __iomem *mem_addr;
> I think we can remove this field.
> You can use a local variable in the m25p80_read.
>
>>   };
>>
>>   static inline struct m25p *mtd_to_m25p(struct mtd_info *mtd)
>> @@ -515,6 +516,7 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
>>   	size_t *retlen, u_char *buf)
>>   {
>>   	struct m25p *flash = mtd_to_m25p(mtd);
>> +	struct spi_master *master = flash->spi->master;
>>   	struct spi_transfer t[2];
>>   	struct spi_message m;
>>   	uint8_t opcode;
>> @@ -523,6 +525,20 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
>>   	pr_debug("%s: %s from 0x%08x, len %zd\n", dev_name(&flash->spi->dev),
>>   			__func__, (u32)from, len);
>>
>> +	if (master->mmap) {
>> +		mutex_lock(&flash->lock);
>> +		/* Wait till previous write/erase is done. */
>> +		if (wait_till_ready(flash)) {
>> +			mutex_unlock(&flash->lock);
>> +			return 1;
>> +		}
>> +		flash->mem_addr = master->get_buf(master);
>> +		memcpy(buf, flash->mem_addr + from, len);
>> +		master->put_buf(master);
>> +		*retlen = len;
>> +		goto out;
>> +	}
>> +
>>   	spi_message_init(&m);
>>   	memset(t, 0, (sizeof t));
>>
>> @@ -558,6 +574,7 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
>>
>>   	*retlen = m.actual_length - m25p_cmdsz(flash) - dummy;
>>
>> +out:
>>   	mutex_unlock(&flash->lock);
>>
>>   	return 0;
>> @@ -1286,6 +1303,9 @@ static int m25p_probe(struct spi_device *spi)
>>   		flash->addr_width = 3;
>>   	}
>>
>> +	if (spi->master->configure_from_slave)
>> +		m25p80_fill_flash_information(flash);
>> +
> You have add a configure_from_slave hook in the SPI, why you also need
> a same hook in the SPI-NOR framework?
>
We need a way to provoke this, currently it is placed in m25p80. If m25p80
is removed, for where should I handle these in nor framework?
> And i think the enable_mmap/disable_mmap is not needed too.
>
> All the three hooks are used to set the SPI bus controller.

> And the SPI-NOR framework only handles the issues between the
> SPI bus controller and the SPI-NOR, or the SPI-NOR controller and the
> SPI-NOR.
My controller can be used as spi flash controller as well as a spi
controller.
> thanks
> Huang Shijie
>
>

