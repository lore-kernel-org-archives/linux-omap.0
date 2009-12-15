From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/4] musb: get rid of unneeded musb->config->dyn_fifo
Date: Tue, 15 Dec 2009 15:34:32 +0200
Message-ID: <20091215133432.GN3689@nokia.com>
References: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38476 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760222AbZLONf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 08:35:28 -0500
Content-Disposition: inline
In-Reply-To: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

Hi,

On Tue, Dec 15, 2009 at 02:31:46PM +0100, ext Ajay Kumar Gupta wrote:
>diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
>index d437556..c5f006e 100644
>--- a/include/linux/usb/musb.h
>+++ b/include/linux/usb/musb.h
>@@ -30,7 +30,6 @@ struct musb_hdrc_eps_bits {
> struct musb_hdrc_config {
> 	/* MUSB configuration-specific details */
> 	unsigned	multipoint:1;	/* multipoint device */
>-	unsigned	dyn_fifo:1;	/* supports dynamic fifo sizing */
> 	unsigned	soft_con:1;	/* soft connect required */
> 	unsigned	utm_16:1;	/* utm data witdh is 16 bits */
> 	unsigned	big_endian:1;	/* true if CPU uses big-endian */

same problem as the other patch I sent:

$ git grep -w dyn_fifo arch/
arch/arm/mach-davinci/usb.c:    .dyn_fifo       = true,
arch/arm/mach-omap2/usb-musb.c: .dyn_fifo       = 1,
arch/blackfin/mach-bf527/boards/cm_bf527.c:     .dyn_fifo       = 0,
arch/blackfin/mach-bf527/boards/ezbrd.c:        .dyn_fifo       = 0,
arch/blackfin/mach-bf527/boards/ezkit.c:        .dyn_fifo       = 0,
arch/blackfin/mach-bf548/boards/cm_bf548.c:     .dyn_fifo       = 0,
arch/blackfin/mach-bf548/boards/ezkit.c:        .dyn_fifo       = 0,

we have to agree who will carry the arch changes.

-- 
balbi
