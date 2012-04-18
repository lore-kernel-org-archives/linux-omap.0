From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] tty: omap-serial: Keep the wakeup mechanism enabled by default
Date: Wed, 18 Apr 2012 07:21:33 -0700
Message-ID: <87mx69nms2.fsf@ti.com>
References: <1334579407-16970-1-git-send-email-govindraj.raja@ti.com>
	<87vckyq6ti.fsf@ti.com>
	<CAMrsUdL1S5GiyG0egS=CHg2fdNkyZVF-wuCNGDg547kfTUODng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:50993 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751210Ab2DROVe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 10:21:34 -0400
Received: by dajx4 with SMTP id x4so10880814daj.28
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 07:21:33 -0700 (PDT)
In-Reply-To: <CAMrsUdL1S5GiyG0egS=CHg2fdNkyZVF-wuCNGDg547kfTUODng@mail.gmail.com>
	(Govindraj Raja's message of "Wed, 18 Apr 2012 18:46:31 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

"Raja, Govindraj" <govindraj.raja@ti.com> writes:

> On Wed, Apr 18, 2012 at 4:55 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>>
>>> The wakeups can be left enabled by default and should be disabled
>>> only when disabled from sysfs and while entering suspend.
>>
>> Left enabled? =C2=A0That assumes something else has initizlied them,=
 but we
>> can't make that assumption.
>>
>> First, wakeups should be disabled when ->probe has finished. =C2=A0T=
hen,
>> they should be enabled whenever driver is in use, and disabled when
>> the driver is not in use.
>>
>> I'm not familiar enough with uart_ops, but it looks like they should
>> probably be enabled in uart_ops->startup and disabled in
>> uart_ops->shutdown.
>
> uart_ops->shutdown gets called in suspend path also
> serial_omap_suspend =3D> uart_suspend_port =3D > ops->shutdown(uport)=
;
>
> This will leave uart wakeup disabled in suspend path.

As I said, I'm not familiar enough with uart_ops to know which are the
right ones.

Maybe ->request_port and ->release_port are the right ones?

The point is that wakeups should be enabled whenever driver is in use,
and disabled when the driver is not in use.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
