From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 09/16] OMAP2+: UART: Add runtime pm support for omap-serial driver
Date: Thu, 13 Oct 2011 14:22:13 -0700
Message-ID: <87obxkio3e.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-9-git-send-email-govindraj.raja@ti.com>
	<878voplppo.fsf@ti.com>
	<CAAL8m4yrXo4KRYxXxWECU99B6--FCMBDFUbNk+vsBV0Jnt0bcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:57652 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752731Ab1JMVWT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 17:22:19 -0400
In-Reply-To: <CAAL8m4yrXo4KRYxXxWECU99B6--FCMBDFUbNk+vsBV0Jnt0bcg@mail.gmail.com>
	(Govindraj's message of "Thu, 13 Oct 2011 06:58:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Thu, Oct 13, 2011 at 5:36 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>> [...]
>>
>>> Use device_may_wakeup to check whether uart has wakeup capabilities
>>> and then enable uart runtime usage for the uart.
>>
>> Curious about what happens when device_may_wakeup() is not set durin=
g
>> device init.
>>
>> [...]
>>
>>> @@ -1305,6 +1363,16 @@ static int serial_omap_probe(struct platform=
_device *pdev)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->uart_dma.rx_dm=
a_channel =3D OMAP_UART_DMA_CH_FREE;
>>> =C2=A0 =C2=A0 =C2=A0 }
>>>
>>> + =C2=A0 =C2=A0 pm_runtime_use_autosuspend(&pdev->dev);
>>> + =C2=A0 =C2=A0 pm_runtime_set_autosuspend_delay(&pdev->dev,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 OMAP_UART_AUTOSUSPEND_DELAY);
>>> +
>>> + =C2=A0 =C2=A0 pm_runtime_irq_safe(&pdev->dev);
>>> + =C2=A0 =C2=A0 if (device_may_wakeup(&pdev->dev)) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_runtime_enable(&pdev=
->dev);
>>
>> So if device_may_wakeup() is false, runtime PM is not enabled, then.=
=2E.
>>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_runtime_get_sync(&pd=
ev->dev);
>>
>> ...this get doesn't happen, and the first register access causes a c=
rash.
>
> Actually no crash, clocks will left enabled from boot up (hwmod_no_re=
set/idle)
> that are idled and enabled back here.
>
> Since hwmod_idle is binded here later ([PATCH v6 15/16]),

IMO, That's not a very maintainable solution.  =20

What happens when when someone fixes serial.c to only set
HWMOD_INIT_NO_IDLE on the console UART?  or if we fix things so we don'=
t
need INIT_NO_IDLE anymore?  Then this will crash.

Driver code should not make assumptions like this about what device ini=
t
code is or isn't doing.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
