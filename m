From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v3 0/3] OMAP4+: Get rid of internal SRAM handling
Date: Fri, 12 Sep 2014 13:47:55 -0500
Message-ID: <54133FDB.9030706@ti.com>
References: <cover.1410362895.git.d-gerlach@ti.com> <20140910165643.GA3118@splat>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47357 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbaILSsW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2014 14:48:22 -0400
In-Reply-To: <20140910165643.GA3118@splat>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On 09/10/2014 11:56 AM, Nishanth Menon wrote:
> On 11:04-20140910, Dave Gerlach wrote:
>> v3:
>> Fix minor issue in last patch to check for null sram_pool if no sram
>> phandle is given in DT.
>>
>> Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
>> use drivers/misc/sram.c driver instead of the omap internal
>> implementation for SRAM handling.
>>
>> Previous discussion can be found at [1].
>>
>> Regards,
>> Dave
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/195588.html
>>
>> Rajendra Nayak (3):
>>   ARM: AM335x: Get rid of unused sram init function
>>   ARM: OMAP4+: Move SRAM data to DT
>>   ARM: OMAP4+: Remove static iotable mappings for SRAM
>>
>>  Documentation/devicetree/bindings/arm/omap/mpu.txt |  3 ++
>>  arch/arm/boot/dts/am33xx.dtsi                      |  5 ++-
>>  arch/arm/boot/dts/am4372.dtsi                      |  5 +++
>>  arch/arm/boot/dts/omap4.dtsi                       |  6 ++++
>>  arch/arm/boot/dts/omap5.dtsi                       |  8 ++++-
>>  arch/arm/configs/omap2plus_defconfig               |  1 +
>>  arch/arm/mach-omap2/io.c                           | 17 ----------
>>  arch/arm/mach-omap2/omap4-common.c                 | 22 +++++++++++-
>>  arch/arm/mach-omap2/sram.c                         | 39 +---------------------
>>  arch/arm/mach-omap2/sram.h                         |  7 ----
>>  10 files changed, 46 insertions(+), 67 deletions(-)
>>
> 
> Could you please provide logs for the following:
> a) Low power transition tests for OMAP3,4 on all available platforms as
> well?
> b) provide bootlogs on all omap2plus platforms to ensure we have no
> regressions.
> 

Here are logs for low power transition, all platforms passed, properly
transitioned power domains with mem sleep using wakeup_timer to wake.

Low Power transition on v3.17-rc4 with patches applied, omap2plus_defconfig
(OMAP3 and OMAP4):

 1: BeagleBoard-XM: http://fpaste.org/133215/
 2: OMAP3430-Labrador(LDP): http://fpaste.org/133225/
 3: n900: http://fpaste.org/133244/
 4: pandaboard-es:  http://fpaste.org/133213/
 5: pandaboard-vanilla: http://fpaste.org/133214/
 6: sdp3430: http://fpaste.org/133246/

Boot on v3.17-rc4 with patches applied, omap2plus_defconfig:

 1: am335x-evm:  Boot PASS: http://fpaste.org/133179/
 2:  am335x-sk:  Boot PASS: http://fpaste.org/133180/
 3: am3517-evm:  Boot PASS: http://fpaste.org/133181/
 4:  am37x-evm:  Boot PASS: http://fpaste.org/133182/
 5: am43xx-epos:  Boot PASS: http://fpaste.org/133183/
 6: am43xx-gpevm:  Boot PASS: http://fpaste.org/133184/
 7: BeagleBoard-XM:  Boot PASS: http://fpaste.org/133191/
 8: beagleboard-vanilla:  Boot PASS: http://fpaste.org/133192/
 9: beaglebone-black:  Boot PASS: http://fpaste.org/133193/
10: beaglebone:  Boot PASS: http://fpaste.org/133194/
11: craneboard:  Boot PASS: http://fpaste.org/133186/
12: dra7xx-evm:  Boot PASS: http://fpaste.org/131396/
13: OMAP3430-Labrador(LDP):  Boot PASS: http://fpaste.org/133206/
14:       n900:  Boot PASS: http://fpaste.org/133207/
15:  omap5-evm:  Boot PASS: http://fpaste.org/133208/
16: pandaboard-es:  Boot PASS: http://fpaste.org/133187/
17: pandaboard-vanilla:  Boot PASS: http://fpaste.org/133188/
18:    sdp2430:  Boot PASS: http://fpaste.org/133189/
19:    sdp3430:  Boot PASS: http://fpaste.org/133212/
TOTAL = 19 boards, Booted Boards = 19, No Boot boards = 0

Again, all pass. I have also tested with next AM335x Suspend/Resume
implementation, next version will use generic sram driver to allocate for
low-level assembly code, and that works fine as well.

Regards,
Dave
