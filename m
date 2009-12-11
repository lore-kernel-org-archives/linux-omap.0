From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 107/122] USB: ehci-omap.c: introduce missing kfree
Date: Sat, 12 Dec 2009 05:00:02 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FABD1BA8@dbde02.ent.ti.com>
References: <20091211212646.GB6624@kroah.com>
 <1260570347-7236-107-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42684 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934530AbZLKXaF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 18:30:05 -0500
In-Reply-To: <1260570347-7236-107-git-send-email-gregkh@suse.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-owner@vger.kernel.org] On Behalf Of Greg
>Kroah-Hartman
>Sent: Friday, December 11, 2009 4:26 PM
>To: linux-usb@vger.kernel.org
>Cc: Julia Lawall; Greg Kroah-Hartman
>Subject: [PATCH 107/122] USB: ehci-omap.c: introduce missing kfree
>Importance: High
>
>From: Julia Lawall <julia@diku.dk>
>
>Error handling code following a kzalloc should free the allocated data.
>
>The semantic match that finds this problem is as follows:
>(http://www.emn.fr/x-info/coccinelle/)

Impressive.
Wondering if sparse do such kind of things?

>
>// <smpl>
>@r exists@
>local idexpression x;
>statement S;
>expression E;
>identifier f,f1,l;
>position p1,p2;
>expression *ptr != NULL;
>@@
>
>x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
>...
>if (x == NULL) S
><... when != x
>     when != if (...) { <+...x...+> }
>(
>x->f1 = E
>|
> (x->f1 == NULL || ...)
>|
> f(...,x->f1,...)
>)
>...>
>(
> return \(0\|<+...x...+>\|ptr\);
>|
> return@p2 ...;
>)
>
>@script:python@
>p1 << r.p1;
>p2 << r.p2;
>@@
>
>print "* file: %s kmalloc %s return %s" % (p1[0].file,p1[0].line,p2[0].line)
>// </smpl>
>
>Signed-off-by: Julia Lawall <julia@diku.dk>
>Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>---
> drivers/usb/host/ehci-omap.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
>index 7ba8df3..12f1ad2 100644
>--- a/drivers/usb/host/ehci-omap.c
>+++ b/drivers/usb/host/ehci-omap.c
>@@ -558,7 +558,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
> 	omap = kzalloc(sizeof(*omap), GFP_KERNEL);
> 	if (!omap) {
> 		ret = -ENOMEM;
>-		goto err_create_hcd;
>+		goto err_disabled;
> 	}
>
> 	hcd = usb_create_hcd(&ehci_omap_hc_driver, &pdev->dev,
>@@ -653,6 +653,7 @@ err_ioremap:
> 	usb_put_hcd(hcd);
>
> err_create_hcd:
>+	kfree(omap);
> err_disabled:
> err_pdata:
> 	return ret;
>--
>1.6.5.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
