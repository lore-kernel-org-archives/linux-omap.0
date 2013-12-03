From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/3] ARM: OMAP2+: USB Host bug fixes for 3.13 rc
Date: Tue, 3 Dec 2013 16:25:45 +0200
Message-ID: <1386080748-17005-1-git-send-email-rogerq@ti.com>
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
To: bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com
Cc: michael@amarulasolutions.com, David.Laight@ACULAB.COM, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, sr@denx.de, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This is a follow up solution to the original series in [1]

The first patch fixes the OMAP4 Panda USB detection problems on 3.13-rc1
with u-boot v2013.10.

The remaining 2 patches are required if SOFTRESET needs to be done for the
USB Host module on OMAP3 platforms.

Patch 2 fixes the hwmod RESET logic to prevent multiple SOFTRESETs
being issued to the modules. This multiple SOFTRESET was causing problems
with OMAP3 USB Host module. On Beagleboard C4 this is seen as failure to
mount NFS root over external USB to Ethernet device.

This might be the reason why HWMOD_INIT_NO_RESET was used for the OMAP
USB host module in OMAP3 hwmod data and just carried forward in OMAP4
and OMAP5 hwmod data as well.

cheers,
-roger

[1] - http://thread.gmane.org/gmane.linux.kernel/1603931

Roger Quadros (3):
  ARM: OMAP4+: hwmod data: Don't prevent RESET of USB Host module
  ARM: OMAP2+: hwmod: Fix RESET logic
  ARM: OMAP3: hwmod data: Don't prevent RESET of USB Host module

 arch/arm/mach-omap2/omap_hwmod.c           | 43 +++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 13 +++------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 12 ++-------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 13 +++------
 4 files changed, 50 insertions(+), 31 deletions(-)

-- 
1.8.3.2
