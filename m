From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/7] usb: dwc3-omap: add dt support
Date: Mon, 8 Oct 2012 14:53:49 +0530
Message-ID: <1349688236-22814-1-git-send-email-kishon@ti.com>
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
To: sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch series adds dt support to dwc3 core and fixes few minor
stuff in dwc3-omap glue to get dwc3 working.

While at that it also uses *of_platform* to create the child device
(dwc3-core) and fixes to use runtime API's to enable clock and write
to SYSCONFIG register.

Changes from v2:
* Fixed Sergei comment to use of_property_read_u32 insted of of_get_property

Changes from v1:
* made device_for_each_child() as a seperate patch
* made all other minor fixes wrt typos and function renames

This patch series is developed on:
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git dwc3


Kishon Vijay Abraham I (7):
  usb: dwc3-omap: use device_for_each_child to handle child removal
  usb: dwc3-omap: use of_platform API to create dwc3 core pdev
  usb: dwc3-omap: use runtime API's to enable clocks
  usb: dwc3-omap: Remove explicit writes to SYSCONFIG register
  usb: dwc3-omap: Add an API to write to dwc mailbox
  usb: dwc3-omap: Minor fixes to get dt working
  usb: dwc3: core: add dt support for dwc3 core

 Documentation/devicetree/bindings/usb/dwc3.txt |   23 ++++
 drivers/usb/dwc3/core.c                        |   14 +-
 drivers/usb/dwc3/dwc3-omap.c                   |  173 +++++++++++++-----------
 include/linux/usb/dwc3-omap.h                  |   30 ++++
 4 files changed, 160 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3.txt
 create mode 100644 include/linux/usb/dwc3-omap.h

-- 
1.7.9.5
