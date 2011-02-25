From: Pavol Kurina <pavol.kurina@emsys.de>
Subject: Re: [patch-v2.6.39 03/12] usb: musb: gadget: do not poke with gadget's =?utf-8?b?bGlzdF9oZWFk?=
Date: Fri, 25 Feb 2011 19:41:47 +0000 (UTC)
Message-ID: <loom.20110225T201502-888@post.gmane.org>
References: <1297946329-9353-1-git-send-email-balbi@ti.com> <1297946329-9353-4-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:33314 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932878Ab1BYUAI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 15:00:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1Pt3pe-0002ss-7c
	for linux-omap@vger.kernel.org; Fri, 25 Feb 2011 21:00:06 +0100
Received: from filterlix.emsys.de ([195.145.211.170])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 21:00:06 +0100
Received: from pavol.kurina by filterlix.emsys.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 21:00:06 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Felipe Balbi <balbi <at> ti.com> writes:
> 
> struct usb_request's list_head is supposed to be
> used only by gadget drivers, but musb is abusing
> that. Give struct musb_request its own list_head
> and prevent musb from poking into other driver's
> business.

Hi,

I think, the patch misses to fix the usage of 
"request->list" in musb_gadget_dequeue in 
musb_gadget.c.

I found out by having troubles with f_mass_storage. 
It needs musb_gadget_dequeue to work properly...

I backported the patch to android-2.6.35 kernel on a 
omap4 system and also fixed the musb_gadget_dequeue 
there so f_mass_storage seem to work at least there 
now...

Can you check this patch regarding some missing bits
please?

Thanks,
Pavol.

