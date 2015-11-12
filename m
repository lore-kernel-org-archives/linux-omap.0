From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Thu, 12 Nov 2015 10:02:56 +0530
Message-ID: <56441678.6040504@ti.com>
References: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
 <1447133399-25658-2-git-send-email-vigneshr@ti.com>
 <20151111192441.GG12143@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151111192441.GG12143@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Michal Suchanek <hramrach@gmail.com>, Russell King <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Vasut <marex@denx.de>
List-Id: linux-omap@vger.kernel.org

Hi Brian,

On 11/12/2015 12:54 AM, Brian Norris wrote:
> In addition to my other comments:
> 

[...]

>> +	int (*spi_mtd_mmap_read)(struct  spi_device *spi,
>> +				 loff_t from, size_t len,
>> +				 size_t *retlen, u_char *buf,
>> +				 u8 read_opcode, u8 addr_width,
>> +				 u8 dummy_bytes);
> 
> This is seeming to be a longer and longer list of arguments. I know MTD
> has a bad habit of long argument lists (which then cause a ton of
> unnecessary churn when things need changed in the API), but perhaps we
> can limit the damage to the SPI layer. Perhaps this deserves a struct to
> encapsulate all the flash read arguments? Like:
> 
> struct spi_flash_read_message {
> 	loff_t from;
> 	size_t len;
> 	size_t *retlen;
> 	void *buf;
> 	u8 read_opcode;
> 	u8 addr_width;
> 	u8 dummy_bits;
> 	// additional fields to describe rx_nbits for opcode/addr/data
> };
> 
> struct spi_master {
> 	...
> 	int (*spi_flash_read)(struct spi_device *spi,
> 			      struct spi_flash_message *msg);
> };


Yeah.. I think struct encapsulation helps, this can also be used to pass
sg lists for dma in future. I will rework the series with your
suggestion to include nbits for opcode/addr/data.
Also, will add validation logic (similar to __spi_validate()) to check
whether master supports dual/quad mode for opcode/addr/data. I am
planning to add this validation code to spi_flash_read_validate(in place
of spi_mmap_read_supported())
Thanks!


-- 
Regards
Vignesh
