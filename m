From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/6] omap cleanup for v3.11 merge window
Date: Wed, 12 Jun 2013 11:24:33 -0700
Message-ID: <E1Umpji-0005dK-Up@merlin.infradead.org>
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

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/cleanup-signed

for you to fetch changes up to 09182ab11b49b67d04598b19eb89cf0bbd672a60:

  ARM: OMAP4: hwmod data: Remove irq entries from mcspi, mmc hwmods (2013-06-12 09:41:46 -0700)

----------------------------------------------------------------
Move omap4 over to device tree based booting. This allows us to get rid
a big pile of platform init code for things that are already handled by
device tree related code. As am33xx is already device tree based, we
can also remove the same data for am33xx.

----------------------------------------------------------------
Sricharan R (2):
      ARM: OMAP4: hwmod data: Clean up the data file
      ARM: OMAP4: hwmod data: Remove irq entries from mcspi, mmc hwmods

Tomi Valkeinen (1):
      ARM: OMAP4: hwmod data: add DSS data back

Tony Lindgren (8):
      ARM: OMAP2+: Legacy support for wl12xx when booted with devicetree
      ARM: OMAP2+: Remove board-4430sdp.c
      ARM: OMAP2+: Remove board-omap4panda.c
      ARM: OMAP2+: Remove legacy mux data for omap4
      ARM: OMAP2+: Remove omap4 pdata from hsmmc.c
      ARM: OMAP2+: Remove omap4 pdata for USB
      ARM: OMAP2+: Remove omap4 ocp2scp pdata
      Merge branch 'am33xx' into omap-for-v3.11/cleanup

Vaibhav Hiremath (1):
      ARM: AM33XX: hwmod data: irq, dma and addr info clean up

 arch/arm/mach-omap2/Kconfig                |   22 -
 arch/arm/mach-omap2/Makefile               |    3 -
 arch/arm/mach-omap2/board-4430sdp.c        |  765 --------------
 arch/arm/mach-omap2/board-omap4panda.c     |  455 --------
 arch/arm/mach-omap2/devices.c              |  132 +--
 arch/arm/mach-omap2/hsmmc.c                |  103 +-
 arch/arm/mach-omap2/mux.h                  |    3 -
 arch/arm/mach-omap2/mux44xx.c              | 1356 ------------------------
 arch/arm/mach-omap2/mux44xx.h              |  298 ------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 1067 -------------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 1544 +---------------------------
 arch/arm/mach-omap2/usb-host.c             |  194 ----
 arch/arm/mach-omap2/usb-musb.c             |    3 -
 drivers/bus/omap-ocp2scp.c                 |   60 --
 include/linux/platform_data/omap_ocp2scp.h |   31 -
 15 files changed, 54 insertions(+), 5982 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-4430sdp.c
 delete mode 100644 arch/arm/mach-omap2/board-omap4panda.c
 delete mode 100644 arch/arm/mach-omap2/mux44xx.c
 delete mode 100644 arch/arm/mach-omap2/mux44xx.h
 delete mode 100644 include/linux/platform_data/omap_ocp2scp.h
