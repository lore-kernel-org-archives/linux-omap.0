From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
Date: Fri, 9 May 2014 23:06:55 +0200
Message-ID: <CALbNGRR3U1veFgXmOWpfG3yNVESdxi2t79WDrJwOZ1oShuG1yA@mail.gmail.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
	<1398815562-24113-2-git-send-email-tony@atomide.com>
	<536C860E.1000501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:48286 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757382AbaEIVG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 17:06:56 -0400
In-Reply-To: <536C860E.1000501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, May 9, 2014 at 9:38 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 30/04/14 02:52, Tony Lindgren wrote:
>> Otherwise we can get often errors like the following and the
>> display won't come on:
>>
>> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
>> omapdss APPLY error: SYNC_LOST on channel lcd, restarting
>> the output with video overlays disabled
>>
>> There are some earlier references to this issue:
>>
>> http://www.spinics.net/lists/linux-omap/msg59511.html
>> http://www.spinics.net/lists/linux-omap/msg59724.html
>
resend - my client had HTML enabled...

FWIW: I have had issues long time ago [1]. With mainline 3.14.3 I had
still the reboot problem on old 600MHz OMAP 3530. Applying this patch
solved the issues. For other versions I had no chance to reproduce the
original wakup issue mentioned in old thread

[1] http://marc.info/?l=linux-omap&m=136250904607413&w=2

Andreas
> Those don't sound like the same issue, but it's hard to say. What kind
> of clock rates do you get? Cat you paste debugfs/omapdss/clk, with and
> without this patch?
>
> What resolution do you have? If it's a very high resolution (say, DVI
> output to a monitor), it could just be an issue of
> not-enough-memory-bandwidth.
>
>> It seems that it's safe to set the lower values even for 3630.
>> If we can confirm that 3630 works with the higher values
>> reliably we can add further detection.
>>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>  drivers/video/fbdev/omap2/dss/dss.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
>> index d55266c..ad6561f 100644
>> --- a/drivers/video/fbdev/omap2/dss/dss.c
>> +++ b/drivers/video/fbdev/omap2/dss/dss.c
>> @@ -707,9 +707,10 @@ static const struct dss_features omap34xx_dss_feats __initconst = {
>>       .dpi_select_source      =       &dss_dpi_select_source_omap2_omap3,
>>  };
>>
>> +/* Supposedly 3630 can use div 32 mult 2, but that needs to be rechecked */
>>  static const struct dss_features omap3630_dss_feats __initconst = {
>> -     .fck_div_max            =       32,
>> -     .dss_fck_multiplier     =       1,
>> +     .fck_div_max            =       16,
>> +     .dss_fck_multiplier     =       2,
>
> These values tell about the clock hardware, they are not settings that
> can be changed to change the clock. OMAP3630 has a fixed x2 multiplier
> and a divider with maximum value of 16.
>
>  Tomi
>
>
