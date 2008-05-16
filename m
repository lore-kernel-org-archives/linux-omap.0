From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC PATCH 1/5] USB: MUSB: Switch to =?UTF-8?Q?a=5Fidle=20when=20micr?=
 =?UTF-8?Q?o/mini-a=20cable=20is=20attached?=
Date: Fri, 16 May 2008 13:33:16 -0500
Message-ID: <6a33dfd999477caafba5330f53cb8716@felipebalbi.com>
References: <1210681796-1984-1-git-send-email-felipe.balbi@nokia.com> <1210681796-1984-2-git-send-email-felipe.balbi@nokia.com> <20080516173843.GK23002@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47488 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbYEPSdW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 14:33:22 -0400
In-Reply-To: <20080516173843.GK23002@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org



On Fri, 16 May 2008 10:38:43 -0700, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [080513 05:33]:
>> From: ext Felipe Balbi <felipe.balbi@nokia.com>
>>
>> This is mostly cosmetic but can help us in the future
>> making musb driver not insertion-based.
>>
>> I mean, whenever we attach micro-/mini-A connector to
>> musb-based devices, we instantaneously turn vbus on where
>> we should wait until we need to use the bus.
> 
> This would break standard host behavious of basic USB devices that
> don't support SRP?

Hmm... the way it is today yeah, but I can keep the behaviour
that we try to turn vbus on whenever we attach micro/mini-a. But
I was thinking on letting a file manager (or any other application
that would use usb) to turn vbus on.

If it's a mass storage device, you could let file manager write
to session sysfs entry (which I'm changing to make it work on
both roles).

> 
> Tony
> 
>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>> ---
>>  drivers/usb/musb/tusb6010.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
>> index 1f3643b..9f92cef 100644
>> --- a/drivers/usb/musb/tusb6010.c
>> +++ b/drivers/usb/musb/tusb6010.c
>> @@ -673,6 +673,8 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void
> __iomem *tbase)
>>  			default_a = is_host_enabled(musb);
>>  		DBG(2, "Default-%c\n", default_a ? 'A' : 'B');
>>  		musb->xceiv.default_a = default_a;
>> +		musb->xceiv.state = default_a ? OTG_STATE_A_IDLE
>> +			: OTG_STATE_B_IDLE;
>>  		tusb_source_power(musb, default_a);
>>
>>  		/* Don't allow idling immediately */
>> --
>> 1.5.5.1.125.gc697a
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

