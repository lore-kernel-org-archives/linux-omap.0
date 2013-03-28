From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL v2] ARM: omap2: twl-common update
Date: Thu, 28 Mar 2013 09:04:15 -0700
Message-ID: <20130328160414.GU10155@atomide.com>
References: <5146E895.50709@ti.com>
 <20130319182336.GE16413@atomide.com>
 <20130327183822.GC10155@atomide.com>
 <51540D09.7000104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56916 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558Ab3C1QES (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 12:04:18 -0400
Content-Disposition: inline
In-Reply-To: <51540D09.7000104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@list.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130328 02:32]:
> Hi Tony,
> 
> On 03/27/2013 07:38 PM, Tony Lindgren wrote:
> > Sorry just noticed that this one adds:
> > 
> > Section mismatch in reference from the variable omap3_power_pdata to the (unknown reference) .init.data:(unknown)
> > The variable omap3_power_pdata references
> > the (unknown reference) __initdata (unknown)
> > If the reference is valid then annotate the
> > variable with __init* or __refdata (see linux/init.h) or name the variable:
> > *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> > 
> > Is it safe to make it __initdata, or should also other power_pdata
> > have their __initdata flags removed if used by the drivers?
> 
> We could make the whole stack of struct for the omap3_power_pdata as
> __initdata since the driver (mfd/twl4030-power) is bool.

What if you rebind the driver via sysfs unbind/bind?

Regards,

Tony
