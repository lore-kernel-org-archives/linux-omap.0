From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for automode
Date: Mon, 2 Dec 2013 01:02:40 +0100
Message-ID: <CAOf5uwnkQwkS7_fsLtC5nzdXyS1Rzw2SkxaziUuJrO9SKXh3yw@mail.gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
	<1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
	<CAOf5uwkrep0PhOn67+9PHmP2A2Jxrp9DNK3BRp9D_sYu_PYvvw@mail.gmail.com>
	<201311242001.23126@pali>
	<CAOf5uw=-cy2QoDxjecxYTYsrQRD=LtN0N7DcYJHZ6HSbexzPRw@mail.gmail.com>
	<20131201223730.GD6271@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:64243 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab3LBACm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Dec 2013 19:02:42 -0500
Received: by mail-wi0-f171.google.com with SMTP id ca18so4020352wib.4
        for <linux-omap@vger.kernel.org>; Sun, 01 Dec 2013 16:02:40 -0800 (PST)
In-Reply-To: <20131201223730.GD6271@lizard>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>
Cc: =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz

Hi Anton

On Sun, Dec 1, 2013 at 11:37 PM, Anton Vorontsov <anton@enomsg.org> wrote:
> On Mon, Nov 25, 2013 at 08:16:34PM +0100, Michael Trimarchi wrote:
> ...
>> >> So you can read this value without any type of synchronization
>> >> with the power_supply_core
>> >> and sysfs implementation?
> ...
>> https://lists.ubuntu.com/archives/kernel-team/2013-January/025206.html
>>
>> I found and equivalent scenario that I was trying to said
>
> That's a good question, actually. Even though in Pali's case the notifier
> is atomic (so that we are pretty confident that the object won't be
> unregistered), there is still a possiblity of a dead lock, for example. So

So if the get_property is a sleeping function it will be a deadlock. Right?

Michael

> notifiers should be careful to not hold any locks, because the other
> driver might call get_property(), which might acquire locks.
>
> Thanks,
>
> Anton
