From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: PM: introduce power domains functional states
Date: Fri, 13 Jul 2012 00:29:08 -0500
Message-ID: <CAOMWX4ctd20p2qBKyVBEE7PxXaEoExMivnE9Kcx6Om1w6U5yCw@mail.gmail.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
 <1339685591-11177-3-git-send-email-j-pihet@ti.com> <CAOMWX4cT+U2iq3e=rfBaSX5Hdn_kNEkdF0ffC33UCuEfEjdisw@mail.gmail.com>
 <4FFFB19D.2090808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:59015 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754866Ab2GMF3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 01:29:31 -0400
Received: by wgbdq11 with SMTP id dq11so2531675wgb.29
        for <linux-omap@vger.kernel.org>; Thu, 12 Jul 2012 22:29:28 -0700 (PDT)
In-Reply-To: <4FFFB19D.2090808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

On Fri, Jul 13, 2012 at 12:26 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Friday 13 July 2012 08:31 AM, Menon, Nishanth wrote:
>>
>> my Crib about the above apis are lack of logic power state handling:(
>> which forces code like cpuidle to use different apis for logic
>> power state and force them to use these apis just for pwrst.
>
>
> Have you looked at an alternate approach that was proposed here..
> https://patchwork.kernel.org/patch/1160431/
>
Santosh pointed me to the thread offline. This is indeed a much better
approach IMHO than having 3 conflicting options inside powerdomain
framework.

Regards,
Nishanth Menon
