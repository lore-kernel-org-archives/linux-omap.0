From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Thu, 5 May 2011 04:50:07 -0700
Message-ID: <20110505115007.GF2092@atomide.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
 <1304494704-7285-2-git-send-email-archit@ti.com>
 <20110504094050.GI27860@atomide.com>
 <1304595408.30935.16.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61241 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751966Ab1EELuM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 07:50:12 -0400
Content-Disposition: inline
In-Reply-To: <1304595408.30935.16.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110505 04:33]:
> On Wed, 2011-05-04 at 12:40 +0300, Tony Lindgren wrote:
> > 
> > Looks like we should first combine all this cut and paste data
> > for each board file into some common init function to cut
> > down the "crazy churn".
> 
> Sorry, I don't see how this would be possible with the regulator
> framework. What we would need is to setup some
> regulator_consumer_supplies dynamically depending on the omap and on the
> given parameters.
> 
> Adding Liam and Mark for possible comments. A short summary of the
> situation:
> 
> OMAP display subsystem (DSS) HW needs a few power supplies (vdds_dsi,
> vdds_sdi, vdda_dac), depending on the OMAP version. All the known boards
> have the standard TWL power chip which provides these powers, and they
> are connected almost always the same way. However, there's no reason
> that the powers for DSS couldn't be provided from some other source.
> 
> As an example, on OMAP3 we could have:
> (regulator -> name -> driver)
> VDDA_DAC -> "vdda_dac" -> omapdss_venc
> VPLL2 -> "vdds_dsi" -> omapdss
> VPLL2 -> "vdds_dsi" -> omapdss_dsi
> 
> So currently we have REGULATOR_SUPPLY defines for each board in all the
> board files which support display. It would be much better to have an
> overrideable standard setup for the DSS powers, but this would require
> dynamically setting up the regulator_consumer_supplies. And I can't see
> how this could be done, except dynamically creating the
> regulator_consumer_supply array before initializing the TWL chip, but as
> DSS is not the only user of those powers the end result could be quite a
> mess with changes needed in every board file.

What if you just do all common DSS REGULATOR_SUPPLY entries in the common
platform init code for DSS? Then just set the regulator_init_data pointers
based on the desired configuration.

Or maybe I misunderstood your problem..

Tony

