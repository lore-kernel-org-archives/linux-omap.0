From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/10] updates for omap2plus_defconfig
Date: Thu,  1 Mar 2018 14:16:54 -0800
Message-ID: <20180301221704.104530-1-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are some omap2plus_defconfig updates to fix up the options that
have changed and would get removed with make defconfig, then to drop
the unneeded options with make defconfig, and finally add some new
options.

The biggest changes naturally are the switch from omap_serial to
8250_omap, and from omapfb to omapdrm. But both have been tested for
several years now, so I think we can flip over to use them now.

And then we now enable the options needed for am335x and am437x PM.

Regards,

Tony

Tony Lindgren (10):
  ARM: omap2plus_defconfig: Update for moved options
  ARM: omap2plus_defconfig: Add SERIAL_DEV for bluetooth
  ARM: omap2plus_defconfig: Select MFD_TI_LMU
  ARM: omap2plus_defconfig: Update LIRC options
  ARM: omap2plus_defconfig: Add SND_OSSEMUL
  ARM: omap2plus_defconfig: Drop unneeded options
  ARM: omap2plus_defconfig: Enable am335x and am437x PM options
  ARM: omap2plus_defconfig: Enable CEC
  ARM: omap2plus_defconfig: Switch to use omapdrm by default
  ARM: omap2plus_defconfig: Enable 8250_OMAP

 arch/arm/configs/omap2plus_defconfig | 91 ++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 39 deletions(-)

-- 
2.16.2
