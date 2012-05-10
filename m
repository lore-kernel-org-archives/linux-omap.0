From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] ARM: OMAP: AM35xx: fix some boot warnings with AM3505/3517
Date: Thu, 10 May 2012 11:29:13 -0600
Message-ID: <20120510172449.13418.66815.stgit@dusk>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kyle Manna <kyle.manna@fuel7.com>, "Mark A.Greer" <mgreer@animalcreek.com>, Ranjith Lohithakshan <ranjithl@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello,

this series fixes some of the warnings observed at boot with the AM35xx
boards.  Intended for either the 3.5 or 3.5-rc merge windows.

Particularly appreciated would be some feedback on the "ARM: OMAP:
AM35xx: fix UART4 softreset" patch from people who know the AM35xx SoC
hardware.


- Paul

---

am35xx_hwmod_data_fixes_a_3.5
   text	   data	    bss	    dec	    hex	filename
6601274	 724684	5587616	12913574	 c50ba6	vmlinux.omap2plus_defconfig.orig
6601274	 724748	5587616	12913638	 c50be6	vmlinux.omap2plus_defconfig

Paul Walmsley (3):
      ARM: OMAP AM35xx: clock and hwmod data: fix AM35xx HSOTGUSB hwmod
      ARM: OMAP AM35xx: clock and hwmod data: fix UART4 data
      ARM: OMAP: AM35xx: fix UART4 softreset


 arch/arm/mach-omap2/clock3xxx_data.c       |   26 +++++++++++--------
 arch/arm/mach-omap2/cm-regbits-34xx.h      |    4 +--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   38 ++++++++++++++++++++--------
 arch/arm/mach-omap2/prcm-common.h          |    4 +--
 4 files changed, 46 insertions(+), 26 deletions(-)
