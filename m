From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 2/2] OMAP: remove OMAP_TAG_UART
Date: Mon, 24 Aug 2009 15:54:02 +0300
Message-ID: <6ed0b2680908240554m7e7b7fc3m95ec28d7223cb85e@mail.gmail.com>
References: <20090807051516.4787.36125.stgit@tikku>
	 <20090807051650.4787.84433.stgit@tikku>
	 <87k50tslp1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34569 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbZHXMyD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 08:54:03 -0400
Received: by bwz19 with SMTP id 19so1428491bwz.37
        for <linux-omap@vger.kernel.org>; Mon, 24 Aug 2009 05:54:03 -0700 (PDT)
In-Reply-To: <87k50tslp1.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Kalle Valo <kalle.valo@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Mon, Aug 24, 2009 at 10:41 AM, Kevin
Hilman<khilman@deeprootsystems.com> wrote:
> Kalle Valo <kalle.valo@iki.fi> writes:
>
>> Omap tags are deprecrated and convert all OMAP_TAG_UART cases to use
>> omap_uart_platform_data instead.
>>
>> Tested on rx51 and n8x0. Compile tested on omap_osk_5912.
>>
>> Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
>
> Rather than converting all the omap_uart_configs into platform_data.
> Any objections to just dropping the platform_data all together?
>
> This is only used for selecting which UARTs to enable at boot time,
> and all the board files simply enable all the UARTs.

Pandora wasn't enabling all UARTs, as did some other off-tree board
(someone was posting UART questions on this list). This meant that
UART3 was appearing as ttyS0 here, and after this patch it will appear
as ttyS2, which means we will have to update our boot scripts. Not a
huge deal but I'd prefer retaining platform_data.

> Also, selective
> enable is no longer needed since UART core has an inactivity timer
> which will disable clocks after inactivity anyways.
>
> I just posted a patch which does this:
>
> =A0http://patchwork.kernel.org/patch/43516/
>
> If others are OK with this, it can be folded into original patch
> before going upstream via Tony's for-next.
>
> Kevin
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
