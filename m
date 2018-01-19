From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] dts driver fixes for omaps for v4.16 merge window
Date: Fri, 19 Jan 2018 07:38:06 -0800
Message-ID: <pull-1516376193-270253@atomide.com>
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

The following changes since commit 80a06c0d8357d1e75a8fbc10813fcdada4d897fb:

  ARM: dts: dm816x: add clkctrl nodes (2017-12-11 08:28:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/dt-clk-dts-signed

for you to fetch changes up to e14d7e5320ebae9bffe4fbd585dfdd9d6de2550f:

  ARM: dts: Update ti-sysc data for existing users (2018-01-12 15:16:57 -0800)

----------------------------------------------------------------
Few omap interconnect dts fixes for v4.16 merge window

Now that we have the dts clocks for the clkctrl clock and the
interconnect binding, we need to update the existing ti-sysc
users according to the binding to make it usable for drivers.

Apologies for not being able to send this earlier but it took
me few revisions to get the smartreflex changes right and
tested with yet to be posted patches to make smartreflex probe
with dts and I wanted to have it sit in next for a while to make
sure we're not introducing regressions for legacy platform data
based booting.

Note that this is based on a merge with commit 20a2742e5784
("dt-bindings: ti-sysc: Update binding for timers and capabilities")
to avoid a merge conflict with the binding changes.

----------------------------------------------------------------
Tony Lindgren (4):
      dt-bindings: ti-sysc: Update binding for timers and capabilities
      Merge commit '20a2742e5784295b9197250b50c40f6d38a55880' into omap-for-v4.16/dt-clk
      ARM: dts: Fix smartreflex compatible for omap3 shared mpu-iva instance
      ARM: dts: Update ti-sysc data for existing users

 Documentation/devicetree/bindings/bus/ti-sysc.txt  |  36 +++++++
 .../devicetree/bindings/power/ti-smartreflex.txt   |   2 +-
 arch/arm/boot/dts/am3517.dtsi                      |   4 -
 arch/arm/boot/dts/dra7.dtsi                        |  26 ++++--
 arch/arm/boot/dts/omap3.dtsi                       |  14 ---
 arch/arm/boot/dts/omap34xx.dtsi                    |  39 ++++++++
 arch/arm/boot/dts/omap36xx.dtsi                    |  46 +++++++++
 arch/arm/boot/dts/omap4.dtsi                       | 104 ++++++++++++++++++---
 include/dt-bindings/bus/ti-sysc.h                  |  22 +++++
 9 files changed, 257 insertions(+), 36 deletions(-)
 create mode 100644 include/dt-bindings/bus/ti-sysc.h
