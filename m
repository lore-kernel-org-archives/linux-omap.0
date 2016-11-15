From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] add #pinctrl-cells for v4.10
Date: Mon, 14 Nov 2016 16:34:19 -0800
Message-ID: <28349.054818$1505294588@news.gmane.org>
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

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/pinctrl-cells-signed

for you to fetch changes up to be76fd3197df608e1b010bf5ab90377205f54344:

  ARM: dts: Add #pinctrl-cells for pinctrl-single instances (2016-11-07 08:27:49 -0700)

----------------------------------------------------------------
Add #pinctrl-cells for pinctrl-single using dts files. This allows
us to use generic parser later on. Note that the driver supports
handling the legacy binding also with no #pinctrl-cells so these
changes can be queued separately from the driver changes.

----------------------------------------------------------------
Tony Lindgren (1):
      ARM: dts: Add #pinctrl-cells for pinctrl-single instances

 Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt | 3 +++
 arch/arm/boot/dts/am33xx.dtsi                                | 2 ++
 arch/arm/boot/dts/am3517.dtsi                                | 1 +
 arch/arm/boot/dts/am4372.dtsi                                | 1 +
 arch/arm/boot/dts/da850.dtsi                                 | 1 +
 arch/arm/boot/dts/dm814x.dtsi                                | 1 +
 arch/arm/boot/dts/dm816x.dtsi                                | 2 ++
 arch/arm/boot/dts/dra7.dtsi                                  | 1 +
 arch/arm/boot/dts/hi3620.dtsi                                | 2 ++
 arch/arm/boot/dts/keystone-k2g.dtsi                          | 1 +
 arch/arm/boot/dts/keystone-k2l.dtsi                          | 1 +
 arch/arm/boot/dts/omap2420.dtsi                              | 2 ++
 arch/arm/boot/dts/omap2430.dtsi                              | 2 ++
 arch/arm/boot/dts/omap3.dtsi                                 | 2 ++
 arch/arm/boot/dts/omap34xx.dtsi                              | 1 +
 arch/arm/boot/dts/omap36xx.dtsi                              | 1 +
 arch/arm/boot/dts/omap4.dtsi                                 | 2 ++
 arch/arm/boot/dts/omap5.dtsi                                 | 2 ++
 arch/arm/boot/dts/pxa3xx.dtsi                                | 1 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi                    | 3 +++
 20 files changed, 32 insertions(+)
