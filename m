From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH] tty: omap-serial: Keep the wakeup mechanism enabled by default
Date: Wed, 18 Apr 2012 18:46:31 +0530
Message-ID: <CAMrsUdL1S5GiyG0egS=CHg2fdNkyZVF-wuCNGDg547kfTUODng@mail.gmail.com>
References: <1334579407-16970-1-git-send-email-govindraj.raja@ti.com> <87vckyq6ti.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87vckyq6ti.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 18, 2012 at 4:55 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> The wakeups can be left enabled by default and should be disabled
>> only when disabled from sysfs and while entering suspend.
>
> Left enabled? =A0That assumes something else has initizlied them, but=
 we
> can't make that assumption.
>
> First, wakeups should be disabled when ->probe has finished. =A0Then,
> they should be enabled whenever driver is in use, and disabled when
> the driver is not in use.
>
> I'm not familiar enough with uart_ops, but it looks like they should
> probably be enabled in uart_ops->startup and disabled in
> uart_ops->shutdown.

uart_ops->shutdown gets called in suspend path also
serial_omap_suspend =3D> uart_suspend_port =3D > ops->shutdown(uport);

This will leave uart wakeup disabled in suspend path.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
