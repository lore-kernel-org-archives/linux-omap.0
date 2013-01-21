From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 13/15] drivers/usb/musb/omap2430.c: adjust duplicate test
Date: Mon, 21 Jan 2013 14:02:57 +0100
Message-ID: <1358773378-4700-14-git-send-email-Julia.Lawall@lip6.fr>
References: <1358773378-4700-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358773378-4700-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Delete successive tests to the same location.  Data is the just previously
allocated and tested value.  Test the result of the allocation made here
instead.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@s exists@
local idexpression y;
expression x,e;
@@

*if ( \(x == NULL\|IS_ERR(x)\|y != 0\) )
 { ... when forall
   return ...; }
... when != \(y = e\|y += e\|y -= e\|y |= e\|y &= e\|y++\|y--\|&y\)
    when != \(XT_GETPAGE(...,y)\|WMI_CMD_BUF(...)\)
*if ( \(x == NULL\|IS_ERR(x)\|y != 0\) )
 { ... when forall
   return ...; }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The previous code could be further simplified by removing the
initializations of ret to -ENOMEM, as is absent in this case.  But that is
probably for another patch.

 drivers/usb/musb/omap2430.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index da00af4..533c4fd 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -545,7 +545,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		}
 
 		config = devm_kzalloc(&pdev->dev, sizeof(*config), GFP_KERNEL);
-		if (!data) {
+		if (!config) {
 			dev_err(&pdev->dev,
 				"failed to allocate musb hdrc config\n");
 			goto err2;
