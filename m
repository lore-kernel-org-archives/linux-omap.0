From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 0/2] usb: phy: add usb3 phy driver
Date: Fri, 25 Jan 2013 16:29:32 +0530
Message-ID: <1359111574-6613-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Apologies for the delay in sending this version.
 
Added a driver for usb3 phy that handles the interaction between usb phy
device and dwc3 controller.

Changes from v3:
* Changed the property name from "ctrl_module" to "ctrl-module"

Changes from v2:
* used control module driver APIs to write to control module register.
* Added pm_runtime_put and pm_runtime_disable in the usb3 phy driver.
* Added checks for enabling and disabling "usb_otg_ss_refclk960m" so that
  it doesn't break omap4.

Changes from v1:
* Added missing clk_put()
* Remove the patches usb: dwc3: Fix gadget pullup in SS mode and
usb: phy: omap-usb3: Decrease the number of transitions to recovery. Those
are actually WA for hw issues which will be fixed in ES2.
* Removed the *has960mhzclk* property

This patch series is developed on
git://github.com/rrnayak/linux.git omap5-3.8-rc4-base-palmas

I've kept this patch series and the patch series to follow in a single branch
git://gitorious.org/linux-usb/linux-usb.git omap5-with-palmas
(changes up to 23b4dfa2ab7052569cd88acc6383c4b1a8e8a482)

Did enumeration testing on omap4 panda and omap5 evm.

Kishon Vijay Abraham I (2):
  usb: phy: add a new driver for usb3 phy
  usb: phy: omap-usb2: enable 960Mhz clock for omap5

 Documentation/devicetree/bindings/usb/usb-phy.txt |   23 ++
 drivers/usb/phy/Kconfig                           |   10 +
 drivers/usb/phy/Makefile                          |    1 +
 drivers/usb/phy/omap-usb2.c                       |   28 +-
 drivers/usb/phy/omap-usb3.c                       |  355 +++++++++++++++++++++
 include/linux/usb/omap_usb.h                      |   23 ++
 6 files changed, 439 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/phy/omap-usb3.c

-- 
1.7.9.5
