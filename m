From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v5 06/10] ARM: dts: am4372: Add DCAN nodes
Date: Mon, 24 Nov 2014 13:11:12 +0200
Message-ID: <54731250.9050909@ti.com>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com> <1415881371-4982-7-git-send-email-rogerq@ti.com> <5469F35D.80504@ti.com> <20141121235032.GC7046@atomide.com> <20141122000853.GI7046@atomide.com> <54730144.9070106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54420 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbaKXLLc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2014 06:11:32 -0500
In-Reply-To: <54730144.9070106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org

On 11/24/2014 11:58 AM, Roger Quadros wrote:
> On 11/22/2014 02:08 AM, Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [141121 15:52]:
>>> * Roger Quadros <rogerq@ti.com> [141117 05:10]:
>>>> The SoC contains 2 DCAN modules. Add them.
>>>
>>> Thanks applying all into omap-for-v3.19/dt-v2.
>>
>> Oops, have to drop these as they cause this on make dtbs:
>>
>>   DTC     arch/arm/boot/dts/dra7-evm.dtb
>> Warning (reg_format): "reg" property in /soc/can@481cc000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
>> Warning (reg_format): "reg" property in /soc/can@481d0000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
>> Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/can@481cc000
>> Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/can@481cc000
>> Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/can@481d0000
>> Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/can@481d0000
>>   DTC     arch/arm/boot/dts/am57xx-beagle-x15.dtb
>> Warning (reg_format): "reg" property in /soc/can@481cc000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
>> Warning (reg_format): "reg" property in /soc/can@481d0000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
>> Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/can@481cc000
>> Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/can@481cc000
>> Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/can@481d0000
>> Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/can@481d0000
>>   DTC     arch/arm/boot/dts/dra72-evm.dtb
>> Warning (reg_format): "reg" property in /soc/can@481cc000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
>> Warning (reg_format): "reg" property in /soc/can@481d0000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
>> Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/can@481cc000
>> Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/can@481cc000
>> Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/can@481d0000
>> Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/can@481d0000
>>
>> Care to update the patches for that and then do a pull request for me?
> 
> I didn't see these warnings on 3.18-rc1 though. Looks like some new checks were added in -next.
> I'll fix these and send you an updated pull request.

I couldn't reproduce the errors on linux-next nor on your branch. Maybe you had a conflict resolution issue?
I've rebased the patches on omap-for-v3.19/dt-v2 and are available for you to pull from:

The following changes since commit 0f39f7b906dbeabe2ffd8739d5201e890d102ea6:

  ARM: dts: AM43xx: add tscadc DT entries for am437x-evm and am43x-epos-evm (2014-11-21 16:25:06 -0800)

are available in the git repository at:

  git@github.com:rogerq/linux.git for-v3.19/omap-dts-dcan

for you to fetch changes up to bae6665b8002282a833bf482b242e7df5d63b3d3:

  ARM: dts: am335x-evm: Add DCAN1 details (2014-11-24 12:41:17 +0200)

----------------------------------------------------------------
Mugunthan V N (1):
      arm: dts: am437x-gp: Add dcan support

Roger Quadros (9):
      ARM: dts: dra7: Add syscon regmap for CORE CONTROL area
      ARM: dts: DRA7: Add DCAN nodes
      ARM: dts: dra7-evm: Add CAN support
      ARM: dts: dra72-evm: Add CAN support
      ARM: dts: am4372: Add control module syscon node
      ARM: dts: am4372: Add DCAN nodes
      ARM: dts: am33xx: Add control module syscon node
      ARM: dts: am33xx: Update DCAN nodes
      ARM: dts: am335x-evm: Add DCAN1 details

 arch/arm/boot/dts/am335x-evm.dts    | 13 +++++++++++++
 arch/arm/boot/dts/am33xx.dtsi       | 25 +++++++++++++++++--------
 arch/arm/boot/dts/am4372.dtsi       | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7-evm.dts      | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi         | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/dra72-evm.dts     | 23 +++++++++++++++++++++++
 7 files changed, 154 insertions(+), 8 deletions(-)

--
cheers,
-roger
