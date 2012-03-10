From: yang gqyang <hustgqyang@gmail.com>
Subject: Re: implementing "suspend to ram" on cortex A8 based on linux 3.0.8
Date: Sat, 10 Mar 2012 22:37:09 +0800
Message-ID: <CAFawwkVuCTijwLr6UWVRh9XNGCt-8brr2f4aDrpM_YwkWSGP+A@mail.gmail.com>
References: <CAFawwkXQhyj+c8LEDnD7q4mXDJV2jYCAHV0tBrqxrEaNGk+_0w@mail.gmail.com>
	<CACNz9cVbULxVSGvo60V+JLL=15BDEaYwgd5k9ZMNu09Kfwz4WQ@mail.gmail.com>
	<CAFawwkWQd=y=kVm97UjSs37=-MRmJiy9f7sy8ChYzCHZ9Y-gyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40633 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371Ab2CJOhK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Mar 2012 09:37:10 -0500
In-Reply-To: <CAFawwkWQd=y=kVm97UjSs37=-MRmJiy9f7sy8ChYzCHZ9Y-gyA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chenglie He <chengjie.he@linaro.org>
Cc: Robert Lee <rob.lee@linaro.org>, nicolas.pitre@linaro.org, venki@google.com, linaro-dev@lists.linaro.org, linux-sh@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, ccross@google.com, kernel@wantstofly.org, khilman@ti.com, kgene.kim@samsung.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, jon-hunter@ti.com, len.brown@intel.com, patches@linaro.org, nsekhar@ti.com, rjw@sisk.pl, Baohua.Song@csr.com, linux-omap@vger.kernel.org, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, g.trinabh@gmail.com, linux-pm@vger.kernel.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lethal@linux-sh.org

 Thanks for your comment.
 Finally, i find out that i made a mistake.  The uart(8250) have not be=
en
 restore after resume, instead, it use the configuration got from boot.=
 The
 uart have not been restored correctly, so that "ls" can not output res=
ult
 correctly resulting in it seems that the busybox can not work correctl=
y.
 Now, i still have a question about the uart: why the "printk" can work
 correctly, but the "printf" not?

 Before this, i believe that the "printk" work correctly, then the uart
 work ok. but now, i  need more reconsidaration about
 the relation between the "printk", "printf" and "uart".
 Can anyone give me some suggestion? Any comment is welcome, thanks a
 lot.


> =D4=DA 2012=C4=EA3=D4=C29=C8=D5 =CF=C2=CE=E710:08=A3=ACChenglie He <c=
hengjie.he@linaro.org>=D0=B4=B5=C0=A3=BA
>
>> Hi,
>>
>> I am doing this on A9, echo mem >/sys/power/state is right, will tri=
gger
>> kernel to sleep.
>>
>> -jack

>
some recipient promote:
"The message contains HTML subpart, therefore we consider it SPAM or
Outlook Virus"
so i resend the email, hope it not disturb u. thanks a lot.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
