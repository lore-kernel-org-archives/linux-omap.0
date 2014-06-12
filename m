From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [media] staging: allow omap4iss to be modular
Date: Thu, 12 Jun 2014 08:15:35 -0700
Message-ID: <20140612151534.GF17845@atomide.com>
References: <5192928.MkINji4uKU@wuerfel>
 <20140611144754.GA17845@atomide.com>
 <2207210.T6NoNSQSCo@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2207210.T6NoNSQSCo@avalon>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, Mauro Carvalho Chehab <m.chehab@samsung.com>, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.org
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [140612 07:52]:
> On Wednesday 11 June 2014 07:47:54 Tony Lindgren wrote:
> > 
> > These should just use either pinctrl-single.c instead for muxing.
> > Or if they are not mux registers, we do have the syscon mapping
> > available in omap4.dtsi that pbias-regulator.c is already using.
> > 
> > Laurent, got any better ideas?
> 
> The ISS driver needs to write a single register, which contains several 
> independent fields. They thus need to be controlled by a single driver. Some 
> of them might be considered to be related to pinmuxing (although I disagree on 
> that), others are certainly not about muxing (there are clock gate bits for 
> instance).
> 
> Using the syscon mapping seems like the best option. I'll give it a try.

OK if it's not strictly pinctrl related then let's not use
pinctrl-single,bits for it. You may be able to implement one or more
framework drivers for it for pinctrl/regulator/clock/transceiver
whatever that register is doing.

In any case it's best to have that handling in a separate helper driver
somewhere as it's a separate piece of hardware from the camera module.
If it does not fit into any existing frameworks then it's best to have
it in a separate driver with the camera driver.

Regards,

Tony
