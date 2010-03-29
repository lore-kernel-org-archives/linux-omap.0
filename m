From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [patch-2.6.34-rc2+ 10/11] musb_core: don't call
 musb_platform_exit() twice
Date: Mon, 29 Mar 2010 18:12:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032231CF9B@dbde02.ent.ti.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
 <1269515673-27980-11-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032221AF79@dbde02.ent.ti.com>
 <20100325130554.GE4964@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42133 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194Ab0C2Mmp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Mar 2010 08:42:45 -0400
In-Reply-To: <20100325130554.GE4964@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: Greg KH <greg@kroah.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Felipe Balbi wrote: 
> On Thu, Mar 25, 2010 at 01:34:25PM +0100, ext Gadiyar, Anand wrote:
> >Felipe Balbi wrote:
> >>
> >> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> >>
> >> musb_platform_exit() is called twice from musb_init_controller() iff controller
> >> initialization fails. Move the call (and the DevCtl register writes surrounding
> >> it) from musb_free() to musb_remove().
> >>
> >> Fix mispalced and now incorrect 'goto's in musb_init_controller().
> >>
> >> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> >> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> >
> >This one doesn't apply for me. I'm on commit 01e7770 plus
> >gregkh-07-usb-2.6.34-rc1.patch. The first 9 patches apply correctly,
> >but this one fails on hunk 4 of 6.
> >
> >Felipe - are we on the same base here?
> >
> >Looking at gregkh-07-usb-2.6.34-rc1.patch, this hunk is already taken care
> >of there.
> 
> I'm on today's Linus' tree. Greg's queue doesn't apply there. I tried 
> v2.6.33, v2.6.34-rc1 and v2.6.34-rc2 tags also and couldn't get all 
> patches to apply.

This is probably a bad idea because Greg's queue currently has patches
that touch the same files. That's a sure way to cause a conflict.

Also, Greg's queue cleanly applies on current Linus' tree for me.
Not sure why you're having trouble applying his queue.

- Anand
