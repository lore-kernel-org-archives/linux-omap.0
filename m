From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/4] drivers: iio: ti_am335x_adc: add dma support
Date: Thu, 22 Sep 2016 14:16:42 +0300
Message-ID: <30294b90-af44-d8cf-d70b-92a9461f1e5f@ti.com>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
 <20160921161134.6951-3-mugunthanvnm@ti.com>
 <1dbd7bbd-36ac-4433-79bf-8975a06dd07e@ti.com>
 <0cd3dfcc-2525-c2fb-35ab-1b260c5973a8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0cd3dfcc-2525-c2fb-35ab-1b260c5973a8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>, Vignesh R <vigneshr@ti.com>, linux-iio@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, "Andrew F . Davis" <afd@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On 09/22/16 13:45, Mugunthan V N wrote:
>>> +	if (!dma->chan)
>>> +		return -ENODEV;
>>> +
>>> +	/* RX buffer */
>>> +	dma->buf = dma_alloc_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
>>> +				      &dma->addr, GFP_KERNEL);
>>> +	if (!dma->buf)
>>> +		goto err;
>>> +
>>> +	dev_dbg_ratelimited(adc_dev->mfd_tscadc->dev, "got dma channel\n");
>>
>> Do we need _ratelimited? AFAICS, this print is called only once.
> 
> True, will change to dev_dbg.

It would be better to remove it. It gives no useful debuggin information apart
from the fact that the driver did not failed to probe.

-- 
Péter
