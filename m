From: Andy Green <andy.green@linaro.org>
Subject: Re: [PATCH 2/3] OMAP2+ devices add mac address allocation register
 api
Date: Fri, 29 Jun 2012 21:59:02 +0800
Message-ID: <4FEDB4A6.7040609@linaro.org>
References: <20120629054404.11091.31289.stgit@build.warmcat.com> <4FED7E6A.4090207@linaro.org> <20120629120325.GD4202@atomide.com> <201206291345.49878.arnd@arndb.de> <20120629135559.GH4202@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:42023 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653Ab2F2N7N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 09:59:13 -0400
In-Reply-To: <20120629135559.GH4202@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.pitre@linaro.org, s-jan@ti.com, patches@linaro.org, rostedt@goodmis.org

On 06/29/12 21:55, the mail apparently from Tony Lindgren included:
> * Arnd Bergmann <arnd@arndb.de> [120629 06:50]:
>> On Friday 29 June 2012, Tony Lindgren wrote:
>>> * Andy Green <andy.green@linaro.org> [120629 03:12]:
>>>>> 2. Is this really how we want to pass the board generated mac add=
resses
>>>>>     and other dynamically generated data to the drivers that are =
device
>>>>>     tree based?
>>>>
>>>> The issue is that both these busses have an async probe, in the ca=
se
>>>> of USB stack the maintainer was not interested last year in adding
>>>> platform data.  Maybe it changed but that's my understanding.
>>>
>>> OK, I'd like to hear Arnds comments on the #2 above too as this is
>>> a more generic issue.
>>
>> In case we have a device tree, we should just be using the USB bindi=
ng
>> to find the specific device node, and add the property there. Then
>> the device driver can use of_get_mac_address() on the usb device its=
elf.
>
> But would you generate the mac address then in the bootloader already=
?

I'm pretty sure correct answer does not introduce more dependencies on=20
bootloader code.

>> I'm not sure what it takes to add the link for the device node in th=
e
>> usb probing code, but my feeling is that it's not too hard.
>>
>> Right now, USB is probed entirely without DT, so the patch is about
>> the best we can do.
>
> Right, but that still assumes a static mac from the bootloader unless
> we do a generic driver as below? Or do you have some other ideas?

What happens without this patch is randomized MAC address assigned by=20
Linux in smsc Ethernet case.

-Andy


--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
