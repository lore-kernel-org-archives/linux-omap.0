From: Kevin Hilman <khilman@linaro.org>
Subject: Re: next boot: 34 pass, 5 fail (next-20140122)
Date: Wed, 5 Feb 2014 07:23:14 -0800
Message-ID: <CAGa+x86d4BbefALJhY2c=kMFmpJ+SLGu2ibfwuZxStCzXm65Uw@mail.gmail.com>
References: <52e06652.c103450a.79d7.6517@mx.google.com>
	<CAGa+x86=gKh11g1pzLqxdimeCxuZ478+ZAxd9GjO-m7Aa8L2fg@mail.gmail.com>
	<52E0B569.8000809@ti.com>
	<52E0CF58.5040109@epfl.ch>
	<52E0DA13.9090302@ti.com>
	<52E0DD9F.8000100@epfl.ch>
	<20140124181155.GC25488@atomide.com>
	<52E2AD49.9060301@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:62137 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaBEPXP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Feb 2014 10:23:15 -0500
Received: by mail-qa0-f53.google.com with SMTP id cm18so726660qab.12
        for <linux-omap@vger.kernel.org>; Wed, 05 Feb 2014 07:23:14 -0800 (PST)
In-Reply-To: <52E2AD49.9060301@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, kernel-build-reports@lists.linaro.org, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Ash Charles <ash@gumstix.com>

On Fri, Jan 24, 2014 at 10:13 AM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:
> Hi,
>
> On 01/24/2014 07:11 PM, Tony Lindgren wrote:
>> * Florian Vaussard <florian.vaussard@epfl.ch> [140123 01:17]:
>>>
>>> I just tested next-20140123 with an OMAP3630 ES1.2 Overo/Tobi. Changing
>>> the include to omap36xx.dtsi do not fix the issue. I still get the
>>> external abort on non-linefetch (full log here [1]).
>>
>> I think the issue here is that you need to have "ti,omap36xx" in
>> the compatible string in addition to including omap36xx.dtsi.
>> Otherwise "ti,omap3" will initialize things for 34xx.
>>
>> For the initial minimal fix, I suggest we do something like the
>> following. This should fix things for 36xx based tobi, then
>> 34xx based tobi support can be added later on. Untested as I
>> don't have one.
>>
>
> You are probably right. I will test Monday.

Any progress on this?

We still have the 36xx Tobi boards failing basic boot tests -next, but
now also in mainline.

Kevin
