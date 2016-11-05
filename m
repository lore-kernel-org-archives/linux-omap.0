From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 0/3] Add memremap executable mapping and extend
 drivers/misc/sram.c
Date: Sat, 5 Nov 2016 03:47:46 +0100
Message-ID: <20161105024746.hgkdrgjmu6lehy6a@piout.net>
References: <20161027185612.22362-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161027185612.22362-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 27/10/2016 at 13:56:09 -0500, Dave Gerlach wrote :
> There are several instances when one would want to execute out of on-chip
> SRAM, such as PM code on ARM platforms, so once again revisiting this
> series to allow that in a generic manner. Seems that having a solution for
> allowing SRAM to be mapped as executable will help clean up PM code on several
> ARM platforms that are using ARM internal __arm_ioremap_exec API
> and also open the door for PM support on new platforms like TI AM335x and
> AM437x. This was last sent as RFC here [1] and based on comments from Russell
> King and Arnd Bergmann has been rewritten to use memremap API rather than
> ioremap API, as executable iomem does not really make sense.
> 
> I still see several platforms (at-91, imx6, socfpga) that could make use
> of this and use the generic sram driver to allocate the SRAM needed for PM.
> This series allows direct allocation of SRAM using the generic SRAM driver
> that will be already mapped as executable. Otherwise platform SRAM allocation
> code must be used or if the generic sram driver is used as-is the memory
> must be remapped as executable after it has been mapped normally by the
> SRAM driver.
> 

Rockchip also actually needs that.

> I had sent omap3 series to convert from using old omap sram platform
> mapping code to using the generic sram driver instead here [2] which was
> based on previous RFC but can easily be rebased on this updated series.
> Finally, forthcoming TI am335x and am437x PM code must make use of
> it as well, as portions of PM code are moving in to drivers.
> 
> Changes from the RFC include:
> 
> - Rather than introduce ioremap_exec API, use memremap API, as the concept
>   of executable iomem does not make sense; any memory that can used to
>   run code should not have io side effects like iomem.
> - Rather than having a fallback mapping if a platform does not support
>   exec mappings under the memremap API, have the mapping fail, as if you
>   are mapping memory as exec, presumably you will then try to run code
>   from it which will fail anyway, so it makes more sense to prevent the
>   mapping in the first place.
> - Update sram driver to use memremap rather than ioremap for exec flags.
> 
> Regards,
> Dave
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg503071.html
> [2] http://www.spinics.net/lists/linux-omap/msg128753.html
> 
> Dave Gerlach (3):
>   ARM: memremap: implement arch_memremap_exec/exec_nocache
>   memremap: add MEMREMAP_EXEC and MEMREMAP_EXEC_NOCACHE flags
>   misc: SRAM: Add option to map SRAM to allow code execution
> 
>  Documentation/devicetree/bindings/sram/sram.txt |  2 ++
>  arch/arm/include/asm/io.h                       |  5 ++++
>  arch/arm/mm/ioremap.c                           | 16 ++++++++++++
>  arch/arm/mm/nommu.c                             | 12 +++++++++
>  drivers/misc/sram.c                             |  7 +++++
>  include/linux/io.h                              |  2 ++
>  kernel/memremap.c                               | 34 ++++++++++++++++++++++++-
>  7 files changed, 77 insertions(+), 1 deletion(-)
> 

To the whole series:
Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>



-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
