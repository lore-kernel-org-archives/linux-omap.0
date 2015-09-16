From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Wed, 16 Sep 2015 15:37:00 +0530
Message-ID: <55F93F44.3090706@ti.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-2-git-send-email-vigneshr@ti.com>
 <CAD6G_RT8Q+Uyp1ZjzHf54Tno1wHm0SmLKEwRAe2gkdp772FD9A@mail.gmail.com>
 <20150914183553.GE12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150914183553.GE12027@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jagan Teki <jteki@openedev.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, hramrach@gmail.com, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org



On 09/15/2015 12:05 AM, Mark Brown wrote:
> On Fri, Sep 04, 2015 at 04:55:33PM +0530, Jagan Teki wrote:
>> On 4 September 2015 at 13:59, Vignesh R <vigneshr@ti.com> wrote:
> 
>>> + * @spi_mtd_mmap_read: some spi-controller hardwares provide memory
>>> + *                     mapped interface to communicate with mtd flashes.
>>> + *                     For this, spi  controller needs to know flash
>>> + *                     memory settings like read command to use, dummy
>>> + *                     bytes and address width. Once these settings are
>>> + *                     populated in hardware registers, any read
>>> + *                     accesses to flash's memory map region(as defined
>>> + *                     by SoC) through memcpy or mem-to-mem DMA copy
>>> + *                     will be handled by controller hardware. The
>>> + *                     hardware will automatically generate spi signals
>>> + *                     required to read data from flash and present it
>>> + *                     to CPU or DMA. SPI master drivers can use this
>>> + *                     callback to implement memory mapped read
>>> + *                     interface. Flash driver (like m25p80) requests
>>> + *                     memory mapped read via this method. The interface
>>> + *                     should  only be used mtd flashes and cannot be
>>> + *                     used with other spi devices.
> 
> This comment is *way* too verbose - probably you just need up to the
> "Once" here.
> 

Ok, I will move the extra text to commit log.


-- 
Thanks,
Vignesh
