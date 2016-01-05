From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v5 0/5] Add memory mapped read support for ti-qspi
Date: Tue, 5 Jan 2016 10:50:42 +0530
Message-ID: <568B52AA.4070900@ti.com>
References: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, hramrach@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Brian,

On 12/11/2015 09:39 AM, Vignesh R wrote:
> Changes since v4:
> Use syscon to access system control module register in ti-qspi driver.
> 

Gentle ping...
Are you ok with MTD side changes of this patch series?

> Changes since v3:
> Rework to introduce spi_flash_read_message struct.
> Support different opcode/addr/data formats as per Brian's suggestion
> here: https://lkml.org/lkml/2015/11/11/454
> 
> Changes since v2:
> Remove mmap_lock_mutex.
> Optimize enable/disable of mmap mode.
> 
> Changes since v1:
> Introduce API in SPI core that MTD flash driver can call for mmap read
> instead of directly calling spi-master driver callback. This API makes
> sure that SPI core msg queue is locked during mmap transfers.
> v1: https://lkml.org/lkml/2015/9/4/103
> 
> 
> Cover letter:
> 
> This patch series adds support for memory mapped read port of ti-qspi.
> ti-qspi has a special memory mapped port through which SPI flash
> memories can be accessed directly via SoC specific memory region.
> 
> First patch adds a method to pass flash specific information like read
> opcode, dummy bytes etc and to request mmap read. Second patch
> implements mmap read method in ti-qspi driver. Patch 3 adapts m25p80 to
> use mmap read method before trying normal SPI transfer. Patch 4 and 5
> add memory map region DT entries for DRA7xx and AM43xx SoCs.
> 
> This patch series is based on the discussions here:
> http://www.spinics.net/lists/linux-spi/msg04796.html
> 
> Tested on DRA74 EVM and AM437x-SK.
> Read performance increases from ~100kB/s to ~2.5MB/s.
> 
> Vignesh R (5):
>   spi: introduce accelerated read support for spi flash devices
>   spi: spi-ti-qspi: add mmap mode read support
>   mtd: devices: m25p80: add support for mmap read request
>   ARM: dts: DRA7: add entry for qspi mmap region
>   ARM: dts: AM4372: add entry for qspi mmap region
> 
>  Documentation/devicetree/bindings/spi/ti_qspi.txt |  22 +++-
>  arch/arm/boot/dts/am4372.dtsi                     |   4 +-
>  arch/arm/boot/dts/dra7.dtsi                       |   6 +-
>  drivers/mtd/devices/m25p80.c                      |  20 ++++
>  drivers/spi/spi-ti-qspi.c                         | 139 +++++++++++++++++-----
>  drivers/spi/spi.c                                 |  45 +++++++
>  include/linux/spi/spi.h                           |  41 +++++++
>  7 files changed, 243 insertions(+), 34 deletions(-)
> 

-- 
Regards
Vignesh
