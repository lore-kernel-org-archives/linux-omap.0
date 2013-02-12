From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/5] omap pm wfi late changes for v3.9 merge window
Date: Tue, 12 Feb 2013 10:11:01 -0800
Message-ID: <E1U5KKJ-0003nJ-SI@merlin.infradead.org>
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

The following changes since commit 8d61d7f94522a0c023ed79d4f690f2bfc8a41d96:

  Merge tag 'omap-for-v3.9/pm-signed' into omap-for-v3.9/pm-wfi-take2 (2013-02-11 09:19:44 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/pm-wfi-take2-signed-v2

for you to fetch changes up to 25e4d0f6df356ec7c2a09f6744c36a84b5537f33:

  Merge branch 'omap-for-v3.9/pm-fix' into omap-for-v3.9/pm-wfi-take2 (2013-02-12 09:01:25 -0800)

----------------------------------------------------------------

omap pm wfi changes via Paul Walmsley <paul@pwsan.com>:

On OMAP2+ devices, standardize and clean up WFI entry and WFI blocking.

Basic test logs are available here:

   http://www.pwsan.com/omap/testlogs/wfi_devel_a_3.9/20130208085027/

Conflicts:
    arch/arm/mach-omap2/pm24xx.c

Note that this is based on earlier omap-for-v3.9/pm-signed because
of a non-trivial merge conflict. This branch also contains a fix
for c1d1cd59 ("ARM: OMAP2+: omap_device: remove obsolete pm_lats
and early_device code").

----------------------------------------------------------------
Paul Walmsley (5):
      ARM: OMAP2xxx: PM: enter WFI via inline asm if CORE stays active
      ARM: OMAP2+: hwmod: add support for blocking WFI when a device is active
      ARM: OMAP2420: hwmod data/PM: use hwmod to block WFI when I2C active
      ARM: OMAP AM3517/05: hwmod data: block WFI when EMAC active
      ARM: OMAP2+: fix some omap_device_build() calls that aren't compiled by default

Tony Lindgren (2):
      Merge tag 'omap-devel-b-for-3.9' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.9/pm-wfi-take2
      Merge branch 'omap-for-v3.9/pm-fix' into omap-for-v3.9/pm-wfi-take2

 arch/arm/mach-omap2/am35xx-emac.c          |  3 +--
 arch/arm/mach-omap2/devices.c              |  2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  7 ++++++-
 arch/arm/mach-omap2/pm24xx.c               | 12 ++++++------
 arch/arm/mach-omap2/sleep24xx.S            | 19 -------------------
 arch/arm/mach-omap2/sr_device.c            |  2 +-
 6 files changed, 15 insertions(+), 30 deletions(-)
