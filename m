From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/5] omap clock late changes for v3.9 merge window
Date: Tue, 12 Feb 2013 10:11:01 -0800
Message-ID: <E1U5KKV-0003q6-Tz@merlin.infradead.org>
References: <pull-1360692662-889112>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1360692662-889112>
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

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/clock-signed

for you to fetch changes up to 14211e2fd223212ee6498a707e01ac45fef22b10:

  Merge tag 'omap-devel-e-for-3.9' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.9/clock (2013-02-09 19:59:34 -0800)

----------------------------------------------------------------

omap clock changes via Paul Walmsley <paul@pwsan.com>:

Some miscellaneous OMAP2+ clock fixes, mostly related to the recent
common clock framework conversion.

Basic test logs are available here:

    http://www.pwsan.com/omap/testlogs/clock_devel_a_3.9/20130208120108/

----------------------------------------------------------------
Afzal Mohammed (3):
      ARM: OMAP2+: dpll: am335x - avoid freqsel
      ARM: OMAP2+: clock data: add DEFINE_STRUCT_CLK_FLAGS helper
      ARM: OMAP AM33XX: clock data: SET_RATE_PARENT in lcd path

Laurent Pinchart (2):
      ARM: OMAP3: clock: Back-propagate rate change from cam_mclk to dpll4_m5
      omap3isp: Set cam_mclk rate directly

Paul Walmsley (1):
      Merge branch 'clock_misc_devel_a_3.9', remote-tracking branch 'remotes/pinchart/omap3isp/clock' into clock_devel_a_3.9

Rajendra Nayak (1):
      ARM: OMAP4: clock data: Add missing clkdm association for dpll_usb

Tony Lindgren (1):
      Merge tag 'omap-devel-e-for-3.9' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.9/clock

 arch/arm/mach-omap2/cclock33xx_data.c | 10 ++++++----
 arch/arm/mach-omap2/cclock3xxx_data.c | 10 +++++++++-
 arch/arm/mach-omap2/cclock44xx_data.c | 13 ++++++++++++-
 arch/arm/mach-omap2/clock.h           | 11 +++++++++++
 arch/arm/mach-omap2/dpll3xxx.c        |  5 +++--
 drivers/media/platform/omap3isp/isp.c | 18 ++----------------
 drivers/media/platform/omap3isp/isp.h |  8 +++-----
 7 files changed, 46 insertions(+), 29 deletions(-)
