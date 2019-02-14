From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] Fix omap4 and later lost cpu1 interrupts for periodic timer
Date: Thu, 14 Feb 2019 10:01:34 -0800
Message-ID: <pull-1550167274-497763@atomide.com>
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

The following changes since commit dc30e70391376ba3987aeb856ae6d9c0706534f1:

  ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized (2019-01-29 08:54:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.0/fixes-rc5

for you to fetch changes up to 50d6b3cf9403879911e06d69c7ef41e43f8f7b4b:

  ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug (2019-02-07 07:48:22 -0800)

----------------------------------------------------------------
Fix omap4 and later lost cpu1 interrupts for periodic timer

A fix from Russell that took a while to get applied into fixes as
I thought Russell is merging this one.

----------------------------------------------------------------
Russell King (1):
      ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug

 arch/arm/mach-omap2/cpuidle44xx.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)
