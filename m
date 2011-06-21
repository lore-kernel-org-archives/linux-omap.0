From: Daniel Mack <zonque@gmail.com>
Subject: Re: Trouble with newer kernels on Gumstix Overo boards
Date: Tue, 21 Jun 2011 10:21:42 +0200
Message-ID: <BANLkTim8Sh7kZp=92jhoU3NxgzAu0YgoWw@mail.gmail.com>
References: <BANLkTimJTBpj30EKf_EucvOf2yCHHbRrkQ@mail.gmail.com>
	<ADF30F4D7BDE934D9B632CE7D5C7ACA4047B99E7E7AD@dbde03.ent.ti.com>
	<BANLkTimfeS1Xin779eg=8cdjqmqcQeB6HA@mail.gmail.com>
	<4DFF4BCB.1000206@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61429 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab1FUIVn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jun 2011 04:21:43 -0400
Received: by pwj7 with SMTP id 7so856097pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 01:21:42 -0700 (PDT)
In-Reply-To: <4DFF4BCB.1000206@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegor_sub1@visionsystems.de
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jun 20, 2011 at 3:31 PM, Yegor Yefremov
<yegor_sub1@visionsystems.de> wrote:
> Am 17.06.2011 17:11, schrieb Daniel Mack:
>> On Fri, Jun 17, 2011 at 4:03 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>>>> console=ttyS2,115200 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
>>>
>>> Here is your problem. We now use the OMAP-serial driver for the UARTs.
>>
>> Which breaks backward-compatibility with bootloaders set up for older
>> kernels. Now I have to deploy kernels with CONFIG_CMDLINE_FORCE=y. Was
>> that really necessary?
>>
>>> Change the ttyS2 to ttyO2 and you should be fine.
>>
>> You're right, that did the trick. Thanks a lot!
>
> Are you using some extra patches? I have a custom board based on am3517 SoC and I have much more errors during booting as I can see from your boot log. I have no problems booting 2.6.32/37 though. Any idea?

I don't use any extra patches. Just a plain 3.0.0-rc3 from Linus'
master branch plus the patch I've sent some days ago to this list.
With that setup, and console=ttyO2, my systems runs just fine.

Daniel
