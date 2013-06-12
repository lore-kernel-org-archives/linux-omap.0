From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 6/6] omap5 data for v3.11 merge window
Date: Wed, 12 Jun 2013 11:24:35 -0700
Message-ID: <E1Umpk1-0005eT-9P@merlin.infradead.org>
References: <pull-1371061475-206272>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1371061475-206272>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

  Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/omap5-signed

for you to fetch changes up to 6503a8e109a639760408f874c1251060d563942e:

  ARM: OMAP5: Remove unused include for ocp2scp (2013-06-09 21:17:15 -0700)

----------------------------------------------------------------
Omap5 SoC data via Paul Walmsley <paul@pwsan.com:

Add support for the OMAP5 SoC family.

As part of the transition to DT, no board files will be used
for OMAP5.  The hwmod data is gradually being transitioned
away from arch/arm/mach-omap2: IRQ, DMA, and memory map data
has been moved to DT.  Hopefully the dev_attr and clock role
data will be the next step.

Basic test logs are available here, although not for OMAP5,
since I don't have an OMAP5 board:
http://www.pwsan.com/omap/testlogs/omap5_v3.10/20130608130949/

----------------------------------------------------------------
Benoit Cousson (7):
      ARM: OMAP5: PRM: Add OMAP54XX register and bitfield files
      ARM: OMAP5: CM: Add OMAP54XX register and bitfield files
      ARM: OMAP5: PRCM: Add OMAP54XX local MPU PRCM registers
      ARM: OMAP5: SCRM: Add OMAP54XX header file.
      ARM: OMAP5: clockdomain data: Add OMAP54XX data and update the header
      ARM: OMAP5: powerdomain data: Add OMAP54XX data and update the header
      ARM: OMAP5: hwmod data: Create initial OMAP5 SOC hwmod data

Santosh Shilimkar (5):
      ARM: OMAP4+: PRM: Move function prototypes to common header for re-use
      ARM: OMAP4+: CM: Move function prototypes to common header for re-use
      ARM: OMAP4+: PRCM MPU: Move function prototypes to common header for re-use
      ARM: OMAP5: voltagedomain data: Add OMAP5 voltage domain data
      ARM: OMAP5: Enable build and frameowrk initialisations

Tony Lindgren (2):
      Merge tag 'omap-devel-a-for-3.11' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.11/omap5
      ARM: OMAP5: Remove unused include for ocp2scp

 arch/arm/mach-omap2/Makefile                  |    4 +
 arch/arm/mach-omap2/clockdomain.h             |    1 +
 arch/arm/mach-omap2/clockdomains54xx_data.c   |  464 +++++
 arch/arm/mach-omap2/cm-regbits-54xx.h         | 1737 ++++++++++++++++
 arch/arm/mach-omap2/cm1_44xx.h                |    7 +-
 arch/arm/mach-omap2/cm1_54xx.h                |  213 ++
 arch/arm/mach-omap2/cm2_44xx.h                |    7 +-
 arch/arm/mach-omap2/cm2_54xx.h                |  389 ++++
 arch/arm/mach-omap2/cm_44xx_54xx.h            |   36 +
 arch/arm/mach-omap2/io.c                      |    6 +
 arch/arm/mach-omap2/omap_hwmod.h              |    1 +
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c    | 2150 ++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h             |    1 +
 arch/arm/mach-omap2/powerdomains54xx_data.c   |  331 +++
 arch/arm/mach-omap2/prcm44xx.h                |    6 +
 arch/arm/mach-omap2/prcm_mpu44xx.h            |   14 +-
 arch/arm/mach-omap2/prcm_mpu54xx.h            |   87 +
 arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h      |   36 +
 arch/arm/mach-omap2/prm-regbits-54xx.h        | 2701 +++++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h                 |   33 +-
 arch/arm/mach-omap2/prm44xx_54xx.h            |   58 +
 arch/arm/mach-omap2/prm54xx.h                 |  421 ++++
 arch/arm/mach-omap2/scrm54xx.h                |  231 +++
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains54xx_data.c |  102 +
 25 files changed, 8982 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains54xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-54xx.h
 create mode 100644 arch/arm/mach-omap2/cm1_54xx.h
 create mode 100644 arch/arm/mach-omap2/cm2_54xx.h
 create mode 100644 arch/arm/mach-omap2/cm_44xx_54xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_54xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains54xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm_mpu54xx.h
 create mode 100644 arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h
 create mode 100644 arch/arm/mach-omap2/prm-regbits-54xx.h
 create mode 100644 arch/arm/mach-omap2/prm44xx_54xx.h
 create mode 100644 arch/arm/mach-omap2/prm54xx.h
 create mode 100644 arch/arm/mach-omap2/scrm54xx.h
 create mode 100644 arch/arm/mach-omap2/voltagedomains54xx_data.c
