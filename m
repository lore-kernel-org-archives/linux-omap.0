From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: ehci-omap: Build break on Linus' tree
Date: Sun, 13 Dec 2009 10:38:39 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4CB2@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4CB1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57313 "HELO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750782AbZLMFIv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Dec 2009 00:08:51 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4CB1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> (Really looping Tony. Darn broken mailer and poor memory) 
> 
> Gadiyar, Anand wrote:
> 
> > 
> > Tony,
> > 
> > We lost this patch on the way to mainline:
> > (it needs a small update - filename changed before
> > we can send it out)
> > 
> > http://patchwork.kernel.org/patch/58093/
> > 
> > Would you like me to rework it, or can you take care of this?
> > 
> > 
> > Without this, the omap3 defconfigs that build EHCI will
> > break (tested omap_3430sdp_defconfig for now).
> > 

All that was needed was this one:
http://patchwork.kernel.org/patch/65678/

which is already in your omap-fixes queue.


Now to take care of the build warnings and suspend-resume.

- Anand
