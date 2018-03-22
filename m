From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] droid4 defconfig changes for v4.17
Date: Thu, 22 Mar 2018 09:43:45 -0700
Message-ID: <pull-1521736966-849602@atomide.com-3>
References: <pull-1521736966-849602@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1521736966-849602@atomide.com>
In-Reply-To: <pull-1521736966-849602@atomide.com>
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

The following changes since commit 740c01f76ab3712a45c2f02233c800829626e9ba:

  ARM: multi_v7_defconfig: Enable USB gadget configfs as loadable module (2018-03-06 11:25:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/defconfig-pt2-signed

for you to fetch changes up to 372bed66bfbbc867c085c655b927a4c7fdb4870c:

  ARM: multi_v7_defconfig: Enable CPCAP related options mostly as loadable modules (2018-03-20 07:10:24 -0700)

----------------------------------------------------------------
Second set of defconfig changes for omap variants for v4.17

This series enables more devices working on droid4 to make it easier
for people and distros to use out of the box.

----------------------------------------------------------------
Tony Lindgren (5):
      ARM: omap2plus_defconfig: Enable PWM_VIBRA
      ARM: omap2plus_defconfig: Add AUDIO_GRAPH_CARD
      ARM: omap2plus_defconfig: Enable MDM6600 USB PHY
      ARM: omap2plus_defconfig: Add UINPUT
      ARM: multi_v7_defconfig: Enable CPCAP related options mostly as loadable modules

 arch/arm/configs/multi_v7_defconfig  | 9 +++++++++
 arch/arm/configs/omap2plus_defconfig | 5 +++++
 2 files changed, 14 insertions(+)
