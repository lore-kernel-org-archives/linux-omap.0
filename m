From: Barry Song <21cnbao@gmail.com>
Subject: Re: implementing "suspend to ram" on cortex A8 based on linux 3.0.8
Date: Tue, 13 Mar 2012 22:34:18 +0800
Message-ID: <CAGsJ_4yDjDLSPwXubcecmCzpeJTwvGz30-awSAZfC+YtTwB_-w@mail.gmail.com>
References: <CAFawwkXQhyj+c8LEDnD7q4mXDJV2jYCAHV0tBrqxrEaNGk+_0w@mail.gmail.com>
 <CACNz9cVbULxVSGvo60V+JLL=15BDEaYwgd5k9ZMNu09Kfwz4WQ@mail.gmail.com>
 <CAFawwkWQd=y=kVm97UjSs37=-MRmJiy9f7sy8ChYzCHZ9Y-gyA@mail.gmail.com> <CAFawwkVuCTijwLr6UWVRh9XNGCt-8brr2f4aDrpM_YwkWSGP+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37330 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442Ab2CMOei convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 10:34:38 -0400
In-Reply-To: <CAFawwkVuCTijwLr6UWVRh9XNGCt-8brr2f4aDrpM_YwkWSGP+A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yang gqyang <hustgqyang@gmail.com>
Cc: Chenglie He <chengjie.he@linaro.org>, Robert Lee <rob.lee@linaro.org>, nicolas.pitre@linaro.org, venki@google.com, linaro-dev@lists.linaro.org, linux-sh@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, ccross@google.com, kernel@wantstofly.org, khilman@ti.com, kgene.kim@samsung.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, jon-hunter@ti.com, len.brown@intel.com, patches@linaro.org, nsekhar@ti.com, rjw@sisk.pl, Baohua.Song@csr.com, linux-omap@vger.kernel.org, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, g.trinabh@gmail.com, linux-pm@vger.kernel.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lethal@linux-sh.org

hi yang,

=E5=9C=A8 2012=E5=B9=B43=E6=9C=8810=E6=97=A5 =E4=B8=8B=E5=8D=8810:37=EF=
=BC=8Cyang gqyang <hustgqyang@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
> =C2=A0Thanks for your comment.
> =C2=A0Finally, i find out that i made a mistake. =C2=A0The uart(8250)=
 have not been
> =C2=A0restore after resume, instead, it use the configuration got fro=
m boot. The
> =C2=A0uart have not been restored correctly, so that "ls" can not out=
put result
> =C2=A0correctly resulting in it seems that the busybox can not work c=
orrectly.
> =C2=A0Now, i still have a question about the uart: why the "printk" c=
an work
> =C2=A0correctly, but the "printf" not?
>
> =C2=A0Before this, i believe that the "printk" work correctly, then t=
he uart
> =C2=A0work ok. but now, i =C2=A0need more reconsidaration about
> =C2=A0the relation between the "printk", "printf" and "uart".
> =C2=A0Can anyone give me some suggestion? Any comment is welcome, tha=
nks a
> =C2=A0lot.

printk use "struct console" driver, it doesn't depend on a device node
for userspace.
printf actaully depends on uart_driver and a /dev/ttySx device node,
stdout and stderr are redirected to /dev/ttySx
uart is just a hardware which can be a tty or kernel console output.


>
>
-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
