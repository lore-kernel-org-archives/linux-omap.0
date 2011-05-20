From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC PATCH 06/10] OMAP: GPIO: Use USHRT_MAX for rev offset
 instead of -1
Date: Fri, 20 May 2011 14:01:44 +0530
Message-ID: <BANLkTikpDZBj9vGOfARpx=uowA5QR7zpxg@mail.gmail.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
 <1305546104-1511-7-git-send-email-tarun.kanti@ti.com> <87ei3u8yvr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:34666 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934559Ab1ETIcZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 04:32:25 -0400
Received: by iwn33 with SMTP id 33so3791076iwn.41
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 01:32:24 -0700 (PDT)
In-Reply-To: <87ei3u8yvr.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Kevin,

On Thu, May 19, 2011 at 21:29, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> Use USHRT_MAX for revision offset instead of -1 if revision register
>> is not available for a given SoC since rev offset is a u16 value.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>
> Thanks, folded this into the original.

I could not figure out this change in the repo. Please update.

-V Charulatha

>
> Kevin
>
>> ---
