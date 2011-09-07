From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v6 00/25] gpio/omap: driver cleanup and fixes
Date: Wed, 7 Sep 2011 11:01:33 +0530
Message-ID: <CAC83ZvLMXknFVjJsBAQHub=SRJ5hU9GWbLzAEHcT+vRgAPrOnw@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<87bouxz21m.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:59197 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751744Ab1IGFbe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Sep 2011 01:31:34 -0400
Received: by mail-bw0-f45.google.com with SMTP id zv3so8010452bkb.32
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 22:31:33 -0700 (PDT)
In-Reply-To: <87bouxz21m.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wed, Sep 7, 2011 at 4:55 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Tarun,
>
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> This series is continuation of cleanup of OMAP GPIO driver and fixes=
=2E
>> The cleanup include getting rid of cpu_is_* checks wherever possible=
,
>> use of gpio_bank list instead of static array, use of unique platfor=
m
>> specific value associated data member to OMAP platforms to avoid
>> cpu_is_* checks. The series also include PM runtime support.*
>
> I tested this series on top of v3.1-rc4 using a 3430/n900 platform.
>
> During suspend the PER powerdomain does not hit the targetted power
> state. =A0Also, in idle PER never hits retention.
>
> As with previous versions of this series, it appears to be related to
> debounce clocks being left enabled. =A0On my n900, I removed debounce=
 from
> all the GPIO keys pads and PER was then able to hit retention during
> suspend and idle.
In this series the debounce clock is turned off and it should have work=
ed.

>
> Please be sure to test on a platform that is using debounce, or modif=
y
> the board file for one of the platforms your testing so that at least
> one of the GPIOs has debounce enabled so you are verifying the deboun=
ce
> clock gating during suspend and idle.
Yes, I will setup a system for testing debounce clock gating.

>
> Thanks,
>
> Kevin
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
