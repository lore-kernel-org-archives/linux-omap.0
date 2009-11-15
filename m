From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] [OMAP7XX] Add missing clocks for MMC
Date: Sat, 14 Nov 2009 19:13:44 -0800
Message-ID: <6cb013310911141913p5d1a7789g7b56625095408971@mail.gmail.com>
References: <6cb013310910031458x666606cagdd1c5f9d4fb26dac@mail.gmail.com>
	<20091111003615.GH23952@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:56160 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbZKODN6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Nov 2009 22:13:58 -0500
Received: by pwi3 with SMTP id 3so2680581pwi.21
        for <linux-omap@vger.kernel.org>; Sat, 14 Nov 2009 19:14:04 -0800 (PST)
In-Reply-To: <20091111003615.GH23952@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, Nov 10, 2009 at 4:36 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Cory Maccarrone <darkstar6262@gmail.com> [091003 15:09]:
>> The omap730 and omap850 both use a different clock for the "fck"
>> clock of the MMC interface than other omap processors based on the
>> SOFT_REQ_REG, pin 12. =C2=A0The "ick" clock is the same as that used
>> by other omap processors.
>>
>> * Added the missing clock definition as mmc3_ck to clock.h
>> * Added the clock definition to omap_clks in clock.c
>> * Added CK_7XX to the mmci-omap.0 "ick" clock already in clock.c
>>
>> With this change, it is now possible to initialize and use MMC
>> cards with omap730 and omap850 devices.
>
> Pushing all the 7xx mmc platform init code as a single patch to
> for-next today. Can you please check?
>
> The drivers/mmc/host/omap.c patch you need to get merged via
> linux-mmc@vger.kernel.org list :)
>
> Tony
>

MMC code is good.  With the additions of the omap.c patch and board
support, MMC works beautifully.

I'll go ahead and repost that patch to linux-mmc, thanks for the tip.

Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
