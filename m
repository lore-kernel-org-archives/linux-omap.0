From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/2] dwc3: exynos: Device tree fixes
Date: Thu, 14 Mar 2013 16:14:56 +0530
Message-ID: <1363257898-17504-1-git-send-email-gautam.vivek@samsung.com>
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
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch-set modifies dwc3-exynos as per latest bindings
available for dwc3. Now the dwc3 core also has device support,
there's no need to add platform device for core in glue layers.
This change has come as a result of discussion happened in:
[PATCH RFC] usb: dwc3: Get PHY from platform specific dwc3 dt node.

Additionally, now that Samsung exynos series has moved to common
clock framework, we use clock_prepare_enable() and clock_disable_unprepare()
APIs.
Some cleanup is also done here.

Based on 'usb-next' plus Felipe's 'testing' branch patches;
(some 194 patches in fact ;-), on top of 3.9rc2 tag).
Also based on: "usb: dwc3: set dma_mask for dwc3_omap device" by Kishon
in which DMA mask for dwc3-core is being set from its parent.

Vivek Gautam (2):
  usb: dwc3: exynos: Use of_platform API to create dwc3 core pdev
  usb: dwc3: exynos: use clk_prepare_enable and clk_disable_unprepare

 drivers/usb/dwc3/dwc3-exynos.c |   54 ++++++++++++++--------------------------
 1 files changed, 19 insertions(+), 35 deletions(-)

-- 
1.7.6.5
