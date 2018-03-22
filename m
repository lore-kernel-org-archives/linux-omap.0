From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] aux control module changes for v4.17
Date: Thu, 22 Mar 2018 09:43:43 -0700
Message-ID: <pull-1521736966-849602@atomide.com>
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

The following changes since commit e33509c19da5931e4363c85f6e83bd11803ba121:

  ARM: OMAP2+: Fix typo for wakeup_ns_pa_addr (2018-02-28 14:47:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/soc-pt2-signed

for you to fetch changes up to 5aa6d80624d54d8aefaed8a4798b7aaa56290ccc:

  ARM: OMAP5: control: add support for control module wkup pad config (2018-03-20 08:06:18 -0700)

----------------------------------------------------------------
Two omap5 specific aux control module patches for v4.17

On omap5 there is an aux control module that we are not handling
currently for clocks, so let's add support for it.

----------------------------------------------------------------
Tero Kristo (2):
      ARM: omap2+: control: add support for auxiliary control module instances
      ARM: OMAP5: control: add support for control module wkup pad config

 arch/arm/mach-omap2/control.c | 20 ++++++++++++++++----
 include/linux/clk/ti.h        |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)
