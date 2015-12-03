From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v4 4/5] ARM: dts: DRA7: add entry for qspi mmap region
Date: Thu, 3 Dec 2015 15:51:28 +0530
Message-ID: <566017A8.5040106@ti.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
 <1448860515-28336-5-git-send-email-vigneshr@ti.com>
 <20151130223408.GJ23396@atomide.com> <565D25E6.4070206@ti.com>
 <20151201163950.GR23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151201163950.GR23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, "hramrach@gmail.com" <hramrach@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 12/01/2015 10:09 PM, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [151130 20:46]:
>> On 12/01/2015 04:04 AM, Tony Lindgren wrote:
>>>
>>> Actually none of the IO areas above are within the same interconnect target:
>>>
>>> 0x4b300000  QSPI0 address space in L3 main interconnect
>>> 0x5c000000  QSPI1 address space in L3 main interconnect
>>
>>
>> First address range (configuration port: 0x4b300000) corresponds to QSPI
>> registers space. These registers alone are sufficient for generic SPI
>> communication (serial flash as well as non-flash SPI devices).
> 
> OK
> 
>> In order to speed up SPI flash reads SFI_MM_IF(SPI memory mapped
>> interface) is provided by QSPI IP. This _cannot_ be used with non-flash
>> devices.
> 
> OK
> 
>> The second address range (0x5c000000) corresponds to memory-mapped
>> region of SFI_MM_IF, through which SPI flash memories can be read as if
>> though they were RAM addresses (i.e using readl/memcpy). The SFI_MM_IF
>> block that takes care of communicating over SPI bus and getting the data
>> from flash device.
> 
> OK
> 
>> But SFI_MM_IF block needs to know some flash specific information(such
>> as read opcode, address bytes, dummy bytes, mode). This information must
>> first be populated in QSPI_SPI_SETUP*_REG(0x4B300054-60) before
>> accessing SFI_MM_IF address range via readl.
>> Both addresses space belong to same instance of the driver, one
>> corresponds to register space and other is memory-mapped region.
>> Therefore both regions are claimed by the same driver.
> 
> OK
> 
>>> 0x4a002558  CTRL_CORE_CONTROL_IO_2 in System Control Module (SCM) in L4_CFG
>>>
>>> The first two address spaces should be two separate instances of this driver.
>>
>> Not actually two instances.
> 
> OK. They are both on L3 main so that won't cause any issues for separate
> interconnect driver instances. As they are still separate targets flushing
> a posted write to one area will not flush anything to the other.
> 

I didn't quite understand what you meant by interconnect driver instance.
qspi_base and qspi_mmap region are tightly bound to each other and both
needs to be accessed by ti-qspi driver (though different targets).
Besides qspi_mmap region is only used to read data, there will not be
any write accesses to this target. Are you saying this binding is not
viable?

>>> The CTRL_CORE_CONTROL_IO_2 needs seems like a shared clock register that
>>> needs to be accessed using the clock framework most likely.
>>>
>>
>> Not shared clock.
>> The CTRL_CORE_CONTROL_IO_2[10:8] QSPI_MEMMAPPED_CS bit fields provides a
>> functionality for remapping the previously described address space which
>> starts at 0x5C000000 L3_MAIN address to one of the four supported chip
>> selects.
>> How about using syscon to access CTRL_CORE_CONTROL_IO_2?
> 
> A separate driver implementing some Linux generic framework would be idael :)
> 
> But if that does not fit, yeah then syscon makes sense as that IO range
> will be on separate interconnect driver (and clock and possibly power domain)
> instances eventually.
> 

I will go ahead with syscon for accessing CTRL_CORE_CONTROL_IO_2 register.

-- 
Regards
Vignesh
