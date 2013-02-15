From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/RFT PATCH 2/2] SERIAL: OMAP: Remove the idle handling from
 the driver
Date: Fri, 15 Feb 2013 19:13:42 +0530
Message-ID: <511E3B8E.20806@ti.com>
References: <1360930135-32092-1-git-send-email-santosh.shilimkar@ti.com> <20130215125740.GB16558@arwen.pp.htv.fi> <511E35D8.1030109@ti.com> <20130215133439.GF16558@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34182 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161511Ab3BONmd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 08:42:33 -0500
In-Reply-To: <20130215133439.GF16558@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Rajendra nayak <rnayak@ti.com>

On Friday 15 February 2013 07:04 PM, Felipe Balbi wrote:
> Hi,
>
> On Fri, Feb 15, 2013 at 06:49:20PM +0530, Santosh Shilimkar wrote:
>>>> @@ -279,8 +259,6 @@ static void serial_omap_stop_tx(struct uart_port *port)
>>>>   		serial_out(up, UART_IER, up->ier);
>>>>   	}
>>>>
>>>> -	serial_omap_set_forceidle(up);
>>>> -
>>>>   	pm_runtime_mark_last_busy(up->dev);
>>>>   	pm_runtime_put_autosuspend(up->dev);
>>>>   }
>>>> @@ -348,7 +326,6 @@ static void serial_omap_start_tx(struct uart_port *port)
>>>>
>>>>   	pm_runtime_get_sync(up->dev);
>>>>   	serial_omap_enable_ier_thri(up);
>>>> -	serial_omap_set_noidle(up);
>>>
>>> this patch is changing behavior. Currently driver has:
>>>
>>> start_tx()
>>> get_sync()
>>> set_noidle()
>>> put_autosuspend()
>>>
>>> ....
>>>
>>> stop_tx()
>>> get_sync()
>>> set_force_idle()
>>> put_autosuspend()
>>>
>>> with this change, you will have:
>>>
>>> start_tx()
>>> get_sync()
>>> set_noidle()
>>> put_autosuspend()
>>> set_force_idle()
>>>
>>> this in itself might be enough to go back to corrupted serial if
>>> put_autosuspend is so quick that set_force_idle() is called before all
>>> data has been shifted out of FIFO and through the UART lines.
>>>
>> Really. Infact the old sequence was buggy because you are setting
>> force_idle even before suspending the device. And that force idle
>
> then that bug has to be fixed first and patch needs to be sent to stable
> before we change that part of the code, wouldn't you agree ?
>
Agree. Will be good to get that fixed for stable. Probably Sourabh
can fix that one.

>> isn't really force idle but setting ip to smart idle. Just look at
>> what serial.c
>
> indeed.
>
>>> Before doing this, you should at least test that removing
>>> pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend() from
>>> start_tx() and removing pm_runtime_get_sync() from stop_tx() works fine.
>>>
>> Seems to work for me with above changes as well. Can you please
>> try out and see if you see any issue. I doubt you will...
>
> what I'm saying is that current code, as you put it yourself, is buggy,
> so we ought to fix the bugs first before changing behavior. If not for
> anything else, at least to have a clean tree which we can bisect.
>
>>> Also, $SUBJECT isn't improving the situation regarding UART Wakeup,
>>> there is still the regression of UART never being wakeup capable.
>>>
>> You are mixing the stuff here. The subject is correct.
>
> ->enable_wakeup() sets the IP to smart_idle_wakeup, which is done on
> SYSC register. If $SUBJECT wants to fix SYSC usage, it ought to fix them
> all.
>
But SYSC is already in smart_idle_wakeup() mode. I get your point
though. The main purpose of that wakeup hook is to trigger io_ring
and pad wakeup.

BTW, Rajendra is looking at how to get rid of wakeup function pointer
as well since that also comes in way for DT.

Regards
Santosh


