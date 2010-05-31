From: "Arce, Abraham" <x0066660@ti.com>
Subject: [RFC] [PATCH v3 0/4] OMAP4 Keyboard Controller Support
Date: Mon, 31 May 2010 16:43:31 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E537F72@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

Keyboard controller for OMAP4 includes

 - built-in scanning algorithm
 - debouncing feature
 - handling mechanism up to 9 x 9 keys
 - wake-up event generation

Dependency on hwmod changes for OMAP4
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28188.html

Tested using SDP4430 board in Kevin Hillman's tree, origin/pm-wip/mmc branch

  commit 14ed0ad58d8dcfdde319ec6bbf66c3c318e5cd02
  Author: Benoit Cousson <b-cousson@ti.com>
      OMAP4: hwmod: Add remaining hwmod support for OMAP4430 ES1.0

--

v1
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26502.html

v2
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28334.html

v3
 Dmitry.Torokhov | Rework in driver code
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg29297.html

--

 [PATCH v3 1/4] OMAP4: Keyboard controller support
 [PATCH v3 2/4] OMAP4: Keyboard device registration
 [PATCH v3 3/4] OMAP4: Keyboard board support
 [PATCH v3 4/4] OMAP4: Keyboard kernel configuration

--

 arch/arm/configs/omap_4430sdp_defconfig        |    3
 arch/arm/mach-omap2/board-4430sdp.c            |  104 +++++++++
 arch/arm/mach-omap2/devices.c                  |   59 +++++
 arch/arm/plat-omap/include/plat/omap4-keypad.h |   23 +
 drivers/input/keyboard/Kconfig                 |   10
 drivers/input/keyboard/Makefile                |    1
 drivers/input/keyboard/omap4-keypad.c          |  288 +++++++++++++++++++++++++
 7 files changed, 487 insertions(+), 1 deletion(-)

