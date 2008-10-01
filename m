From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 11/9] move twl4030-gpio to drivers/gpio
Date: Wed, 1 Oct 2008 18:05:36 +0200
Message-ID: <20081001180536.3084b730@hyperion.delvare>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com>
	<200809272216.14672.david-b@pacbell.net>
	<94a0d4530810010646j7bc4bd8bsb2b94e96adbb0182@mail.gmail.com>
	<200810010858.13612.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:45227 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbYJAQFv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 12:05:51 -0400
In-Reply-To: <200810010858.13612.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, 1 Oct 2008 08:58:12 -0700, David Brownell wrote:
> On Wednesday 01 October 2008, Felipe Contreras wrote:
> > Hmm, I'm seeing two different configs:
> > CONFIG_TWL4030_GPIO
> > CONFIG_GPIO_TWL4030
> > 
> > I guess the defconfigs are wrong.
> 
> Right, they should get fixed.
> 
> The same issue will come when drivers/i2c/chips/twl4030-core.c
> moves to drivers/mfd/twl4030-core.c (...)

Yes, please! I think I'll kill drivers/i2c/chips soon.

-- 
Jean Delvare
