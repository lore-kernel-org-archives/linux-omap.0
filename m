From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/4] omap late cpufreq changes for v3.13 merge window
Date: Wed, 23 Oct 2013 07:36:43 -0700
Message-ID: <E1VYzYt-0008Mq-Kk@merlin.infradead.org>
References: <pull-1382539003-174282>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1382539003-174282>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 06ff74fd197aa8205443cf64b94383802602e320:

  ARM: OMAP2+: remove legacy support for IGEP boards (2013-10-18 10:25:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/cpufreq-late

for you to fetch changes up to 60c5fc86d01154e2a005bf701f495426ebc81f73:

  ARM: OMAP3+: use cpu0-cpufreq driver in device tree supported boot (2013-10-22 08:10:09 -0700)

----------------------------------------------------------------
Few patches to make cpufreq work for omap3 with device tree.

Note that this branch has a dependency to the patches merged
with omap-for-v3.13/board-removal-signed-take2.

----------------------------------------------------------------
Nishanth Menon (3):
      ARM: OMAP3+: do not register non-dt OPP tables for device tree boot
      ARM: OMAP2+: add missing lateinit hook for calling pm late init
      ARM: OMAP3+: use cpu0-cpufreq driver in device tree supported boot

 arch/arm/mach-omap2/board-generic.c |  4 ++++
 arch/arm/mach-omap2/common.h        |  4 ++++
 arch/arm/mach-omap2/io.c            | 20 ++++++++++++++++++++
 arch/arm/mach-omap2/opp.c           |  4 ++++
 arch/arm/mach-omap2/pm.c            | 12 +++++++++---
 5 files changed, 41 insertions(+), 3 deletions(-)
