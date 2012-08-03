From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] ARM: OMAP3: igep0020: set GPIO mode for mux
 mcspi1_cs2 pin
Date: Fri, 3 Aug 2012 10:06:06 +0200
Message-ID: <CABxcv=kueP=UA6sQwS8Hs-s3vyAX+RhJgkHmyWWAVb668y-EOQ@mail.gmail.com>
References: <1341885452-5372-1-git-send-email-javier@dowhile0.org>
	<CAFqH_511c6CyAYnbtU0ECZwzRNwJEdTqtcZ63nODCYZU4GC0aA@mail.gmail.com>
	<CABxcv=miEavW5Qf-Y+S4Nph+ah5gQ6QDpt-T44tdHLBxcP8pqQ@mail.gmail.com>
	<20120718072052.GK6522@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:33053 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab2HCIGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 04:06:07 -0400
Received: by ghrr11 with SMTP id r11so507469ghr.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Aug 2012 01:06:07 -0700 (PDT)
In-Reply-To: <20120718072052.GK6522@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>, Tom Rini <trini@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jul 18, 2012 at 9:20 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Javier Martinez Canillas <javier@dowhile0.org> [120717 00:16]:
>>
>> Hi Tony,
>>
>> Just pinging to see if you have further comments on this patch or if
>> it can be applied. It solves a bug on IGEPv2 boards.
>>
>> I know the trend is to move away from board code. I'll start working
>> on an device tree for the IGEPv2 but it will take some time until is
>> ready (and I'm not sure if all the OMAP3 support is already present on
>> DT).
>>
>> So could you please take bug fixes for the board code in the meantime?
>
> Yes seems like something for the v3.6-rc series.
>
> Regards,
>
> Tony

Hi Tony,

I saw that Linus 3.6-rc1 has already been released and I didn't see
this patch on it.

So, this is a kindly reminder so you don't miss this patch :-)

Thanks a lot and best regards,
Javier
