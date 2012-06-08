From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: suspend broken on 3.5-rc1?
Date: Fri, 08 Jun 2012 17:55:09 +0530
Message-ID: <4FD1EF25.3060906@ti.com>
References: <4FD1D570.1010508@ti.com> <20120608105611.GO12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:44475 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754479Ab2FHMa0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 08:30:26 -0400
Received: by obceq6 with SMTP id eq6so3353412obc.37
        for <linux-omap@vger.kernel.org>; Fri, 08 Jun 2012 05:30:25 -0700 (PDT)
In-Reply-To: <20120608105611.GO12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: loml <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Tero Kristo <t-kristo@ti.com>

On Friday 08 June 2012 04:26 PM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [120608 03:40]:
>> Hi,
>>
>> I don;t seem to be able to get suspend to work on 3.5-rc1 on
>> my 4430 panda. I am not sure if its UART wakeups that are
>> an issue or suspend itself is broken.
>> Is there anything more than setting
>> '/sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup'
>> to 'enabled' that I need to do to get UART to be wakeup capable?
>>
>> 3.4 major works just fine for me.
>
> Can you try with the fixes branch that Olof just merged?

I tried merging the fixes branch on 3.5-rc1 as well as latest
mainline and both didn't work.

> If it's the UART wake-up events, there's a patch that should
> help.
>
> Tony

