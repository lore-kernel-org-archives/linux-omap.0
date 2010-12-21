From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 00/10] OMAP: Adding Smartreflex and Voltage driver
 support
Date: Tue, 21 Dec 2010 10:55:14 -0800
Message-ID: <20101221185514.GF5829@atomide.com>
References: <1292864357-13939-1-git-send-email-thara@ti.com>
 <877hf45414.fsf@deeprootsystems.com>
 <20101221022329.GC5829@atomide.com>
 <87lj3jyua2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51265 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab0LUSzZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 13:55:25 -0500
Content-Disposition: inline
In-Reply-To: <87lj3jyua2.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com

* Kevin Hilman <khilman@deeprootsystems.com> [101221 08:17]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@deeprootsystems.com> [101220 17:05]:
> >> Thara Gopinath <thara@ti.com> writes:
> >> 
> >> > This patch series introduces smartreflex and voltage driver support
> >> > for OMAP3430 and OMAP3630. SmartReflex modules do adaptive voltage
> >> > control for real-time voltage adjustments.
> >> 
> >> Thanks Thara, these are looking good for 2.6.38.
> >> 
> >> Tony, unless there are major objections, I'll be queuing these two SR
> >> series for 2.6.38.  They have dependencies on Paul's integration branch
> >
> > Well looking at patch 3/6 I think it should live under drivers somewhere
> > and mostly be compiled as a module. Probably the only change needed
> > for that is to not call cpu_is_omapxxxx but instead use some flags
> > passed in the platform_data. Otherwise the whole series looks OK to me.
> 
> Moving this to be a regulator driver is part of the medium-term plan,
> and is already under development.  For this phase, we just split up the
> current driver into device and driver code and left under mach-omap2.
> We are investigating (and making) changes to the regulator core so that
> SmartReflex can be converted into a real regulator driver, but that is
> still under development.
> 
> So, in the mean time, I'd like to merge this version so that other
> development that depends on this (the regulator work mentioned above,
> the DVFS work, etc.) can have a stable starting point.

OK up to you.

Tony
