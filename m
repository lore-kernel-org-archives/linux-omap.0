From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] omap: musb: Add device tree support
Date: Thu, 6 Sep 2012 20:25:28 +0530
Message-ID: <1346943331-18120-1-git-send-email-kishon@ti.com>
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
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch series adds device tree support for MUSB.

The glue layer is now made to write to mailbox register (present in
control module) instead of calling phy layer to write to mailbox
register. Writing to mailbox register notifies the core of events like
device connect/disconnect.

Previously these patches were part of
[PATCH v7 0/7] omap: musb: Add device tree support

This patch series was created to contain only the *musb* part and it
also has one hwmod patch.

This patch series was created on
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git musb

Kishon Vijay Abraham I (3):
  arm: omap: hwmod: add a new addr space in otg for writing to control
    module
  usb: musb: omap: write directly to mailbox instead of using phy
  usb: musb: omap: Add device tree support for omap musb glue

 Documentation/devicetree/bindings/usb/omap-usb.txt |   33 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    5 +
 drivers/usb/musb/omap2430.c                        |  106 ++++++++++++++++++--
 drivers/usb/musb/omap2430.h                        |    9 ++
 4 files changed, 146 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/omap-usb.txt

-- 
1.7.9.5
