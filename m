From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: Use enable_off_mode variable instead of
	dsp_test_sleepstate
Date: Wed, 27 Jan 2010 23:00:06 +0200
Message-ID: <94a0d4531001271300r6146c282tc9d3b727f91434ac@mail.gmail.com>
References: <1264241986-29071-1-git-send-email-felipe.contreras@gmail.com>
	 <1264241986-29071-2-git-send-email-felipe.contreras@gmail.com>
	 <4B5F6B51.6050607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f186.google.com ([209.85.223.186]:46896 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472Ab0A0VAH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 16:00:07 -0500
Received: by iwn16 with SMTP id 16so549748iwn.5
        for <linux-omap@vger.kernel.org>; Wed, 27 Jan 2010 13:00:06 -0800 (PST)
In-Reply-To: <4B5F6B51.6050607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jouni Hogander <jouni.hogander@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

On Wed, Jan 27, 2010 at 12:23 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> Hi,
>
> On 1/23/2010 4:19 AM, Felipe Contreras wrote:
>>
>> From: Jouni Hogander<jouni.hogander@nokia.com>
>>
>> Signed-off-by: Jouni Hogander<jouni.hogander@nokia.com>
>> Signed-off-by: Hiroshi DOYU<Hiroshi.DOYU@nokia.com>
>
> This patch is missing to export enable_off_mode otherwise it will fail while
> linking.
>
> FTR, I don't like to be exporting symbols of other subsystems, guess the
> same applies to:

I don't know, I was just making sure this patch wasn't lost.

But to me, it looks like a hint that perhaps
drivers/dsp/bridge/wmd/tiomap3430_pwr.c
should move to:
arch/arm/mach-omap2/dspbridge.c

Then you could #include "pm.h", just like in
arch/arm/mach-omap2/serial.c

-- 
Felipe Contreras
