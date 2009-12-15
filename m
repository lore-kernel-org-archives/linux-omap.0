From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/3] musb: save dynfifo in musb struct
Date: Tue, 15 Dec 2009 13:07:38 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404372AAE01@dbde02.ent.ti.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <20091214162454.GA31829@nokia.com>
 <19F8576C6E063C45BE387C64729E739404372AAD03@dbde02.ent.ti.com>
 <20091215072650.GA3147@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50174 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbZLOHhp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 02:37:45 -0500
In-Reply-To: <20091215072650.GA3147@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Tuesday, December 15, 2009 12:57 PM
> To: Gupta, Ajay Kumar
> Cc: Balbi Felipe (Nokia-D/Helsinki); linux-usb@vger.kernel.org; linux-
> omap@vger.kernel.org; david-b@pacbell.net
> Subject: Re: [PATCH 1/3] musb: save dynfifo in musb struct
> 
> Hi,
> 
> On Tue, Dec 15, 2009 at 05:04:30AM +0100, ext Gupta, Ajay Kumar wrote:
> >musb->config->dyn_fifo is coming from platform files and is user defined
> >but we need to check if the mentor core itself supports dynamic fifo.
> >
> >See the dynamic fifo code snippet:
> >
> >--------------------------------------------------------
> >        if (reg & MUSB_CONFIGDATA_DYNFIFO) {
> >                if (musb->config->dyn_fifo)
> >                        status = ep_config_from_table(musb);
> >                else {
> >                        ERR("reconfigure software for Dynamic FIFOs\n");
> >                        status = -ENODEV;
> >                }
> >        } else {
> >--------------------------------------------------------
> >
> >If CONFIGDATA register bit indicates that dynamic FIFO is supported then
> >musb->config->dyn_fifo has to be set to '1' for suceessful
> initialization.
> >
> >Thus CONFIGDATA register bit alone is sufficient condition to
> save/restore
> >Tx/Rx FIFOSZ/FIFOADDR registers.
> 
> yes, but if the user has to reconfigure the sw for dyn_fifo anyways, so
> we can be sure musb->config->dyn_fifo is correct when you need.

As per current logic, user has to set dyn_fifo if mentor core supports it
and it has to be set to '0' if core doesn't support it. So what's the need
for musb->config->dyn_fifo at all. We can very well decide based on only
CONFIGDATA register bits alone.

I think we should just get rid of this unwanted user defined flag. I will
post a patch on this along with next revision.

-Ajay
> 
> --
> balbi
