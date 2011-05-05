From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Thu, 05 May 2011 14:58:29 +0300
Message-ID: <1304596709.30935.21.camel@deskari>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
	 <1304494704-7285-2-git-send-email-archit@ti.com>
	 <20110504094050.GI27860@atomide.com> <1304595408.30935.16.camel@deskari>
	 <20110505115007.GF2092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54312 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752717Ab1EEL6f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 07:58:35 -0400
Received: by eye27 with SMTP id 27so883794eye.34
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 04:58:32 -0700 (PDT)
In-Reply-To: <20110505115007.GF2092@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

On Thu, 2011-05-05 at 04:50 -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [110505 04:33]:
> > On Wed, 2011-05-04 at 12:40 +0300, Tony Lindgren wrote:
> > > 
> > > Looks like we should first combine all this cut and paste data
> > > for each board file into some common init function to cut
> > > down the "crazy churn".
> > 
> > Sorry, I don't see how this would be possible with the regulator
> > framework. What we would need is to setup some
> > regulator_consumer_supplies dynamically depending on the omap and on the
> > given parameters.
> > 
> > Adding Liam and Mark for possible comments. A short summary of the
> > situation:
> > 
> > OMAP display subsystem (DSS) HW needs a few power supplies (vdds_dsi,
> > vdds_sdi, vdda_dac), depending on the OMAP version. All the known boards
> > have the standard TWL power chip which provides these powers, and they
> > are connected almost always the same way. However, there's no reason
> > that the powers for DSS couldn't be provided from some other source.
> > 
> > As an example, on OMAP3 we could have:
> > (regulator -> name -> driver)
> > VDDA_DAC -> "vdda_dac" -> omapdss_venc
> > VPLL2 -> "vdds_dsi" -> omapdss
> > VPLL2 -> "vdds_dsi" -> omapdss_dsi
> > 
> > So currently we have REGULATOR_SUPPLY defines for each board in all the
> > board files which support display. It would be much better to have an
> > overrideable standard setup for the DSS powers, but this would require
> > dynamically setting up the regulator_consumer_supplies. And I can't see
> > how this could be done, except dynamically creating the
> > regulator_consumer_supply array before initializing the TWL chip, but as
> > DSS is not the only user of those powers the end result could be quite a
> > mess with changes needed in every board file.
> 
> What if you just do all common DSS REGULATOR_SUPPLY entries in the common
> platform init code for DSS? Then just set the regulator_init_data pointers
> based on the desired configuration.
> 
> Or maybe I misunderstood your problem..

The problem with that approach is that there could be other users for
the same regulator, so the consumer_supplies list could also need to
contain some other entries than dss.

Then again, I guess those cases are minority, so we would still get
majority of the board files cleaned up.

Thanks for the idea, I'll try this approach.

 Tomi


