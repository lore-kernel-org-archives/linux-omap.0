From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP CLK / CM data move to /drivers/clk
Date: Mon, 4 Mar 2013 16:01:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303041600280.23192@utopia.booyaka.com>
References: <1361954659.8362.70.camel@sokoban>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42496 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab3CDQBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 11:01:12 -0500
In-Reply-To: <1361954659.8362.70.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, mturquette@linaro.org, "Valentin, Eduardo" <eduardo.valentin@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Hi guys,

On Wed, 27 Feb 2013, Tero Kristo wrote:

> It looks like we need to start putting more effort into this clock data
> move now, as this is starting to hinder us on several fronts.
> Unfortunately I still can't personally participate in this work myself
> as I am now allocated to some hwmod related work, but Eduardo should
> have plenty of time to help with this...
> 
> Anyway, Paul, I think you have been working a bit with this topic, what
> is the latest status with this? Do you see any areas Eduardo can help
> with? If you have some partially finished work also which you don't have
> time yourself, we can even take a look at that.
> 
> Also, I would like to receive some initial comments about the approach
> we should take, and I added Mike here for this as you are the maintainer
> for the /drivers/clk. I believe we should start by moving the clock data
> under /drivers/clk/omap, and potentially move also some other stuff
> here, like CM code, clockdomain code and clockdomain data even. Do you
> have any opinions on this?

Will respond soon to this...

- Paul
