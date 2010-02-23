From: "Anna, Suman" <s-anna@ti.com>
Subject: RE: [PATCH] omap: mailbox: unregister correct mbox device for
 omap2420
Date: Mon, 22 Feb 2010 18:09:56 -0600
Message-ID: <2C1563023E232C49B9F505633D57C2DA2640F2C571@dlee04.ent.ti.com>
References: <23D0CDE7C386D144A4F26EB0F427F8C0986C7517@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33787 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115Ab0BWAKC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 19:10:02 -0500
In-Reply-To: <23D0CDE7C386D144A4F26EB0F427F8C0986C7517@dlee04.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguilar Pena, Leed" <leed.aguilar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Hi Aguilar,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aguilar Pena, Leed
> Sent: Monday, February 22, 2010 5:55 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; Hiroshi DOYU
> Subject: [PATCH] omap: mailbox: unregister correct mbox device for
> omap2420
> 
> label err_iva1 is defined to unregister the mbox device
> for omap2420 which is contained in mbox_iva_info struct
> 
> mbox_dsp_info is not being used by the omap2420
> 
> Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Index: omap/arch/arm/mach-omap2/mailbox.c
> ===================================================================
> --- omap.orig/arch/arm/mach-omap2/mailbox.c	2010-02-22
> 17:41:24.000000000 -0600
> +++ omap/arch/arm/mach-omap2/mailbox.c	2010-02-22 17:51:31.000000000 -
> 0600
> @@ -420,7 +420,7 @@
>  	return 0;
> 
>  err_iva1:
> -	omap_mbox_unregister(&mbox_dsp_info);
> +	omap_mbox_unregister(&mbox_iva_info);

The err_iva1 label is indicating that the iva1 registration has failed, and you need to free the previously registered dsp. So, this patch is not valid.

> 
>  err_dsp:
>  	iounmap(mbox_base);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards
Suman
