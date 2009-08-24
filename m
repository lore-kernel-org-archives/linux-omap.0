From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP: remove OMAP_TAG_UART
Date: Mon, 24 Aug 2009 15:57:57 +0300
Message-ID: <87hbvxpdwq.fsf@deeprootsystems.com>
References: <20090807051516.4787.36125.stgit@tikku>
	<20090807051650.4787.84433.stgit@tikku>
	<87k50tslp1.fsf@deeprootsystems.com>
	<6ed0b2680908240554m7e7b7fc3m95ec28d7223cb85e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:40200 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbZHXM6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 08:58:00 -0400
Received: by fxm17 with SMTP id 17so1431171fxm.37
        for <linux-omap@vger.kernel.org>; Mon, 24 Aug 2009 05:58:01 -0700 (PDT)
In-Reply-To: <6ed0b2680908240554m7e7b7fc3m95ec28d7223cb85e@mail.gmail.com> (Grazvydas Ignotas's message of "Mon\, 24 Aug 2009 15\:54\:02 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Kalle Valo <kalle.valo@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Mon, Aug 24, 2009 at 10:41 AM, Kevin
> Hilman<khilman@deeprootsystems.com> wrote:
>> Kalle Valo <kalle.valo@iki.fi> writes:
>>
>>> Omap tags are deprecrated and convert all OMAP_TAG_UART cases to use
>>> omap_uart_platform_data instead.
>>>
>>> Tested on rx51 and n8x0. Compile tested on omap_osk_5912.
>>>
>>> Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
>>
>> Rather than converting all the omap_uart_configs into platform_data.
>> Any objections to just dropping the platform_data all together?
>>
>> This is only used for selecting which UARTs to enable at boot time,
>> and all the board files simply enable all the UARTs.
>
> Pandora wasn't enabling all UARTs, as did some other off-tree board
> (someone was posting UART questions on this list). This meant that
> UART3 was appearing as ttyS0 here, and after this patch it will appear
> as ttyS2, which means we will have to update our boot scripts. Not a
> huge deal but I'd prefer retaining platform_data.

I think your boot scripts should be fixed.

Your problem actually points out another justification for my patch.
Having all the UARTs enabled means that the ttyS* names will be
consistent across multiple boards and result in much more portable
userspace init.

Kevin


