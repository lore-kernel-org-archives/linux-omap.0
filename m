From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 06/10] OMAP: GPIO: Use USHRT_MAX for rev offset instead of -1
Date: Fri, 20 May 2011 11:30:15 +0200
Message-ID: <87r57t67o8.fsf@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
	<1305546104-1511-7-git-send-email-tarun.kanti@ti.com>
	<87ei3u8yvr.fsf@ti.com>
	<BANLkTikpDZBj9vGOfARpx=uowA5QR7zpxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:33389 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753389Ab1ETJaW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 05:30:22 -0400
Received: by mail-ww0-f46.google.com with SMTP id 28so2863925wwb.27
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 02:30:21 -0700 (PDT)
In-Reply-To: <BANLkTikpDZBj9vGOfARpx=uowA5QR7zpxg@mail.gmail.com> (Charulatha
	Varadarajan's message of "Fri, 20 May 2011 14:01:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Kevin,
>
> On Thu, May 19, 2011 at 21:29, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>
>>> From: Charulatha V <charu@ti.com>
>>>
>>> Use USHRT_MAX for revision offset instead of -1 if revision register
>>> is not available for a given SoC since rev offset is a u16 value.
>>>
>>> Signed-off-by: Charulatha V <charu@ti.com>
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Cc: Kevin Hilman <khilman@ti.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>
>> Thanks, folded this into the original.
>
> I could not figure out this change in the repo. Please update.

You're right, I didn't push the update.

Just pushed now (may take some time to get out to kernel.org mirrors.)

Kevin
