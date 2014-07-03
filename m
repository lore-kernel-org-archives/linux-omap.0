From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/3] OMAP: dra7: hwmod: Fixes for 3.16
Date: Thu, 3 Jul 2014 14:01:11 +0300
Message-ID: <1404385274-5093-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: rnayak@ti.com, kishon@ti.com, george.cherian@ti.com, balbi@ti.com, balajitk@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

For your convenience I have collected the 3 hwmod patches that were floating around
and added the Reviewed-by and Tested-by tags.

Please queue them for 3.16-rc. Thanks.

Patches are also available in my git tree
git@github.com:rogerq/linux.git		hwmod-v3.16-v2

cheers,
-roger

Roger Quadros (3):
  ARM: DRA7: hwmod: Add OCP2SCP3 module
  ARM: DRA7: hwmod: Fixup SATA hwmod
  ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss

 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 42 +++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 5 deletions(-)

-- 
1.8.3.2
