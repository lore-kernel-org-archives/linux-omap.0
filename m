From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/12] USB: ehci-omap: Device tree support for 3.10
Date: Tue, 12 Mar 2013 12:44:38 +0200
Message-ID: <1363085090-24676-1-git-send-email-rogerq@ti.com>
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
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Greg,

These patches implement device tree support for the OMAP's
EHCI host controller. The corresponding MFD/SoC patches will be sent
separately and this set has no dependeny with them.

NOTE: Last 2 patches are new and still need and Ack from Alan Stern.
Please accept this set after he has acked them. Thanks.

cheers,
-roger

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:
  git://github.com/rogerq/linux.git usbhost-usb-next

Alan Stern (1):
  USB: EHCI: split ehci-omap out to a separate driver

Roger Quadros (11):
  USB: ehci-omap: Use devm_ioremap_resource()
  USB: ehci-omap: Use PHY APIs to get the PHY device and put it out of
    suspend
  USB: ehci-omap: Remove PHY reset handling code
  USB: ehci-omap: Remove PHY regulator handling code
  USB: ehci-omap: Select NOP USB transceiver driver
  USB: ehci-omap: Get platform resources by index rather than by name
  USB: ohci-omap3: Get platform resources by index rather than by name
  USB: ohci-omap3: Add device tree support and binding information
  USB: ehci-omap: Add device tree support and binding information
  USB: ehci-omap: Try to get PHY even if not in PHY mode
  USB: ehci-omap: Fix detection in HSIC mode

 .../devicetree/bindings/usb/ehci-omap.txt          |   32 ++
 .../devicetree/bindings/usb/ohci-omap3.txt         |   15 +
 drivers/usb/host/Kconfig                           |    3 +-
 drivers/usb/host/Makefile                          |    1 +
 drivers/usb/host/ehci-hcd.c                        |    6 +-
 drivers/usb/host/ehci-omap.c                       |  312 +++++++++-----------
 drivers/usb/host/ohci-omap3.c                      |   24 ++-
 7 files changed, 214 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-omap.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ohci-omap3.txt

-- 
1.7.4.1
