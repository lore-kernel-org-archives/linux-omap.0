From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/2] usb: ehci-omap: fix compilation warning
Date: Tue, 4 May 2010 19:53:09 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E351733@dbde02.ent.ti.com>
References: <1272959123-31362-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1272959123-31362-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> -----Original Message-----
> From: Gupta, Ajay Kumar
> Sent: Tuesday, May 04, 2010 1:15 PM
> To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org; Gupta, Ajay Kumar
> Subject: [PATCH 1/2] usb: ehci-omap: fix compilation warning
> 
> Fixes below compilation warning:
> drivers/usb/host/ehci-hcd.c:425:
> 	warning: 'ehci_port_power' defined but not used
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/host/ehci-omap.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 40a8583..e55fd58 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -659,6 +659,8 @@ static int ehci_hcd_omap_probe(struct platform_device
> *pdev)
>  		goto err_add_hcd;
>  	}
> 
> +	ehci_port_power(omap->ehci, 0);

There is a typo error, Port power has to be '1'. I am copying the correct
patch below.

-Ajay
--------------------- cut here --------------------
Subject: [PATCH 1/2 v2] usb: ehci-omap: fix compilation warning

Fixes below compilation warning:
drivers/usb/host/ehci-hcd.c:425:
	warning: 'ehci_port_power' defined but not used

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 40a8583..711332e 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -659,6 +659,9 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		goto err_add_hcd;
 	}
 
+	/* root ports should always stay powered */
+	ehci_port_power(omap->ehci, 1);
+
 	return 0;
 
 err_add_hcd:
-- 
1.6.2.4--------------------- end -------------------------

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
