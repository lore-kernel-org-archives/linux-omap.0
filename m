From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/6] omap3: pm: re-program the sleep state of TRITON resources by modifying the REMAP register
Date: Thu, 21 Jan 2010 16:10:48 -0800
Message-ID: <87ljfrdmnr.fsf@deeprootsystems.com>
References: <1263922501-13701-1-git-send-email-x0080970@ti.com>
	<4B572121.50402@compulab.co.il>
	<020501ca9a60$71a2e800$LocalHost@wipultra1385>
	<4B58E397.4080506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f172.google.com ([209.85.222.172]:61607 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242Ab0AVAKw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 19:10:52 -0500
Received: by pzk2 with SMTP id 2so439747pzk.21
        for <linux-omap@vger.kernel.org>; Thu, 21 Jan 2010 16:10:50 -0800 (PST)
In-Reply-To: <4B58E397.4080506@ti.com> (Mike Turquette's message of "Thu\, 21 Jan 2010 17\:30\:31 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: Lesly AM <x0080970@ti.com>, Mike Rapoport <mike@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Derrick, David" <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Mike Turquette <mturquette@ti.com> writes:

> Lesly AM wrote:

[...]

>> From: "Mike Rapoport" <mike@compulab.co.il>

[...]

>>>
>>> Is it necessary to initialize the remap sleep twice?
>>>
>>
>> No.
>> Sorry..  I didn't notice that Amit has already pushed this.
>
> The existing remap programming does have a bug in it.  Lesly, try
> adding the following to this patch:

And this fix should be sent as a separate patch to Samuel and queued
as a fix for 2.6.33.

Kevin
