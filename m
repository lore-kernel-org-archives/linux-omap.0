From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch-2.6.34-rc2+ 10/11] musb_core: don't call
 musb_platform_exit() twice
Date: Mon, 29 Mar 2010 16:59:51 +0300
Message-ID: <20100329135950.GA3877@gandalf>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
 <1269515673-27980-11-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032221AF79@dbde02.ent.ti.com>
 <20100325130554.GE4964@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032231CF9B@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53734 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab0C2N7V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Mar 2010 09:59:21 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032231CF9B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Greg KH <greg@kroah.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Mon, Mar 29, 2010 at 06:12:30PM +0530, Gadiyar, Anand wrote:
> This is probably a bad idea because Greg's queue currently has patches
> that touch the same files. That's a sure way to cause a conflict.
> 
> Also, Greg's queue cleanly applies on current Linus' tree for me.
> Not sure why you're having trouble applying his queue.

Maybe i need to manually quilt push, git quiltimport fails always.

-- 
balbi
