From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/6] omap hwmod changes for v3.13 merge window
Date: Fri, 11 Oct 2013 18:44:58 -0700
Message-ID: <E1VUoHI-0004fg-H7@merlin.infradead.org>
References: <pull-1381542299-305003>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1381542299-305003>
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

The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

  Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/hwmod-signed

for you to fetch changes up to 254f57a92987b6cde6004f58d6b847813dfb9e0e:

  ARM: OMAP5: hwmod: add missing ocp2scp hwmod data (2013-10-11 15:37:05 -0700)

----------------------------------------------------------------
omap hwmod related changes via Paul Walmsley <paul@pwsan.com>:

Some OMAP hwmod changes for 3.13.  Significant changes here include:

- support for moving some of the hwmod flags to DT data

- support for the SSI, hardware spinlock, USB host/TLL, and RNG IP
  blocks for various OMAPs

- a fix that again decouples hwmod data changes from unrelated DT data
  patchsets

Basic test logs are available at:

http://www.pwsan.com/omap/testlogs/prcm_fixes_v3.13/20131009094936/

----------------------------------------------------------------
Benoit Cousson (1):
      ARM: OMAP5: hwmod: add missing ocp2scp hwmod data

Lokesh Vutla (1):
      ARM: AM33xx: hwmod: Add RNG module data

Rajendra Nayak (2):
      ARM: OMAP2+: hwmod: cleanup HWMOD_INIT_NO_RESET usage
      ARM: OMAP2+: hwmod: Extract no-idle and no-reset info from DT

Roger Quadros (1):
      ARM: OMAP5: hwmod data: Add USB Host and TLL modules

Sebastian Reichel (1):
      ARM: OMAP2+: hwmod data: Add SSI information

Suman Anna (3):
      ARM: OMAP2+: hwmod: check for module address space during init
      ARM: OMAP5: hwmod data: Add spinlock data
      ARM: AM33xx: hwmod_data: add the sysc configuration for spinlock

Tony Lindgren (1):
      Merge tag 'for-v3.13/hwmod' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.13/hwmod

 arch/arm/mach-omap2/omap_hwmod.c           |  49 ++++--
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |  67 +++++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  48 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   6 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 230 ++++++++++++++++++++++++++++-
 5 files changed, 370 insertions(+), 30 deletions(-)
