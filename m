From: "Arce, Abraham" <x0066660@ti.com>
Subject: [UPDATE] [PATCH 0/3] OMAP4 Keyboard Controller Support
Date: Thu, 22 Apr 2010 21:25:16 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DC165B1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Thanks all for your comments; I am working to incorporate all of them so next
version is posted. Please find for now completed and pending action items:

Completed

  Vimal.Singh.01 | Signed-off-by missing in patch
  Vimal.Singh.02 | row/column interpretation in board file
  Vimal.Singh.03 | 0 element removal in board file

  Trilok.Soni.01 | hwmod framework in mainline
  Trilok.Soni.02 | extra brackets in Kconfig
  Trilok.Soni.03 | default y/n option in Kconfig
  Trilok.Soni.04 | path/filename in the header of driver
  Trilok.Soni.06 | input_sync added in driver
  Trilok.Soni.07 | check error return in all driver
  Trilok.Soni.08 | keypad_data->input=NULL

  Felipe.Balbi.05 | dev_dbg() usage
  Felipe.Balbi.06 | missing input_sync()

Pending

  Trilok.Soni.05 | static? omap_device_pm_latency in driver

  Felipe.Balbi.01 | platform_driver to know about hwmod and omap_device?
  Felipe.Balbi.02 | blank line
  Felipe.Balbi.03 | saving struct device *
  Felipe.Balbi.04 | platform_data should not be saved
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

Best Regards
Abraham

