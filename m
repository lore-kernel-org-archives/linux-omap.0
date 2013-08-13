From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Tue, 13 Aug 2013 10:33:04 -0500
Message-ID: <520A51B0.3010805@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <52077B26.1010103@gmail.com> <5209307F.9000701@ti.com> <520A28E5.9030304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50917 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757619Ab3HMPda (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Aug 2013 11:33:30 -0400
In-Reply-To: <520A28E5.9030304@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>

On 08/13/2013 07:39 AM, Daniel Mack wrote:
> Hi Dave,
>
> On 12.08.2013 20:59, Dave Gerlach wrote:
>> On 08/11/2013 06:53 AM, Daniel Mack wrote:
>
>>> The problem I currently face is that I can't make the board resume, as
>>> neither UART0 nor GPIO0 seem to work as wakeup source.
>>
>> Did you apply the other patches that are mentioned besides Suman's
>> series? The board will hang while suspending without these.
>
> Yes. However, just to make sure you referenced the correct patches - on
> top of yours an Suman's set, I have:
>
>    [PATCH 1/2] ARM: OMAP2+: hwmod: rt address space index for DT
>    [PATCH 2/2] ARM: OMAP2+: hwmod: AM335x: fix cpgmac address space
>    [PATCH 1/2] ARM: dts: add AM33XX EDMA support
>
> The last one seems somewhat unrelated though.
>
> However, I see an issue with the musb dsps glue. With the usb controller
> disabled in DT, I also had to remove the usb_otg_hs entry from
> am33xx_mod[] (pm33xx.c). When the usb controller is _enabled_, I get an
> instant NULL pointer exception due to a rather obvious bug. I'll send
> out a patch right now.
>
> When I send the board to suspend (with USB disabled), the power
> consumption drops significantly, and the output is:
>
> # echo mem > /sys/power/state
> [   93.001937] PM: Syncing filesystems ... done.
> [   93.033591] Freezing user space processes ... (elapsed 0.002 seconds)
> done.
> [   93.048532] Freezing remaining freezable tasks ... (elapsed 0.002
> seconds) done.
> [   93.059277] PM: Sending message for entering DeepSleep mode
> [   93.085368] PM: suspend of devices complete after 15.070 msecs
> [   93.096671] PM: late suspend of devices complete after 5.122 msecs
> [   93.108853] PM: noirq suspend of devices complete after 5.647 msecs
>
>
> ... but traffic on UART0 won't cause a resume.
>

It looks like you are using no_console_suspend? UART0 does not work as a 
wakeup source with this option set.

>
> I'll dig a little deeper now, but if you have any idea, please let me know.
>
>
> Thanks,
> Daniel
>

