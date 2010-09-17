From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5 4/6] OMAP4: hwmod data: Add watchdog timer
Date: Fri, 17 Sep 2010 08:18:32 -0700
Message-ID: <877hik1jqv.fsf@deeprootsystems.com>
References: <1284528403-6494-1-git-send-email-charu@ti.com>
	<1284528403-6494-5-git-send-email-charu@ti.com>
	<4C91382F.1060505@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD307BEA@dbde02.ent.ti.com>
	<4C933B1F.2040100@ti.com> <8762y44f8d.fsf@deeprootsystems.com>
	<4C937C52.60300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39096 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab0IQPSo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 11:18:44 -0400
In-Reply-To: <4C937C52.60300@ti.com> (Benoit Cousson's message of "Fri, 17 Sep
	2010 16:33:54 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Cousson, Benoit" <b-cousson@ti.com> writes:

[...]

>>>>
>>>> As you mentioned, wd_timer3 in OMAP4 is an IVA3 watchdog timer.
>>>>
>>>> Also the current watchdog driver (omap_wdt.c) does not support more
>>>> than one watchdog timer. To add this support we need to first
>>>> redesign the driver code and then add wd_timer3 to the database.
>>>>
>>>> This patch series is intended to make watchdog driver to use
>>>> omap_hwmod APIs and PM runtime APIs. Driver modification to support
>>>> more than one watchdog timers can be taken up as a separate
>>>> activity later.
>>>
>>> No necessarily, even if you do not manage this watchdog, we do need to
>>> expose its hwmod in order to allow dspbridge/syslink to potentially
>>> enable or disable it.
>>
>> We also should expose it in the hwmod db so that it is initialized and
>> properly reset on init.
>
> Correct, so you do recommend to expose most hwmods as soon as they are
> not crashing at boot?  So far, the plan was to add only the ones
> validated with the drivers.

I think all hwmods for a given class should be posted at the same time.

If they are not validated with the driver, that is fine and the reason
should be clearly stated in the changelog.

Kevin
