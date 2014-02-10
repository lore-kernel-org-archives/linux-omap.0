From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv5] omap3: Add basic support for 720MHz part
Date: Mon, 10 Feb 2014 08:46:35 -0600
Message-ID: <CAGo_u6psBV18zdr0j7X2-xxr_oqc5a3XEVLGDXHTHL+R725teQ@mail.gmail.com>
References: <1297239010-29683-1-git-send-email-premi@ti.com>
	<1623915.4eAJkBo57q@avalon>
	<CAGo_u6r4Q0QyaZ9jPyiBNT-xBqxWA1MpESiyG7quzUn5kkoLhA@mail.gmail.com>
	<3626990.QRqYkuhRtF@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:41071 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbaBJOqg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Feb 2014 09:46:36 -0500
Received: by mail-vc0-f169.google.com with SMTP id hq11so4943761vcb.0
        for <linux-omap@vger.kernel.org>; Mon, 10 Feb 2014 06:46:35 -0800 (PST)
In-Reply-To: <3626990.QRqYkuhRtF@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sanjeev Premi <premi@ti.com>

On Mon, Feb 10, 2014 at 6:17 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> On Thu, Feb 6, 2014 at 1:26 PM, Laurent Pinchart wrote:
>> > On Friday 22 June 2012 11:33:51 Laurent Pinchart wrote:
>> >> On Thursday 10 February 2011 08:45:00 Kevin Hilman wrote:
>> >> > Sanjeev Premi <premi@ti.com> writes:
>> >> > > This patch adds support for speed enhanced variant of OMAP35x
>> >> > > processors. These parts allow ARM and IVA running at 720MHz
>> >> > > and 520MHz respectively.
>> >> > >
>> >> > > These parts can be detected at runtime by reading contents of
>> >> > > PRODID.SKUID[3:0] at 0x4830A20C [1].
>> >> > >
>> >> > > This patch specifically does following:
>> >> > >  * Add new OPP to omap34xx_opp_def_list[] - disabled by default.
>> >> > >  * Detect devices capable of running at new OPP.
>> >> > >  * Enable new OPP only if device supports it.
>> >> > >  * Check for presence of IVA before attempting to enable the
>> >> > >    corresponding OPP.
>> >> > >
>> >> > >   [1] http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf
>> >> > >
>> >> > > It appears from discussions (on this patch) that a variant of
>> >> > > OMAP3430 supports this OPP but lacks runtime detection. This
>> >> > > OPP can be enabled for these device by either:
>> >> > >  1) Setting the bit corresponding to OMAP3_HAS_720MHZ
>> >> > >     in 'omap3_features'. (Refer changes to id.c)
>> >> > >
>> >> > >  2) Removing check for omap3_has_720mhz() before enabling
>> >> > >     the OPP. (Refer changes to opp3xxx_data.c)
>> >> > >
>> >> > >  3) Calling opp_enable() for 720MHz/VDD1 and 520MHz/VDD2 in
>> >> > >     the board file. (Refer changes to opp3xxx_data.c).
>> >> > >     This should, ideally, be done before omap3_opp_init() is
>> >> > >     called during device_initcall().
>> >> > >
>> >> > > CAUTION: This should be done for identified parts only.
>> >> > >          Else, the device could be damaged permanently.
>> >> > >
>> >> > > Signed-off-by: Sanjeev Premi <premi@ti.com>
>> >> > > Reviewed-by: G, Manjunath Kondaiah <manjugk@ti.com>
>> >> >
>> >> > Acked-by: Kevin Hilman <khilman@ti.com>
>> >>
>> >> This patch seems to never have made it upstream. Is there a reason for
>> >> that
>> >> ?
>> >
>> > Ping ?
>>
>> We'd have to figure out a proper opp modifier logic with device tree.
>> considering that non-dt boot is slowly getting dismantled in mach-omap2, to
>> add new capabilities in non-dt is not really a good idea at this point in
>> time - Further, we do have equivalent requirements in other TI SoCs as well
>
> Good point, but I'm not sure to see where this patch is specific to legacy
> boot. The two functions it modifies, and omap3xxx_check_features() and
> omap3_opp_init(), are called for DT boot as well.

omap3_opp_init() ->omap_init_opp_table returns if of_have_populated_dt().
check_features enable a flag for omap3_opp_init to pick the right OPPs
up -> this is precisely the intent of something like opp modifier
logic.

Regards,
Nishanth Menon
