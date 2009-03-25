From: Tony Lindgren <tony@atomide.com>
Subject: Re: Kernel support of the Zoom OMAP35X Development kit
Date: Wed, 25 Mar 2009 10:33:41 -0700
Message-ID: <20090325173341.GP8057@atomide.com>
References: <49CA662B.6000104@balister.org> <1f11a5490903251020o40ec542dyd44a2098c273a211@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50076 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756320AbZCYRdq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 13:33:46 -0400
Content-Disposition: inline
In-Reply-To: <1f11a5490903251020o40ec542dyd44a2098c273a211@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: Philip Balister <philip@balister.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Ashwin Bihari <abihari@gmail.com> [090325 10:21]:
> On Wed, Mar 25, 2009 at 1:13 PM, Philip Balister <philip@balister.org> wrote:
> > I looked at the kit kernel and didn't see support for this board:
> >
> > http://www.logicpd.com/products/devkit/ti/zoom_omap3_development_kit
> >
> > What are my chances getting this board going with the Linux-omap git kernel?
> >
> > If that doesn't work, what boards give easy access to the GPMC pins and work
> > with the linux-omap kernel?
> >
> > Philip
> >
> 
> Philip,
> 
> We have support for the OMAP3530LV_SOM (the LogicPD DevKit in the
> link) on 2.6.28-rc8. We have patches available against that particular
> release of the Linux OMAP tree and that'll get you up to speed on the
> SOM to do your work. Register yourself on the website and you should
> get access to the patches there.

How about send the board-*.c and other patches you have against the
mainline kernel to this list so we can review them?

Then let's queue them up for integration to the mainline kernel for
the next merge window!

Cheers,

Tony
