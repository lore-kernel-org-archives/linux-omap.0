From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c: change twl4030-usb back to subsys_initcall
Date: Fri, 3 Oct 2008 16:28:32 +0300
Message-ID: <20081003132830.GL25482@atomide.com>
References: <200810030136.33838.david-b@pacbell.net> <1223027154-20385-1-git-send-email-felipe.balbi@nokia.com> <132EE04E-D594-4F84-9C2B-D907D3D4CD5E@student.utwente.nl> <20081003120445.GB27798@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64678 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbYJCNZh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 09:25:37 -0400
Content-Disposition: inline
In-Reply-To: <20081003120445.GB27798@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [081003 15:05]:
> On Fri, Oct 03, 2008 at 12:19:33PM +0200, ext Koen Kooi wrote:
> >
> > Op 3 okt 2008, om 11:45 heeft Felipe Balbi het volgende geschreven:
> >
> >> without it, otg_get/set_transceiver won't be useful and
> >> twl4030-usb transceiver won't get to musb code.
> >
> > Is the 'fix-something' patch still needed, and if yes, why isn't it in l-o 
> > git yet?
> 
> we need that otg_get/set_transceiver call, yes. But those are omap
> specifc. there's a patch pending in linux-usb making those calls
> generic.
> 
> I'd say we can keep a patch in l-o only untill otg_get/set_transceiver
> hooks get accepted.
> 
> What say you Tony ?

Sure, we should keep things working for all the omap users while
waiting for the necessary stuff to get merged into mainline.

Felipe, just let me know what we need for l-o tree for musb.

Tony
