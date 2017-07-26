From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v3 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Wed, 26 Jul 2017 09:54:15 -0700
Message-ID: <9b856bf5-f404-5cfc-6f1e-5ae527c6e0b1@oracle.com>
References: <20170724212454.27574-1-d-gerlach@ti.com>
 <20170724212454.27574-3-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724212454.27574-3-d-gerlach@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org


On 7/24/2017 2:24 PM, Dave Gerlach wrote:
> Certain SoCs like Texas Instruments AM335x and AM437x require parts
> of the EMIF PM code to run late in the suspend sequence from SRAM,
> such as saving and restoring the EMIF context and placing the memory
> into self-refresh.
> 
> One requirement for these SoCs to suspend and enter its lowest power
> mode, called DeepSleep0, is that the PER power domain must be shut off.
> Because the EMIF (DDR Controller) resides within this power domain, it
> will lose context during a suspend operation, so we must save it so we
> can restore once we resume. However, we cannot execute this code from
> external memory, as it is not available at this point, so the code must
> be executed late in the suspend path from SRAM.
> 
> This patch introduces a ti-emif-sram driver that includes several
> functions written in ARM ASM that are relocatable so the PM SRAM
> code can use them. It also allocates a region of writable SRAM to
> be used by the code running in the executable region of SRAM to save
> and restore the EMIF context. It can export a table containing the
> absolute addresses of the available PM functions so that other SRAM
> code can branch to them. This code is required for suspend/resume on
> AM335x and AM437x to work.
> 
> In addition to this, to be able to share data structures between C and
> the ti-emif-sram-pm assembly code, we can automatically generate all of
> the C struct member offsets and sizes as macros by making use of the ARM
> asm-offsets file. In the same header that we define our data structures
> in we also define all the macros in an inline function and by adding a
> call to this in the asm_offsets file all macros are properly generated
> and available to the assembly code without cluttering up the asm-offsets
> file.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v2->v3:
> * Move all static vars into common struct and instead point to one static
>    instance of this struct and pass this struct around for internal calls.
> * Rename ti_emif_prepare_push_sram to ti_emif_alloc_sram
> * Clean up probe path to avoid leftover vairable values from being used
>    after probe defer or failure.
> * Fix mistake in ASM code that stored EMIF_POWER_MANAGEMENT_CONTROL into
>    location for shadow register.
> * Avoid extern definition for asm-offsets definition and use a stub instead
>    of defining out in asm-offsets.
> * A few general fixups to code.
> 
>   arch/arm/kernel/asm-offsets.c    |   4 +
>   drivers/memory/Kconfig           |  10 ++
>   drivers/memory/Makefile          |   4 +
>   drivers/memory/emif.h            |  17 ++
>   drivers/memory/ti-emif-pm.c      | 339 +++++++++++++++++++++++++++++++++++++++
>   drivers/memory/ti-emif-sram-pm.S | 334 ++++++++++++++++++++++++++++++++++++++
>   include/linux/ti-emif-sram.h     | 147 +++++++++++++++++
>   7 files changed, 855 insertions(+)
>   create mode 100644 drivers/memory/ti-emif-pm.c
>   create mode 100644 drivers/memory/ti-emif-sram-pm.S
>   create mode 100644 include/linux/ti-emif-sram.h
> 
I will need RMKs blessing since he reviewed the ASM code.

Also need work out how to line this up. Typically I use to get
driver/memory patches via Greg's driver-core but this is more
PM code than memory driver and very SOC specific.

Hi Arnd/Olof,
Will you be ok to pull this via arm-soc ? There is also follow
up platform PM code and DTS series which will make use of this.

Regards,
Santosh
