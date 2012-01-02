From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v8 19/20] OMAP2+: UART: Do not gate uart clocks if used
 for debug_prints
Date: Mon, 2 Jan 2012 16:00:37 +0530
Message-ID: <CAAL8m4yXD-gpeXNVsCOYeDkYDWmVX8FUcpXKjx6k=AXSF4V9iA@mail.gmail.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
 <1321005712-21871-5-git-send-email-govindraj.raja@ti.com> <B5906170F1614E41A8A28DE3B8D1214304B3E2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <B5906170F1614E41A8A28DE3B8D1214304B3E2@DBDE01.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "R, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Vaibhav,

On Mon, Jan 2, 2012 at 2:55 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> w=
rote:
> Hello,
>
> On Fri, Nov 11, 2011 at 15:31:52, R, Govindraj wrote:
> [...]
>>
>> - =A0 =A0 if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pad=
s)
>> + =A0 =A0 if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pa=
ds)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && !uart_debug)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_init_wakeup(&pdev->dev, true);
>> =A0}
>
> I was testing this on AM335x and realized that this leads to creation=
 of two
> 'wakeup' entries for UART. One is created by the tty layer in serial-=
core.c
> and the other is created here.
>
> Here's what I see on a branch based on Tony's 3.2-rc6:
>
> ./sys/devices/platform/omap/omap_uart.0/power/wakeup
> ./sys/devices/platform/omap/omap_uart.0/tty/ttyO0/power/wakeup
>
> Shouldn't the OMAP serial just enable the 'wakeup' entry created by s=
erial-core.c?

currently runtime pm is available from omap-serial device and not from =
tty_dev.
Setting tty_dev wakeup is to use irq_wakeup from suspend available
from serail_core layer which I think we are not using for omap-uart
and we use pad wakeup from suspend path.

Also omap-uart.x/power/wakeup is used to gate uart clocks using runtime
PM api's in omap-serial driver.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
