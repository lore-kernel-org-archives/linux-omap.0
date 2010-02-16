From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] OMAP3: PM: Wakeup from TWL4030 keypad with OFF mode
Date: Tue, 16 Feb 2010 16:54:01 -0600
Message-ID: <874olgkd12.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E259DEEC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:49236 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933312Ab0BPWyF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 17:54:05 -0500
Received: by ywh6 with SMTP id 6so5039271ywh.4
        for <linux-omap@vger.kernel.org>; Tue, 16 Feb 2010 14:54:04 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E259DEEC@dbde02.ent.ti.com> (Sanjeev Premi's message of "Fri\, 5 Feb 2010 13\:36\:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>> Sent: Friday, February 05, 2010 3:22 AM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 3/3] OMAP3: PM: Wakeup from TWL4030 
>> keypad with OFF mode
>> 
>> Sanjeev Premi <premi@ti.com> writes:
>> 
>> > This patch allows wakeup from TWL4030 keypad when
>> > OFF mode is hit during suspend.
>> >
>> > Tested on OMAP3EVM.
>> >
>> > Signed-off-by: Sanjeev Premi <premi@ti.com>
>> 
>> The idea here looks good, but there is nothing realy EVM specific here
>> AFAICT, and this exact code could be used on any other board using
>> the T2 keypad, right?  How about a common location?
>
> [sp] The EVM uses SYS_NIRQ for hooking up with the T2 keypad. Not
>      sure of everyone would be doing so. Also, PADCONFs are more
>      applicable for OMAP3, but T2 can be used with other processors
>      as well...
>
>      I did initially inplement these functions in:
>      drivers/input/keyboard/twl4030_keypad.c
>
>      ...but then moved to board specific file.

I know at least SDP and EVM have these hooked up identically, so some common
way to set them up would be preferred.  Maybe a mach-omap2/t2-keypad.c that
could be shared between various board files.  The board files would still
configure the IRQ line and the padconfs used.

Kevin



>> 
>> Also, after looking at this patch, I think the 'void *pstate' member
>> of struct twl4030_keypad_data should be renamed to 'void *data' to
>> be more clear that it's just a pointer.
>
> [sp] Will make the change. However, will wait for your response on the
>      earlier comment before re-submit.
>
> ~sanjeev
>
>> 
>> Kevin
>> 
>> 
>
> [snip]--[snip]
