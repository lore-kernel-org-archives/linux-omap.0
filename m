From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/RFT] OMAP: N770: remove custom implementation of
 ads7846_get_pendown_state
Date: Tue, 20 Nov 2012 10:27:06 -0800
Message-ID: <20121120182704.GJ18567@atomide.com>
References: <20121120083052.GA29020@core.coreip.homeip.net>
 <20121120144333.GA20727@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:22104 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751635Ab2KTS1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 13:27:12 -0500
Content-Disposition: inline
In-Reply-To: <20121120144333.GA20727@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [121120 06:45]:
> Hi,
> 
> On Tue, Nov 20, 2012 at 12:30:53AM -0800, Dmitry Torokhov wrote:
> > The default implementation matches exactly our custom one so we can switch
> > to using the default one. As a bonus the driver will take care of setting
> > GPIO line for us.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> > No hardware so not tested...
> 
> This seems to work.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> A minor nitpick, the board is just 770 not N770. :-)

Nice. Looks safe to merge along with other input related
patches:

Acked-by: Tony Lindgren <tony@atomide.com>
