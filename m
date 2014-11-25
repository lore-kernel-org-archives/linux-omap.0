From: George Cherian <george.cherian@ti.com>
Subject: [PATCH 06/19] usb: dwc3: host: Pass the XHCI_DRD_SUPPORT and
 XHCI_NEEDS_LHC_RESET quirk
Date: Tue, 25 Nov 2014 18:41:42 +0530
Message-ID: <1416921115-10467-7-git-send-email-george.cherian@ti.com>
References: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: mark.rutland@arm.com, George Cherian <george.cherian@ti.com>, kgene.kim@samsung.com, linux@arm.linux.org.uk, ben-linux@fluff.org, mathias.nyman@intel.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, gregkh@linuxfoundation.org, sojka@merica.cz, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, peter.chen@freescale.com, bcousson@baylibre.com, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

Pass the quir flag XHCI_DRD_SUPPORT from DWC3 host to xhci platform driver.
This enables xhci driver to handle deallocation's differently while in DRD mode.
Pass the quirk flag XHCI_NEEDS_LHC_RESET from DWC3 host to xhci platform
driver. This enables to do LHRESET during xhci_reset().

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 drivers/usb/dwc3/host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index dcb8ca0..257b5b5 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -53,6 +53,8 @@ int dwc3_host_init(struct dwc3 *dwc)
 #ifdef CONFIG_DWC3_HOST_USB3_LPM_ENABLE
 	pdata.usb3_lpm_capable = 1;
 #endif
+	pdata.usb_drd_support = 1;
+	pdata.usb_needs_lhc_reset = 1;
 
 	ret = platform_device_add_data(xhci, &pdata, sizeof(pdata));
 	if (ret) {
-- 
1.8.3.1
