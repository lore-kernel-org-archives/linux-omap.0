From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 09/16] OMAP2+: UART: Add runtime pm support for
 omap-serial driver
Date: Fri, 14 Oct 2011 23:59:53 +0530
Message-ID: <CAAL8m4zt1aA2ysRTRazQgn=1QGJkzcYLMCi2m_dUqNKf+0Sh7w@mail.gmail.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
 <1317380495-584-9-git-send-email-govindraj.raja@ti.com> <878voplppo.fsf@ti.com>
 <CAAL8m4yrXo4KRYxXxWECU99B6--FCMBDFUbNk+vsBV0Jnt0bcg@mail.gmail.com>
 <87obxkio3e.fsf@ti.com> <CAAL8m4zbdA9rtwLhft8UGQTtvroNbYYoBoq4BG2Eu2nCToX5+w@mail.gmail.com>
 <87ehyfec7t.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87ehyfec7t.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 14, 2011 at 10:34 PM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Fri, Oct 14, 2011 at 2:52 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> Govindraj <govindraj.ti@gmail.com> writes:
>>>
>>>> On Thu, Oct 13, 2011 at 5:36 AM, Kevin Hilman <khilman@ti.com> wro=
te:
>>>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>>>
>>>>> [...]
>>>>>
>>>>>> Use device_may_wakeup to check whether uart has wakeup capabilit=
ies
>>>>>> and then enable uart runtime usage for the uart.
>>>>>
>>>>> Curious about what happens when device_may_wakeup() is not set du=
ring
>>>>> device init.
>>>>>
>>>>> [...]
>>>>>
>>>>>> @@ -1305,6 +1363,16 @@ static int serial_omap_probe(struct platf=
orm_device *pdev)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_channel =3D OMAP=
_UART_DMA_CH_FREE;
>>>>>> =A0 =A0 =A0 }
>>>>>>
>>>>>> + =A0 =A0 pm_runtime_use_autosuspend(&pdev->dev);
>>>>>> + =A0 =A0 pm_runtime_set_autosuspend_delay(&pdev->dev,
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_UART_AUTOSUSPEND_=
DELAY);
>>>>>> +
>>>>>> + =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>>>>>> + =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>>>>>
>>>>> So if device_may_wakeup() is false, runtime PM is not enabled, th=
en...
>>>>>
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&pdev->dev);
>>>>>
>>>>> ...this get doesn't happen, and the first register access causes =
a crash.
>>>>
>>>> Actually no crash, clocks will left enabled from boot up (hwmod_no=
_reset/idle)
>>>> that are idled and enabled back here.
>>>>
>>>> Since hwmod_idle is binded here later ([PATCH v6 15/16]),
>>>
>>> IMO, That's not a very maintainable solution.
>>>
>>> What happens when when someone fixes serial.c to only set
>>> HWMOD_INIT_NO_IDLE on the console UART? =A0or if we fix things so w=
e don't
>>> need INIT_NO_IDLE anymore? =A0Then this will crash.
>>>
>>> Driver code should not make assumptions like this about what device=
 init
>>> code is or isn't doing.
>>>
>>
>> Okay, How about doing as below ensuring get_sync always
>> and forbid runtime to avoid clock_gating if wakeup is not set.
>>
>
> This is better, I'm not crazy about that either.
>
> Consider a platform that doesn't have wakeups, but the UARTs are not
> used (at least initially.) =A0 That means on power up, all the UARTs =
are
> left enabled to consume power even when they're not used.
>

okay, the right place would be serial_omap_pm
to do add runtime forbid.

whenever the uart port is used it will call serial_omap_pm
with state param assigned value zero from serial_core layer
for open system call from user space.

Also when uart port is closed it will shutdown where we can add runtime=
_allow.
So for uart ports not wakeup capable keep uart clocks on until
used and once port is shutdown cut uart clocks.


diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap=
-serial.c
index 8a955fc..2c43744 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -608,6 +608,10 @@ static void serial_omap_shutdown(struct uart_port =
*port)
                        up->uart_dma.rx_buf_dma_phys);
                up->uart_dma.rx_buf =3D NULL;
        }
+
+       if (!device_may_wakeup(&up->pdev->dev))
+               pm_runtime_allow(&up->pdev->dev);
+
        pm_runtime_put(&up->pdev->dev);
        free_irq(up->port.irq, up);
 }
@@ -893,6 +897,10 @@ serial_omap_pm(struct uart_port *port, unsigned in=
t state,
        serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
        serial_out(up, UART_EFR, efr);
        serial_out(up, UART_LCR, 0);
+
+       if (!state && !device_may_wakeup(&up->pdev->dev))
+               pm_runtime_forbid(&up->pdev->dev);
+
        pm_runtime_put(&up->pdev->dev);
 }


--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
