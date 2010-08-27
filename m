From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 1/2] USB: musb-gadget: fix bulk IN infinite hangs in
 double buffer case
Date: Fri, 27 Aug 2010 20:36:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CB8E@dbde02.ent.ti.com>
References: <1282909040-2936-1-git-send-email-tom.leiming@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0328C1CB42@dbde02.ent.ti.com>
 <AANLkTinY5XoknTuB670atr5dRHPgF0bL0t4qD+_HxXws@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57815 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009Ab0H0PGl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 11:06:41 -0400
In-Reply-To: <AANLkTinY5XoknTuB670atr5dRHPgF0bL0t4qD+_HxXws@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: "greg@kroah.com" <greg@kroah.com>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Ming Lei wrote:
> 2010/8/27 Gadiyar, Anand <gadiyar@ti.com>:
> > tom.leiming@gmail.com wrote:
> >> From: Ming Lei <tom.leiming@gmail.com>
> >>
> >> This patch fixes one infinite hang of bulk IN transfer in double buffer
> >> case, the hang can be observed easily by test #6 of usbtest if musb is
> >> configured as g_zero and fifo mode 3 is taken to enable double fifo.
> > I sent out this patch a while ago [1]. I've tested it on
> > OMAP3 and OMAP4 silicon.
> 
> Oh, I did not see your patch before,  you have seen the issue
> for long time,  why not merge into mainline?
> 

I discovered this a week or so before sending it out doing some
weekend spare-time debugging of the double-buffering problem. I
posted it out to get some feedback, and then forgot about it. :(

MUSB in general has been hammered by many lost patches in the
recent past - I know folks have been busy getting products out,
and haven't followed up as well as they could have. Hopefully
this will change in future.

- Anand
