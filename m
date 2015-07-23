From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: PRCM and hwmod changes for v4.3
Date: Thu, 23 Jul 2015 14:58:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507231456540.29543@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.3/omap-hwmod-prcm-a

for you to fetch changes up to 3b86616e3058462c340710dc7a5ac34ec8453944:

  Merge branch 'prcm-a-for-v4.3' into hwmod-prcm-for-v4.3 (2015-07-23 08:49:57 -0600)

- ----------------------------------------------------------------
ARM: OMAP2+: PRCM and hwmod changes for v4.3

This series adds:

- - I/O wakeup support for AM43xx
- - register lock and unlock support to the hwmod code (needed for the RTC
  IP blocks on some chips)
- - several fixes for sparse warnings and an unnecessary null pointer test
- - a DRA7xx clockdomain configuration workaround, to deal with some hardware
  bugs

Basic build, boot, and PM tests are here:

http://www.pwsan.com/omap/testlogs/hwmod-prcm-for-v4.3/20150723080012/

Since I do not have an AM43xx or DRA7xx device, I can't test on those
platforms.

- ----------------------------------------------------------------
Keerthy (6):
      ARM: OMAP4: PRM: Remove hardcoding of PRM_IO_PMCTRL_OFFSET register
      ARM: AM43xx: Add the PRM IRQ register offsets
      ARM: dts: AM4372: Add PRCM IRQ entry
      ARM: OMAP: PRM: Remove hardcoding of IRQENABLE_MPU_2 and IRQSTATUS_MPU_2 register offsets
      ARM: OMAP4+: PRM: Add AM437x specific data
      ARM: PRM: AM437x: Enable IO wakeup feature

Lokesh Vutla (1):
      ARM: OMAP2+: hwmod: add support for lock and unlock hooks

Markus Elfring (1):
      ARM: OMAP2: Delete an unnecessary check

Paul Walmsley (1):
      Merge branch 'prcm-a-for-v4.3' into hwmod-prcm-for-v4.3

Sekhar Nori (2):
      ARM: OMAP2+: sparse: add missing static declaration
      ARM: OMAP2+: sparse: add missing function declarations

Vignesh R (1):
      ARM: OMAP2+: DRA7: clockdomain: change l4per2_7xx_clkdm to SW_WKUP

 arch/arm/boot/dts/am4372.dtsi                      |  1 +
 arch/arm/mach-omap2/clockdomains7xx_data.c         |  2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |  2 +-
 arch/arm/mach-omap2/omap3-restart.c                |  1 +
 arch/arm/mach-omap2/omap4-restart.c                |  1 +
 arch/arm/mach-omap2/omap_hwmod.c                   | 13 +++++
 arch/arm/mach-omap2/omap_hwmod.h                   |  4 ++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  2 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  2 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         | 34 ++++++------
 arch/arm/mach-omap2/pdata-quirks.c                 |  6 +--
 arch/arm/mach-omap2/prcm-common.h                  |  2 +
 arch/arm/mach-omap2/prcm43xx.h                     |  7 +++
 arch/arm/mach-omap2/prm44xx.c                      | 61 +++++++++++++---------
 arch/arm/mach-omap2/prm_common.c                   |  1 +
 arch/arm/mach-omap2/timer.c                        |  3 +-
 16 files changed, 92 insertions(+), 50 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVsQCiAAoJEMePsQ0LvSpLSxUP/2BIP8+R5r6CGzsSF/r5uQny
aEYZoVPnB7bnTQJnrkrIlkj+oGoH+5JwMX4/v1G6/y6p9f5tTon9uvZSzSkJsW/k
mmm4LPK+lX4UiCDRw6w21rJD2DrRUlpXqFSsfdK8XwY94dx1eGWB+bZBcoJXQb7/
67ge693e6/ZCtg4J1BA1SMXnk9vaa4seDJ1N4AY09fJtROno30tUS7gfBanXi1Ht
EQ8FIRB68tTwzrUAnG6osyDR1av/hB1nj9OX4VfoAzgPceyc7u33zUpo5iat1+Ib
iAQjdvdMYYFpT7ExuXNSmrLT7v0W0bJ950EDy7XHss4Q/F8Fyevo96dRecypM4wx
nCo5a5zk378tlVpPILcTYcrAYax1pU6z0FVc7ghTG7/lYMEe2YRD8mdqSwuLMyHZ
GG1ofYX8WNEWai0SyPwGECSNFQXxrgbCqLlWzoJk8t4RjE9yHJEr+b1gi7Wh0/ZB
KZMb6rSMzP5tmyQOjIhuQxTlFwZV44noJHf55wyIk1OFmiDPkGjKw5HaLttxb5V2
yJOLSJQ0+CpMakDBwWQd8oWTuiDX9VxbUXZxIndEAoEc9YpTmFg2hUwwLqrAI/6/
Y+J3XHkfwxj8va+FRdY6dZsh51Fq+o6yUoweuwsUUOwyrkuaI2p6iZGTHvjiOyt+
w9T0RwVuta9hX19Bc2gF
=9zrq
-----END PGP SIGNATURE-----
