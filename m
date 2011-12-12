From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv8 2/5] omap3: voltage: fix channel configuration
Date: Mon, 12 Dec 2011 07:02:16 -0800
Message-ID: <87d3btg7ev.fsf@ti.com>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
	<1323444589-19940-3-git-send-email-t-kristo@ti.com>
	<8739ctjmyq.fsf@ti.com> <1323682464.31914.3.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51482 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750790Ab1LLPCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 10:02:19 -0500
Received: by mail-iy0-f182.google.com with SMTP id l21so4736944iak.27
        for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 07:02:18 -0800 (PST)
In-Reply-To: <1323682464.31914.3.camel@sokoban> (Tero Kristo's message of
	"Mon, 12 Dec 2011 11:34:24 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> On Fri, 2011-12-09 at 16:21 -0800, Kevin Hilman wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>> 
>> > OMAP3 uses the default settings for VDD1 channel, otherwise the settings will
>> > overlap with VDD2 and attempting to modify VDD1 voltage will actually change
>> > VDD2 voltage.
>> >
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> > ---
>> >  arch/arm/mach-omap2/vc3xxx_data.c |    1 +
>> >  2 files changed, 5 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
>> > index cfe348e..0136ad5 100644
>> > --- a/arch/arm/mach-omap2/vc3xxx_data.c
>> > +++ b/arch/arm/mach-omap2/vc3xxx_data.c
>> > @@ -46,6 +46,7 @@ static struct omap_vc_common omap3_vc_common = {
>> >  };
>> >  
>> >  struct omap_vc_channel omap3_vc_mpu = {
>> > +	.flags = OMAP_VC_CHANNEL_DEFAULT,
>> >  	.common = &omap3_vc_common,
>> >  	.smps_sa_reg	 = OMAP3_PRM_VC_SMPS_SA_OFFSET,
>> >  	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
>> 
>> Looking more at the flow diagram you mentioned in the OMAP3 TRM, I don't
>> think this is right for OMAP3.
>> 
>> Setting the USE_DEFAULTS flags means that VDD1 will only ever be able to
>> use [slave address | voltage reg | command reg] zero.  While this is
>> quite likely in most scenarios, the HW doesn't limit this like it does
>> on OMAP4.
>> 
>> On OMAP3, it's very possible to configure VDD1 to use 
>> [slave address | voltage reg | command reg] one if you want (even though
>> I'm not sure why you would.)
>> 
>> In any case, my point is that setting the USE_DEFAULTS flag forces an
>> OMAP4 restriction onto OMAP3 which the hardware doesn't have.
>> 
>
> Well, the voltage control does not work at all if this is not done. I am
> not sure what is the root cause for this, as I don't have currently
> oscilloscope available so that I could take a look at the bus traffic.
> The voltage rail behavior is incorrect unless this change is in, this is
> easily seen by measuring the voltage levels and trying to change the
> voltages by sw.

Yeah, I understand why it's broken now and the question is only whether
to make the same "default channel" restriction exist for OMAP3 as exists
for OMAP4.  For now, I'm OK with this restriction, so this patch is
fine.

Kevin
