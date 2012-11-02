From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 0/5] usb: musb: am335x support
Date: Fri, 2 Nov 2012 22:01:33 +0530
Message-ID: <cover.1351870620.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Santhapuri Damodar <damodar.santhapuri@ti.com>, Ravi Babu <ravibabu@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Balbi,

This series adds usb support to am335x SoC's found on boards like
Beagle Bone. Here only first instance is supported, as currently
multiple phy's of same type is not supported (am335x has two USB2
phy's).

This series is based on your musb branch,
 (HEAD - 2f77116 usb: musb: remove hand-crafted id handling)
and is made over my series,
 (usb: musb: dsps: fixes for -rc)
and has been tested on Beagle Bone by ethernet gadget.

First two may qualify as -rc material, with these two it is actually
possible to get USB working assuming bootloader leaves phy enabled
and provides Kernel with DT blob.

Last one configures control module to enable bultin phy.

Proper solution is to make use of control module driver, but it is
not expected to be ready soon and this would block USB support for
am335x.

Here dsps wrapper driver is provided with control module register
physical address. Even though this a hack, there is no other option
left till control module driver is ready. As of now only am335x is
using dsps wrapper, and so driver is made aware of am335x control
module physical address.

Please note that this is a temporary arrangment till omap control
module driver is available.

Other options are providing control module register space as memory
resource via DT or using omap hwmod.

DT approach has been rejected by Rob Herring, while resources are
being moved from hwmod to DT. And both of the above approaches
require that control module registers be configured in wrapper driver
itself requring a quirk in driver as well as DT or hwmod.


Regards
Afzal 


Afzal Mohammed (4):
  usb: musb: dsps: remove platform callback
  usb: musb: dsps: reduce musb instance to one
  usb: musb: dsps: get resources by index
  usb: musb: dsps: dt binding - add resources, example

Santhapuri, Damodar (1):
  usb: musb: dsps: control module handling (quirk)

 .../devicetree/bindings/usb/am33xx-usb.txt         | 21 +++++
 drivers/usb/musb/musb_dsps.c                       | 95 ++++++++++++++++------
 2 files changed, 89 insertions(+), 27 deletions(-)

-- 
1.7.12

