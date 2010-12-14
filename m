From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5 0/12] dmtimer adaptation to platform_driver
Date: Mon, 13 Dec 2010 18:09:39 -0800
Message-ID: <87k4jd2jh8.fsf@deeprootsystems.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
	<20101206162852.GA4924@manju-desktop>
	<5A47E75E594F054BAF48C5E4FC4B92AB03736F5022@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59019 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758988Ab0LNCJo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 21:09:44 -0500
Received: by iwn9 with SMTP id 9so165451iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 18:09:43 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03736F5022@dbde02.ent.ti.com>
	(Tarun Kanti DebBarma's message of "Tue, 7 Dec 2010 10:29:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

>> On Tue, Dec 07, 2010 at 05:14:07AM +0530, Tarun Kanti DebBarma wrote:
>> > dmtimer adaptation to platform_driver.
>> >
>> > This patch series is adaptation of dmtimer code to platform driver
>> > using omap_device and omap_hwmod abstraction.
>> >
>> > Tested on following platforms:
>> > OMAP4430, OMAP3430, OMAP3630, OMAP2430
>> > OMAP2420 -- Image with omap2plus_defconfig in too large to download on
>> N800.
>> 
>> How about omap1? The mainline code happily compiles and boots on osk5912
>> but this series is going to break omap1 build.
>
> I have built and booted on OMAP1 during v3. This time I could not because
> My OMAP1710 has gone bad. I am looking for one to test.
> That's precisely the reason I have not mentioned OMAP1. 

Rather than not mentioning OMAP1, you should state whether (or not) it
was tested on OMAP1.   As build/boot testing on OMAP1 is a requirement
for merge, this information is crucial.

Kevin


