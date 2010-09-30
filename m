From: Abraham Arce <x0066660@ti.com>
Subject: [PATCH v6 0/8] OMAP4 Keyboard Controller Support
Date: Thu, 30 Sep 2010 00:29:17 -0500
Message-ID: <1285824565-24906-1-git-send-email-x0066660@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Abraham Arce <x0066660@ti.com>
List-Id: linux-omap@vger.kernel.org

Keyboard controller for OMAP4 includes

 - built-in scanning algorithm
 - debouncing feature

This patch series is based in already accepted OMAP4 keyboard controller:

 Linux Input Tree
 Commit a17f79553f052f04d47689a842118f775f81b7e3
 Input: add support for OMAP4 keyboard controller

Dependency on hwmod changes for OMAP4:
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28188.html

---

v1
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26502.html
 Initial Version

v2
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28334.html

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

v3
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg29297.html

 Dmitry.Torokhov | Rework in driver code


v4
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30759.html

 Felipe.Balbi.01    | rows, cols, base and irq definitions
 Felipe.Balbi.02    | device_* calls
 Felipe.Balbi.03    | input device registration before irq enabling
 Felipe.Balbi.04    | kzalloc allocation never to be freed

 Tony.Lindgren.01   | test in omap2 and omap3
 Tony.Lindgren.02   | add cpu_is_omap44xx()

 Kevin.Hillman.01   | drop device_* calls
 Kevin.Hillman.01   | use runtime PM API

 Tomas.Petazzoni.01 | oh_name declaration

v5
 Basak.Partha.01 | Enable Wakeup patch dependency by Rajendra
 Basak.Partha.02 | dev_pm_ops dummy functions, avoid .runtime functions
 Basak.Partha.03 | Remove omap_hwmod_for_each_by_class 
 Basak.Partha.04 | Remove request_mem_region
 Basak.Partha.04 | Overall PM runtime implementation

 Benoit.Cousson.01 | Detailed history required

 Anand.Gadiyar.01 | s/initialization/init for omap4_keypad_initialization
                    It will be renamed to omap4_keyboard_init
 Anand.Gadiyar.02 | 2 unnecessary line additions
 Anand.Gadiyar.03 | 1 unnecessary line removal
 Anand.Gadiyar.04 | Correct interrupt line behaviour in a separate patch
 Anand.Gadiyar.05 | cpu_is_omap44xx() extra check

 Sergio.Aguirre.01 | Change sdp4430_keypad_data naming, use keypad_data instead
 Sergio.Aguirre.02 | Remove unnecessary keypad_data variable
 Sergio.Aguirre.03 | 2 changes for name/oh_name definition, to be const
 Sergio.Aguirre.04 | Use sdp4430_keypad_data variable directly
 Sergio.Aguirre.05 | Add check for return value for WARN(IS_ERR(od)...

 Manjunatha.GK.01 | Use different subject: OMAP3: hwmod data: add system DMA
 Manjunatha.GK.02 | change unsigned used for negative number
 Manjunatha.GK.03 | cpu_is_omap44xx() under CONFIG_ARCH_OMAP4

---

Abraham Arce (5):
  Input: omap4 - use platform device helpers
  Input: omap4 - SYSCONFIG register configuration
  Input: omap4 - Interrupt line configuration
  OMAP4: Keyboard device registration
  Input: omap4 - pm runtime

Benoit Cousson (1):
  OMAP4: hwmod data: add keyboard controller

Mike Turquette (1):
  Input: omap4 - Wake-up on events & long presses

Syed Rafiuddin (1):
  OMAP4: Keyboard board support

 arch/arm/mach-omap2/board-4430sdp.c            |   90 ++++++++++++++++++++++++
 arch/arm/mach-omap2/devices.c                  |   39 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c     |   69 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap4-keypad.h |    4 +-
 drivers/input/keyboard/omap4-keypad.c          |   66 ++++++++++++++----
 5 files changed, 251 insertions(+), 17 deletions(-)

