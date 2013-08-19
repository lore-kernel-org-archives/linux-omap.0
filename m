From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Subject: [PATCH 0/6] simplify platform_get_resource_byname/devm_ioremap_resource
Date: Mon, 19 Aug 2013 10:51:50 +0200
Message-ID: <1376902316-18520-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

devm_ioremap_resource often uses the result of a call to
platform_get_resource_byname as its last argument.  devm_ioremap_resource
does appropriate error handling on this argument, so error handling can be
removed from the call to platform_get_resource_byname.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression pdev,res,n,e,e1;
expression ret != 0;
identifier l,f;
expression list es;
@@

(
  res = f(...);
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  e = devm_ioremap_resource(e1, res);
|
- res = f(es);
  ... when != res
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  ... when != res
+ res = f(es);
  e = devm_ioremap_resource(e1, res);
)
// </smpl>

In practice, f is always platform_get_resource_byname (or
platform_get_resource, which was handled by a previous patch series).  And
the call to platform_get_resource_byname always immediately precedes the
call to devm_ioremap_resource.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
