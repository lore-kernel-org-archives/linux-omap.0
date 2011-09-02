From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/7] OMAP3: board-dt: Add generic board file for DT
 support
Date: Fri, 2 Sep 2011 14:57:33 +0300
Message-ID: <20110902115733.GU3548@atomide.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
 <1314897912-18178-7-git-send-email-b-cousson@ti.com>
 <20110902080944.GP3548@atomide.com>
 <4E609800.9090402@ti.com>
 <20110902104330.GR3548@atomide.com>
 <4E60C174.50604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:37803 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751083Ab1IBL5i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 07:57:38 -0400
Content-Disposition: inline
In-Reply-To: <4E60C174.50604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [110902 14:10]:
> On 9/2/2011 12:43 PM, Tony Lindgren wrote:
> > * Cousson, Benoit<b-cousson@ti.com>  [110902 11:13]:
> >> Hi Tony,
> >>
> >> On 9/2/2011 10:09 AM, Tony Lindgren wrote:
> >>> Hi,
> >>>
> >>> * Benoit Cousson<b-cousson@ti.com>   [110901 19:52]:
> >>>> Create an OMAP3 generic board to start the DT migration.
> >>>
> >>> I don't think this needs to be SoC specific, we can add multiple
> >>> DT_MACHINE_START entries into a single file. So it should be
> >>> just board-omap-dt.c.
> >>
> >> I do agree, it should not, I made that comment into the
> >> board-omap4-dt.c, but for the moment we still have dedicated OMAP
> >> specifics stuff at board level, like the map_io.
> > 
> > Well map_io can also be set in DT_MACHINE_START. For most part
> > it already is generic like omap3_map_io and omap4_map_io.
> > So that should not stop anything.
> 
> OK, I think I was trying to be a little bit more extreme, meaning only one omap_map_io for every OMAPs.
> Then, inside omap_map_io we can use the DT compatible information to retrieve the proper OMAPs revision and thus use the proper init table.
>
> Whereas in your case you are still relying on the various DT_MACHINE entries to detect which OMAP revision is used.

Sure that can be changed. But why not get the whole data that's
now in various structs from DT too? It's just something like:

        .class  = OMAP243X_CLASS,
        .tap    = OMAP2_L4_IO_ADDRESS(0x4900a000),
        .sdrc   = OMAP243X_SDRC_BASE,
        .sms    = OMAP243X_SMS_BASE,
        .ctrl   = OMAP243X_CTRL_BASE,
        .prm    = OMAP2430_PRM_BASE,
        .cm     = OMAP2430_CM_BASE,

And all these could be just defined in DT right?
 
> It looks to me that relying on several DT_MACHINE_START to identify a SoC version is a little bit more a hack. 
> I will let the device-tree experts answering that question :-)
> For my point of view, using DT compatible in the various place where the OMAP revision is important, might allow a finer granularity.

Sure I agree.
 
> >> I have an other series that make the map_io DT aware to get rid of
> >> that, but it still not finalized.
> > 
> > Hmm maybe take a look again? We've already sorted out quite a bit
> > of the init stuff over past few merge windows. If there's still
> > something blocking that, let's clear it out ASAP.
> 
> Now that I understand your approach, it is fine. Please find below an example of what I was trying to achieve, and why that point was an issue.
> The clear advantage of your method is that not further effort will be require for this part. At least for the moment.

Well I guess the globals could come from device tree still :)

In general, I'd like to get rid of the cpu_is_omapxxxx stuff
and SoC detection early as that always requires DEBUG_LL to
see any decent debug info when things go wrong.

If we get the SoC major type from DT, then we only need to
do SoC specific ES revision and GP/HS omap detection. And that's
very simple code compared to the current cpu_is_omapxxxx stuff.

Then we can boot with the DT information pretty far to map_io
and initialize low-level serial console, and then set up things
further while having a decent console ;)

Regards,

Tony
