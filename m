From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
Subject: Re: omapdss wakeup issues
Date: Fri, 1 Mar 2013 22:06:36 +0100
Message-ID: <CALbNGRSgPj69TTQjsjGMGk34n+ZcrSuYhy3BghEsrtwxvtqrjA@mail.gmail.com>
References: <CALbNGRThXXuSE9Q9h7rcSHYm_s4nUcdGjC-xRFD23f0-Ncy3-w@mail.gmail.com>
	<CABuKBe+==L3+3t0A0MxLWAu4HovG2vmfY3LXHVJakOw8=nP5MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:38937 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab3CAVGh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 16:06:37 -0500
Received: by mail-ve0-f180.google.com with SMTP id jx10so3241724veb.25
        for <linux-omap@vger.kernel.org>; Fri, 01 Mar 2013 13:06:36 -0800 (PST)
In-Reply-To: <CABuKBe+==L3+3t0A0MxLWAu4HovG2vmfY3LXHVJakOw8=nP5MQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-omap@vger.kernel.org

On Fri, Mar 1, 2013 at 2:25 PM, Matthias Brugger <matthias.bgg@gmail.co=
m> wrote:
> Hi Andreas,
>
> 2013/2/28 Andreas M=C3=BCller <schnitzeltony@googlemail.com>:
>> Hi,
>>
>> I am preparing 3.8 mainline for gumstix overo and have the following
>> issue: waking Monitor connected by HDMI from power save makes Monito=
r
>> complain for unsupported frequency and console says:
>>
>> | omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
>>
>> Is this a known issue?
>
> I'm not sure if it's the same issue, but you might give it a shot.
> The problem is, that when changing the CPU frequency in OMAP3530, the
> frequency of L3 is changed. This frequency is used in DSS.
> The result is a fifo underflow on gfx.
>
> First check, if you use some dynamic cpufreq governor, which might be
> changing the frequency.
> A workaround (although not very nice) is to set fixed l3_main values
> in mach-omap2/opp3xxx_data.c
>
> Best regards,
> Matthias
>
I have gouvernor 'performance' selected which AFAIK keeps frequency at
maximum. Some more details in another mail which I already prepared.

Andreas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
