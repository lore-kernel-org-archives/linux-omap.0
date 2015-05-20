From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] omap gpmc changes for parsing devices and working debug
Date: Wed, 20 May 2015 14:21:01 -0700
Message-ID: <1432156863-19695-1-git-send-email-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are few fixes that allow to hook any devices to GPMC
instead of artificially limiting them by name. There are at
least FPGAs and USB controllers that I'm aware of.

Then we need disable hwmod reset for GPMC debug, otherwise
debug only shows the default memory timings.. Let's do this
with a Kconfig option.

Regards,

Tony


Tony Lindgren (2):
  memory: omap-gpmc: Fix parsing of devices
  memory: omap-gpmc: Add Kconfig option for debug

 arch/arm/mach-omap2/omap_hwmod.h                        |  6 ++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c      | 12 ++----------
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  3 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c              | 12 ++----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c              | 11 ++---------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c               |  4 ++--
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c              |  2 ++
 drivers/memory/Kconfig                                  |  8 ++++++++
 drivers/memory/omap-gpmc.c                              | 14 ++++----------
 9 files changed, 30 insertions(+), 42 deletions(-)

-- 
2.1.4
