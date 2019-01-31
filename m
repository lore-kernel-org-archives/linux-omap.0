From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] dts changes for ti81xx for v5.1
Date: Thu, 31 Jan 2019 08:23:55 -0800
Message-ID: <pull-1548951676-587288@atomide.com-2>
References: <pull-1548951676-587288@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1548951676-587288@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit d27cda291b2341d39692421b4e64940879ff9dd8:

  ARM: ti81xx: Add hwmod boilerplate for all GPIO and SPI peripherals (2019-01-24 08:43:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/dt-ti-81xx-signed

for you to fetch changes up to d031773169df2de868c1b6ff75679ddac5d4a7ec:

  ARM: dts: Adds device tree file for McGill's IceBoard, based on TI AM3874 (2019-01-24 10:22:43 -0800)

----------------------------------------------------------------
dts updates for ti81xx for v5.1 merge window

Two changes to add support for McGill University's IceBoard telescope
ARM + FPGA instrumentation board. This board is used for several
telescopes around the world, see the related device tree commit for
some interesting links for more information.

Note that these changes are based on the related ti81xx soc changes.

----------------------------------------------------------------
Graeme Smecher (2):
      ARM: dts: ti81xx: Add dts boilerplate for all GPIO and SPI peripherals
      ARM: dts: Adds device tree file for McGill's IceBoard, based on TI AM3874

 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/am3874-iceboard.dts | 496 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dm814x.dtsi         |  64 ++++-
 3 files changed, 560 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am3874-iceboard.dts
