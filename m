From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 3/5] mtd: devices: m25p80: add support for mmap read
 request
Date: Wed, 16 Sep 2015 15:37:11 +0530
Message-ID: <55F93F4F.1010704@ti.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-4-git-send-email-vigneshr@ti.com>
 <20150914182704.GD12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150914182704.GD12027@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, hramrach@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 09/14/2015 11:57 PM, Mark Brown wrote:
> On Fri, Sep 04, 2015 at 02:00:00PM +0530, Vignesh R wrote:
> 
>> +	if (spi->master->spi_mtd_mmap_read) {
>> +		return  spi->master->spi_mtd_mmap_read(spi, from, len,
>> +						       retlen, buf,
>> +						       nor->read_opcode,
>> +						       nor->addr_width,
>> +						       dummy);
>> +	}
> 
> We should be calling some API provided by the SPI core here, not peering
> directly into the ops struture.
> 

Ok..
-- 
Regards
Vignesh
