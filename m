From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/5] Minor ti-sysc cleanups
Date: Tue, 25 Jun 2019 18:33:10 -0500
Message-ID: <20190625233315.22301-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

The following series includes minor cleanup patches against the ti-sysc
code. Patches are based on top of all your 5.3 staged branches. Feel free
to pick them up for either 5.3 (if it is not too late) or 5.4 merge window. 

The first 4 patches are non-coding changes, and the last patch is a minor
fixup cleaning up the code flow on failure error paths in sysc_probe()
function. I have boot tested on the limited boards that I have - AM335x
BeagleBone Black, AM437x IDK, AM57xx GP EVM, OMAP4 PandaBoard and OMAP5
uEVM.

regards
Suman

Suman Anna (5):
  MAINTAINERS: Add ti-sysc files under the OMAP2+ entry
  dt-bindings: ti-sysc: Add SPDX license identifier
  bus: ti-sysc: Switch to SPDX license identifier
  bus: ti-sysc: Add missing kerneldoc comments
  bus: ti-sysc: Simplify cleanup upon failures in sysc_probe()

 MAINTAINERS                           |  2 ++
 drivers/bus/ti-sysc.c                 | 31 +++++++++++++--------------
 include/dt-bindings/bus/ti-sysc.h     |  1 +
 include/linux/platform_data/ti-sysc.h |  7 ++++--
 4 files changed, 23 insertions(+), 18 deletions(-)

-- 
2.21.0
