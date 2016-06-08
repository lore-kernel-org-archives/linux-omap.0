From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 2/2] spi: spi-ti-qspi: Add DMA support for QSPI mmap
 read
Date: Wed, 8 Jun 2016 12:23:42 +0530
Message-ID: <5757C0F6.20906@ti.com>
References: <20160607081810.6640-1-vigneshr@ti.com>
 <20160607081810.6640-3-vigneshr@ti.com>
 <1d3484c6-6f9e-847c-3e22-9b1726700a37@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1d3484c6-6f9e-847c-3e22-9b1726700a37@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 07 June 2016 02:47 PM, Peter Ujfalusi wrote:
[...]
>> @@ -637,6 +770,33 @@ static int ti_qspi_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto free_master;
>>  
>> +	dma_cap_zero(mask);
>> +	dma_cap_set(DMA_MEMCPY, mask);
>> +
>> +	qspi->rx_chan = dma_request_channel(mask, NULL, NULL);
> 
> dma_request_channel is deprecated, please use the:
> dma_request_chan_by_mask()
> 

Updated to use dma_request_chan_by_mask() in v4, Thanks.


-- 
Regards
Vignesh
