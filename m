From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch-v2.6.39 03/12] usb: musb: gadget: do not poke with
 gadget's list_head
Date: Tue, 1 Mar 2011 17:44:44 +0200
Message-ID: <20110301154444.GI12368@legolas.emea.dhcp.ti.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
 <1297946329-9353-4-git-send-email-balbi@ti.com>
 <loom.20110225T201502-888@post.gmane.org>
 <20110228084311.GJ2459@legolas.emea.dhcp.ti.com>
 <4D6D1295.1020809@emsys.de>
 <20110301153918.GF12368@legolas.emea.dhcp.ti.com>
 <20110301154059.GG12368@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:51811 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756678Ab1CAPos (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 10:44:48 -0500
Received: by mail-bw0-f45.google.com with SMTP id 16so5686215bwz.18
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 07:44:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110301154059.GG12368@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Pavol Kurina <pavol.kurina@emsys.de>, linux-omap@vger.kernel.org

On Tue, Mar 01, 2011 at 05:40:59PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Mar 01, 2011 at 05:39:18PM +0200, Felipe Balbi wrote:
> > >         /* if the hardware doesn't have the request, easy ... */
> > > -       if (musb_ep->req_list.next != &request->list || musb_ep->busy)
> > > +       if (musb_ep->req_list.next != &req->list || musb_ep->busy)
> > >                 musb_g_giveback(musb_ep, request, -ECONNRESET);
> > > 
> > 
> > I'll fix it before Greg pulls, thanks
> 
> fixed and pushed to for-next. Greg, now it seems to be safe to pull.

to late, please send me a patch fixing that when we're in -rc. I'm not
sending pull requests for the merge window anymore :-(

-- 
balbi
