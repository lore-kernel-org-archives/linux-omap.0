From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 07/11] Serial: OMAP: Add runtime pm support for omap-serial driver
Date: Fri, 09 Sep 2011 11:14:13 -0700
Message-ID: <8739g5y45m.fsf@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
	<1315400013-4849-8-git-send-email-govindraj.raja@ti.com>
	<87obyu36lo.fsf@ti.com>
	<CAAL8m4wpCVrhY7++ROwu0Whh4w_cF_dUr0t5622+WmJZah_FRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4wpCVrhY7++ROwu0Whh4w_cF_dUr0t5622+WmJZah_FRA@mail.gmail.com>
	(Govindraj's message of "Fri, 9 Sep 2011 12:02:49 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Fri, Sep 9, 2011 at 5:54 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> Adapts omap-serial driver to use pm_runtime API's.
>>>
>>> 1.) Moving context_restore func to driver from serial.c
>>> 2.) Use runtime irq safe to use get_sync from irq context.
>>> 3.) autosuspend for port specific activities and put for reg access=
=2E
>>
>> Re: autosuspend, it looks like the driver now has 2 mechanisms for
>> tracking activity. =C2=A0The runtime PM 'mark last busy' and the exi=
sting
>> 'up->port_activity =3D jiffies' stuff. =C2=A0Do you think those coul=
d be
>> unified?
>>
>
> Is there a way where we can retrieve the last busy jiffie value
> using runtime API? I don't find that available.
>

Not currently.  The question is more along the lines of: what is the
port_activity jiffies used for, and can it be replaced by using
_mark_last_busy().

If it cannot, that's fine, but it should be described.

>> At first glance, it looks like most places with a _mark_last_busy() =
also
>> have a up->port_activity update. =C2=A0I'm not familiar enough with =
the
>> driver to make the call, but they look awfully similar.
>>
>
> Ok, I will check whether I can get rid if it.
>
>>> 4.) for earlyprintk usage the debug macro will write to console uar=
t
>>> =C2=A0 =C2=A0 so keep uart clocks active from boot, idle using hwmo=
d API's re-enable back
>>> =C2=A0 =C2=A0 using runtime API's.
>>
>> /me doesn't understand
>
> I have added this reason in early mail reply to 04/11 patch review
> [needed for earlyprintk option from low level debug ]

OK, but AFAIK, DEBUG_LL + earlyprintk do not use this driver.  Instead
they use the debug macros, so any hacks to deal with that do not belong
in the driver.

If there are hacks required, they should be in a separate patch, with a
separate descriptive changelog.

>>
>>> 5.) Moving context restore to runtime suspend and using reg values =
from port
>>> =C2=A0 =C2=A0 structure to restore the uart port context based on c=
ontext_loss_count.
>>> =C2=A0 =C2=A0 Maintain internal state machine for avoiding repeated=
 enable/disable of
>>> =C2=A0 =C2=A0 uart port wakeup mechanism.
>>> 6.) Add API to enable wakeup and check wakeup status.
>>>
>>> Acked-by: Alan Cox <alan@linux.intel.com>
>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> ---
>>> =C2=A0arch/arm/mach-omap2/serial.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 49 ++++++
>>> =C2=A0arch/arm/plat-omap/include/plat/omap-serial.h | =C2=A0 10 ++
>>> =C2=A0drivers/tty/serial/omap-serial.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0211 ++++++++++++++++++++++---
>>> =C2=A03 files changed, 250 insertions(+), 20 deletions(-)
>>>
>
> [..]
>
>>> +
>>> +static void omap_uart_wakeup_enable(struct platform_device *pdev, =
bool enable)
>>> +{
>>> + =C2=A0 =C2=A0 struct omap_device *od;
>>> + =C2=A0 =C2=A0 struct omap_uart_port_info *up =3D pdev->dev.platfo=
rm_data;
>>> +
>>> + =C2=A0 =C2=A0 /* Set or clear wake-enable bit */
>>> + =C2=A0 =C2=A0 if (up->wk_en && up->wk_mask) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 v =3D __raw_readl(u=
p->wk_en);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (enable)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 v |=3D up->wk_mask;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 v &=3D ~up->wk_mask;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel(v, up->wk_=
en);
>>> + =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 od =3D to_omap_device(pdev);
>>> + =C2=A0 =C2=A0 if (enable)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_hwmod_enable_wakeu=
p(od->hwmods[0]);
>>> + =C2=A0 =C2=A0 else
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_hwmod_disable_wake=
up(od->hwmods[0]);
>>> +}
>>> +
>>
>> Here again, this is difficult to review because you removed the code=
 in
>> [4/11] and add it back here, but with rather different functionality
>> with no description as to why.
>>
>
> will move this change as part of 4/11 itself.
>

The point was not just that the move was confusing, but that you change=
d
the functionality along with the move without any description.

>> The previous version enabled wakeups at the PRCM and at the IO ring.
>> This version enables wakeups at the PRCM as well but instead of enab=
ling
>> them at the IO ring, enables them at the module.
>>
>
> Since we are gating using prepare idle call I think
> we can use this enable wake-up call as part of prepare idle call itse=
lf,
> as done earlier.

Not sure what that has to with my comment.

In moving this code, you removed the enable/disable of IO ring wakeups.
It probably continues to work because they're enabled by the bootloader=
,
but that is not correct and the driver should be managing the IO ring
wakeups as before.

[...]

>>> =C2=A0}
>>>
>>> =C2=A0static int __init
>>> @@ -1065,22 +1123,33 @@ static struct uart_driver serial_omap_reg =3D=
 {
>>> =C2=A0 =C2=A0 =C2=A0 .cons =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D O=
MAP_CONSOLE,
>>> =C2=A0};
>>>
>>> -static int
>>> -serial_omap_suspend(struct platform_device *pdev, pm_message_t sta=
te)
>>> +static int serial_omap_suspend(struct device *dev)
>>> =C2=A0{
>>> - =C2=A0 =C2=A0 struct uart_omap_port *up =3D platform_get_drvdata(=
pdev);
>>> + =C2=A0 =C2=A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>>>
>>> - =C2=A0 =C2=A0 if (up)
>>> + =C2=A0 =C2=A0 if (up) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uart_suspend_port(=
&serial_omap_reg, &up->port);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (up->port.line =3D=3D=
 up->port.cons->index &&
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !is_console_locked())
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 up->console_locked =3D console_trylock();
>>> + =C2=A0 =C2=A0 }
>>> +
>>
>> Motiviation for console locking in this version of the series is not
>> clear, and not described in the changelog.
>>
>> It's also present here in static suspend/resume but not in runtime
>> suspend/resume, which also is suspicious.
>>
>
> Yes will add to change log,
>
> We needed this for no console suspend use case
> no console lock is taken in no_console_suspend is specified,
>
> Since our pwr_dmn hooks disable clocks left enabled during suspend,
> so any prints after pwr_dmn hooks can cause problems since clocks
> are already cut from pwr_dmn hooks.
>
> So buffer prints while entering suspend by taking console lock
> if not taken already and print back after uart state machine restores
> console uart.

Any special consideration for features like no_console_suspend should b=
e
done in a separate patch with a separate changelog.

However, as I've stated before during previous reviews, if someone has
put no_console_suspend on the command line, that means they've
specifically stated they *want* to see console writes during suspend.
That means, we should not cut clocks at all.

Of course, that means the system will not hit the low power state becas=
e
the UART clocks are not gated, but that is what the user requested.


Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
