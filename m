From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/4] musb: get rid of unneeded musb->config->dyn_fifo
Date: Thu, 17 Dec 2009 18:31:27 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940449F4399B@dbde02.ent.ti.com>
References: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
 <20091215133432.GN3689@nokia.com>,<20091215134857.GO3689@nokia.com>
 <19F8576C6E063C45BE387C64729E7394043698118E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35879 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbZLQNBf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 08:01:35 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E7394043698118E@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gupta, Ajay Kumar
> Sent: Tuesday, December 15, 2009 8:45 PM
> To: felipe.balbi@nokia.com
> Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 1/4] musb: get rid of unneeded musb->config->dyn_fifo
> 
> 
> >Hi,
> >
> >On Tue, Dec 15, 2009 at 02:31:46PM +0100, ext Ajay Kumar Gupta wrote:
> >>diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
> >>index d437556..c5f006e 100644
> >>--- a/include/linux/usb/musb.h
> >>+++ b/include/linux/usb/musb.h
> >>@@ -30,7 +30,6 @@ struct musb_hdrc_eps_bits {
> >> struct musb_hdrc_config {
> >>      /* MUSB configuration-specific details */
> >>      unsigned        multipoint:1;   /* multipoint device */
> >>-     unsigned        dyn_fifo:1;     /* supports dynamic fifo sizing */
> >>      unsigned        soft_con:1;     /* soft connect required */
> >>      unsigned        utm_16:1;       /* utm data witdh is 16 bits */
> >>      unsigned        big_endian:1;   /* true if CPU uses big-endian */
> >
> >same problem as the other patch I sent:
> >
> >$ git grep -w dyn_fifo arch/
> >arch/arm/mach-davinci/usb.c:    .dyn_fifo       = true,
> >arch/arm/mach-omap2/usb-musb.c: .dyn_fifo       = 1,
> >arch/blackfin/mach-bf527/boards/cm_bf527.c:     .dyn_fifo       = 0,
> >arch/blackfin/mach-bf527/boards/ezbrd.c:        .dyn_fifo       = 0,
> >arch/blackfin/mach-bf527/boards/ezkit.c:        .dyn_fifo       = 0,
> >arch/blackfin/mach-bf548/boards/cm_bf548.c:     .dyn_fifo       = 0,
> >arch/blackfin/mach-bf548/boards/ezkit.c:        .dyn_fifo       = 0,
> >
> >we have to agree who will carry the arch changes.
> 
> >what we can do is mark that field as deprecated and give one major
> >release for people to remove that from their boards, then we send a
> >patch finally removing it.
> 
> Even with one major release window someone has to submit patch removing
> them
> from arch/ files. So I think it's better to remove them now itself. we can
> seperately
> submit patches to respective maintainers. Or best is if Greg can accept
> those changes
> which are mostly trivial.

Felipe,

Any update on this ? Shall I send the series again with __deprecated ? or
If you can just add it on your own?

Thanks,
Ajay

> 
> -Ajay--
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
