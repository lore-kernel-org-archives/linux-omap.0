From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] musb: fix power field to hold all possible values
Date: Thu, 25 Feb 2010 14:19:40 -0800
Message-ID: <20100225221940.GN28173@atomide.com>
References: <1266918404-17715-1-git-send-email-ajay.gupta@ti.com>
 <20100223095154.GA12815@gandalf>
 <19F8576C6E063C45BE387C64729E7394044DA995E5@dbde02.ent.ti.com>
 <20100223203215.GA21920@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62985 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934167Ab0BYWSk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 17:18:40 -0500
Content-Disposition: inline
In-Reply-To: <20100223203215.GA21920@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Balbi <me@felipebalbi.com> [100223 12:30]:
> Hi,
> 
> On Tue, Feb 23, 2010 at 08:01:50PM +0530, Gupta, Ajay Kumar wrote:
> > Board files are providing the actual mA and it is getting divided in 
> > Arch/arm/mach-omap2/usb-musb.c. See the code snippet below,
> > 
> >         musb_plat.clock = "ick";
> >         musb_plat.board_data = board_data;
> > -->     musb_plat.power = board_data->power >> 1;
> >         musb_plat.mode = board_data->mode;
> > 
> > So we need to either take this patch or fix this logic of dividing the mA
> > supplied from all omap board files.
> 
> that's true, had missed that. Sorry.

Hmm, I believe this value is also divided somewhere else but
I forgot where. In any case, when making changes like this
please run the standard USB tests for gadgets and OTG.

Otherwise things are guaranteed to break for USB certs :)

Tony
