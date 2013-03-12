From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/8] USB: PHY: nop: Device tree support for 3.10
Date: Tue, 12 Mar 2013 13:24:18 +0200
Message-ID: <1363087466-32444-1-git-send-email-rogerq@ti.com>
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
To: balbi-l0cyMroinI0@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

These patches add device tree support as well as PHY resource handling
(i.e. clock, reset, power) for the NOP transceiver driver.

Please add these patches before your patches that move/rename the
drivers/usb/otg/nop-usb-xceiv.c file.

NOTE: The first patch that changes platform header must be common between
you and Tony's OMAP tree. Maybe you guys can share an immutable branch?

cheers,
-roger

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:
  git://github.com/rogerq/linux.git usbhost-phy-next

Roger Quadros (8):
      usb: phy: nop: Add some parameters to platform data
      usb: phy: nop: use devm_kzalloc()
      usb: phy: nop: Manage PHY clock
      usb: phy: nop: Handle power supply regulator for the PHY
      usb: phy: nop: Handle RESET for the PHY
      usb: phy: nop: use new PHY API to register PHY
      usb: phy: nop: Add device tree support and binding information
      USB: phy: nop: Defer probe if device needs VCC/RESET

 .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 +++++
 drivers/usb/otg/nop-usb-xceiv.c                    |  143 +++++++++++++++++--
 include/linux/usb/nop-usb-xceiv.h                  |    5 +
 3 files changed, 167 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt

-- 
1.7.4.1
