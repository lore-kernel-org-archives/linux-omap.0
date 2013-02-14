From: Roger Quadros <rogerq@ti.com>
Subject: [GIT PULL] common: OMAP USB Host cleanup for 3.9
Date: Thu, 14 Feb 2013 14:01:25 +0200
Message-ID: <511CD215.8080005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Kernel development list <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony & Samuel,

This is the common patch for the OMAP USB Host cleanup series for 3.9.
It makes changes to platform headers only.
The other 2 pull requests, one for each of you will be based on this.

This is based on 3.8-rc6.

Please pull. Thanks.

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:
  git://github.com/rogerq/linux.git usbhost17-common

Roger Quadros (1):
      ARM: OMAP: Consolidate OMAP USB-HS platform data (part 1/3)

 include/linux/platform_data/usb-omap.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

--
cheers,
-roger
