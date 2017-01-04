From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] pinctrl: Introduce TI IOdelay configuration driver
Date: Wed, 4 Jan 2017 10:51:52 -0600
Message-ID: <4b102eed-b795-3b07-179d-7f5cda53d46f@ti.com>
References: <20161230183732.5595-1-tony@atomide.com>
 <20161230183732.5595-3-tony@atomide.com> <20170102221228.GH9325@atomide.com>
 <63a8a1ec-343a-8c96-a0d2-21d81f7ad10e@ti.com>
 <20170104160511.GF25222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170104160511.GF25222-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gary Bisson <gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 01/04/2017 10:05 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [170104 07:39]:
>> On 01/02/2017 04:12 PM, Tony Lindgren wrote:
>> [...]
>> Minor one:
>>> + * Copyright (C) 2015 Texas Instruments, Inc.
>> Could you make this:
>>  Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
>
> Sure, it's your patch :) Will repost.
Thanks.

I just finished testing it as well and well it still does the job it 
used to do. thanks for taking this forward.

I did get a few kernel-doc warnings, which i need to look closer at. 
will comment back today if I see something of use for us to fix up.


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
