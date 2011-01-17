From: "Jan, Sebastien" <s-jan@ti.com>
Subject: Re: Passing mem=1G to kernel on Panda, system is unstable.
Date: Mon, 17 Jan 2011 19:41:17 +0100
Message-ID: <AANLkTi=OQ-RYmuz71qXeYKiY3i4j+Nxv_n3R_7cr8qKC@mail.gmail.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
 <641ab84b6cedfd62b9b6bedeae077f1b@mail.gmail.com> <AANLkTi=EaxW9D_rtNuk3CT1K-CoTBXiy5qOW=EL9ay1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:60293 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752600Ab1AQSl4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jan 2011 13:41:56 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so3007732ewy.4
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 10:41:48 -0800 (PST)
In-Reply-To: <AANLkTi=EaxW9D_rtNuk3CT1K-CoTBXiy5qOW=EL9ay1d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

On Fri, Jan 14, 2011 at 11:12 AM, Bryan Wu <bryan.wu@canonical.com> wrote:
>
> On Fri, Jan 14, 2011 at 4:12 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> > Bryan,
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Bryan Wu
> >> Sent: Tuesday, January 11, 2011 10:22 PM
> >> To: linux-omap@vger.kernel.org; Ricardo Salveti de Araujo
> >> Subject: Passing mem=1G to kernel on Panda, system is unstable.
> >>
> >> Hi folks,
> >>
> >> We are trying to build kernel package or GCC natively on OMAP4 panda
> >> board. With the mainline 2.6.37 kernel or Ubuntu Natty 2.6.35 based
> >> kernel, we met same instabilities on the system when we try to use
> >> mem=1G on the board.
> >>
> >> Please find our bug tracker here:
> >> https://bugs.launchpad.net/ubuntu/+source/linux-ti-omap4/+bug/633227
> >> and I think another bug is also related:
> >> https://bugs.launchpad.net/ubuntu/+source/linux-ti-
> >> omap4/+bug/690370.
> >> System will freeze at all when building GCC natively on Panda.
> >>
> >> Did any folks meet this issue? or we need more simple test case to
> >> catch the root cause of this issue.
> >>
> > Haven't seen this issue on my SDP with 2.6.37.
> Do you have Panda for testing? I don't have SDP. Maybe Sebastien can
> help to verify on SDP.

I reproduced the issue on my Blaze board, confirming that this issue
is not specific to panda.

> > Have you enabled HIGHMEM, when tried mem = 1G on 2.6.37 ?
> >
>
> Yeah, CONFIG_HIGHMEM=y for this mainline testing. Please use this
> kernel config file:
> http://launchpadlibrarian.net/62061659/mainline_config

So far, I have not been able to reproduce the issue with
CONFIG_HIGHMEM option deactivated (I am cleaning/building kernels for
more than 24 hours now), and mem=1G. I will keep my test run, but it
seems that deactivating highmem at least hides the issue.
