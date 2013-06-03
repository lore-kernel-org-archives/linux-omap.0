From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5] dwc3: omap: adapt dwc3 to use extcon framework
Date: Mon, 3 Jun 2013 21:43:35 +0530
Message-ID: <1370276020-17446-1-git-send-email-kishon@ti.com>
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
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The first three patches deals with cleanup of extcon inorder to get
through compilation without any issues. It also adds an API to get
extcon device from dt node which I felt was missing.

The next two patches deals with adapt dwc3 to use extcon framework.
The 4th patch (usb: dwc3: omap: improve error handling of dwc3_omap_probe)
should have ideally been sent to Felipe, however since
there will be merge conflicts with the 5th patch
(usb: dwc3: use extcon fwrk to receive connect/disconnect)
in this series, I've sent in the same series.

Once this patch series get merged, dwc3 in omap would be functional
in device mode. However there is still some discussion on modelling
SMPS10 regulator. Once that gets finalized, dwc3 should be functional
in host mode as well.

Kishon Vijay Abraham I (5):
  extcon: Add an API to get extcon device from dt node
  extcon: Kconfig: Make extcon config type as bool
  extcon: add EXPORT_SYMBOL_GPL for exported functions
  usb: dwc3: omap: improve error handling of dwc3_omap_probe
  usb: dwc3: use extcon fwrk to receive connect/disconnect

 Documentation/devicetree/bindings/usb/omap-usb.txt |    5 +
 drivers/extcon/Kconfig                             |    2 +-
 drivers/extcon/extcon-class.c                      |   42 +++++++
 drivers/usb/dwc3/dwc3-omap.c                       |  133 ++++++++++++++++----
 include/linux/extcon.h                             |    8 ++
 include/linux/usb/dwc3-omap.h                      |   30 -----
 6 files changed, 168 insertions(+), 52 deletions(-)
 delete mode 100644 include/linux/usb/dwc3-omap.h

-- 
1.7.10.4
