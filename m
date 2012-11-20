From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [RFC/RFT] OMAP: N770: remove custom implementation of
 ads7846_get_pendown_state
Date: Tue, 20 Nov 2012 16:43:34 +0200
Message-ID: <20121120144333.GA20727@blackmetal.musicnaut.iki.fi>
References: <20121120083052.GA29020@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:60048 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab2KTOni (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 09:43:38 -0500
Content-Disposition: inline
In-Reply-To: <20121120083052.GA29020@core.coreip.homeip.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

Hi,

On Tue, Nov 20, 2012 at 12:30:53AM -0800, Dmitry Torokhov wrote:
> The default implementation matches exactly our custom one so we can switch
> to using the default one. As a bonus the driver will take care of setting
> GPIO line for us.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> No hardware so not tested...

This seems to work.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A minor nitpick, the board is just 770 not N770. :-)

A.
