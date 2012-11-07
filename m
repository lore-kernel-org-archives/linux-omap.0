From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] ARM: OMAP: voltage: move voltdm_reset to
 platform_data header
Date: Tue, 6 Nov 2012 17:18:08 -0800
Message-ID: <20121107011808.GZ6801@atomide.com>
References: <1352127734-30103-1-git-send-email-nm@ti.com>
 <1352127734-30103-5-git-send-email-nm@ti.com>
 <20121106184935.GL6801@atomide.com>
 <20121106214819.GA16246@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48803 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753314Ab2KGBSL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 20:18:11 -0500
Content-Disposition: inline
In-Reply-To: <20121106214819.GA16246@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Rafael <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbouatmailru@gmail.com>, linux-pm <linux-pm@vger.kernel.org>

* Nishanth Menon <nm@ti.com> [121106 13:50]:
> On 10:49-20121106, Tony Lindgren wrote:
> > 
> > Looks like there are other things there too that's not platform data:
> > 
> > struct voltagedomain *voltdm_lookup(const char *name);
> > int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
> > unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
> > struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
> > 		unsigned long volt);
> > 
> > Can you please add a patch fixing that ASAP?
> 
> Agreed include/linux/platform_data/voltage-omap.h has more functions as well.
> Considering it did:
> rename arch/arm/plat-omap/include/plat/voltage.h =>
> include/linux/platform_data/voltage-omap.h
> 
> Where do we move these functions to?
> 
> drivers/power/avs/smartreflex.c needs:
> omap_voltage_get_voltdata
> and
> drivers/power/avs/smartreflex-class3.c
> will need voltdm_reset and voltdm_get_voltage

How about something local drivers/power/avs/smartreflex.h?

Regards,

Tony
