From: Vignesh R <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Fri, 7 Aug 2015 14:05:10 +0530
Message-ID: <55C46DBE.7060809@ti.com>
References: <20150805115013.GJ20873@sirena.org.uk> <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com> <20150805124412.GN20873@sirena.org.uk> <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com> <20150806090202.GO20873@sirena.org.uk> <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com> <20150806102225.GI7576@n2100.arm.linux.org.uk> <55C35233.2000105@ti.com> <20150806135129.GJ7576@n2100.arm.linux.org.uk> <CAMuHMdWWDwZ=ziGQXFCnOX8pErXpsEi533J73_Hh=sEqq4hR6Q@mail.gmail.com> <20150806213340.GK7576@n2100.arm.linux.org.uk> <CAOMqctRBW230fA4AEhK7MyqkZY==6ENNNHE-LVm7-mHKA_VzRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMqctRBW230fA4AEhK7MyqkZY==6ENNNHE-LVm7-mHKA_VzRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Suchanek <hramrach@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Mark Brown <broonie@kernel.org>, devicetree <devicetree@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Huang Shijie <b32955@freescale.com>, MTD Maling List <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org



On 08/07/2015 01:08 PM, Michal Suchanek wrote:

> Now since the description is clearer it's obvious that ti-qspi cannot
> work fully mmapped as fsl-qspi does because the setup has to be done
> over normal spi access and using non-m25p80 devices on the same bus is
> a requirement.
> 
> The place where it is known if a transfer can use the mmap access is m25p80.c
> 
> So my suggestion is
> 
>  - add a new method for spi master that gets the read opcode, dummy
> length, address, address length, buffer, buffer length and performs
> read from the flash memory in a hardware-specific way
> 
> - add a check in m25p80.c that the master supports this feature and if
> so use it (eg check that the method is non-null)
> 
> Presumably if some new SPI controllers with similar feature are
> supported in the future they can use the same inteface because you
> pass on everything the m25p80 read knows.
> 

Ok... Do you mean something like this?

I will take m25p80 as example but can be expanded for any flash.

In include/linux/mtd.h:
	struct spi_mtd_config_info {
		struct spi_device 	*spi;
	        u32                     page_size;
	        u8                      addr_width;
       		u8                      erase_opcode;
	        u8                      read_opcode;
        	u8                      read_dummy;
	        u8                      program_opcode;
        	enum read_mode          flash_read;

	} /* subset of struct spi_nor */


In m25p80.c:

	static int m25p80_read(struct spi_nor *nor, loff_t from,
				size_t len, size_t *retlen,
				u_char *buf)
	{
		struct spi_mtd_config_info info;
		struct spi_device *spi;
		
		if (spi->master->spi_mtd_mmap_read) {
		  /* Populate spi_mtd_config_info */
		  spi->master->spi_mtd_mmap_read(&info, from, len,
						 retlen, buf);
		}
		else {
		/* no mtd specific acceleration supported try normal
		 * SPI way of communicating with flash
		 * continue with current code
		 * set up spi_message and call spi_sync()
		 */
	}

      }

In spi-ti-qspi.c:
Implement spi_mtd_mmap_read while holding master->bus_lock mutex.


-- 
Regards
Vignesh
