From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap non urgent fixes for v3.16 merge window, resend
Date: Mon, 19 May 2014 19:10:30 -0700
Message-ID: <20140520021029.GK15793@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here are three pull requests that never made the lists
on the 8th of May as I have something still wrong with
my scripts it seems. Anyways, these should be fine pulled
out of order, if in doubt see my temporary merge branch
at omap-for-v3.16/tmp-merge-2014-05-19.

The following changes since commit fb677ef70b65e22cd4401d31b700a8b4041efae1:

  ARM: OMAP2+: Fix GPMC remap for devices using an offset (2014-04-23 11:09:22 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/fixes-not-urgent-signed

for you to fetch changes up to e610c9d3aeca8d7335803f816ae2e39e5103233e:

  Merge branch 'pull/l3noc/dts-fixes' of https://github.com/nmenon/linux-2.6-playground into omap-for-v3.16/fixes-not-urgent (2014-05-08 08:02:57 -0700)

----------------------------------------------------------------

Non urgent omap fixes for v3.16 merge window.

----------------------------------------------------------------
Afzal Mohammed (1):
      ARM: dts: AM4372: add l3-noc information

Dave Gerlach (1):
      ARM: dts: am437x-gp-evm: Do not reset gpio5

Javier Martinez Canillas (1):
      ARM: dts: omap3-igep0020: use SMSC9221 timings

Joel Fernandes (2):
      ARM: OMAP5: Switch to THUMB mode if needed on secondary CPU
      ARM: OMAP5: Redo THUMB mode switch on secondary CPU

Johan Hovold (1):
      ARM: dts: am335x-boneblack: remove use of ti,vcc-aux-disable-is-sleep

Oussama Ghorbel (1):
      ARM: OMAP2+: free use_gptimer_clksrc variable after boot

Pekon Gupta (1):
      ARM: dts: am43xx: fix starting offset of NAND.filesystem MTD partition

Rajendra Nayak (1):
      ARM: dts: DRA7: Use dra7-l3-noc instead of omap4-l3-noc

Suman Anna (3):
      ARM: dts: OMAP5: Add mailbox dt node to fix boot warning
      ARM: dts: OMAP2: Fix interrupts for OMAP2420 mailbox
      ARM: dts: AM3517: Disable absent IPs inherited from OMAP3

Tony Lindgren (4):
      ARM: dts: Fix bad OTG muxing for cm-t boards
      ARM: dts: Fix GPMC Ethernet timings for omap cm-t sbc-t boards for device tree
      ARM: dts: Fix GPMC timings for LAN9220
      Merge branch 'pull/l3noc/dts-fixes' of https://github.com/nmenon/linux-2.6-playground into omap-for-v3.16/fixes-not-urgent

 arch/arm/boot/dts/am335x-boneblack.dts    |  1 -
 arch/arm/boot/dts/am3517.dtsi             | 16 ++++++++
 arch/arm/boot/dts/am4372.dtsi             |  6 ++-
 arch/arm/boot/dts/am437x-gp-evm.dts       |  5 +++
 arch/arm/boot/dts/am43x-epos-evm.dts      |  2 +-
 arch/arm/boot/dts/dra7.dtsi               |  6 +--
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi | 19 ++++-----
 arch/arm/boot/dts/omap2.dtsi              |  7 ----
 arch/arm/boot/dts/omap2420.dtsi           |  8 ++++
 arch/arm/boot/dts/omap2430.dtsi           |  7 ++++
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi     | 66 +++++++------------------------
 arch/arm/boot/dts/omap3-igep.dtsi         |  2 +-
 arch/arm/boot/dts/omap3-igep0020.dts      |  4 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi       | 37 +++++------------
 arch/arm/boot/dts/omap3-sbc-t3517.dts     | 13 ++++++
 arch/arm/boot/dts/omap3.dtsi              |  2 +-
 arch/arm/boot/dts/omap5.dtsi              |  7 ++++
 arch/arm/mach-omap2/omap-headsmp.S        |  6 +--
 arch/arm/mach-omap2/timer.c               |  2 +-
 19 files changed, 106 insertions(+), 110 deletions(-)
