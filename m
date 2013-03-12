From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/6] mfd: omap-usb-host: Device tree support for 3.10
Date: Tue, 12 Mar 2013 12:25:34 +0200
Message-ID: <1363083940-20050-1-git-send-email-rogerq@ti.com>
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
To: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Samuel,

These patches implement device tree support for the OMAP High Speed
USB Host subsystem. The corresponding EHCI & SoC patches will be sent
separately and this set has no build dependencies with them.

Patch 3 is acutally a bug fix which should go into 3.9-rc. I've sent
it separately to you before.

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:
  git://github.com/rogerq/linux.git usbhost-mfd-next

Roger Quadros (6):
      mfd: omap-usb-host: update nports in platform_data
      mfd: omap-usb-host: Remove PHY reset handling code
      mfd: omap-usb-host: Actually update hostconfig
      mfd: omap-usb-tll: move configuration code to omap_tll_init()
      mfd: omap-usb-tll: Add device tree support and binding information
      mfd: omap-usb-host: Add device tree support and binding information

 .../devicetree/bindings/mfd/omap-usb-host.txt      |   80 ++++++++
 .../devicetree/bindings/mfd/omap-usb-tll.txt       |   17 ++
 drivers/mfd/omap-usb-host.c                        |  206 ++++++++++++++-----
 drivers/mfd/omap-usb-tll.c                         |  214 ++++++++++----------
 drivers/mfd/omap-usb.h                             |    5 +-
 5 files changed, 365 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-host.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt

--
cheers,
-roger
