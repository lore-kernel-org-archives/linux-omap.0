From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: PM: introduce power domains functional states
Date: Fri, 13 Jul 2012 09:18:49 +0200
Message-ID: <CAORVsuWvELiRj4XYGQ5WZuNbmWO_Hp8FaHHHhSjXbCPDeaigGg@mail.gmail.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
	<1339685591-11177-3-git-send-email-j-pihet@ti.com>
	<CAOMWX4cT+U2iq3e=rfBaSX5Hdn_kNEkdF0ffC33UCuEfEjdisw@mail.gmail.com>
	<4FFFB19D.2090808@ti.com>
	<CAOMWX4ctd20p2qBKyVBEE7PxXaEoExMivnE9Kcx6Om1w6U5yCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39827 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab2GMHSv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 03:18:51 -0400
Received: by lbbgm6 with SMTP id gm6so5393113lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jul 2012 00:18:49 -0700 (PDT)
In-Reply-To: <CAOMWX4ctd20p2qBKyVBEE7PxXaEoExMivnE9Kcx6Om1w6U5yCw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

Hi!

On Fri, Jul 13, 2012 at 7:29 AM, Menon, Nishanth <nm@ti.com> wrote:
> On Fri, Jul 13, 2012 at 12:26 AM, Rajendra Nayak <rnayak@ti.com> wrote:
>> On Friday 13 July 2012 08:31 AM, Menon, Nishanth wrote:
>>>
>>> my Crib about the above apis are lack of logic power state handling:(
>>> which forces code like cpuidle to use different apis for logic
>>> power state and force them to use these apis just for pwrst.
>>
>>
>> Have you looked at an alternate approach that was proposed here..
>> https://patchwork.kernel.org/patch/1160431/
>>
> Santosh pointed me to the thread offline. This is indeed a much better
> approach IMHO than having 3 conflicting options inside powerdomain
> framework.
After looking at the code and having sent my comments, I like it ...
mainly because it is really similar to my proposal ;-p
Can you elaborate more on 'having 3 conflicting options inside
powerdomain framework'?

Here are the main differences in the implementation:
- the RFC code provides a _private header file, which forces the
external users (cpuidle, pmXXXX.c etc.),
- the RFC code still uses the same function names while my code
renames them to '*_func_*'. This makes the code look more complicated
than it really is.

> Regards,
> Nishanth Menon

We are having a discussion on the best way to have the feature in. More to come!

Thanks!
Jean
