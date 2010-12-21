From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 00/10] OMAP: Adding Smartreflex and Voltage driver
 support
Date: Mon, 20 Dec 2010 19:18:41 -0800
Message-ID: <20101221031840.GD5829@atomide.com>
References: <1292864357-13939-1-git-send-email-thara@ti.com>
 <877hf45414.fsf@deeprootsystems.com>
 <20101221022329.GC5829@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35275 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933498Ab0LUDSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 22:18:47 -0500
Content-Disposition: inline
In-Reply-To: <20101221022329.GC5829@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: nm@ti.com, paul@pwsan.com, b-cousson@ti.com, sawant@ti.com, vishwanath.bs@ti.com, Thara Gopinath <thara@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [101220 18:31]:
> * Kevin Hilman <khilman@deeprootsystems.com> [101220 17:05]:
> > Thara Gopinath <thara@ti.com> writes:
> > 
> > > This patch series introduces smartreflex and voltage driver support
> > > for OMAP3430 and OMAP3630. SmartReflex modules do adaptive voltage
> > > control for real-time voltage adjustments.
> > 
> > Thanks Thara, these are looking good for 2.6.38.
> > 
> > Tony, unless there are major objections, I'll be queuing these two SR
> > series for 2.6.38.  They have dependencies on Paul's integration branch
> 
> Well looking at patch 3/6 I think it should live under drivers somewhere
> and mostly be compiled as a module. Probably the only change needed
> for that is to not call cpu_is_omapxxxx but instead use some flags
> passed in the platform_data. Otherwise the whole series looks OK to me.

Considering the short time left, maybe you can leave out the driver
part for now and merge all the platform related part for smartreflex?

Sorry I really should have made that driver comment way earlier..

Regards,

Tony
