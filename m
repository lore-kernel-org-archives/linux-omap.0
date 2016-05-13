From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap fixes for v4.7 merge window
Date: Fri, 13 May 2016 10:11:40 -0700
Message-ID: <15522.0932829709$1463159594@news.gmane.org>
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

The following changes since commit 7472931f7f1e9d91f761dce30107ae345b61a5c3:

  ARM: dts: omap5: fix range of permitted wakeup pinmux registers (2016-04-26 10:16:12 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7/fixes-v2

for you to fetch changes up to 65db875d110b8e517f81fa71c57a65fc6d0019ac:

  ARM: OMAP2+: AM43XX: Enable fixes for Cortex-A9 errata (2016-05-12 13:47:51 -0700)

----------------------------------------------------------------
Two fixes for omaps for v4.7 merge window, one to enable
ARM errata for am437x, and the other to add ARM errtum
workaround for dra7.

AFAIK these both can wait for v4.7, we can then request them
for stable kernels as needed.

----------------------------------------------------------------
Dave Gerlach (1):
      ARM: OMAP2+: AM43XX: Enable fixes for Cortex-A9 errata

Nishanth Menon (1):
      ARM: OMAP5 / DRA7: Introduce workaround for 801819

 arch/arm/mach-omap2/Kconfig       | 10 ++++++++
 arch/arm/mach-omap2/omap-secure.h |  1 +
 arch/arm/mach-omap2/omap-smp.c    | 48 +++++++++++++++++++++++++++++++++++----
 3 files changed, 54 insertions(+), 5 deletions(-)
