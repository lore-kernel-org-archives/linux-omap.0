From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 05/12] OMAP: Serial: Hold console lock for console usage.
Date: Thu, 05 May 2011 07:52:03 -0700
Message-ID: <8762ppmc8c.fsf@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-6-git-send-email-govindraj.raja@ti.com>
	<87vcxqp577.fsf@ti.com>
	<BANLkTi=Ded-q777t=fTc_rcX4=HBq5Bh1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:40545 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753042Ab1EEOwM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 May 2011 10:52:12 -0400
In-Reply-To: <BANLkTi=Ded-q777t=fTc_rcX4=HBq5Bh1g@mail.gmail.com> (Govindraj's
	message of "Thu, 5 May 2011 15:55:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

Govindraj <govindraj.ti@gmail.com> writes:

> On Thu, May 5, 2011 at 2:13 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> Acquire console lock before enabling and writing to console-uart
>>> to avoid any recursive prints from console write.
>>> for ex:
>>> =C2=A0 =C2=A0 =C2=A0 --> printk
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 --> uart_console_write
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --> get_sync
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --> printk from omap_devi=
ce enable
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --> uart_console w=
rite
>>
>> By this time, since the device's runtime PM hooks have been called, =
the
>> device's rutime PM state should be set to RPM_SUSPENDING (not yet
>> RPM_SUSPENDED).
>>
>> In addition to the console lock, you should be able to use that flag=
 to
>> avoid console writes while the console is in the process of suspendi=
ng.
>>
>
> Yes RPM_SUSPENDING check helps along with console lock

Great!

> << Changes as below >>
> ---------------
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index 59f548f..71964c3 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1040,6 +1040,18 @@ serial_omap_console_write(struct console *co,
> const char *s,
>         if (console_trylock())
>                 console_lock =3D 1;
>
> +       /*
> +        * If console_lock is not available and we are in suspending
> +        * state then we can avoid the console usage scenario
> +        * as this may introduce recursive prints.
> +        * Basically this scenario occurs during boot while
> +        * printing debug bootlogs.
> +        */
> +
> +       if (!console_lock &&
> +               up->pdev->dev.power.runtime_status =3D=3D RPM_SUSPEND=
ING)
> +               return;
> +
>         local_irq_save(flags);
>         if (up->port.sysrq)
>                 locked =3D 0;
>
> ------------
>
> Is it ok to check the RPM_SUSPENDING flag in driver ?
> I can't find any API currently available under runtime.h to use.

I would propose a new API in pm_runtime.h similar to
pm_runtime_suspended() that checks for this.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
