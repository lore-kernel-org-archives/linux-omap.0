From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.28-rc3-omap] twl4030-core simplification
Date: Thu, 13 Nov 2008 17:05:46 -0800
Message-ID: <200811131705.47110.david-b@pacbell.net>
References: <200811071645.15687.david-b@pacbell.net> <20081114004243.GB3106@atomide.com> <20081114010013.GD3106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:38852 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751878AbYKNBFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2008 20:05:49 -0500
In-Reply-To: <20081114010013.GD3106@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@openedhand.com>

On Thursday 13 November 2008, Tony Lindgren wrote:
> If CONFIG_REGULATOR is not set, I get:
> 
> drivers/mfd/twl4030-core.c: In function 'add_children':
> drivers/mfd/twl4030-core.c:592: error: 'REGULATOR_MODE_OFF' undeclared (first use in this function)
> 
> Where do you want to have that for now? Add it also into
> twl4030-core.c like in twl4030-regulator.c?

#ifndef REGULATOR_MODE_OFF
#define REGULATOR_MODE_OFF 0
#endif

for now... but the fact that you're getting that at all seems to
mean you're applying the third regulator patch (register regulators)
without the fourth (debug oriented) which has that #ifndef.

Don't merge regulator patches #3 or #4 yet ... #2 should be OK,
but it's a NOP without #3 (which has the is ifdef issue).

- Dave


