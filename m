From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Tue, 15 Nov 2011 10:03:33 +0530
Message-ID: <4EC1EB9D.1000503@ti.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com> <1321274409-24643-2-git-send-email-rnayak@ti.com> <20111114172312.GI31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35017 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751504Ab1KOEdl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Nov 2011 23:33:41 -0500
Received: by mail-vw0-f52.google.com with SMTP id 42so158990vwm.11
        for <linux-omap@vger.kernel.org>; Mon, 14 Nov 2011 20:33:39 -0800 (PST)
In-Reply-To: <20111114172312.GI31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linus.walleij@stericsson.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

On Monday 14 November 2011 10:53 PM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [111114 04:05]:
>> >  --- /dev/null
>> >  +++ b/drivers/pinctrl/pinmux-omap.c
>> >  @@ -0,0 +1,735 @@
>> >  +
>> >  +/* omap4 core pads */
>> >  +static const struct pinctrl_pin_desc omap4_core_pads[] = {
>> >  +	PINCTRL_PIN(0, "c12"),
>> >  +	PINCTRL_PIN(1, "d12"),
>> >  +	PINCTRL_PIN(2, "c13"),
> ...
>
> Let's not even plan on adding this data here. We already have
> about 6000 lines of pinmux data for omaps even without this patch.
>
> Instead, just write something as a separate patch that populates
> omap pinmux data from the existing data until we have the data
> coming from DT.
>
But the plan is to get rid of those 6000 lines of pinmux data that
exists today for OMAP. I did not remove it now, because I still need
to take care of the pull up/down configurations which are missing.
Once thats in place, we can get rid of the existing data completely.

Linus,
Is there a plan to move even the data that exists in the pinmux
drivers today (including the function/pin-groups definition)
eventually to DT? Or is it just the 'mapping' data to map
devices to functions (that today is done from board files) which
alone will be moved?

regards,
Rajendra
