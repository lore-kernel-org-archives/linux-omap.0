From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/5] omap timer changes for v3.8 merge window
Date: Wed, 14 Nov 2012 18:56:44 -0800
Message-ID: <E1TYpdf-0007Fq-9e@merlin.infradead.org>
References: <pull-1352948204-277861>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1352948204-277861>
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

The following changes since commit d308ba50a1234b299a00e63a95e61fdeb2f1a2df:

  Merge branch 'omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3' into omap-for-v3.8/dt (2012-11-09 14:58:34 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/timer-signed

for you to fetch changes up to 9dc57643738f9fbe45c10cc062903d5dfda5bdd9:

  Merge branch 'fixes-timer' of github.com:jonhunter/linux into omap-for-v3.8/timer (2012-11-13 13:52:38 -0800)

----------------------------------------------------------------

Timer fixes for omaps via Jon Hunter <jon-hunter@ti.com>:

Several fixes for the OMAP DMTIMER driver including ...
1. Adding workaround for OMAP3+ errata i103/i767
2. Fixing posted mode support
3. Spurious interrupts when using match interrupt
4. HWMOD fixes for timers
5. Unnecessary restoration of read-only registers
6. Adds function for disabling timer interrupts
7. Fixing timer1 reset for OMAP1

----------------------------------------------------------------
Jon Hunter (13):
      ARM: OMAP: Add DMTIMER definitions for posted mode
      ARM: OMAP3+: Implement timer workaround for errata i103 and i767
      ARM: OMAP: Fix timer posted mode support
      ARM: OMAP3: Correct HWMOD DMTIMER SYSC register declarations
      ARM: OMAP2/3: Define HWMOD software reset status for DMTIMERs
      ARM: OMAP2+: Don't use __omap_dm_timer_reset()
      ARM: OMAP: Fix dmtimer reset for timer1
      ARM: OMAP: Don't restore of DMTIMER TISTAT register
      ARM: OMAP: Don't restore DMTIMER interrupt status register
      ARM: OMAP: Fix spurious interrupts when using timer match feature
      ARM: OMAP: Add dmtimer interrupt disable function
      ARM: OMAP: Remove unnecessary call to clk_get()
      ARM: OMAP: Remove __omap_dm_timer_set_source function

Tony Lindgren (1):
      Merge branch 'fixes-timer' of github.com:jonhunter/linux into omap-for-v3.8/timer

 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c | 15 ++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 41 ++++++------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  4 ++
 arch/arm/mach-omap2/timer.c                        | 70 +++++++++++++++-----
 arch/arm/plat-omap/dmtimer.c                       | 77 +++++++++++++---------
 arch/arm/plat-omap/include/plat/dmtimer.h          | 72 ++++++++++++++------
 6 files changed, 188 insertions(+), 91 deletions(-)
