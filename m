From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/7] usb: musb: Add context save and restore support
Date: Mon, 25 Jan 2010 12:51:14 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A542879@dbde02.ent.ti.com>
References: <1264080838-9452-2-git-send-email-felipe.balbi@nokia.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E22167F0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37558 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437Ab0AYHVU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jan 2010 02:21:20 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E22167F0@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Patra, Nilkesh" <nilkesh.patra@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>

Hi,
> -----Original Message-----
> From: Patra, Nilkesh
> Sent: Monday, January 25, 2010 12:49 PM
> To: Felipe Balbi; Greg KH
> Cc: Linux USB Mailing List; Linux OMAP Mailing List; Gupta, Ajay Kumar;
> Gadiyar, Anand
> Subject: RE: [PATCH 1/7] usb: musb: Add context save and restore support
> > +
> > +		if (musb->dyn_fifo) {
> 
> dyn_fifo should be declared under struct musb. Otherwise it will give
> compilation errors.

Already done in one of the earlier submitted patch.

> 
> > +			musb_context.index_regs[i].txfifoadd =
> > +					musb_read_txfifoadd(musb_base);
> > +			musb_context.index_regs[i].rxfifoadd =
> > +					musb_read_rxfifoadd(musb_base);
