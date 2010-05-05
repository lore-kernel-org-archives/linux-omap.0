From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] usb: musb: Update FIFO mode_5_cfg to accomodate 4K
Date: Wed, 5 May 2010 21:32:46 +0300
Message-ID: <20100505183245.GB2274@gandalf>
References: <1272963722-8659-1-git-send-email-ajay.gupta@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0322BA91B3@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35133 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757697Ab0EEScF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 14:32:05 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322BA91B3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On Tue, May 04, 2010 at 02:40:58PM +0530, Gadiyar, Anand wrote:
> > FIFO table fifo_5_cfg was added so that it can be used as a
> > workaround for OMAP34x/35x errata which limits the FIFO space
> > uses to be within first 8K or next 8K.
> > 
> > Updating this table to accomodate an endpoint of 4K so that
> > the same table can be used for high bandwidth transfers as
> > used by some USB cameras.
> > 
> 
> No issues with this patch as is, but it's probably high time we
> made this fifo table something that the board files can pass down.
> 
> Is anyone already working on this, or should I give it a shot?

I had sent a version of that to linux-usb@vger, will dig it and resend.

-- 
balbi
