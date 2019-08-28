From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/4] sgx soc glue changes for omaps for v5.4
Date: Wed, 28 Aug 2019 11:34:52 -0700
Message-ID: <pull-1567016893-318461@atomide.com-4>
References: <pull-1567016893-318461@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1567016893-318461@atomide.com>
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

The following changes since commit 7edd00f71f4b91ca31dbfa08926495fe5e77aab4:

  bus: ti-sysc: Detect d2d when debug is enabled (2019-08-26 08:33:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.4/ti-sysc-sgx-signed

for you to fetch changes up to 6cb0ac0fb9786d01f140dcfcd3d09ce850dd0a64:

  ARM: dts: ARM: dts: Configure interconnect target module for am3517sgx (2019-08-26 08:47:09 -0700)

----------------------------------------------------------------
SoC glue layer changes for SGX on omap variants for v5.4

For a while we've had omap4 sgx glue layer defined in dts and probed
with ti-sysc driver. This allows idling the sgx module for PM, and
removes the need for custom platform glue layer code for any further
driver changes.

We first drop the unused legacy platform data for omap4 sgx. Then for
omap5, we need add the missing clkctrl clock data so we can configure
sgx. And we configure sgx for omap34xx, omap36xx and am3517.

For am335x, we still have a dependency for rstctrl reset driver changes,
so that will be added later on.

Note that this branch is based on earlier ti-sysc branch for omap36xx
glue layer quirk handling.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: ARM: dts: Configure interconnect target module for am3517sgx

Tony Lindgren (4):
      ARM: OMAP2+: Drop legacy platform data for omap4 gpu
      clk: ti: add clkctrl data omap5 sgx
      ARM: dts: Configure sgx for omap5
      ARM: dts: Configure interconnect target module for omap3 sgx

 arch/arm/boot/dts/am3517.dtsi              | 24 ++++++++++++++
 arch/arm/boot/dts/omap34xx.dtsi            | 26 +++++++++++++++
 arch/arm/boot/dts/omap36xx.dtsi            | 28 ++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi               |  1 -
 arch/arm/boot/dts/omap5.dtsi               | 23 +++++++++++++
 arch/arm/boot/dts/omap54xx-clocks.dtsi     | 14 ++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 53 ------------------------------
 drivers/clk/ti/clk-54xx.c                  | 34 +++++++++++++++++++
 include/dt-bindings/clock/omap5.h          |  3 ++
 9 files changed, 152 insertions(+), 54 deletions(-)
