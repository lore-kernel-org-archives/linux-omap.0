From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/6] ARM: OMAP: voltage: move voltdm_reset to
 platform_data header
Date: Wed, 7 Nov 2012 22:52:49 -0600
Message-ID: <20121108045249.GB15742@kahuna>
References: <1352127734-30103-1-git-send-email-nm@ti.com>
 <1352127734-30103-5-git-send-email-nm@ti.com>
 <20121106184935.GL6801@atomide.com>
 <20121106214819.GA16246@kahuna>
 <20121107011808.GZ6801@atomide.com>
 <20121107012838.GA13630@kahuna>
 <20121107014608.GB6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45306 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467Ab2KHEwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 23:52:53 -0500
Content-Disposition: inline
In-Reply-To: <20121107014608.GB6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Rafael <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbouatmailru@gmail.com>, linux-pm <linux-pm@vger.kernel.org>

On 17:46-20121106, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [121106 17:30]:
> > On 17:18-20121106, Tony Lindgren wrote:
> > > * Nishanth Menon <nm@ti.com> [121106 13:50]:
> > > > On 10:49-20121106, Tony Lindgren wrote:
> > > > > 
> > > > > Looks like there are other things there too that's not platform data:
> > > > > 
> > > > > struct voltagedomain *voltdm_lookup(const char *name);
> > > > > int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
> > > > > unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
> > > > > struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
> > > > > 		unsigned long volt);
> > > > > 
> > > > > Can you please add a patch fixing that ASAP?
> > > > 
> > > > Agreed include/linux/platform_data/voltage-omap.h has more functions as well.
> > > > Considering it did:
> > > > rename arch/arm/plat-omap/include/plat/voltage.h =>
> > > > include/linux/platform_data/voltage-omap.h
> > > > 
> > > > Where do we move these functions to?
> > > > 
> > > > drivers/power/avs/smartreflex.c needs:
> > > > omap_voltage_get_voltdata
> > > > and
> > > > drivers/power/avs/smartreflex-class3.c
> > > > will need voltdm_reset and voltdm_get_voltage
> > > 
> > > How about something local drivers/power/avs/smartreflex.h?
> > These APIs are exposed by voltage layer, not smartreflex :(
> > stuff like voltdm_scale will have to be used by regulator logic
> > eventually, so moving to AVS driver header is probably not right.
> 
> Well ideally you'd have some generic API doing it rather than
> these omap specifc exported functions.
> 
> Meanwhile, I guess you need to find some suitable location
> for the header file that works for Rafael.
I wonder if including mach/voltage.h is acceptable here? if Kevin could
suggest an option as well, it will be great.

-- 
Regards,
Nishanth Menon
