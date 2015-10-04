From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 5/8] dwc3-pci: use PCI_VDEVICE() instead of PCI_DEVICE()
Date: Mon, 05 Oct 2015 00:02:38 +0300
Message-ID: <38004664.ldNRYcghgf@wasted.cogentembedded.com>
References: <60171155.g7UZoV0Hgv@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <60171155.g7UZoV0Hgv@wasted.cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, balbi@ti.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Fix using the PCI_DEVICE() macro instead of less verbose PCI_VDEVICE().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/usb/dwc3/dwc3-pci.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

Index: usb/drivers/usb/dwc3/dwc3-pci.c
===================================================================
--- usb.orig/drivers/usb/dwc3/dwc3-pci.c
+++ usb/drivers/usb/dwc3/dwc3-pci.c
@@ -174,16 +174,13 @@ static void dwc3_pci_remove(struct pci_d
 }
 
 static const struct pci_device_id dwc3_pci_id_table[] = {
-	{
-		PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS,
-				PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3),
-	},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BSW), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BYT), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRFLD), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SPTLP), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SPTH), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB), },
+	{ PCI_VDEVICE(SYNOPSYS, PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3), },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BSW), },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BYT), },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MRFLD), },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SPTLP), },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SPTH), },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_NL_USB), },
 	{  }	/* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(pci, dwc3_pci_id_table);
