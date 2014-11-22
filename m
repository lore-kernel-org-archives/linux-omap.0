From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] usb: dwc3: return error code from the most recent call
Date: Sat, 22 Nov 2014 15:56:47 +0100
Message-ID: <1416668207-10770-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: kernel-janitors@vger.kernel.org, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Copy-paste error from the previous block of error handling code.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,e1;
@@

if (IS_ERR(e)) {
  ...
(
  ret = PTR_ERR(e);
|
*  ret = PTR_ERR(e1);
)
  ...
  return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/usb/dwc3/dwc3-st.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index c7602b5..4a1a543 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -243,7 +243,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	dwc3_data->rstc_rst = devm_reset_control_get(dev, "softreset");
 	if (IS_ERR(dwc3_data->rstc_rst)) {
 		dev_err(&pdev->dev, "could not get reset controller\n");
-		ret = PTR_ERR(dwc3_data->rstc_pwrdn);
+		ret = PTR_ERR(dwc3_data->rstc_rst);
 		goto undo_powerdown;
 	}
 

