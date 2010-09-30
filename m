From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
Date: Thu, 30 Sep 2010 07:51:45 -0700
Message-ID: <87tyl7gu7y.fsf@deeprootsystems.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com>
	<4CA45341.3080300@ti.com> <87vd5njpyq.fsf@deeprootsystems.com>
	<4CA49ADE.6080202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55055 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412Ab0I3Owd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 10:52:33 -0400
In-Reply-To: <4CA49ADE.6080202@ti.com> (Benoit Cousson's message of "Thu, 30
	Sep 2010 16:12:46 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "Menon, Nishanth" <nm@ti.com>, "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 9/30/2010 3:55 PM, Kevin Hilman wrote:
>> "Cousson, Benoit"<b-cousson@ti.com>  writes:
>>
>>> Hi Charu,
>>>
>>> On 9/30/2010 10:11 AM, Varadarajan, Charulatha wrote:
>>>> With OMAP2PLUS watchdog implemented in hwmod fw way, the
>>>> module is reset during init.
>>>
>>> In that case hwmod fw just highlighted the real behavior that was
>>> hidden so far by the X-loader.
>>>
>>> You should as well add a link to the email thread with Kevin that
>>> raised the issue.
>>>
>>>> After a watchdog timer module reset, the WDTs are enabled. The
>>>> default time for a system reset after a watchdog module reset
>>>> is ~10s as per the default value of the WDT registers. Hence
>>>> the system would be reset after 10s, if watchdog is not disabled
>>>> within 10s.
>>>>
>>>> This patch fixes the above issue by disabling the watchdog timer
>>>> after reset during initialization of devices.
>>>
>>> I'm still wondering as well what is the expected behavior of the
>>> watchdog in a real product. If it is started by default at boot time,
>>> this is probably for a good reason (or maybe not...).
>>>
>>> So, disabling it all the time is maybe not the best solution.
>>
>> I'm not sure what the other options are.  If you don't have a watchdog
>> driver, and the watchdog is armed, it will reboot the system.
>>
>> The approach in this patch is just to continue the behavior that all
>> bootloaders currently do, but make it explicit in the kernel.
>
> Yes, because we are not a building a product, and for us watchdog is a
> pain. But I'm not sure that a real product will disable that at all
> during the boot process.

Maybe not.  But wouldn't a product just ensure the real watchdog
driver is loaded?

Or more likely, in addition to the hundreds of other out-of-tree
patches, they would just remove $SUBJECT patch.  ;)

> I think that disabling it should be done only if the CONFIG_OMAP_WDT
> is not set.

That's not easy either, as the watchdog driver can be built as a module,
and may (or may not) be loaded some unknown time from the kernel boot,
resulting in a likely

Kevin

> But since I don't have a clue about a product can use that, it will be
> good to have such inputs to understand the usecase.




