From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] alsa: add Beagleboard SoC configuration.
Date: Mon, 6 Oct 2008 09:09:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810060906140.354@utopia.booyaka.com>
References: <1221597643-29601-1-git-send-email-felipe.contreras@gmail.com> <200810032334.04565.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36043 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbYJFPJT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 11:09:19 -0400
In-Reply-To: <200810032334.04565.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org

Hi David,

On Fri, 3 Oct 2008, David Brownell wrote:

> On Tuesday 16 September 2008, Felipe Contreras wrote:
> > This is exactly the same as the overo configuration. It might make sense
> > to have them in a single one.
> 
> I got a hard lockup (no timer ticking), no blinkenlights, etc ...
> doesn't look like the issue is *this* driver.

...

> [ INFO: possible recursive locking detected ]
> 2.6.27-rc8-omap1 #174
> ---------------------------------------------
> aplay/1816 is trying to acquire lock:
>  (clockfw_lock){....}, at: [<c0036be4>] clk_enable+0x24/0x70
> 
> but task is already holding lock:
>  (clockfw_lock){....}, at: [<c0036be4>] clk_enable+0x24/0x70

Yeah, the code that's in that driver is broken.  The driver 
sets up a custom clk_enable() function that calls clk_enable() again.  And 
clk_enable() takes clockfw_lock.

The omap_clk_associate() code should resolve this problem.


- Paul
