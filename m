From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Thu, 18 Nov 2010 19:34:46 +0100
Message-ID: <AANLkTi=m1MXATmUzXNxbggoUS01AbyeGZm9WMgWUqdNo@mail.gmail.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
	<1290091906-32539-2-git-send-email-j-pihet@ti.com>
	<d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com>
	<87tyjey6h3.fsf@deeprootsystems.com>
	<4CE55A88.6010300@ti.com>
	<20101118175215.GE9264@atomide.com>
	<AANLkTi=bhULQsXhnN9ugDm7k=2P4E7-SvXEnx06pBwmu@mail.gmail.com>
	<20101118182752.GI9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36445 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760103Ab0KRSes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 13:34:48 -0500
Received: by qyk2 with SMTP id 2so1327691qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 10:34:47 -0800 (PST)
In-Reply-To: <20101118182752.GI9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, Jean Pihet-XID <j-pihet@ti.com>

On Thu, Nov 18, 2010 at 7:27 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Jean Pihet <jean.pihet@newoldbits.com> [101118 10:06]:
>> On Thu, Nov 18, 2010 at 6:52 PM, Tony Lindgren <tony@atomide.com> wrote:
>>
>> About the DPLL lock:
>> 1) wait_sdrc_ok is only called when back from the non-OFF modes,
>> 2) I checked that when running wait_sdrc_ok the CORE is already out of
>> idle and the DPLL is already locked. Note: l-o code has no support for
>> the voltages OFF and the external clocks OFF.
>>
>> What to conclude from 1) and 2)? In my test setup ot looks like
>> wait_sdrc_ok is of no use, but I agree this a premature conclusion.
>
> Yeah we should figure out in which cases wait_sdrc_ok is needed.
>
> BTW, are you sure you're hitting core idle in your tests?
Yes it is OK from the console messages and the counters values in
/debug/pm_debug/count.

Let me confirm asap with the PRCM registers dump.

>
> Regards,
>
> Tony
>

Thanks,
Jean

>
