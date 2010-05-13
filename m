From: "Arce, Abraham" <x0066660@ti.com>
Subject: [RFC] [PATCH 0/4] OMAP4 Keyboard Controller Support
Date: Thu, 13 May 2010 15:49:37 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E113BF3@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37168 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759465Ab0EMUtj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 16:49:39 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Keyboard controller for OMAP4 includes

 - built-in scanning algorithm
 - debouncing feature
 - handling mechanism up to 9 x 9 keys
 - wake-up event generation

Dependency on hwmod changes for OMAP4
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28188.html

--

v1
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26502.html

v2
 Vimal.Singh.01 | Signed-off-by missing in patch
 Vimal.Singh.02 | row/column interpretation in board file
 Vimal.Singh.03 | 0 element removal in board file

 Trilok.Soni.01 | hwmod framework in mainline
 Trilok.Soni.02 | extra brackets in Kconfig
 Trilok.Soni.03 | default y/n option in Kconfig
 Trilok.Soni.04 | path/filename in the header of driver
 Trilok.Soni.05 | static? omap_device_pm_latency in driver
 Trilok.Soni.06 | input_sync added in driver
 Trilok.Soni.07 | check error return in all driver
 Trilok.Soni.08 | keypad_data->input=NULL

 Felipe.Balbi.01 | platform_driver to know about hwmod and omap_device?
 Felipe.Balbi.02 | blank line
 Felipe.Balbi.03 | saving struct device *
 Felipe.Balbi.04 | platform_data should not be saved
 Felipe.Balbi.05 | dev_dbg() usage
 Felipe.Balbi.06 | missing input_sync()
 Felipe.Balbi.07 | snprintf() usage
 Felipe.Balbi.08 | omap_hwmod and omap_device location
 Felipe.Balbi.09 | matrix_keypad_platform_data allocation from platform code
 Felipe.Balbi.10 | omap_device_build from platform code
 Felipe.Balbi.11 | registering/configuring call location

 Kevin.Hillman.01 | Driver Testing
 Kevin.Hillman.02 | omap_hwmod and omap_device location

 Dmitry.Torokhov.01 | reason to make omap_keypad_threaded threaded?
 Dmitry.Torokhov.02 | MATRIX_SCAN_CODE and incorrect values
 Dmitry.Torokhov.03 | matrix_keypad_platform_data allocation
 Dmitry.Torokhov.04 | overriding pdata pointer
 Dmitry.Torokhov.05 | keypad_codes separate allocation
 Dmitry.Torokhov.06 | keypad_data->base check location
 Dmitry.Torokhov.07 | keypad_data->irq check location
 Dmitry.Torokhov.08 | input_dev->keycodemax needed
 Dmitry.Torokhov.09 | KEY_OK set bit
 Dmitry.Torokhov.10 | MSC_SCAN report missing
 Dmitry.Torokhov.11 | input_dev = NULL;
 Dmitry.Torokhov.12 | free_irq call location in remove function

--

 [PATCH v2 1/4] Input: matrix_keypad: Device driver interfaces
 [PATCH v2 2/4] OMAP4: Keyboard controller support
 [PATCH v2 3/4] OMAP4: Keyboard board support
 [PATCH v2 4/4] OMAP4: Keyboard kernel configuration

--

 arch/arm/configs/omap_4430sdp_defconfig |    3
 arch/arm/mach-omap2/board-4430sdp.c     |  157 ++++++++++++++++
 drivers/input/keyboard/Kconfig          |   10 +
 drivers/input/keyboard/Makefile         |    1
 drivers/input/keyboard/omap4-keypad.c   |  304 ++++++++++++++++++++++++++++++++
 include/linux/input/matrix_keypad.h     |    7
 6 files changed, 481 insertions(+), 1 deletion(-)

