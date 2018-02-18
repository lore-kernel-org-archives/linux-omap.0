From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH usb-next v10 0/8] initialize (multiple) PHYs for a HCD
Date: Sun, 18 Feb 2018 19:44:56 +0100
Message-ID: <20180218184504.3331-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter.Chen-3arQi8VN3Tc@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The goal of this series is to initialize multiple PHYs on a USB host
controller, which is needed on Amlogic Meson GXL and GXM SoCs.
- Amlogic Meson GXL and GXM SoCs come with a dwc3 IP block which has two
  or three USB2 ports enabled on the internal root-hub. The SoCs also
  provide separate USB2 PHYs, one per port. All USB2 PHYs (which are
  internally "connected" to the dwc3 roothub) need to be powered on,
  otherwise USB devices cannot be enumerated (even if just one PHY is
  disabled and if the device is plugged into another, enabled port)
- dwc3 already takes one USB2 and one USB3 PHY and initializes these
  correctly
- some other HCI platform drivers (like ehci-platform.c, xhci-mtk.c and
  ohci-platform.c) do not have a limitation on the number of PHYs - they
  support any number of USB PHYs (typically one PHY per actual port)

This series adds a new "PHY wrapper". This can be configured through
devicetree by passing a "phys" property (with any number of PHY handles)
to the USB controller.
Additionally it this integrates this new PHY wrapper into hcd.c which
automatically enables it for all USB controller drivers (tested on an
Amlogic Meson GXL SoC which uses a dwc3 controller). Since this leaves
some duplicate code (which now becomes obsolete!) in various drivers
this is being cleaned up as well.


Changes since v9 at [12]:
- changed "skip_phy_initialization" from PATCH #2 into a bitfield and
  moved it below the "remove_phy" bitfield as suggested by Alan Stern
  (thanks!)
- rebased against usb-next (which is currently identical to v4.16-rc1)

