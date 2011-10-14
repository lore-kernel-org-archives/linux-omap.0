From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 09/16] OMAP2+: UART: Add runtime pm support for omap-serial driver
Date: Fri, 14 Oct 2011 10:04:38 -0700
Message-ID: <87ehyfec7t.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-9-git-send-email-govindraj.raja@ti.com>
	<878voplppo.fsf@ti.com>
	<CAAL8m4yrXo4KRYxXxWECU99B6--FCMBDFUbNk+vsBV0Jnt0bcg@mail.gmail.com>
	<87obxkio3e.fsf@ti.com>
	<CAAL8m4zbdA9rtwLhft8UGQTtvroNbYYoBoq4BG2Eu2nCToX5+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4zbdA9rtwLhft8UGQTtvroNbYYoBoq4BG2Eu2nCToX5+w@mail.gmail.com>
	(Govindraj's message of "Fri, 14 Oct 2011 18:02:19 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Fri, Oct 14, 2011 at 2:52 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Govindraj <govindraj.ti@gmail.com> writes:
>>
>>> On Thu, Oct 13, 2011 at 5:36 AM, Kevin Hilman <khilman@ti.com> wrot=
e:
>>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>>
>>>> [...]
>>>>
>>>>> Use device_may_wakeup to check whether uart has wakeup capabiliti=
es
>>>>> and then enable uart runtime usage for the uart.
>>>>
>>>> Curious about what happens when device_may_wakeup() is not set dur=
ing
>>>> device init.
>>>>
>>>> [...]
>>>>
>>>>> @@ -1305,6 +1363,16 @@ static int serial_omap_probe(struct platfo=
rm_device *pdev)
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->uart_dma.rx_=
dma_channel =3D OMAP_UART_DMA_CH_FREE;
>>>>> =C2=A0 =C2=A0 =C2=A0 }
>>>>>
>>>>> + =C2=A0 =C2=A0 pm_runtime_use_autosuspend(&pdev->dev);
>>>>> + =C2=A0 =C2=A0 pm_runtime_set_autosuspend_delay(&pdev->dev,
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OMAP_UART_AUTOSUSPEND_DELAY);
>>>>> +
>>>>> + =C2=A0 =C2=A0 pm_runtime_irq_safe(&pdev->dev);
>>>>> + =C2=A0 =C2=A0 if (device_may_wakeup(&pdev->dev)) {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_runtime_enable(&pd=
ev->dev);
>>>>
>>>> So if device_may_wakeup() is false, runtime PM is not enabled, the=
n...
>>>>
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_runtime_get_sync(&=
pdev->dev);
>>>>
>>>> ...this get doesn't happen, and the first register access causes a=
 crash.
>>>
>>> Actually no crash, clocks will left enabled from boot up (hwmod_no_=
reset/idle)
>>> that are idled and enabled back here.
>>>
>>> Since hwmod_idle is binded here later ([PATCH v6 15/16]),
>>
>> IMO, That's not a very maintainable solution.
>>
>> What happens when when someone fixes serial.c to only set
>> HWMOD_INIT_NO_IDLE on the console UART? =C2=A0or if we fix things so=
 we don't
>> need INIT_NO_IDLE anymore? =C2=A0Then this will crash.
>>
>> Driver code should not make assumptions like this about what device =
init
>> code is or isn't doing.
>>
>
> Okay, How about doing as below ensuring get_sync always
> and forbid runtime to avoid clock_gating if wakeup is not set.
>

This is better, I'm not crazy about that either.

Consider a platform that doesn't have wakeups, but the UARTs are not
used (at least initially.)   That means on power up, all the UARTs are
left enabled to consume power even when they're not used.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
