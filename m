From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] omap: Disable GAIA I2C1/I2C4 internal pull-ups
Date: Tue, 2 Feb 2010 08:56:29 -0800
Message-ID: <20100202165629.GS22747@atomide.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B4CBDEA@dbde02.ent.ti.com>
 <20100202015336.GN22747@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026AFAA3F2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55978 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0BBQ4D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 11:56:03 -0500
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026AFAA3F2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pais, Allen" <allen.pais@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pais, Allen <allen.pais@ti.com> [100201 18:56]:
> 
> ________________________________________
> From: Tony Lindgren [tony@atomide.com]
> Sent: Monday, February 01, 2010 7:53 PM
> To: Pais, Allen
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/2] omap: Disable GAIA I2C1/I2C4 internal pull-ups
> 
> Hi,
> 
> * Pais, Allen <allen.pais@ti.com> [100121 02:31]:
> > From 4044fcc9c517e86fbea9f7d3b15d5cf75a767476 Mon Sep 17 00:00:00 2001
> > From: Allen Pais <allen.pais@ti.com>
> > Date: Thu, 21 Jan 2010 21:00:04 +0530
> > Subject: [PATCH 1/2] omap: Disable GAIA I2C1/I2C4 internal pull-ups
> >
> > This patch disables GAIA I2C1 adn I2C4(SR) internal pull-up, to
> > use only the external HW resistor >=470 Ohm for the assured
> > functionality in HS mode.
> >
> > While testing the I2C in High Speed mode, it was discovered that
> > without a proper pull-up resistor, there is data corruption during
> > multi-byte transfer. RTC(time_set) test case was used for testing.
> >
> > From the analysis done, it was concluded that ideally we need a
> > pull-up of 1.6k Ohm(recomended) or atleast 470 Ohm or greater for
> > assured performance in HS mode.
> 
> Does this apply to 3630 only, or also 34xx? Is this safe to do
> always?
> 
> [Allen] Yes, it does apply to 36xx only. 

Sounds like then this configuration should be passed from the
board-*.c file in platform_data as the external pulls depend
on the board.
 
> BTW, once ready it hould be sent to Samuel Ortiz with linux-omap
> list Cc'd:
> 
> [Allen] i'll have it sent to Samuel also.

Thanks, we can't merge it yet though, see above.

Regards,

Tony
