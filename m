From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/4] ti-sysc dts changes for omaps for v5.6
Date: Tue,  7 Jan 2020 10:14:18 -0800
Message-ID: <pull-1578420398-290837@atomide.com-3>
References: <pull-1578420398-290837@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1578420398-290837@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: soc@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 2c81f0f6d3f52ac222a5dc07a6e5c06e1543e88b:

  bus: ti-sysc: Fix iterating over clocks (2019-12-16 14:55:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.6/ti-sysc-dt-signed

for you to fetch changes up to d71b48236c83a8a732ccaf23dbf3b719d5c62e88:

  Merge tag 'sdma-dts' into omap-for-v5.6/ti-sysc-dt (2019-12-30 10:01:16 -0800)

----------------------------------------------------------------
dts changes for omaps for ti-sysc driver for v5.6 merge window

Devicetree changes for omaps to configure more devices to probe with
ti-sysc interconnect target module:

- Configure am4 qspi

- Configure aes, des and sham accelerators for am3, 4 and dra7

- Configure iommus for omap4, 5 and dra7

- Add a generic compatible for sdma, and configure omap2 and 3 sdma

----------------------------------------------------------------
Tero Kristo (4):
      ARM: dts: dra7: convert IOMMUs to use ti-sysc
      ARM: dts: dra74x: convert IOMMUs to use ti-sysc
      ARM: dts: omap4: convert IOMMUs to use ti-sysc
      ARM: dts: omap5: convert IOMMUs to use ti-sysc

Tony Lindgren (13):
      ARM: dts: Add generic compatible for omap sdma instances
      ARM: dts: Configure interconnect target module for omap2 sdma
      ARM: dts: Configure interconnect target module for omap3 sdma
      ARM: dts: Configure interconnect target module for am4 qspi
      ARM: dts: Configure interconnect target module for am3 sham
      ARM: dts: Configure interconnect target module for am4 sham
      ARM: dts: Configure interconnect target module for dra7 sham
      ARM: dts: Configure interconnect target module for am3 aes
      ARM: dts: Configure interconnect target module for am4 aes
      ARM: dts: Configure interconnect target module for dra7 aes
      ARM: dts: Configure interconnect target module for am4 des
      ARM: dts: Configure interconnect target module for dra7 des
      Merge tag 'sdma-dts' into omap-for-v5.6/ti-sysc-dt

 arch/arm/boot/dts/am33xx.dtsi    |  67 ++++++++--
 arch/arm/boot/dts/am4372.dtsi    | 140 ++++++++++++++++-----
 arch/arm/boot/dts/dra7-l4.dtsi   |  34 +++++-
 arch/arm/boot/dts/dra7.dtsi      | 255 +++++++++++++++++++++++++++++----------
 arch/arm/boot/dts/dra74x.dtsi    |  71 ++++++++---
 arch/arm/boot/dts/omap2.dtsi     |  42 +++++--
 arch/arm/boot/dts/omap2430.dtsi  |   4 +
 arch/arm/boot/dts/omap3-n900.dts |   5 +
 arch/arm/boot/dts/omap3.dtsi     |  45 +++++--
 arch/arm/boot/dts/omap36xx.dtsi  |   4 +
 arch/arm/boot/dts/omap4-l4.dtsi  |  13 +-
 arch/arm/boot/dts/omap4.dtsi     |  43 ++++---
 arch/arm/boot/dts/omap5-l4.dtsi  |  13 +-
 arch/arm/boot/dts/omap5.dtsi     |  40 +++---
 14 files changed, 595 insertions(+), 181 deletions(-)
