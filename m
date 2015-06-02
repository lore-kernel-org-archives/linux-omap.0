From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap device tree changes for v4.2, part 2
Date: Tue,  2 Jun 2015 10:22:15 -0700
Message-ID: <37677.0957293504$1433265923@news.gmane.org>
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
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 52dfcbfc94833b0192d439127ee9ff46023cdbb2:

  ARM: dts: am335x-evm: add mmc3 and wlan definitions to dts (2015-05-21 12:05:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/dt-pt2

for you to fetch changes up to 8584d4fcab2222e2501e1c95b4d063cd4a76891d:

  ARM: dts: am335x-sl50: Add Toby-Churchill SL50 board support. (2015-05-28 09:49:50 -0700)

----------------------------------------------------------------
Few more omap device tree changes for v4.2 merge window:

- Add dm9000 Ethernet support to omap3-devkit8000

- Add Toby-Churchill SL50 board support

- Add vendor prefix for Toby Churchill Ltd

----------------------------------------------------------------
Anthoine Bourgeois (1):
      ARM: dts: omap3-devkit8000: Add dm9000 support

Enric Balletbo i Serra (2):
      of: Add vendor prefix for Toby Churchill Ltd.
      ARM: dts: am335x-sl50: Add Toby-Churchill SL50 board support.

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-sl50.dts                  | 482 +++++++++++++++++++++
 arch/arm/boot/dts/omap3-devkit8000.dts             |  41 ++
 4 files changed, 525 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-sl50.dts
