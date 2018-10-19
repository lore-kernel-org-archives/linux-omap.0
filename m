From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap1 fix for v4.20 merge window
Date: Fri, 19 Oct 2018 14:24:14 -0700
Message-ID: <pull-1539984133-332635@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 1137ceee76ba8b8c698e11b7150e35524f071bda:

  ARM: OMAP1: ams-delta: Don't request unused GPIOs (2018-09-20 14:24:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/omap1-fix-signed

for you to fetch changes up to ab6ead7d07ca87e3e66e6d524c8aa311732878de:

  ARM: OMAP1: ams-delta: Fix impossible .irq < 0 (2018-10-04 07:29:41 -0700)

----------------------------------------------------------------
Fix for omap1 ams-delta irq

We need to use IRQ_NOTCONNECTED instead of -EINVAL for
ams_delta_modem_ports irq.

----------------------------------------------------------------
Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix impossible .irq < 0

 arch/arm/mach-omap1/board-ams-delta.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)
