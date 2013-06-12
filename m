From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/6] omap pm changes for v3.11 merge window
Date: Wed, 12 Jun 2013 11:24:34 -0700
Message-ID: <E1UmpjQ-0005cT-Lo@merlin.infradead.org>
References: <pull-1371061475-206272>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1371061475-206272>
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

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/pm-signed

for you to fetch changes up to 49a34fd5380d249ae8a2173399c62fc5a1fddd70:

  Merge tag 'omap-pm-v3.10/cleanup/pm' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.11/pm (2013-05-16 08:27:49 -0700)

----------------------------------------------------------------

Omap PM changes via Kevin Hilman <khilman@linaro.org>:

OMAP PM cleanups for v3.10

----------------------------------------------------------------
Santosh Shilimkar (4):
      ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for all CPU power states except off
      ARM: OMAP4+: PM: Consolidate MPU subsystem PM code for re-use
      ARM: OMAP4+: Make secondary_startup function name more consistent
      ARM: OMAP4+: PM: Consolidate OMAP4 PM code to re-use it for OMAP5

Tony Lindgren (1):
      Merge tag 'omap-pm-v3.10/cleanup/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.11/pm

 arch/arm/mach-omap2/common.h              |  4 +-
 arch/arm/mach-omap2/omap-headsmp.S        |  8 ++--
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 69 +++++++++++++++++++++++++------
 arch/arm/mach-omap2/omap-smp.c            |  6 +--
 arch/arm/mach-omap2/pm44xx.c              | 58 +++++++++++++++++++++-----
 5 files changed, 113 insertions(+), 32 deletions(-)
