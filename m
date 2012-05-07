From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/5] omap cpuidle cleanup for v3.5 merge window
Date: Mon, 7 May 2012 15:38:43 -0700
Message-ID: <E1SRWaH-0004dz-8T@merlin.infradead.org>
References: <pull-1336430323-742388>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1336430323-742388>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-cpuidle-for-v3.5

for you to fetch changes up to 274994c49c0ae7c42ce96dcd33b9555a697e7391:

  Merge branch 'for_3.5/cleanup/omap-cpuidle' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into cleanup-cpuidle (2012-05-07 13:51:31 -0700)

----------------------------------------------------------------

CPUidle cleanup

----------------------------------------------------------------
Daniel Lezcano (18):
      ARM: OMAP4: cpuidle - Remove unused valid field
      ARM: OMAP4: cpuidle - Declare the states with the driver declaration
      ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
      ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
      ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
      ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
      ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at boot time
      ARM: OMAP3: cpuidle - remove rx51 cpuidle parameters table
      ARM: OMAP3: define cpuidle statically
      ARM: OMAP3: cpuidle - remove errata check in the init function
      ARM: OMAP3: cpuidle - remove the 'valid' field
      ARM: OMAP3: cpuidle - remove cpuidle_params_table
      ARM: OMAP3: define statically the omap3_idle_data
      ARM: OMAP3: cpuidle - use omap3_idle_data directly
      ARM: OMAP3: cpuidle - simplify next_valid_state
      ARM: OMAP3: set omap3_idle_data as static
      ARM: OMAP3: cpuidle - set global variables static
      ARM: OMAP3: cpuidle - check the powerdomain lookup

Tony Lindgren (1):
      Merge branch 'for_3.5/cleanup/omap-cpuidle' of git://git.kernel.org/.../khilman/linux-omap-pm into cleanup-cpuidle

 arch/arm/mach-omap2/board-rx51.c  |   38 +++--
 arch/arm/mach-omap2/cpuidle34xx.c |  298 +++++++++++++++----------------------
 arch/arm/mach-omap2/cpuidle44xx.c |  126 +++++++---------
 arch/arm/mach-omap2/pm.h          |   21 ---
 4 files changed, 190 insertions(+), 293 deletions(-)
