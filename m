From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v5] spi: spi-ti-qspi: Add DMA support for QSPI mmap read
Date: Wed, 17 Aug 2016 10:43:12 +0530
Message-ID: <7f441117-8fd9-6681-70c8-85fb6de40631@ti.com>
References: <20160809110311.13521-1-vigneshr@ti.com>
 <20160809113329.GA9347@sirena.org.uk>
 <13e676c2-7e2f-d1c5-5312-bc2e11a6b6a1@ti.com>
 <20160816184253.GC9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160816184253.GC9347@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Wednesday 17 August 2016 12:12 AM, Mark Brown wrote:
> On Tue, Aug 09, 2016 at 06:20:01PM +0530, Vignesh R wrote:
>>
>>
> 
>> According to this thread[1], converting virtual address
>> pointer into scatterlist which is then DMA mapped is unsafe on systems
>> with certain cache architecture. Hence, I added code to handle kmap
>> buffers inside the driver rather than updating generic spi-core code.
> 
> That's saying that things that aren't covered aren't DMAable safely at
> all which is a more general issue...
> 
>> If its okay to update the spi_map_buf() to handle kmap buffers as above
>> then I can submit the patch accordingly.
> 
> Yes, the whole point is that this is all in generic code so drivers
> don't need to worry about it.

Ok, I will send another version updating spi_map_buf() to handle kmap
buffers. Thanks!

-- 
Regards
Vignesh
