From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few new beaglebone variants for v4.19 merge window
Date: Thu, 19 Jul 2018 00:47:47 -0700
Message-ID: <pull-1531986403-289188@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 792f98677d7f777a4f58e567b5b0578191cb986a:

  Merge commit '949bdcc8a97c' into omap-for-v4.19/dt (2018-07-11 05:54:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.19/dt-pt2-signed

for you to fetch changes up to 91f6278bfa3966529c61808bd3cb8f05d7ed5dc6:

  ARM: dts: am335x: add am335x-sancloud-bbe board support (2018-07-17 01:05:37 -0700)

----------------------------------------------------------------
Few more beaglebone variants for v4.19 merge window

This adds dts files for two new beaglebone variants for
Octavo Systems OSD3358-SM-RED and Sancloud am335x-sancloud-bbe.

----------------------------------------------------------------
Koen Kooi (2):
      dt-bindings: Add vendor prefix for Sancloud
      ARM: dts: am335x: add am335x-sancloud-bbe board support

Neeraj Dantu (1):
      ARM: dts: Add DT support for Octavo Systems OSD3358-SM-RED based on TI AM335x

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts        | 457 +++++++++++++++++++++
 arch/arm/boot/dts/am335x-sancloud-bbe.dts          | 136 ++++++
 4 files changed, 597 insertions(+), 1 deletion(-)
 create mode 100755 arch/arm/boot/dts/am335x-osd3358-sm-red.dts
 create mode 100644 arch/arm/boot/dts/am335x-sancloud-bbe.dts
