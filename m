From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
Date: Sat, 24 Sep 2011 14:20:19 +0530
Message-ID: <4E7D99CB.7090004@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>	<87mxdwm8pk.fsf@ti.com> <CAC83ZvKu5Fo-c88L4WFPdvq91T=usaZY4mzTVVzDLw9HE7g9Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:58275 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751161Ab1IXIu0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 04:50:26 -0400
Received: by gwj20 with SMTP id 20so4261659gwj.12
        for <linux-omap@vger.kernel.org>; Sat, 24 Sep 2011 01:50:25 -0700 (PDT)
In-Reply-To: <CAC83ZvKu5Fo-c88L4WFPdvq91T=usaZY4mzTVVzDLw9HE7g9Kg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, charu@ti.com

On Saturday 24 September 2011 09:26 AM, DebBarma, Tarun Kanti wrote:
> [...]
>> After debugging this myself a bit, here's what I think may be going on.
>> This may not be the only problem but here's at least one of them.
>>
>> First, debounce clocks are disabled in the runtime_suspend callback.
>>
>> When a GPIO is freed and it's the last one in the bank, bank->mod_usage
>> goes to zero.
>>
>> After that, pm_runtime_put_sync() is called, which will trigger the
>> driver's ->runtime_suspend callback.  The ->runtime_suspend() callback
>> checks bank->mod_usage as well, and if zero, doesn't do anything
>> (notably, it doesn't disable debounce clocks.)
> I need some clarification in reproducing/testing the fix on OMAP3430SDP.
> The first thing I am trying to verify is the code flow of suspend.
> 
> 1) With no debounce clock enabled, when I enable UART timeouts, I
> automatically see
> system going to retention. That is I don't have to type echo mem >
> /sys/power/state
> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
> 
> 2) I am do not see the print in omap_gpio_suspend/resume(), but I see
> the print in
> *_prepare_for_idle()/*_resume_after_idle().
> 
Hmmm,

This is mostly happening because you are missing a below
fix from Kevin in the branch you are testing with.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg54927.html
{OMAP: omap_device: fix !CONFIG_SUSPEND case in _noirq handlers}

If you rebase, your branch against 3.1-rc6, you should already
have this fix. Commit {126caf1376e7}

Regards
Santosh
