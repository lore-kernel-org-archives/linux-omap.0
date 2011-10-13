From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 09/16] OMAP2+: UART: Add runtime pm support for
	omap-serial driver
Date: Thu, 13 Oct 2011 06:58:48 +0530
Message-ID: <CAAL8m4yrXo4KRYxXxWECU99B6--FCMBDFUbNk+vsBV0Jnt0bcg@mail.gmail.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-9-git-send-email-govindraj.raja@ti.com>
	<878voplppo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <878voplppo.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 13, 2011 at 5:36 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
> [...]
>
>> Use device_may_wakeup to check whether uart has wakeup capabilities
>> and then enable uart runtime usage for the uart.
>
> Curious about what happens when device_may_wakeup() is not set during
> device init.
>
> [...]
>
>> @@ -1305,6 +1363,16 @@ static int serial_omap_probe(struct platform_devi=
ce *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_channel =3D OMAP_UART_DM=
A_CH_FREE;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 pm_runtime_use_autosuspend(&pdev->dev);
>> + =A0 =A0 pm_runtime_set_autosuspend_delay(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_UART_AUTOSUSPEND_DELAY);
>> +
>> + =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>> + =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>
> So if device_may_wakeup() is false, runtime PM is not enabled, then...
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&pdev->dev);
>
> ...this get doesn't happen, and the first register access causes a crash.

Actually no crash, clocks will left enabled from boot up (hwmod_no_reset/id=
le)
that are idled and enabled back here.

Since hwmod_idle is binded here later ([PATCH v6 15/16]),

>
> So either this get isn't needed, because there is no device access in
> this path, or this path is broken and needs validation.
>
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 ui[pdev->id] =3D up;
>> =A0 =A0 =A0 serial_omap_add_console_port(up);
>>
>> @@ -1312,6 +1380,7 @@ static int serial_omap_probe(struct platform_devic=
e *pdev)
>> =A0 =A0 =A0 if (ret !=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto do_release_region;
>>
>> + =A0 =A0 pm_runtime_put(&pdev->dev);
>
> ...also, this put is not balanced with a corresponding get.

this needs to happen only when runtime is enabled.

will correct this.

--
Thanks,
Govindraj.,R
