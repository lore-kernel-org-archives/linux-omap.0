From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH] omap3_beagle: Init only uart3 used for console
Date: Tue, 6 Mar 2012 14:40:57 +0530
Message-ID: <CAMrsUdLWaLqSr-PCmmGxrp0qZSojr5EWAUYmuk6v2pHiVdf9kA@mail.gmail.com>
References: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com> <87399mkecv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:43612 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751173Ab2CFJLS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 04:11:18 -0500
Received: by mail-tul01m020-f177.google.com with SMTP id ta2so8276712obb.22
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 01:11:17 -0800 (PST)
In-Reply-To: <87399mkecv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Tue, Mar 6, 2012 at 1:30 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> On beagle some of uart mux lines are used for other
>> purpose so init only uart3.
>
> OK, but you should also be clear that this patch is effectively
> disabling all UARTS (except UART3) by defatul, which I'm not sure all
> Beagle users will be happy about.
>

Okay, I have posted new version of the patch
"[PATCH] omap3_beagle: init uart2 for beagle rev AX/BX only"

which initialises uart1/3/4 on all beagle boards

and uart2 init is done for only beagle rev ax/bx
which doesn't seem to have external usb module.


>> Uart2 rx line clashes with gpio_147 used for usb ehci
>> phy reset. Initializing uart2 pad_mux lines can break
>> ehci module on beagle xm.
>> (gpio_147 is available on uart2_rx in mode4 reference
>> mux34xx.c -> uart2_rx.gpio_147)
>
> As Koen mentioned, this conflict only exists on certain boards, so
> you should be clear that this is just an example.
>

conflict exists all beagle rev's expect rev ax/bx.

--
Thanks,
Govindraj.R
