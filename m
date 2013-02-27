From: Mike Turquette <mturquette@linaro.org>
Subject: Re: OMAP CLK / CM data move to /drivers/clk
Date: Wed, 27 Feb 2013 10:43:45 -0800
Message-ID: <20130227184345.14870.23049@quantum>
References: <1361954659.8362.70.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:38122 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580Ab3B0Sn7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Feb 2013 13:43:59 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so533846pbb.41
        for <linux-omap@vger.kernel.org>; Wed, 27 Feb 2013 10:43:58 -0800 (PST)
In-Reply-To: <1361954659.8362.70.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.comTero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Quoting Tero Kristo (2013-02-27 00:44:19)
> Hi Paul and Mike,
> 
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
> 

My gut reaction is that I do not want the clockdomain or CM code under
drivers/clk.  The clock code and data is welcome under drivers/clk.  If
there are zero users of the CM and clockdomain code outside of the clock
code, then I'll consider it, but otherwise the CM and clockdomain code
must find a proper home.

There was some discussion about a general place to put power controller
code [1] and some stuff about power sequencing on the list [2], perhaps
that is a better destination for the CM and clockdomain code?  I admit
it is a stretch.

There are two other points to consider when migrating this data:

1) Has the hwmod initialization been changed to run after early init,
when slab is up?  If so then that removes the barrier keeping the OMAP
clock data statically initialized via clk-private.h.  Whoever is going
to migrate this data should think about registering the clocks
dynamically and using clk-provider.h instead of clk-private.h.  I'd like
to remove the latter header and after Tegra's latest CCF patches I
believe that only OMAP is making use of it.

2) Migrating the clock data to device tree.  This seems to be the way
everyone is going.  I care less about this one as the maintainer of
drivers/clk and more about getting rid of clk-private.h users once and
for all.

Regards,
Mike

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/90425
[2] http://article.gmane.org/gmane.linux.kernel/1395912/match=runtime+interpreted+power+sequences

> -Tero
