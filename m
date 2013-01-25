From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v1 0/8] usb: otg: palmas-usb: fixes/cleanups to get dwc3
 working
Date: Fri, 25 Jan 2013 08:42:23 +0530
Message-ID: <1359083551-8524-1-git-send-email-kishon@ti.com>
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
To: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, s-guiriec-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This includes a series of patches that should be used for testing
dwc3 in omap5.

Among other changes, palmas is made as a comparator driver
to the phy. And includes a fix to get a regulator by having phandle.

This patch series is developed on
git://github.com/rrnayak/linux.git omap5-3.8-rc4-base-palmas

I've kept this patch series and the patch series to follow in a single branch
git://gitorious.org/linux-usb/linux-usb.git omap5-with-palmas
(changes up to 23b4dfa2ab7052569cd88acc6383c4b1a8e8a482)

Did enumeration testing on omap5 evm.

Kishon Vijay Abraham I (8):
  usb: otg: palmas-usb: make palmas-usb as a comparator driver
  usb: otg: palmas-usb: use devres API to allocate resources
  usb: otg: palmas-usb: remove compiler warning
  usb: otg: palmas-usb: use mailbox API to send VBUS or ID events
  usb: otg: palmas-usb: use bool to read property instead of u32
  usb: otg: palmas-usb: call regulator enable/disable only on valid
    regulator
  usb: otg: palmas-usb: pass the correct dev ptr in regulator get
  usb: otg: palmas-usb: fix cold plug issue

 .../devicetree/bindings/usb/twlxxxx-usb.txt        |   24 +++
 drivers/usb/otg/palmas-usb.c                       |  163 +++++++++-----------
 include/linux/mfd/palmas.h                         |    7 +-
 3 files changed, 99 insertions(+), 95 deletions(-)

-- 
1.7.9.5
