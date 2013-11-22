From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: N900 board code in 3.14
Date: Fri, 22 Nov 2013 11:41:27 +0100
Message-ID: <CABxcv==b-Nj4ADT+qN9qLC8bL5raqkRkaLkGG0cMNrZV8njhDg@mail.gmail.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
	<20131116120508.GA22335@earth.universe>
	<20131116141226.GD10317@atomide.com>
	<20131116155031.GA5104@earth.universe>
	<20131121185844.GA10023@atomide.com>
	<20131121235111.GC9772@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:48128 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901Ab3KVKl2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Nov 2013 05:41:28 -0500
Received: by mail-we0-f170.google.com with SMTP id w61so959134wes.15
        for <linux-omap@vger.kernel.org>; Fri, 22 Nov 2013 02:41:27 -0800 (PST)
In-Reply-To: <20131121235111.GC9772@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Nov 22, 2013 at 12:51 AM, Sebastian Reichel <sre@ring0.de> wrote:
> Hi Tony,
>
> On Thu, Nov 21, 2013 at 10:58:45AM -0800, Tony Lindgren wrote:
>> Also, I just posted a patch to fix the eMMC that you may want to
>> try out.
>
> Let's move eMMC diskussion to that patch :)
>
>> > > > [...]
>> > > >
>> > > > My suggestion would be:
>> > > >  1. Find a better workaround for omapdss to acquire the SDI
>> > > >     regulator. My current hack is obviously not acceptable.
>> > > >  2. Load the panel driver via DT as seen above and reference
>> > > >     the omapdss interface with something like the above
>> > > >     "ti,dss-source".
>> > >
>> > > To me it seems that we should be able to add minimal panel entries to DT
>> > > if we stick to existing standard bindings. Then the timings etc can be
>> > > set up based on the compatible flag. So I would leave out the properties
>> > > for ti,sdi-datapairs and ti,dss-source for now, and just set those in
>> > > the driver based on the sony,acx565akm compatible flag. Or maybe it should
>> > > be sony,acx565akm-n900 if there's some board specific configuration info.
>> >
>> > So we add reset-gpio and label to the DT data (they are panel
>> > specific and independent of omapdss) and just hardcode "dsi.0"
>> > with 2 data lanes into the driver? That sounds fine for me.
>> >
>> > If neither Tomi nor anybody else has better ideas I will cook a
>> > patch for that. I'm not sure how to setup the vdds_sdi regulator for
>> > omapdss, though. Is there an example for a legacy driver using a DT
>> > regulator available?
>>
>> Not that I know of :)
>
> Javier Martinez Canillas patch did what I was thinking of in [0].

I dropped that patch from my series and posted a v2 that just name the
VPLL2 regulator as vdds_dsi [1]. That way will be safer for Tony and
Benoit to take this series as a fix for the -rc cycle since the
changes are contained within IGEP boards DTS.

> My suggestion would be to add something like this pseudocode to
> omapdss:
>
> if(board_is_n900_dt()) {
>     vdds_dsi = devm_regulator_get(&dpi.pdev->dev, "V28");
> }
>
> The problem is, that we do not want to name the regulator
> "vdds_dsi", since it's not used exclusivly for omapdss.
>
> In the future it can get the regulator via phandle of course.
>

For what is worth I think that your suggestion is a good workaround.
Please just add a comment specifying that it is a hack and that we
have to get rid of these once the DSS DT bindings land on mainline and
we can use a phandle to get the regulator.

>> But I guess only the panel driver would need to parse the
>> compatible flag and the rest of the DSS could still be initialize
>> the legacy way if needed.
>
> Yes, except of the regulator. I will try to get this working
> tomorrow.
>
> [0] http://www.spinics.net/lists/arm-kernel/msg286896.html
>
> -- Sebastian

[1]: http://www.spinics.net/lists/arm-kernel/msg287703.html

Best regards,
Javier
