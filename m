From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] spi: Add DMA support for spi_flash_read()
Date: Tue, 12 Apr 2016 13:50:48 +0530
Message-ID: <570CAFE0.1070604@ti.com>
References: <1459828192-5531-1-git-send-email-vigneshr@ti.com>
 <1459828192-5531-2-git-send-email-vigneshr@ti.com>
 <20160412043115.GV3351@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160412043115.GV3351@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 04/12/2016 10:01 AM, Mark Brown wrote:
> On Tue, Apr 05, 2016 at 09:19:51AM +0530, Vignesh R wrote:
> 
>>  	mutex_lock(&master->bus_lock_mutex);
>> +	if (master->dma_rx) {
>> +		rx_dev = master->dma_rx->device->dev;
>> +		ret = spi_map_buf(master, rx_dev, &msg->rx_sg,
>> +				  msg->buf, msg->len,
>> +				  DMA_FROM_DEVICE);
>> +		if (ret != 0)
>> +			goto  err;
>> +	}
> 
> This is unconditionally DMA mapping the buffer if DMA is supported.
> That's going to be common but I'm not sure it'll be universal, we need
> to think of something better here.  I'm not immediately seeing what
> though.  Possibly a flag...
> 

Ok, I will introduced a flag along the lines of cur_msg_mapped currently
part of spi_message struct.

This reminds me the issue of possible kmap'd buffers(falling in
PKMAP_BASE - PAGE_OFFSET-1  region) that might be passed to
spi_map_buf() which are not currently being handled properly. Boris
attempted to fix this in generic way[1] but was rejected as it couldn't
handle all type of caches.
I was wondering whether you would accept a patch returning error when
kmap'd buffers are passed to spi_map_buf()? Or would it still make sense
to port changes from that series to handle kmap'd buffers to SPI core alone?

[1]https://lkml.org/lkml/2016/3/31/462

-- 
Regards
Vignesh
