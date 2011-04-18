From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v9 4/9] OMAP3: PM: TWL4030 power scripts for OMAP3
 boards
Date: Mon, 18 Apr 2011 15:58:20 +0300
Message-ID: <20110418125820.GO12272@atomide.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
 <1302784077-16697-5-git-send-email-leslyam@ti.com>
 <20110418123240.GN12272@atomide.com>
 <BANLkTinjkqmL5a2YQTnMYFSZt-11vRNy0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61258 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab1DRM6W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 08:58:22 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinjkqmL5a2YQTnMYFSZt-11vRNy0w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Manuel, Lesly Arackal" <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

* Manuel, Lesly Arackal <leslyam@ti.com> [110418 15:52]:
> >
> > To me it seems this should go into drivers/mfd instead.
> > The script may contain omap specific values, but can be
> > a loadable driver module.
> 
> - subsys_initcall(twl_init)
>     -> twl_probe()
>       -> twl4030_power_init()
>         -> load_twl4030_script()  #to copy this script data to the PM IC.
> 
> Since this is getting called from a subsys initcall, not sure whether
> we can make this scripts as loadable module.

AFAIK it does not need to do anything that early. Maybe take a look
at initialing it later?

Regards,

Tony
