From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt
 for AM33XX
Date: Sat, 03 Nov 2012 13:04:30 +0000
Message-ID: <5095165E.10403@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com> <5095037A.2020503@deeprootsystems.com> <B5906170F1614E41A8A28DE3B8D121433EBFEA0E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51063 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932534Ab2KCNEb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 09:04:31 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1969274wib.1
        for <linux-omap@vger.kernel.org>; Sat, 03 Nov 2012 06:04:29 -0700 (PDT)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EBFEA0E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

T
On 11/03/2012 12:47 PM, Bedia, Vaibhav wrote:
> Hi Kevin,
>
> On Sat, Nov 03, 2012 at 17:13:54, Kevin Hilman wrote:
>> On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
>>> AM33XX has only one usable timer in the WKUP domain.
>>> Currently the timer instance in WKUP domain is used
>>> as the clockevent and the timer in non-WKUP domain
>>> as the clocksource. The timer in WKUP domain can keep
>>> running in suspend from a 32K clock and hence serve
>>> as the persistent clock. To enable this, interchange
>>> the timers used as clocksource and clockevent for
>>> AM33XX.
>>
>> Doesn't this also mean that you won't get timer wakeups
>> in idle?  Or are you keeping the domain where the clockevent is
>> on during idle?
>>
>
> The lowest idle state that we are targeting will have MPU powered
> off with external memory in self-refresh mode. Peripheral domain
> with the clockevent will be kept on.

Is this a limitation of the hardware?  or the software?

Kevin

P.S.  I haven't yet made my way through the TRM, so I'll probably figure
this out when I read it, but having this summarized in the changelog would
be helpful since even after I read the TRM, I'll forget.  I'm saving the 
TRM
reading for entertainment on upcoming flight home from Linaro Connect.
