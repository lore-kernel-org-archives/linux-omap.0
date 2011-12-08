From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] mcx: initial support for HTKW mcx board
Date: Wed, 7 Dec 2011 16:04:16 -0800
Message-ID: <20111208000416.GT31337@atomide.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com>
 <1320797568-11169-5-git-send-email-yanok@emcraft.com>
 <20111111001203.GD31337@atomide.com>
 <4EC17C64.7010409@emcraft.com>
 <20111119003630.GA31337@atomide.com>
 <4ECAEAF3.4080708@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51821 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753223Ab1LHAEU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 19:04:20 -0500
Content-Disposition: inline
In-Reply-To: <4ECAEAF3.4080708@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

* Ilya Yanok <yanok@emcraft.com> [111121 15:46]:
> Hi Tony,
> 
> On 19.11.2011 04:36, Tony Lindgren wrote:
> >> Well, it already boots with DT actually. Did you mean booting with DT
> >> and board-generic? I have to admit I don't know how to proceed here:
> > 
> > Good to hear you're already playing with it. Yes, let's work on making
> > all the boards work with DT and board-generic..
> 
> Hm, do you think it's absolutely necessary to make everybody work with
> board-generic? It will require a lot of additional bindings to get rid
> of all machine-specific code. I've just thought that on PowerPC we don't
> have such strict rules: if some boards are really similar they share
> common machine file but if we need something specific for the new board
> we can create it's own machine file.

Well ideally yes we would remove the board files completely eventually.

But that will take a while, so I can carry your board file in testing-board
branch.
 
> >> board-generic initialize twl4030 which we don't have on our board...
> >> Could you give me some pointer how I'm supposed to handle this?
> > 
> > .. we should only initialize twl4030/twl6030 if the DT compatible flag
> > for it is set. But we're still missing the DT bindings for those :(
> > 
> > For now, maybe try to fix the twl4030 probe so it won't do anything
> > unless the I2C device is found?
> 
> That turned to be not such a big problem. Device is not present so we
> have tons of error messages but somehow it works.
> 
> The bigger problem is that we have different regulator chip attached.
> How am I supposed to register supplies/consumers data with it? Does
> anybody working on DT bindings for the regulator framework?

Rajendra has posted some regulator DT patches. I believe they have
a dependency to the deferred probe patches in many cases though.

Regards,

Tony
