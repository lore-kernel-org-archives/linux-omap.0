From: Tyler Baker <tyler.baker@linaro.org>
Subject: Re: n900 in 4.1-rc0
Date: Mon, 27 Apr 2015 11:58:06 -0700
Message-ID: <CANMBJr6x40AH586GFjAwm5-qpjefrgk4H0xhLQ3m+VwvtRUAaw@mail.gmail.com>
References: <20150416093234.GA17423@amd>
	<CANMBJr5G2RpS1sw3N8FYitqzqFu8a2Gqj__i_742FZrMYuusOA@mail.gmail.com>
	<20150426102046.GA4340@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vn0-f45.google.com ([209.85.216.45]:46450 "EHLO
	mail-vn0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964923AbbD0S6H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2015 14:58:07 -0400
Received: by vnbf62 with SMTP id f62so13200105vnb.13
        for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2015 11:58:06 -0700 (PDT)
In-Reply-To: <20150426102046.GA4340@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin's boot bot <khilman@kernel.org>, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, Kevin Hilman <khilman@linaro.org>

Hi Pavel,

On 26 April 2015 at 03:20, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > Just tried booting 4.1-rc0 on n900 (commit
>> > 34c9a0ffc75ad25b6a60f61e27c4a4b1189b8085) and it is broken.
>> >
>> > Any ideas?
>>
>> Looks like DT and legacy booting are working fine in our
>> labs. [0][1]
>
> Interesting web pages, thanks.

No problem.

>
> I noticed that legacy booting indicates broken today, but... Is there
> list of your targets somewhere?

It looks to have failed it's boot test on the stable v3.14 based LSK
today, however it is booting fine still on the upstream development
trees. You can also use a query[0] to refine your view if you would
like. The up to date list of targets can be found here[1] and if
interested in receiving email reports you can subscribe here[2].

>
> Best regards,
>                                                                         Pavel
>
>
>
>> [0] http://kernelci.org/boot/omap3-n900/
>> [1] http://kernelci.org/boot/omap3-n900,legacy/
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Cheers,

Tyler

[0] http://kernelci.org/boot/?n900&fail
[1] https://wiki.linaro.org/ProductTechnology/kernelci.org
[2] https://lists.linaro.org/mailman/listinfo/kernel-build-reports
