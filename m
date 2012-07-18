From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/2] omap: add ocp2scp as a bus driver
Date: Wed, 18 Jul 2012 12:00:37 +0530
Message-ID: <1342593039-7728-1-git-send-email-kishon@ti.com>
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
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch series is done as a preparatory step for adding phy drivers
for dwc3 and musb.

This series adds a new driver for ocp2scp (only dt) to which phy
drivers are connected.

Since currently there is no generic way to create a child device along
with doing a pm_runtime_enable (the exact requirement for ocp2scp), I'm
creating a separate driver for ocp2scp.

Changes from v1:
Fixed Sergei's comments to remove the address in the node name of ocp2scp
since the ocp2scp node doesn't have a reg property.

Changes from [RFC PATCH v2 0/2] omap: add ocp2scp as a misc driver:
Created a new folder drivers/bus and moved ocp2scp driver from misc to
drivers/bus.

This patch was developed and tested on
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git

Kishon Vijay Abraham I (2):
  drivers: bus: add a new driver for omap-ocp2scp
  arm/dts: omap4: Add ocp2scp data

 .../devicetree/bindings/bus/omap-ocp2scp.txt       |   10 ++
 arch/arm/boot/dts/omap4.dtsi                       |    8 ++
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +
 drivers/bus/Kconfig                                |   15 +++
 drivers/bus/Makefile                               |    5 +
 drivers/bus/omap-ocp2scp.c                         |   98 ++++++++++++++++++++
 7 files changed, 140 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
 create mode 100644 drivers/bus/Kconfig
 create mode 100644 drivers/bus/Makefile
 create mode 100644 drivers/bus/omap-ocp2scp.c

-- 
1.7.5.4
