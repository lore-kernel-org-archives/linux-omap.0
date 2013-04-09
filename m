From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/5] omap pm clean-up for v3.10 merge window
Date: Mon, 8 Apr 2013 21:51:01 -0700
Message-ID: <E1UPQX1-0007yl-BI@merlin.infradead.org>
References: <pull-1365483063-475562>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1365483063-475562>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/cleanup-pm-signed

for you to fetch changes up to ca8cdff548da76da01f3783548ceb917139a5ddc:

  Merge tag 'omap-pm-v3.10/cleanup/cpuidle' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.10/cleanup-pm (2013-04-08 09:51:00 -0700)

----------------------------------------------------------------

PM cleanup to prepare for omap5 PM via Kevin Hilman <khilman@linaro.org>:

OMAP3/4 CPUidle cleanups for v3.10

----------------------------------------------------------------
Daniel Lezcano (1):
      ARM: omap3: cpuidle: enable time keeping

Santosh Shilimkar (5):
      ARM: OMAP4: CPUidle: Avoid double idle driver registration
      ARM: OMAP: CPUidle: Unregister drivere on device registration failure
      ARM: OMAP4: CPUidle: Make C-state description field more precise
      ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()
      ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support

Tony Lindgren (1):
      Merge tag 'omap-pm-v3.10/cleanup/cpuidle' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.10/cleanup-pm

 arch/arm/mach-omap2/common.h              |  5 ----
 arch/arm/mach-omap2/cpuidle34xx.c         | 11 +++++--
 arch/arm/mach-omap2/cpuidle44xx.c         | 48 +++++++++++++++++--------------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 14 ---------
 4 files changed, 35 insertions(+), 43 deletions(-)
