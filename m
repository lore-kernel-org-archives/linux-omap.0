From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 09/16] OMAP2+: UART: Add runtime pm support for
 omap-serial driver
Date: Fri, 14 Oct 2011 18:02:19 +0530
Message-ID: <CAAL8m4zbdA9rtwLhft8UGQTtvroNbYYoBoq4BG2Eu2nCToX5+w@mail.gmail.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
 <1317380495-584-9-git-send-email-govindraj.raja@ti.com> <878voplppo.fsf@ti.com>
 <CAAL8m4yrXo4KRYxXxWECU99B6--FCMBDFUbNk+vsBV0Jnt0bcg@mail.gmail.com> <87obxkio3e.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36834 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663Ab1JNMck convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Oct 2011 08:32:40 -0400
In-Reply-To: <87obxkio3e.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Oct 14, 2011 at 2:52 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Thu, Oct 13, 2011 at 5:36 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>
>>> [...]
>>>
>>>> Use device_may_wakeup to check whether uart has wakeup capabilitie=
s
>>>> and then enable uart runtime usage for the uart.
>>>
>>> Curious about what happens when device_may_wakeup() is not set duri=
ng
>>> device init.
>>>
>>> [...]
>>>
>>>> @@ -1305,6 +1363,16 @@ static int serial_omap_probe(struct platfor=
m_device *pdev)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_channel =3D OMAP_U=
ART_DMA_CH_FREE;
>>>> =A0 =A0 =A0 }
>>>>
>>>> + =A0 =A0 pm_runtime_use_autosuspend(&pdev->dev);
>>>> + =A0 =A0 pm_runtime_set_autosuspend_delay(&pdev->dev,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_UART_AUTOSUSPEND_DE=
LAY);
>>>> +
>>>> + =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>>>> + =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>>>
>>> So if device_may_wakeup() is false, runtime PM is not enabled, then=
=2E..
>>>
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&pdev->dev);
>>>
>>> ...this get doesn't happen, and the first register access causes a =
crash.
>>
>> Actually no crash, clocks will left enabled from boot up (hwmod_no_r=
eset/idle)
>> that are idled and enabled back here.
>>
>> Since hwmod_idle is binded here later ([PATCH v6 15/16]),
>
> IMO, That's not a very maintainable solution.
>
> What happens when when someone fixes serial.c to only set
> HWMOD_INIT_NO_IDLE on the console UART? =A0or if we fix things so we =
don't
> need INIT_NO_IDLE anymore? =A0Then this will crash.
>
> Driver code should not make assumptions like this about what device i=
nit
> code is or isn't doing.
>

Okay, How about doing as below ensuring get_sync always
and forbid runtime to avoid clock_gating if wakeup is not set.

static int serial_omap_probe(struct platform_device *pdev) {
[..]
        pm_runtime_enable(&pdev->dev);
        pm_runtime_get_sync(&pdev->dev);

        if (!device_may_wakeup(&pdev->dev))
                pm_runtime_forbid(&pdev->dev);

[..]

        pm_runtime_put(&pdev->dev);
[..]
}


--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
