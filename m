From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: OMAP CLK / CM data move to /drivers/clk
Date: Wed, 27 Feb 2013 07:00:10 -0400
Message-ID: <512DE73A.3020601@ti.com>
References: <1361954659.8362.70.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52691 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558Ab3B0LAX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Feb 2013 06:00:23 -0500
In-Reply-To: <1361954659.8362.70.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, mturquette@linaro.org, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On 27-02-2013 04:44, Tero Kristo wrote:
> Hi Paul and Mike,
>
> It looks like we need to start putting more effort into this clock data
> move now, as this is starting to hinder us on several fronts.
> Unfortunately I still can't personally participate in this work myself
> as I am now allocated to some hwmod related work, but Eduardo should
> have plenty of time to help with this...

hehe.. That's a bit stretching, but yes, I can help with this move :-)

>
> Anyway, Paul, I think you have been working a bit with this topic, what
> is the latest status with this? Do you see any areas Eduardo can help
> with? If you have some partially finished work also which you don't have
> time yourself, we can even take a look at that.
Paul,

Couple of initial questions. Would we move also the existing CM / PRM 
code? Is there any cross dependency with SCM?

Paul, would be you who would be queuing these changes?

>
> Also, I would like to receive some initial comments about the approach
> we should take, and I added Mike here for this as you are the maintainer
> for the /drivers/clk. I believe we should start by moving the clock data
> under /drivers/clk/omap, and potentially move also some other stuff
> here, like CM code, clockdomain code and clockdomain data even. Do you
> have any opinions on this?
>
> -Tero
>
>
>
>

