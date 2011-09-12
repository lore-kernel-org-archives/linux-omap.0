From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v4 07/11] Serial: OMAP: Add runtime pm support for
 omap-serial driver
Date: Mon, 12 Sep 2011 12:28:52 +0530
Message-ID: <CAAL8m4xu+X3A_8kihro__eVx3V0UORNfQPWon8Trq0vHyLEPjQ@mail.gmail.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
 <1315400013-4849-8-git-send-email-govindraj.raja@ti.com> <87obyu36lo.fsf@ti.com>
 <CAAL8m4wpCVrhY7++ROwu0Whh4w_cF_dUr0t5622+WmJZah_FRA@mail.gmail.com>
 <8739g5y45m.fsf@ti.com> <CAAL8m4zR06U115V52+fT84dc6g7PYkLb1jJaMKGyi2VJhFtYxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4zR06U115V52+fT84dc6g7PYkLb1jJaMKGyi2VJhFtYxg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 12, 2011 at 12:25 PM, Govindraj <govindraj.ti@gmail.com> wr=
ote:
> On Fri, Sep 9, 2011 at 11:44 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Govindraj <govindraj.ti@gmail.com> writes:
>>
>>> On Fri, Sep 9, 2011 at 5:54 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>>
>>>>> Adapts omap-serial driver to use pm_runtime API's.
>>>>>
>>>>> 1.) Moving context_restore func to driver from serial.c
>>>>> 2.) Use runtime irq safe to use get_sync from irq context.
>>>>> 3.) autosuspend for port specific activities and put for reg acce=
ss.
>>>>
>>>> Re: autosuspend, it looks like the driver now has 2 mechanisms for
>>>> tracking activity. =A0The runtime PM 'mark last busy' and the exis=
ting
>>>> 'up->port_activity =3D jiffies' stuff. =A0Do you think those could=
 be
