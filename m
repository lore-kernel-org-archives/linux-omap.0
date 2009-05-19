From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/11] OMAP2/3: PM: push core PM code from linux-omap
Date: Tue, 19 May 2009 07:57:26 -0700
Message-ID: <87fxf187jd.fsf@deeprootsystems.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
	<20090518133241.GH3067@n2100.arm.linux.org.uk>
	<87my9a8hxf.fsf@deeprootsystems.com>
	<20090518170656.GJ7042@n2100.arm.linux.org.uk>
	<87k54e721w.fsf@deeprootsystems.com> <4A124875.1080503@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f202.google.com ([209.85.222.202]:60680 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbZESO51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 10:57:27 -0400
Received: by pzk40 with SMTP id 40so252079pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 07:57:29 -0700 (PDT)
In-Reply-To: <4A124875.1080503@nokia.com> (Artem Bityutskiy's message of "Tue\, 19 May 2009 08\:49\:41 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem.Bityutskiy@nokia.com
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Richard Woodruff <r-woodruff2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>

Artem Bityutskiy <Artem.Bityutskiy@nokia.com> writes:

> Kevin Hilman wrote:
>>> The problem here is that such an interface is extremely fragile.  Consider
>>> what happens if a program disables HLT, and then gets killed off for some
>>> reason.  How does this reference get balanced again?
>>>
>>> I think a better solution would be a char device driver which has to be
>>> kept open as long as a reference is held.  When userspace closes it (be
>>> that because the program has exited, been killed, etc) you can drop any
>>> pending references.
>>
>> OK, this interface is not intended for users/applications. It is
>> intended only for OMAP PM developers who are developing the PM code
>> and want to prevent idle for various reasons during development.  It
>> is not intended for productions systems.
>>
>> What about leaving /sys/power/sleep_while_idle but only if
>> CONFIG_PM_DEBUG=y?
>
> Sounds like debugfs is the good place for this then.
>

Sound OK to me.

Kevin
