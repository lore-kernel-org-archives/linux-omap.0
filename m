From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] few more dts changes for omaps for v5.5
Date: Tue, 12 Nov 2019 09:33:01 -0800
Message-ID: <pull-1573579927-542764@atomide.com>
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
To: soc@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit fedc8844d5004ffa69d3e320081bfd59979e1937:

  Merge branch 'omap-for-v5.5/droid4' into omap-for-v5.5/dt (2019-10-23 10:34:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.5/dt-late-signed

for you to fetch changes up to abb0e36b434d784864fe0e4d5dedd17f4d72f3e3:

  ARM: dts: logicpd-torpedo: Disable USB Host (2019-11-11 13:03:06 -0800)

----------------------------------------------------------------
Few late dts changes for omaps for v5.5 merge window

Let's configure omap3 rng as we can now easily do it with a dts change
only by tagging it with status = "disabled" for n900 where it's not
accessible. This improves the boot-up time with distros quite a bit with
proper entropy source around.

There's also another minor update for logicpd-torpedo that does not have
USB host pins wired.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: logicpd-torpedo: Disable USB Host

Tony Lindgren (2):
      ARM: dts: Configure omap3 rng
      Merge branch 'rng' into omap-for-v5.5/dt

 arch/arm/boot/dts/am3517.dtsi                   |  6 ++++++
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi      |  5 +++++
 arch/arm/boot/dts/omap3-n900.dts                |  5 +++++
 arch/arm/boot/dts/omap3.dtsi                    | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi |  2 +-
 5 files changed, 42 insertions(+), 1 deletion(-)
