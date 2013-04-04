From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: GPMC updates
Date: Wed, 3 Apr 2013 21:20:59 -0500
Message-ID: <515CE38B.3080400@ti.com>
References: <515B0D92.6070503@ti.com> <20130403214036.GD10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36963 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932825Ab3DDCVG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Apr 2013 22:21:06 -0400
In-Reply-To: <20130403214036.GD10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 04/03/2013 04:40 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [130402 10:00]:
>> The following changes since commit dca3a783400a18e2bf4503b1d4a85c4d0=
ca1a7e4:
>>
>>   Merge commit '31d9adca82ce65e5c99d045b5fd917c702b6fce3' into tmp (=
2013-04-01 14:33:50 -0500)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/jonhunter/linux.git omap-gpmc-for-v3.10
>>
>> for you to fetch changes up to c67bd6e7cad2160c3bbfa2ac2bd954f918301=
c23:
>>
>>   ARM: OMAP2+: Add GPMC DT support for Ethernet child nodes (2013-04=
-01 14:53:50 -0500)
>>
>> ----------------------------------------------------------------
>> Adds GPMC DT support for NOR flash and Ethernet and includes
>> various GPMC cleans-up and fixes.
>>
>> This series is dependent on commit 7185684 (ARM: OMAP: use
>> consistent error checking) from RMK's clean-up branch and commit
>> 31d9adc (ARM: OMAP2+: Fix broken gpmc support).
>=20
> Looks good except it adds a new warning:
>=20
> arch/arm/mach-omap2/gpmc.c: In function =E2=80=98gpmc_read_timings_dt=
=E2=80=99:
> arch/arm/mach-omap2/gpmc.c:1324: warning: =E2=80=98p=E2=80=99 may be =
used uninitialized in this function
>=20
> Can you please take a look?

No problem. I did not see get this warning, but I believe that=20
there is a bug that needed to be fixed. Can you try the below?

Jon

The following changes since commit dca3a783400a18e2bf4503b1d4a85c4d0ca1=
a7e4:

  Merge commit '31d9adca82ce65e5c99d045b5fd917c702b6fce3' into tmp (201=
3-04-01 14:33:50 -0500)

are available in the git repository at:


  git://github.com/jonhunter/linux.git omap-gpmc-for-v3.10-take2

for you to fetch changes up to 5330dc161cb41e399e85d30e6908f1b93b956d1e=
:

  ARM: OMAP2+: Add GPMC DT support for Ethernet child nodes (2013-04-03=
 20:13:42 -0500)

----------------------------------------------------------------
Ezequiel Garcia (8):
      ARM: omap2: gpmc: Mark local scoped functions static
      ARM: omap2: gpmc: Remove unused gpmc_round_ns_to_ticks() function
      ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
      ARM: omap2: gpmc-nand: Print something useful on CS request failu=
re
      ARM: omap2: gpmc-onenand: Print something useful on CS request fa=
ilure
      ARM: omap2: gpmc-onenand: Replace pr_err() with dev_err()
      ARM: omap2: gpmc-onenand: Replace printk KERN_ERR with dev_warn()
      ARM: omap2: gpmc: Remove redundant chip select out of range check

Javier Martinez Canillas (3):
      ARM: OMAP2+: return -ENODEV if GPMC child device creation fails
      ARM: OMAP2+: rename gpmc_probe_nor_child() to gpmc_probe_generic_=
child()
      ARM: OMAP2+: Add GPMC DT support for Ethernet child nodes

Jon Hunter (17):
      ARM: OMAP2+: Simplify code configuring ONENAND devices
      ARM: OMAP2+: Add variable to store number of GPMC waitpins
      ARM: OMAP2+: Add structure for storing GPMC settings
      ARM: OMAP2+: Add function for configuring GPMC settings
      ARM: OMAP2+: Convert ONENAND to use gpmc_cs_program_settings()
      ARM: OMAP2+: Convert NAND to use gpmc_cs_program_settings()
      ARM: OMAP2+: Convert SMC91x to use gpmc_cs_program_settings()
      ARM: OMAP2+: Convert TUSB to use gpmc_cs_program_settings()
      ARM: OMAP2+: Don't configure of chip-select options in gpmc_cs_co=
nfigure()
      ARM: OMAP2+: Add function to read GPMC settings from device-tree
      ARM: OMAP2+: Add additional GPMC timing parameters
      ARM: OMAP2+: Add device-tree support for NOR flash
      ARM: OMAP2+: Convert NAND to retrieve GPMC settings from DT
      ARM: OMAP2+: Convert ONENAND to retrieve GPMC settings from DT
      ARM: OMAP2+: Detect incorrectly aligned GPMC base address
      ARM: OMAP2+: Remove unnecesssary GPMC definitions and variable
      ARM: OMAP2+: Allow GPMC probe to complete even if CS mapping fail=
s

Mark Jackson (1):
      ARM: OMAP: Clear GPMC bits when applying new setting.

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  103 +++-
 Documentation/devicetree/bindings/mtd/gpmc-nor.txt |   98 ++++
 .../devicetree/bindings/mtd/gpmc-onenand.txt       |    3 +
 Documentation/devicetree/bindings/net/gpmc-eth.txt |   97 ++++
 arch/arm/mach-omap2/gpmc-nand.c                    |   42 +-
 arch/arm/mach-omap2/gpmc-onenand.c                 |  118 ++---
 arch/arm/mach-omap2/gpmc-smc91x.c                  |   30 +-
 arch/arm/mach-omap2/gpmc.c                         |  544 ++++++++++++=
++------
 arch/arm/mach-omap2/gpmc.h                         |   43 +-
 arch/arm/mach-omap2/usb-tusb6010.c                 |   62 ++-
 10 files changed, 831 insertions(+), 309 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nor.txt
 create mode 100644 Documentation/devicetree/bindings/net/gpmc-eth.txt
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
