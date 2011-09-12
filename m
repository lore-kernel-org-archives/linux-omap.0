From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 07/11] Serial: OMAP: Add runtime pm support for omap-serial driver
Date: Mon, 12 Sep 2011 10:01:23 -0700
Message-ID: <87sjo1itjw.fsf@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
	<1315400013-4849-8-git-send-email-govindraj.raja@ti.com>
	<87obyu36lo.fsf@ti.com>
	<CAAL8m4wpCVrhY7++ROwu0Whh4w_cF_dUr0t5622+WmJZah_FRA@mail.gmail.com>
	<8739g5y45m.fsf@ti.com>
	<CAAL8m4zR06U115V52+fT84dc6g7PYkLb1jJaMKGyi2VJhFtYxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51797 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751206Ab1ILRBa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 13:01:30 -0400
In-Reply-To: <CAAL8m4zR06U115V52+fT84dc6g7PYkLb1jJaMKGyi2VJhFtYxg@mail.gmail.com>
	(Govindraj's message of "Mon, 12 Sep 2011 12:25:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

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
>>>> tracking activity. =C2=A0The runtime PM 'mark last busy' and the e=
xisting
>>>> 'up->port_activity =3D jiffies' stuff. =C2=A0Do you think those co=
uld be
>>>> unified?
>>>>
>>>
>>> Is there a way where we can retrieve the last busy jiffie value
>>> using runtime API? I don't find that available.
>>>
>>
>> Not currently. =C2=A0The question is more along the lines of: what i=
s the
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
>>>> have a up->port_activity update. =C2=A0I'm not familiar enough wit=
h the
>>>> driver to make the call, but they look awfully similar.
>>>>
>>>
>>> Ok, I will check whether I can get rid if it.
>>>
>>>>> 4.) for earlyprintk usage the debug macro will write to console u=
art
>>>>> =C2=A0 =C2=A0 so keep uart clocks active from boot, idle using hw=
mod API's re-enable back
>>>>> =C2=A0 =C2=A0 using runtime API's.
>>>>
>>>> /me doesn't understand
>>>
>>> I have added this reason in early mail reply to 04/11 patch review
>>> [needed for earlyprintk option from low level debug ]
>>
>> OK, but AFAIK, DEBUG_LL + earlyprintk do not use this driver. =C2=A0=
Instead
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

My point is that hacks/workaround for DEBUG_LL + earlyprintk don't
belong in this driver, since this driver is not involved.

> I can keep that part as a separate patch.

Yes please.

>>>>
>>>>> 5.) Moving context restore to runtime suspend and using reg value=
s from port
>>>>> =C2=A0 =C2=A0 structure to restore the uart port context based on=
 context_loss_count.
>>>>> =C2=A0 =C2=A0 Maintain internal state machine for avoiding repeat=
ed enable/disable of
>>>>> =C2=A0 =C2=A0 uart port wakeup mechanism.
>>>>> 6.) Add API to enable wakeup and check wakeup status.
>>>>>
>>>>> Acked-by: Alan Cox <alan@linux.intel.com>
>>>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>>>> ---
>>>>> =C2=A0arch/arm/mach-omap2/serial.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 49 ++++++
>>>>> =C2=A0arch/arm/plat-omap/include/plat/omap-serial.h | =C2=A0 10 +=
+
>>>>> =C2=A0drivers/tty/serial/omap-serial.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0211 ++++++++++++++++++++++---
>>>>> =C2=A03 files changed, 250 insertions(+), 20 deletions(-)
>>>>>
>>>
>>> [..]
>>>
>>>>> +
>>>>> +static void omap_uart_wakeup_enable(struct platform_device *pdev=
, bool enable)
>>>>> +{
>>>>> + =C2=A0 =C2=A0 struct omap_device *od;
>>>>> + =C2=A0 =C2=A0 struct omap_uart_port_info *up =3D pdev->dev.plat=
form_data;
>>>>> +
>>>>> + =C2=A0 =C2=A0 /* Set or clear wake-enable bit */
>>>>> + =C2=A0 =C2=A0 if (up->wk_en && up->wk_mask) {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 v =3D __raw_readl=
(up->wk_en);
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (enable)
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 v |=3D up->wk_mask;
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 v &=3D ~up->wk_mask;
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel(v, up->w=
k_en);
>>>>> + =C2=A0 =C2=A0 }
>>>>> +
>>>>> + =C2=A0 =C2=A0 od =3D to_omap_device(pdev);
>>>>> + =C2=A0 =C2=A0 if (enable)
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_hwmod_enable_wak=
eup(od->hwmods[0]);
>>>>> + =C2=A0 =C2=A0 else
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_hwmod_disable_wa=
keup(od->hwmods[0]);
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

OK, let me try this a slightly different way.  Here's what you did:

- remove some code in patch 4
- add it back in patch 7, but in different form (with no description of=
 diffs)
- the missing parts of original code are not documented
- moved code has some new (but undocumented) features (module-level wak=
eup)
- turns out the missing parts (IO pad wakeups) are done using a
  different framework in yet another patch (which would be fine, if it
  the reviewers were given a hint.)

I hope this is enough to demonstrate that trying to decipher what what
you meant to do, what you did, and what you didn't do is extremely
time consuming for a reviewer.

Well-constructed patches, broken up into *logical* chunks with
descriptive changelogs are invaluable to an efficient review process.

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
>     --> omap_hwmod_enable_wakeup
>            --> omap_hwmod_enable_ioring_wakeup [PATCH v4 01/11]
> OMAP2+: hwmod: Add API to enable IO ring wakeup.]
>
> boot-loaders doesn't enable io pad wakeup for uart.
>
>
>> [...]
>>
>>>>> =C2=A0}
>>>>>
>>>>> =C2=A0static int __init
>>>>> @@ -1065,22 +1123,33 @@ static struct uart_driver serial_omap_reg=
 =3D {
>>>>> =C2=A0 =C2=A0 =C2=A0 .cons =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 OMAP_CONSOLE,
>>>>> =C2=A0};
>>>>>
>>>>> -static int
>>>>> -serial_omap_suspend(struct platform_device *pdev, pm_message_t s=
tate)
>>>>> +static int serial_omap_suspend(struct device *dev)
>>>>> =C2=A0{
>>>>> - =C2=A0 =C2=A0 struct uart_omap_port *up =3D platform_get_drvdat=
a(pdev);
>>>>> + =C2=A0 =C2=A0 struct uart_omap_port *up =3D dev_get_drvdata(dev=
);
>>>>>
>>>>> - =C2=A0 =C2=A0 if (up)
>>>>> + =C2=A0 =C2=A0 if (up) {
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uart_suspend_por=
t(&serial_omap_reg, &up->port);
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (up->port.line =3D=
=3D up->port.cons->index &&
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !is_console_locked())
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 up->console_locked =3D console_trylock();
>>>>> + =C2=A0 =C2=A0 }
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

yes please.

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

These are the kinds of things that belong in a descriptive changelog.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