>>>> unified?
>>>>
>>>
>>> Is there a way where we can retrieve the last busy jiffie value
>>> using runtime API? I don't find that available.
>>>
>>
>> Not currently. =A0The question is more along the lines of: what is t=
he
>> port_activity jiffies used for, and can it be replaced by using
>> _mark_last_busy().
>>
>> If it cannot, that's fine, but it should be described.
>
> Okay.
>
>>
>>>> At first glance, it looks like most places with a _mark_last_busy(=
) also
>>>> have a up->port_activity update. =A0I'm not familiar enough with t=
he
>>>> driver to make the call, but they look awfully similar.
>>>>
>>>
>>> Ok, I will check whether I can get rid if it.
>>>
>>>>> 4.) for earlyprintk usage the debug macro will write to console u=
art
>>>>> =A0 =A0 so keep uart clocks active from boot, idle using hwmod AP=
I's re-enable back
>>>>> =A0 =A0 using runtime API's.
>>>>
>>>> /me doesn't understand
>>>
>>> I have added this reason in early mail reply to 04/11 patch review
>>> [needed for earlyprintk option from low level debug ]
>>
>> OK, but AFAIK, DEBUG_LL + earlyprintk do not use this driver. =A0Ins=
tead
>> they use the debug macros, so any hacks to deal with that do not bel=
ong
>> in the driver.
>>
>> If there are hacks required, they should be in a separate patch, wit=
h a
>> separate descriptive changelog.
>>
>
> Yes these are required, because early printk relies on clocks from bo=
otloader
> and if clocks are gated even before console_driver is available it ca=
n
> lead to boot failures.
>
> I can keep that part as a separate patch.
>
>
>>>>
>>>>> 5.) Moving context restore to runtime suspend and using reg value=
s from port
>>>>> =A0 =A0 structure to restore the uart port context based on conte=
xt_loss_count.
>>>>> =A0 =A0 Maintain internal state machine for avoiding repeated ena=
ble/disable of
>>>>> =A0 =A0 uart port wakeup mechanism.
>>>>> 6.) Add API to enable wakeup and check wakeup status.
>>>>>
>>>>> Acked-by: Alan Cox <alan@linux.intel.com>
>>>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>>>> ---
>>>>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 49 ++++++
>>>>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 10 ++
>>>>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0211 ++++++++++++++++++++++---
>>>>> =A03 files changed, 250 insertions(+), 20 deletions(-)
>>>>>
>>>
>>> [..]
>>>
>>>>> +
>>>>> +static void omap_uart_wakeup_enable(struct platform_device *pdev=
, bool enable)
>>>>> +{
>>>>> + =A0 =A0 struct omap_device *od;
>>>>> + =A0 =A0 struct omap_uart_port_info *up =3D pdev->dev.platform_d=
ata;
>>>>> +
>>>>> + =A0 =A0 /* Set or clear wake-enable bit */
>>>>> + =A0 =A0 if (up->wk_en && up->wk_mask) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 v =3D __raw_readl(up->wk_en);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v |=3D up->wk_mask;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v &=3D ~up->wk_mask;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(v, up->wk_en);
>>>>> + =A0 =A0 }
>>>>> +
>>>>> + =A0 =A0 od =3D to_omap_device(pdev);
>>>>> + =A0 =A0 if (enable)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hwmod_enable_wakeup(od->hwmods[0])=
;
>>>>> + =A0 =A0 else
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hwmod_disable_wakeup(od->hwmods[0]=
);
>>>>> +}
>>>>> +
>>>>
>>>> Here again, this is difficult to review because you removed the co=
de in
>>>> [4/11] and add it back here, but with rather different functionali=
ty
>>>> with no description as to why.
>>>>
>>>
>>> will move this change as part of 4/11 itself.
>>>
>>
>> The point was not just that the move was confusing, but that you cha=
nged
>> the functionality along with the move without any description.
>>
>
> If are referring to uart rx pad wakeup its still retained but done
> using mux framework.
>
>>>> The previous version enabled wakeups at the PRCM and at the IO rin=
g.
>>>> This version enables wakeups at the PRCM as well but instead of en=
abling
>>>> them at the IO ring, enables them at the module.
>>>>
>>>
>>> Since we are gating using prepare idle call I think
>>> we can use this enable wake-up call as part of prepare idle call it=
self,
>>> as done earlier.
>>
>> Not sure what that has to with my comment.
>>
>> In moving this code, you removed the enable/disable of IO ring wakeu=
ps.
>> It probably continues to work because they're enabled by the bootloa=
der,
>> but that is not correct and the driver should be managing the IO rin=
g
>> wakeups as before.
>>
>
> Prior to this we used io-pad offsets address and modified to enable w=
akeup
> mechanism, But since we received some comments from Tony to use mux f=
ramework
> for any mux changes, I removed using mux address and use mux framewor=
k from
> hwmod, I have not removed rx-pad wakeup still enable io-pad wakeup.
> otherwise wakeup from off-mode will fail on 3430SDP.
>
> omap_uart_wakeup_enable
> =A0 =A0--> omap_hwmod_enable_wakeup
> =A0 =A0 =A0 =A0 =A0 --> omap_hwmod_enable_ioring_wakeup [PATCH v4 01/=
11]
> OMAP2+: hwmod: Add API to enable IO ring wakeup.]
>
> boot-loaders doesn't enable io pad wakeup for uart.
>
>
>> [...]
>>
>>>>> =A0}
>>>>>
>>>>> =A0static int __init
>>>>> @@ -1065,22 +1123,33 @@ static struct uart_driver serial_omap_reg=
 =3D {
>>>>> =A0 =A0 =A0 .cons =A0 =A0 =A0 =A0 =A0 =3D OMAP_CONSOLE,
>>>>> =A0};
>>>>>
>>>>> -static int
>>>>> -serial_omap_suspend(struct platform_device *pdev, pm_message_t s=
tate)
>>>>> +static int serial_omap_suspend(struct device *dev)
>>>>> =A0{
>>>>> - =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(pdev=
);
>>>>> + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>>>>>
>>>>> - =A0 =A0 if (up)
>>>>> + =A0 =A0 if (up) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_suspend_port(&serial_omap_reg, &=
up->port);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (up->port.line =3D=3D up->port.cons-=
>index &&
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !is_con=
sole_locked())
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->console_locked =3D =
console_trylock();
>>>>> + =A0 =A0 }
>>>>> +
>>>>
>>>> Motiviation for console locking in this version of the series is n=
ot
>>>> clear, and not described in the changelog.
>>>>
>>>> It's also present here in static suspend/resume but not in runtime
>>>> suspend/resume, which also is suspicious.
>>>>
>>>
>>> Yes will add to change log,
>>>
>>> We needed this for no console suspend use case
>>> no console lock is taken in no_console_suspend is specified,
>>>
>>> Since our pwr_dmn hooks disable clocks left enabled during suspend,
>>> so any prints after pwr_dmn hooks can cause problems since clocks
>>> are already cut from pwr_dmn hooks.
>>>
>>> So buffer prints while entering suspend by taking console lock
>>> if not taken already and print back after uart state machine restor=
es
>>> console uart.
>>
>> Any special consideration for features like no_console_suspend shoul=
d be
>> done in a separate patch with a separate changelog.
>>
>
> will add as separate patch.
>
>> However, as I've stated before during previous reviews, if someone h=
as
>> put no_console_suspend on the command line, that means they've
>> specifically stated they *want* to see console writes during suspend=
=2E
>> That means, we should not cut clocks at all.
>>
>> Of course, that means the system will not hit the low power state be=
case
>> the UART clocks are not gated, but that is what the user requested.
>
> Yes correct, But pwr domain callback will now cut all enabled clocks
> now, so only available method was to use console_lock and print later=
=2E
>
> pwr_domain callback done in omap-device.c
> will force to low powers state by gating all clocks that where left
> enabled by driver.
>

=46orgot to specify that the above statement is in context to system wi=
de
suspend scenario and not cpu_idle path use cases.



> --
> Thanks,
> Govindraj.R
>
>
>>
>>
>> Kevin
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
