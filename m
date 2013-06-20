From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: Device Tree for 3.11
Date: Thu, 20 Jun 2013 15:34:16 -0500
Message-ID: <51C36748.80006@ti.com>
References: <51C23902.1080301@ti.com> <20130620064541.GE5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130620064541.GE5523@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mohammed Afzal <afzal@ti.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 6/20/2013 1:45 AM, Tony Lindgren wrote:
> Arnd & Olof,
>
> * Benoit Cousson <b-cousson@ti.com> [130619 16:10]:
>> Hi Tony,
>>
>> Please pull the following commits for OMAP Device Tree for v3.11.
>>
>> It does contains as well 2 clock data patches, I hope it will not generate any conflict with Paul's tree.
>>
>> Special thanks to Florian for his nice cleanup using the C preprocessor.
>
> It's best that Arnd and Olof take this pull request directly as we're
> getting so close to the merge window. These patches should be pretty
> much independent of the other branches I've sent, and are needed to
> keep omap4 booting now that we've flipped the switch for omap4 to be
> DT only.

Thanks and sorry for that. I was not expecting all these last minutes
series :-(

I'll stop accepting at -rc5 next time.

Regards,
Benoit


>> The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:
>>
>>    Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.11/dts
>>
>> for you to fetch changes up to 153030c22defea2f96546d0f1a74fe954551c4cd:
>>
>>    ARM: dts: omap5-uevm: Provide USB Host PHY clock frequency (2013-06-19 16:59:28 -0500)
>>
>> ----------------------------------------------------------------
>> Afzal Mohammed (2):
>>        ARM: dts: AM43x: Initial support
>>        ARM: dts: AM43x EPOS EVM support
>>
>> Dan Murphy (3):
>>        ARM: dts: omap4-panda: Update the LED support for the panda
>>        ARM: dts: omap4-panda: Update the twl6040 gpio to macro definition
>>        ARM: dts: omap5-uevm: Add LED support for uEVM blue LED
>>
>> Eduardo Valentin (3):
>>        ARM: dts: OMAP443x: Add bandgap entry for OMAP443x devices
>>        ARM: dts: OMAP4460: Add bandgap entry for OMAP4460 devices
>>        ARM: dts: OMAP5: Add bandgap DT entry
>>
>> Florian Vaussard (15):
>>        ARM: dts: OMAP2+: Use #include for all device trees
>>        ARM: dts: OMAP2+: Use existing constants for GPIOs
>>        ARM: dts: OMAP4/5: Use existing constants for IRQs
>>        ARM: dts: OMAP2+: Header file for pinctrl constants
>>        ARM: dts: OMAP2+: Use pinctrl constants
>>        ARM: dts: AM3XXX: Use #include for all device trees
>>        ARM: dts: AM33XX: Use existing constants for GPIOs
>>        ARM: dts: AM33XX: Specific pinctrl header
>>        ARM: dts: AM33XX: Use pinctrl constants
>>        ARM: dts: OMAP4/AM35xx: Add missing dtb in the dtbs target
>>        ARM: dts: Protect pinctrl headers against multiple inclusions
>>        ARM: dts: OMAP3: Include IRQ header
>>        ARM: dts: omap3-tobi: Add SMSC911X node
>>        ARM: dts: omap3-tobi: Correct polarity for GPIO LED
>>        ARM: dts: omap3-overo: Add default trigger for TWL4030 LED
>>
>> J Keerthy (1):
>>        ARM: dts: OMAP5: Add Palmas MFD node and regulator nodes
>>
>> Javier Martinez Canillas (3):
>>        ARM: dts: omap3-igep0020: Add SMSC911x LAN chip support
>>        ARM: dts: omap3-igep0020: Add NAND flash support
>>        ARM: dts: omap3-igep0030: Add NAND flash support
>>
>> Kevin Hilman (3):
>>        ARM: dts: OMAP3: beagle/overo: mux console UART, enable wakeup
>>        ARM: dts: OMAP3: beagle: enable user button via gpio_keys, enable wakeup
>>        ARM: dts: TWL4030: fix mux and wakeup for SYS_NIRQ line
>>
>> Mugunthan V N (3):
>>        ARM: dts: AM33XX: Add pinmux configuration for CPSW to beaglebone
>>        ARM: dts: AM33XX: Add pinmux configuration for CPSW to EVMsk
>>        ARM: dts: AM33XX: Add pinmux configuration for CPSW to am335x EVM
>>
>> Philip Avinash (4):
>>        ARM: dts: AM33XX: Add NAND flash device tree data to am335x-evm
>>        ARM: dts: AM33XX: Add PWMSS device tree nodes
>>        ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evm
>>        ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evmsk
>>
>> Philip, Avinash (1):
>>        ARM: dts: AM33XX: Add ELM node
>>
>> Roger Quadros (4):
>>        ARM: dts: omap5-uevm: Add USB Host support
>>        ARM: dts: omap4-panda: Add USB Host support
>>        ARM: dts: omap4-panda: Fix DVI EDID reads
>>        ARM: dts: omap5-uevm: Provide USB Host PHY clock frequency
>>
>> Sourav Poddar (1):
>>        ARM: dts: omap5-uevm: Add uart pinctrl data
>>
>> Sricharan R (1):
>>        ARM: dts: omap5: Make uevm as the official board and deprecate sevm support
>>
>> Suman Anna (1):
>>        ARM: dts: OMAP4+: Remove multimedia carveouts
>>
>> Vaibhav Hiremath (7):
>>        ARM: dts: AM33XX: Add default pinctrl binding for I2C device
>>        ARM: dts: AM33XX: Add pinctrl binding to gpio-leds node
>>        ARM: dts: AM33XX: Fix uart numbering to match hardware/TRM
>>        ARM: dts: AM33XX: Add default pinctrl binding for UART0 device
>>        ARM: dts: AM33XX: Set pinmux for clkout2 pad used for clock output
>>        ARM: AM33XX: clock: Add debugSS clock nodes
>>        ARM: AM33XX: clock data: Enable clkout2 as part of init
>>
>>   .../devicetree/bindings/arm/omap/omap.txt          |    3 +
>>   arch/arm/boot/dts/Makefile                         |    8 +-
>>   arch/arm/boot/dts/am335x-bone.dts                  |  118 ++++-
>>   arch/arm/boot/dts/am335x-evm.dts                   |  264 ++++++++++-
>>   arch/arm/boot/dts/am335x-evmsk.dts                 |  184 +++++++-
>>   arch/arm/boot/dts/am33xx.dtsi                      |  121 ++++-
>>   arch/arm/boot/dts/am3517-evm.dts                   |    2 +-
>>   arch/arm/boot/dts/am3517_mt_ventoux.dts            |    2 +-
>>   arch/arm/boot/dts/am4372.dtsi                      |   68 +++
>>   arch/arm/boot/dts/am43x-epos-evm.dts               |   18 +
>>   arch/arm/boot/dts/omap2.dtsi                       |    5 +-
>>   arch/arm/boot/dts/omap2420-h4.dts                  |    2 +-
>>   arch/arm/boot/dts/omap2420.dtsi                    |    2 +-
>>   arch/arm/boot/dts/omap2430.dtsi                    |    2 +-
>>   arch/arm/boot/dts/omap3-beagle-xm.dts              |   48 +-
>>   arch/arm/boot/dts/omap3-beagle.dts                 |   72 ++-
>>   arch/arm/boot/dts/omap3-devkit8000.dts             |   11 +-
>>   arch/arm/boot/dts/omap3-evm.dts                    |    7 +-
>>   arch/arm/boot/dts/omap3-igep.dtsi                  |   43 +-
>>   arch/arm/boot/dts/omap3-igep0020.dts               |  111 ++++-
>>   arch/arm/boot/dts/omap3-igep0030.dts               |   60 ++-
>>   arch/arm/boot/dts/omap3-overo.dtsi                 |   20 +-
>>   arch/arm/boot/dts/omap3-tobi.dts                   |   52 ++-
>>   arch/arm/boot/dts/omap3.dtsi                       |    6 +-
>>   arch/arm/boot/dts/omap3430-sdp.dts                 |    5 +-
>>   arch/arm/boot/dts/omap34xx.dtsi                    |    2 +-
>>   arch/arm/boot/dts/omap36xx.dtsi                    |    2 +-
>>   arch/arm/boot/dts/omap4-panda-a4.dts               |   10 +-
>>   arch/arm/boot/dts/omap4-panda-common.dtsi          |  162 +++++--
>>   arch/arm/boot/dts/omap4-panda-es.dts               |   38 +-
>>   arch/arm/boot/dts/omap4-panda.dts                  |    4 +-
>>   arch/arm/boot/dts/omap4-sdp-es23plus.dts           |    8 +-
>>   arch/arm/boot/dts/omap4-sdp.dts                    |  126 ++---
>>   arch/arm/boot/dts/omap4-var-som.dts                |    8 +-
>>   arch/arm/boot/dts/omap4.dtsi                       |  124 +++--
>>   arch/arm/boot/dts/omap443x.dtsi                    |    8 +-
>>   arch/arm/boot/dts/omap4460.dtsi                    |   15 +-
>>   arch/arm/boot/dts/omap5-evm.dts                    |  261 -----------
>>   arch/arm/boot/dts/omap5-uevm.dts                   |  485 ++++++++++++++++++++
>>   arch/arm/boot/dts/omap5.dtsi                       |  173 ++++---
>>   arch/arm/boot/dts/twl4030_omap3.dtsi               |   25 +
>>   arch/arm/mach-omap2/cclock33xx_data.c              |   49 +-
>>   include/dt-bindings/pinctrl/am33xx.h               |   42 ++
>>   include/dt-bindings/pinctrl/omap.h                 |   55 +++
>>   44 files changed, 2172 insertions(+), 659 deletions(-)
>>   create mode 100644 arch/arm/boot/dts/am4372.dtsi
>>   create mode 100644 arch/arm/boot/dts/am43x-epos-evm.dts
>>   delete mode 100644 arch/arm/boot/dts/omap5-evm.dts
>>   create mode 100644 arch/arm/boot/dts/omap5-uevm.dts
>>   create mode 100644 arch/arm/boot/dts/twl4030_omap3.dtsi
>>   create mode 100644 include/dt-bindings/pinctrl/am33xx.h
>>   create mode 100644 include/dt-bindings/pinctrl/omap.h
