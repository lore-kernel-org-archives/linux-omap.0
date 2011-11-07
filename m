From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v7 16/21] OMAP2+: UART: Remove custom activate funcs and
 use generic funcs.
Date: Mon, 7 Nov 2011 14:09:01 +0530
Message-ID: <CAAL8m4y1LOhZSLGO5rJQzFxnWxi7gBsHyLfKLNuRxNB465b=rQ@mail.gmail.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
 <1318952110-10659-2-git-send-email-govindraj.raja@ti.com> <877h3f5z0x.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <877h3f5z0x.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 5, 2011 at 3:30 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> The custom hwmod activate and deactivate funcs does hwmod_enable
>> and idle same can be done with omap_device generic API's.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> This one needs a minor update for current mainline...
>
>> ---
>> =A0arch/arm/mach-omap2/serial.c | =A0 18 ++----------------
>> =A01 files changed, 2 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index 7c65410..7658a03 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -78,24 +78,10 @@ static struct omap_uart_port_info omap_serial_de=
fault_info[] __initdata =3D {
>> =A0 =A0 =A0 },
>> =A0};
>>
>> -static int uart_idle_hwmod(struct omap_device *od)
>> -{
>> - =A0 =A0 omap_hwmod_idle(od->hwmods[0]);
>> -
>> - =A0 =A0 return 0;
>> -}
>> -
>> -static int uart_enable_hwmod(struct omap_device *od)
>> -{
>> - =A0 =A0 omap_hwmod_enable(od->hwmods[0]);
>> -
>> - =A0 =A0 return 0;
>> -}
>> -
>> =A0static struct omap_device_pm_latency omap_uart_latency[] =3D {
>> =A0 =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D uart_idle_hwmod,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =A0 =3D uart_enable_hwmod,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =A0 =3D omap_device_enable_=
hwmods,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D omap_device_idle_hwmo=
ds,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D OMAP_DEVICE_LATENCY_AUTO_ADJU=
ST,
>> =A0 =A0 =A0 },
>> =A0};
>
> If we're just using default pm_latency struct, it can be passed to
> omap_device_build as NULL, and a default one will be configured.
>

yes, will update this.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
