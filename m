From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/8] musb: fix compilation warning in host only mode
Date: Tue, 6 Jul 2010 12:12:44 +0300
Message-ID: <20100706091243.GF3035@nokia.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <20100624060338.GF8078@nokia.com>
 <19F8576C6E063C45BE387C64729E7394044E9E38CA@dbde02.ent.ti.com>
 <4C235929.9030605@ru.mvista.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21890 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab0GFJNK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 05:13:10 -0400
Content-Disposition: inline
In-Reply-To: <4C235929.9030605@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@suse.de" <gregkh@suse.de>

On Thu, Jun 24, 2010 at 03:10:01PM +0200, ext Sergei Shtylyov wrote:
>@@ -714,12 +713,16 @@ static irqreturn_t musb_stage0_irq(struct musb
>
>  #ifdef CONFIG_USB_MUSB_OTG
>  		/* flush endpoints when transitioning from Device Mode */
>- 		if (is_peripheral_active(musb)) {
>- 			/* REVISIT HNP; just force disconnect */
>- 		}
>-		musb_writew(mbase, MUSB_INTRTXE, musb->epmask);
>-		musb_writew(mbase, MUSB_INTRRXE, musb->epmask & 0xfffe);
>-		musb_writeb(mbase, MUSB_INTRUSBE, 0xf7);
>+		{

and adding unneded identation level ?? no thanks. Dereferencing musb to 
access mbase sounds better to me.

-- 
balbi

DefectiveByDesign.org
