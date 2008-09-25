From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/4] i2c: clean =?UTF-8?Q?add=5Fchildren=20a=20bit?=
Date: Thu, 25 Sep 2008 17:08:52 -0500
Message-ID: <1159ad0a30debc102abd8b29586ce5bf@felipebalbi.com>
References: <1222354133-12919-1-git-send-email-felipe.balbi@nokia.com> <1222354133-12919-2-git-send-email-felipe.balbi@nokia.com> <200809251028.00242.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39894 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbYIYWI5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 18:08:57 -0400
In-Reply-To: <200809251028.00242.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi Dave,

On Thu, 25 Sep 2008 10:28:00 -0700, David Brownell <david-b@pacbell.net>
wrote:
> On Thursday 25 September 2008, Felipe Balbi wrote:
>> Clean up add_children a bit before adding more children
>> to twl4030-core.c
>>
>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> ACK, except for:
> 
>> --- a/include/linux/i2c/twl4030.h
>> +++ b/include/linux/i2c/twl4030.h
>> @@ -145,4 +145,10 @@ int twl4030_free_gpio(int gpio);
>>  	static inline int twl4030charger_usb_en(int enable) { return 0; }
>>  #endif
>>
>> +#if defined(CONFIG_RTC_DRV_TWL4030) ||
> defined(CONFIG_RTC_DRV_TWL4030_MODULE)
>> +#define twl_has_rtc()	(1)
>> +#else
>> +#define twl_has_rtc()	(0)
>> +#endif
> 
> Who else would need this, other than the core?
> I think the answer is "nobody" ... so these macros
> belong in the core itself, not a public header.
> 
> Also:  parens not appropriate around those values; and
> "true" and "false" values would be a bit more clear...

you sure got a point here, I'll update the series when
I get to work tomorrow (actualy today, already 1am).

Anyways, I'll update and resend the series.

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