Changes since v8 at [10]:
- add new patch #2 which allows disabling "USB PHY management" in the
  USB HCD core driver. this also affects patch #4 which now checks the
  skip_phy_initialization flag before calling
  usb_phy_roothub_{init,power_on} (other functions don't need to be
  guarded since they are null-safe - see patch #3)
- integrated my other series 'remove driver-specific "multiple PHY"
  handling' from [11] into this one so the result of this "generic"
  code (= removing duplicate code in various drivers) can be seen
  directly. affects patches #5-8. (note: patch #1 "usb: mtu3: remove
  custom USB PHY handling" from that series was dropped, because it
  broke device mode support - Chunfeng Yun will come up with a
  separate patch later. patch #5 "usb: chipidea: do not set the "phy"
  field in struct usb_hcd" from that series was rewritten and is now
  integrated into the new patch #2 from this series)
- collected all {Reviewed,Tested,Acked}-by
- dropped RfC prefix since this v8 was out for review for two weeks
  and it only got Reviewed-by's and Tested-by's since then

Changes since v7 at [8]:
- updated the description in the cover-letter
- wrapped the only call usb_phy_roothub_power_{on,off} in
  hcd_bus_{resume,suspend} during system-suspend (excluding it from
  being called during runtime/auto suspend). this also fixes a problem
  on Meson GXL which does not detect that a new device has been
  connected if the PHYs are powered off. Thanks to Manu Gautam for
  suggesting this! (affects patch #3)
- after a discussion about the dt-bindings of this patch I went back to
  simply specifying a "phys" property (without a corresponding phy-names
  property) to pass all PHYs directly in the node of the USB controller.
  From my understanding the root hub node was "artificial" and we should
  describe it's properties as part of the controller, rather than
  introducing a sub-node. see also the discussion with Arnd in [9]
  (this affects patch #1 and #2)
- dropped patch #4 ("dt-bindings: usb: xhci: include the roothub and a
  device in the example") because we're back to just specifying a "phys"
  property directly within the controller.
  NOTE: some HCI platform drivers are using the "phys" property as well.
  With this series phy_{init,power_on,power_off,exit} will be called
  twice for each PHY when using a ehci-platform.c or xhci-mtk.c USB
  controller (because the controller driver and our new, generic code
  now manage the PHYs). the PHY framework handles this gracefully (by
  ref-counting all operations). a follow-up series will be sent which
  removes the custom handling from the affected drivers (so only the
  new PHY wrapper will manage the PHYs state after that follow-up
  series).
- fixed an unnecessary whitespace change spotted by Alan Stern (thanks!)
  in patch #3
- removed all Tested-by's since we're changing code again

Changes since v6 at [6]:
- fixed unnecessary whitespace change (noticed by Alan Stern - thanks)
- added PATCH #4 to clarify (with an example) how I understood how Rob
  wanted the dt-binding to look like (see [0]). please wait for an ACK
  from Rob on this one to make sure that we're not introducing some
  broken binding (as discussed with Arnd: [7])
- added Alan Stern's ACK on PATCH #3
- added Neil's Tested-by on PATCH #2 and #3

Changes since RfC v5 at [5]:
- dropped RfC prefix
- removed noisy dev_err if no roothub node was found (spotted by
  Xiaolong Ye's kbuild test robot - thank you for that!)
- moved the call to usb_phy_roothub_power_off() within
  hcd_bus_suspend() to make sure that the PHYs are turned off
  if the "race with a root-hub wakeup event" condition is met (in
  this case the PHYs are turned on again, with the old code we did
  break the PHYs internal ref-counting because we never turned the
  PHYs off before turning them on again in case of that special
  "race with a root-hub wakeup event").
  additionally we're not handling the status returned by
  usb_phy_roothub_power_off() anymore (the bus is already turned off
  and we tried to turn off all PHYs as well - only the PHYs which
  failed to power off will stay in the current state).
  thanks to Alan Stern for the suggestion
- removed return value from usb_phy_roothub_power_off() because none
  of my code uses it anymore. thanks to Alan Stern for the suggestion

Changes since v4 at [4]:
- renamed the subject of the cover-letter (old name was:
  "initialize (multiple) PHYs in xhci-plat")
- back into RFC status (see below for the reasons)
- dropped Tested-by from Chunfeng Yun (same reasons as RFC status)
- reworded cover-letter and commit messages from "platform-roothub"
  to "roothub PHY wrapper"
- moved code from drivers/usb/host/platform-roothub.* to
  drivers/usb/core/phy.* and the changes to
  drivers/usb/host/xhci-plat.c to drivers/usb/core/hcd.c as suggested
  by Mathias Nyman (as a benefit this will enable the new logic for
  non-xHCI controllers as well - however this was not tested yet)
- rename the structs, function names, etc from platform_roothub_* to
  usb_phy_roothub*

Changes since RFCv3 at [3]:
- moved the DT binding change from patch #3 to patch #1 as suggested
  by Rob Herring (and slightly adjusted the commit message to account
  for that)
- added Tested-by from Chunfeng Yun (who confirmed that the whole
  concept and implementation works fine on Mediatek SoCs - many thanks
  again!) to patch #2
- added Rob Herring's ACK to patches 1 and 3
- dropped RFC status (RFCv3 -> PATCH v4)

Changes since RFCv2 at [2]:
- split phy_{init,exit} and phy_power_{on,off} handling. up until RFCv2
  I called phy_init plus phy_power_on in platform_roothub_power_on and
  phy_power_off plus phy_exit in platform_roothub_power_off. However,
  Chunfeng Yun (a Mediatek SoC developer - many thanks for testing my
  series and providing great feedback) reported that only using
  phy_power_off (and omitting phy_exit) during system suspend fixes an
  issue where USB devices would be re-enumerated when resuming. His
  original problem description: "In order to keep link state on mt8173,
  we just power off all phys(not exit) when system enter suspend, then
  power on them again (needn't init, otherwise device will be
  disconnected) when system resume, this can avoid re-enumerating
  device.". This fix affects patch #2 and #3 as we now have
  platform_roothub_init (which calls phy_init internally),
  platform_roothub_power_on (which calls phy_power_on internally),
  platform_roothub_power_off (which calls phy_power_off internally) and
  platform_roothub_exit (which calls phy_exit internally). suspend and
  resume only call platform_roothub_power_{on,off} to prevent the issue
  described by Chunfeng Yun (unfortunately I cannot test this because
  the Amlogic platform currently does not support system suspend).
- dropped two struct forward declarations from platform-roothub.h which
  are not used in the header file (thanks to Chunfeng Yun for spotting
  this)

Changes since RFCv1 at [1]:
- split the usb-xhci dt-binding documentation into a separate patch
- fixed a typo ("usb-phy" -> "phys" in the dt-binding example)
- rebased to apply against latest usb-next


[0] http://lists.infradead.org/pipermail/linux-amlogic/2016-November/001818.html
[1] http://marc.info/?l=linux-usb&m=148414866303604&w=2
[2] https://www.spinics.net/lists/linux-usb/msg158967.html
[3] https://www.spinics.net/lists/devicetree/msg190426.html
[4] http://lists.infradead.org/pipermail/linux-amlogic/2017-September/004685.html
[5] http://lists.infradead.org/pipermail/linux-amlogic/2017-October/004924.html
[6] http://lists.infradead.org/pipermail/linux-amlogic/2017-October/005049.html
[7] http://lists.infradead.org/pipermail/linux-amlogic/2017-October/005121.html
[8] http://lists.infradead.org/pipermail/linux-amlogic/2017-October/005124.html
[9] http://lists.infradead.org/pipermail/linux-amlogic/2017-October/005192.html
[10] http://lists.infradead.org/pipermail/linux-amlogic/2018-January/006274.html
[11] https://marc.info/?l=linux-usb&m=151683941207898&w=2
[12] http://lists.infradead.org/pipermail/linux-amlogic/2018-February/006412.html

Martin Blumenstingl (8):
  dt-bindings: usb: add the documentation for USB HCDs
  usb: add a flag to skip PHY initialization to struct usb_hcd
  usb: core: add a wrapper for the USB PHYs on the HCD
  usb: core: hcd: integrate the PHY wrapper into the HCD core
  usb: host: xhci-mtk: remove custom USB PHY handling
  usb: host: ehci-platform: remove custom USB PHY handling
  usb: host: ohci-platform: remove custom USB PHY handling
  usb: core: hcd: remove support for initializing a single PHY

 .../devicetree/bindings/usb/mediatek,mtk-xhci.txt  |   5 +-
 .../devicetree/bindings/usb/mediatek,mtu3.txt      |   5 +-
 Documentation/devicetree/bindings/usb/usb-ehci.txt |   6 +-
 Documentation/devicetree/bindings/usb/usb-hcd.txt  |   9 ++
 Documentation/devicetree/bindings/usb/usb-ohci.txt |   6 +-
 Documentation/devicetree/bindings/usb/usb-uhci.txt |   3 +
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   5 +
 drivers/usb/chipidea/host.c                        |   6 +-
 drivers/usb/core/Makefile                          |   2 +-
 drivers/usb/core/hcd.c                             |  64 ++++-----
 drivers/usb/core/phy.c                             | 158 +++++++++++++++++++++
 drivers/usb/core/phy.h                             |   7 +
 drivers/usb/host/ehci-fsl.c                        |   2 +
 drivers/usb/host/ehci-platform.c                   |  55 +------
 drivers/usb/host/ehci-tegra.c                      |   1 +
 drivers/usb/host/ohci-omap.c                       |   1 +
 drivers/usb/host/ohci-platform.c                   |  56 +-------
 drivers/usb/host/xhci-mtk.c                        |  98 +------------
 drivers/usb/host/xhci-plat.c                       |   1 +
 include/linux/usb/hcd.h                            |   8 +-
 20 files changed, 253 insertions(+), 245 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usb-hcd.txt
 create mode 100644 drivers/usb/core/phy.c
 create mode 100644 drivers/usb/core/phy.h

-- 
2.16.1
