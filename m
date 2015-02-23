From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v5 0/7] irqchip: Move OMAP{4,5}/DRA7 to use stacked domains
Date: Mon, 23 Feb 2015 14:39:34 -0600
Message-ID: <54EB9006.70000@ti.com>
References: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com> <20150223203237.GA30588@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60784 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbbBWUkT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 15:40:19 -0500
In-Reply-To: <20150223203237.GA30588@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 02/23/2015 02:32 PM, Nishanth Menon wrote:
> On 17:44-20150223, Marc Zyngier wrote:
>> This series is extracted from [4], which is trying to remove all
>> traces of gic_arch_extn from the tree. As some maintainers are more
>> responsive than others (understatement of the year...), I've decided
>> to split it per sub-arch, and get it moving, at least partially.
>>
>> This series addresses OMAP{4,5} by converting the WUGEN to stacked
>> domains. The DRA7 crossbar gets the same treatment.
>>
>> It is worth realizing that:
>>
>> - I haven't been able to test this as much as I would have wanted to
>>   (it's only been tested on omap4 and omap5).
>>
>> - This actively *breaks* existing setups. Once you boot a new kernel
>>   with an old DT, suspend/resume *will* be broken. Old kernels on a
>>   new DT won't even boot! You've been warned. This really outline the
>>   necessity of actually describing the HW in device trees...
>>
>> Based on 4.0-rc1.
>>
>> * From v4: [4]
>> - Extracted from the full series
>> - Rebased on 4.0-rc1
>>
>> * From v3 [3]:
>> - Rebased on top of the patch working around hardcoded IRQ on OMAP4/5 [4]
>> - Fixed more iMX6 DTs (Stephan)
>> - Fixed Exynos4/5 DTs
>>
>> * From v2 [2]:
>> - Addressed numerous comments from Thierry
>> - Merged bug fixes from Nishanth
>> - Merged bug fix from Stefan
>>
>> * From v1 [1]:
>> - Rebased on 3.19-rc3
>> - Fixed a number of additional platforms
>> - Added crossbar conversion to stacked domains
>> - Merged bug fixes from Nishanth
>>
>> [4]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317531.html
>> [3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315385.html
>> [2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314041.html
>> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/307338.html
>>
>> Marc Zyngier (7):
>>   genirq: Add irqchip_set_wake_parent
>>   irqchip: crossbar: convert dra7 crossbar to stacked domains
>>   DT: update ti,irq-crossbar binding
>>   irqchip: GIC: get rid of routable domain
>>   DT: arm,gic: kill arm,routable-irqs
>>   DT: omap4/5: add binding for the wake-up generator
>>   ARM: omap: convert wakeupgen to stacked domains
>>
>>  Documentation/devicetree/bindings/arm/gic.txt      |   6 -
>>  .../devicetree/bindings/arm/omap/crossbar.txt      |  18 +-
>>  .../interrupt-controller/ti,omap4-wugen-mpu        |  33 ++++
>>  arch/arm/boot/dts/am4372.dtsi                      |  11 +-
>>  arch/arm/boot/dts/am437x-gp-evm.dts                |   1 -
>>  arch/arm/boot/dts/am437x-sk-evm.dts                |   1 -
>>  arch/arm/boot/dts/am43x-epos-evm.dts               |   1 -
>>  arch/arm/boot/dts/am57xx-beagle-x15.dts            |   3 +-
>>  arch/arm/boot/dts/dra7-evm.dts                     |   2 +-
>>  arch/arm/boot/dts/dra7.dtsi                        |  43 +++--
>>  arch/arm/boot/dts/dra72-evm.dts                    |   1 -
>>  arch/arm/boot/dts/dra72x.dtsi                      |   3 +-
>>  arch/arm/boot/dts/dra74x.dtsi                      |   5 +-
>>  arch/arm/boot/dts/omap4-duovero.dtsi               |   2 -
>>  arch/arm/boot/dts/omap4-panda-common.dtsi          |   8 +-
>>  arch/arm/boot/dts/omap4-sdp.dts                    |   8 +-
>>  arch/arm/boot/dts/omap4-var-som-om44.dtsi          |   2 -
>>  arch/arm/boot/dts/omap4.dtsi                       |  18 +-
>>  arch/arm/boot/dts/omap5-cm-t54.dts                 |   1 -
>>  arch/arm/boot/dts/omap5-uevm.dts                   |   2 -
>>  arch/arm/boot/dts/omap5.dtsi                       |  26 ++-
>>  arch/arm/mach-omap2/omap-wakeupgen.c               | 125 ++++++++++---
>>  arch/arm/mach-omap2/omap-wakeupgen.h               |   1 -
>>  arch/arm/mach-omap2/omap4-common.c                 |  21 +--
>>  drivers/irqchip/irq-crossbar.c                     | 207 ++++++++++++---------
>>  drivers/irqchip/irq-gic.c                          |  59 +-----
>>  include/linux/irq.h                                |   1 +
>>  include/linux/irqchip/arm-gic.h                    |   6 -
>>  include/linux/irqchip/irq-crossbar.h               |  11 --
>>  kernel/irq/chip.c                                  |  16 ++
>>  30 files changed, 364 insertions(+), 278 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
>>  delete mode 100644 include/linux/irqchip/irq-crossbar.h
> 
> marc-test-irq (Applied the series to v4.0-rc1) - boot logs:
>  1:                     am335x-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2469913
>  2:                      am335x-sk: BOOT: PASS: http://paste.ubuntu.org.cn/2469914
>  3:                     am3517-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2469915
>  4:                      am37x-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2469916
>  5:                      am437x-sk: BOOT: PASS: http://paste.ubuntu.org.cn/2469917
>  6:                    am43xx-epos: BOOT: PASS: http://paste.ubuntu.org.cn/2469918
>  7:                   am43xx-gpevm: BOOT: PASS: http://paste.ubuntu.org.cn/2469919
>  8:                 BeagleBoard-XM: BOOT: PASS: http://paste.ubuntu.org.cn/2469920
>  9:            beagleboard-vanilla: BOOT: PASS: http://paste.ubuntu.org.cn/2469928
> 10:               beaglebone-black: BOOT: PASS: http://paste.ubuntu.org.cn/2469932
> 11:                     beaglebone: BOOT: PASS: http://paste.ubuntu.org.cn/2469936
> 12:                     craneboard: BOOT: PASS: http://paste.ubuntu.org.cn/2469941
> 13:                     dra72x-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2469945
> 14:                     dra7xx-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2469946
> 15:         OMAP3430-Labrador(LDP): BOOT: PASS: http://paste.ubuntu.org.cn/2469947
> 16:                           n900: BOOT: PASS: http://paste.ubuntu.org.cn/2469948
> 17:                      omap5-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2469949
> 18:                  pandaboard-es: BOOT: PASS: http://paste.ubuntu.org.cn/2469950
> 19:             pandaboard-vanilla: BOOT: PASS: http://paste.ubuntu.org.cn/2469951
> 20:                        sdp2430: BOOT: PASS: http://paste.ubuntu.org.cn/2469952
> 21:                        sdp3430: BOOT: PASS: http://paste.ubuntu.org.cn/2469953
> 22:                        sdp4430: BOOT: PASS: http://paste.ubuntu.org.cn/2469954
> TOTAL = 22 boards, Booted Boards = 22, No Boot boards = 0
> 
> (also tested beagleboard-x15 which was not on farm: http://paste.ubuntu.org.cn/2470017  - looks good as well).
Noticed that I missed proper info about x15 here.. anyways..

http://paste.ubuntu.org.cn/2470017 was vanilla v4.0-rc1
http://pastebin.ubuntu.com/10377375/ is with this series applied on top.

> 
> Comparative boot logs for v4.0-rc1:
> https://github.com/nmenon/kernel-test-logs/tree/v4.0-rc1
> 
> Will dig in detail a little later.. but nothing major stuck out to me.



-- 
Regards,
Nishanth Menon
