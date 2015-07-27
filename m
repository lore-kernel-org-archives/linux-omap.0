From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/3] ARM: dts: dra7: scm_conf node cleanup
Date: Mon, 27 Jul 2015 13:27:27 +0300
Message-ID: <1437992850-6008-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This series cleans up the scm_conf node.

v2:
- split patch. use only core_sma_sw registers for the new scm_conf child.

cheers,
-roger

Roger Quadros (3):
  ARM: dts: dra7: Remove ctrl_core and ctrl_general nodes
  ARM: dts: dra7: fix pinmux@1400 resource length
  ARM: dts: dra7: Add scm_conf@1c04 node

 arch/arm/boot/dts/dra7.dtsi | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

-- 
2.1.4
