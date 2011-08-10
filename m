From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 4/6] OMAP4: Temperature sensor device support
Date: Wed, 10 Aug 2011 05:41:02 -0700
Message-ID: <20110810124102.GM1939@atomide.com>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
 <1312979122-5896-5-git-send-email-j-keerthy@ti.com>
 <20110810123647.GF12882@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:45687 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752534Ab1HJMlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 08:41:09 -0400
Content-Disposition: inline
In-Reply-To: <20110810123647.GF12882@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com

* Felipe Balbi <balbi@ti.com> [110810 05:31]:
> 
> On Wed, Aug 10, 2011 at 05:55:20PM +0530, Keerthy wrote:
> > +
> > +int __init omap_devinit_temp_sensor(void)
> > +{
> > +	if (!cpu_is_omap446x())
> > +		return 0;
> > +
> > +	return omap_hwmod_for_each_by_class("temperature_sensor",
> > +			temp_sensor_dev_init, NULL);
> > +}
> > +
> > +arch_initcall(omap_devinit_temp_sensor);
> 
> I really dislike people adding more and more *initcall() to their pieces
> of code. But Tony is the final Judge.

Yes how about making this just a regular device driver and have it
live under drivers/ somewhere?

Or is there some reason why this could not be a loadable module?

Regards,

Tony
