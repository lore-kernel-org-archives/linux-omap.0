From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] one regression fix and two more omap dt fixes against
 v3.13-rc2
Date: Thu, 5 Dec 2013 17:32:13 -0800
Message-ID: <10501.7235306606$1386293570@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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

The following changes since commit dc1ccc48159d63eca5089e507c82c7d22ef60839:

  Linux 3.13-rc2 (2013-11-29 12:57:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/yet-more-dt-regressions

for you to fetch changes up to 341ba42e76723f2c39da7e288703896ae3d85620:

  ARM: OMAP2+: Fix the machine entry for am3517 (2013-12-05 16:25:30 -0800)

----------------------------------------------------------------
A rather big fix for a regression where we have dropped omap4 hwmod
data earlier but are not initializing it from device tree. In addition
to this fix we eventually also be fix the issues in the .dts files
and drivers, but that's too intrusive for the -rc cycle and must be
done later on.

Also two more legacy booting vs device tree based booting fixes for
am3517 that I did not notice earlier until Nishant Menon reported
these to me few days ago. With these we're good to go having v3.13
working both for legacy booting and device tree based booting, and we
can then go ahed and drop the legacy booting for mach-omap2 for v3.14.

----------------------------------------------------------------
Nishanth Menon (1):
      ARM: OMAP2+: Fix the machine entry for am3517

Tony Lindgren (2):
      ARM: OMAP2+: Fix overwriting hwmod data with data from device tree
      ARM: dts: Fix missing entries for am3517

 arch/arm/boot/dts/am3517-evm.dts    |  6 +--
 arch/arm/boot/dts/am3517.dtsi       | 63 ++++++++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c | 18 +++++++
 arch/arm/mach-omap2/omap_hwmod.c    | 98 +++++++++++++++++++++++++++++--------
 4 files changed, 162 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/boot/dts/am3517.dtsi
