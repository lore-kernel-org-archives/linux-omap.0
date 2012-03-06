From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH] omap3_beagle: Init only uart3 used for console
Date: Tue, 6 Mar 2012 14:46:18 +0530
Message-ID: <CAMrsUdKAS7i1KiqU8pS7Dvt1j8uE7C-R4t=TyzxGkT3rbt6oag@mail.gmail.com>
References: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
 <87399mkecv.fsf@ti.com> <20120305205149.GS12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:59003 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751953Ab2CFJQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 04:16:39 -0500
Received: by mail-tul01m020-f181.google.com with SMTP id eq6so6106325obc.12
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 01:16:39 -0800 (PST)
In-Reply-To: <20120305205149.GS12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org

On Tue, Mar 6, 2012 at 2:21 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Kevin Hilman <khilman@ti.com> [120305 11:28]:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>> > From: "Govindraj.R" <govindraj.raja@ti.com>
>> >
>> > On beagle some of uart mux lines are used for other
>> > purpose so init only uart3.
>>
>> OK, but you should also be clear that this patch is effectively
>> disabling all UARTS (except UART3) by defatul, which I'm not sure all
>> Beagle users will be happy about.
>>
>> > Uart2 rx line clashes with gpio_147 used for usb ehci
>> > phy reset. Initializing uart2 pad_mux lines can break
>> > ehci module on beagle xm.
>> > (gpio_147 is available on uart2_rx in mode4 reference
>> > mux34xx.c -> uart2_rx.gpio_147)
>>
>> As Koen mentioned, this conflict only exists on certain boards, so
>> you should be clear that this is just an example.
>
> OK, thanks for the comments. Also it's a bit clear if
> this really is safe to do on all beagles.

I have clarified the same in reply to "Kevin Hilman" and "Koen Kooi"
in the same thread.

>
>> > Cc: Tony Lindgren <tony@atomide.com>
>> > Cc: Kevin Hilman <khilman@ti.com>
>> > Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> > Tested-by: Robert Nelson <robertcnelson@gmail.com>
>> > Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>
>> [...]
>>
>> > +
>> > +static inline void board_serial_init(void)
>>
>> Should be __init
>>
>> [...]
>>
>> > +static inline void board_serial_init(void)
>>
>> here too.
>
> ..so dropping the patch for now until these are fixed
> and we have some tested-bys for non-xm beagles too.
>

Okay fine, I have new version of the patch
"[PATCH] omap3_beagle: init uart2 for beagle rev AX/BX only"

This patch shouldn't have any impact and should work on beagles.

--
Thanks,
Govindraj.R
