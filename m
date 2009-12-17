From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/4] musb: get rid of unneeded musb->config->dyn_fifo
Date: Thu, 17 Dec 2009 18:42:58 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940449F439A1@dbde02.ent.ti.com>
References: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
 <20091215133432.GN3689@nokia.com> <20091215134857.GO3689@nokia.com>
 <19F8576C6E063C45BE387C64729E7394043698118E@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940449F4399B@dbde02.ent.ti.com>
 <20091217131016.GB4210@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48668 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764413AbZLQNNE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 08:13:04 -0500
In-Reply-To: <20091217131016.GB4210@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Thursday, December 17, 2009 6:40 PM
> To: Gupta, Ajay Kumar
> Cc: Balbi Felipe (Nokia-D/Helsinki); linux-usb@vger.kernel.org; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH 1/4] musb: get rid of unneeded musb->config->dyn_fifo
> 
> Hi,
> 
> On Thu, Dec 17, 2009 at 02:01:27PM +0100, ext Gupta, Ajay Kumar wrote:
> >Any update on this ? Shall I send the series again with __deprecated ? or
> >If you can just add it on your own?
> 
> I guess we have to do that and start sending patches to arch maintainers
> removing the dyn_fifo stuff from board-files.
> 
> we should have all fixed by the end of .33-final, then we send a patch
> finally removing dyn_fifo from musb's platform_data.

Ok fine, then please drop that specific patch from series and pick the
Others.

-Ajay
> 
> --
> balbi
