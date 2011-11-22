From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 4/4] mcx: initial support for HTKW mcx board
Date: Tue, 22 Nov 2011 04:21:07 +0400
Message-ID: <4ECAEAF3.4080708@emcraft.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-5-git-send-email-yanok@emcraft.com> <20111111001203.GD31337@atomide.com> <4EC17C64.7010409@emcraft.com> <20111119003630.GA31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:47778 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab1KVAVA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Nov 2011 19:21:00 -0500
In-Reply-To: <20111119003630.GA31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hi Tony,

On 19.11.2011 04:36, Tony Lindgren wrote:
>> Well, it already boots with DT actually. Did you mean booting with DT
>> and board-generic? I have to admit I don't know how to proceed here:
> 
> Good to hear you're already playing with it. Yes, let's work on making
> all the boards work with DT and board-generic..

Hm, do you think it's absolutely necessary to make everybody work with
board-generic? It will require a lot of additional bindings to get rid
of all machine-specific code. I've just thought that on PowerPC we don't
have such strict rules: if some boards are really similar they share
common machine file but if we need something specific for the new board
we can create it's own machine file.

>> board-generic initialize twl4030 which we don't have on our board...
>> Could you give me some pointer how I'm supposed to handle this?
> 
> .. we should only initialize twl4030/twl6030 if the DT compatible flag
> for it is set. But we're still missing the DT bindings for those :(
> 
> For now, maybe try to fix the twl4030 probe so it won't do anything
> unless the I2C device is found?

That turned to be not such a big problem. Device is not present so we
have tons of error messages but somehow it works.

The bigger problem is that we have different regulator chip attached.
How am I supposed to register supplies/consumers data with it? Does
anybody working on DT bindings for the regulator framework?

Regards, Ilya.
