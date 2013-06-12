From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/6] omap gpmc changes for v3.11 merge window
Date: Wed, 12 Jun 2013 11:24:35 -0700
Message-ID: <E1Umpja-0005cr-1V@merlin.infradead.org>
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

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/gpmc-signed

for you to fetch changes up to b3f5525c55ce5cb67af06f04dbbf28358da23a2c:

  ARM: OMAP2+: gpmc: Converts GPMC driver to pm_runtime capable (2013-06-12 09:56:30 -0700)

----------------------------------------------------------------
Omap GPMC (General Purpose Memory Controller) changes.

----------------------------------------------------------------
Christoph Fritz (1):
      ARM: OMAP2+: nand: reorganize gpmc timing values

Gupta Pekon (1):
      ARM: OMAP2+: gpmc: get number of useable GPMC chip-selects via DT

Jon Hunter (1):
      ARM: dts: OMAP2+: Simplify NAND support

Mark Jackson (1):
      ARM: OMAP2+: Allow NAND transfer mode to be specified in DT

avinash philip (1):
      ARM: OMAP2+: gpmc: Converts GPMC driver to pm_runtime capable

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  1 -
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  8 +++
 arch/arm/boot/dts/omap3430-sdp.dts                 |  1 -
 arch/arm/mach-omap2/board-flash.c                  |  3 ++
 arch/arm/mach-omap2/gpmc-nand.c                    | 44 ++--------------
 arch/arm/mach-omap2/gpmc.c                         | 61 +++++++++++++++++-----
 6 files changed, 63 insertions(+), 55 deletions(-)
