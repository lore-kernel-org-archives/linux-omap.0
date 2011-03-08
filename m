From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable
 requested pads
Date: Tue, 8 Mar 2011 17:49:31 +0530
Message-ID: <AANLkTin2f7n-v5Hg7NHB8a4fEmpzt_07xy-M1wjnKHtU@mail.gmail.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com> <87lj0u8mrf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87lj0u8mrf.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 5, 2011 at 5:24 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Govindraj,
>
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> For device pads which have OMAP_DEVICE_PAD_WAKEUP set (which means t=
hey
>> are wakeup capable) enable the IO-daisy wakeup capability.
>> During re-muxing avoid direct write with val as this can disturb if =
any
>> mux done at bootloader level so read the pad then write back.
>>
>> Also add an API to fetch the wake-up status bit is set for given oma=
p-hwmod
>> device using available mux info which is added during omap_hwmod_mux=
_init.
>> Wakeup status bit is needed for uart_resume_idle call from sram_idle=
 path
>> based on wake-up event has occurred for given uart we can enable clo=
cks back.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/mux.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 28 ++++++++++++++++++++++++++
>> =A0arch/arm/mach-omap2/mux.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 13 ++++++++++++
>> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 13=
 ++++++++++++
>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 +
>> =A04 files changed, 55 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
>> index 98148b6..50edcea 100644
>> --- a/arch/arm/mach-omap2/mux.c
>> +++ b/arch/arm/mach-omap2/mux.c
>> @@ -317,6 +317,29 @@ err1:
>> =A0 =A0 =A0 return NULL;
>> =A0}
>>
>> +/* Gets the wakeup status of given pad from omap-hwmod */
>> +int omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)
>
> should return a bool
>
> Also, documentation should be clear that it returns true if *any* pad
> associated with this device has a wakeup event.
>
> Also a name reflecting the get/check/status nature of this function
> would help readability, maybe:
>
> bool omap_hwmod_mux_wakeup_event(struct omap_hwmod_mux_info *hmux)

Yes sure will modify.

>
>> +{
>> + =A0 =A0 int i;
>> + =A0 =A0 unsigned int val;
>> + =A0 =A0 u8 ret =3D 0;
>> +
>> + =A0 =A0 for (i =3D 0; i < hmux->nr_pads; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct omap_device_pad *pad =3D &hmux->pad=
s[i];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pad->flags & OMAP_DEVICE_PAD_WAKEUP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D omap_mux_read(pad-=
>partition,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 pad->mux->reg_offset);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val & OMAP_WAKEUP_EVEN=
T) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> =A0/* Assumes the calling function takes care of locking */
>> =A0void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>> =A0{
>> @@ -342,6 +365,9 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *=
hmux, u8 state)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags &=3D ~OMAP_DEVICE_=
PAD_ENABLED;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D pad->idle;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags & OMAP_DEVICE_PA=
D_WAKEUP)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D O=
MAP_WAKEUP_EN;
>> +
>
> Is this needed on every idle transition?
>
> You're currently setting it on every idle transition, but never clear=
ing
> it. =A0If it is to be a one-time thing, then move it to the early ini=
t of
> the mux.

I will be removing this as said in earlier mail.


>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Idling %s =
%x\n", __func__,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 pad->name, val);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> @@ -358,6 +384,8 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *=
hmux, u8 state)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val >=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D omap_mux_read(pad=
->partition,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 pad->mux->reg_offset);
>
> I don't think this is doing what you expect, and will lead to very
> difficult to find bugs. =A0Since your OR'ing in bits from the current
> value, you will never be able to clear any bits in this register.
>
> As just a dumb example, consider the enable case where
> pad->enable=3DMUX_MODE0 (0x0). =A0If the bootloader has initialized t=
his pad
> to MUX_MODE7 (0x7), this code will never set it to MUX_MODE0, since t=
his
> read and OR of the existing value will always set it back to MUX_MODE=
7.
>
> At a minimum, this change should be a separate patch with a more
> detailed description.
>

Also this is change will be removed and default serial_pad
reg will have proper values for .enable and .idle fields using
which it will muxed accordingly
[snip of default rx serial reg given in previous mail.]

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_write(pad->part=
ition, val,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 pad->mux->reg_offset);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pad->flags =3D flags;
>> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
>> index a4ab17a..84a8fc2 100644
>> --- a/arch/arm/mach-omap2/mux.h
>> +++ b/arch/arm/mach-omap2/mux.h
>> @@ -220,8 +220,21 @@ omap_hwmod_mux_init(struct omap_device_pad *bpa=
ds, int nr_pads);
>> =A0 */
>> =A0void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
>>
>> +
>> +/**
>> + * omap_hwmod_mux_wakeup - omap hwmod check given pad had wakeup ev=
ent
>> + * @hmux: =A0 =A0 =A0 =A0 =A0 =A0Pads for a hwmod
>> + *
>> + * Called only from omap_hwmod.c, do not use.
>> + */
>> +int omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux);
>> =A0#else
>>
>> +static inline int omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info =
*hmux)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> =A0static inline int omap_mux_init_gpio(int gpio, int val)
>> =A0{
>> =A0 =A0 =A0 return 0;
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/=
omap_hwmod.c
>> index 9e89a58..893dae1 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -2239,3 +2239,16 @@ u32 omap_hwmod_get_context_loss_count(struct =
omap_hwmod *oh)
>>
>> =A0 =A0 =A0 return ret;
>> =A0}
>> +
>> +/**
>> + * omap_hwmod_pad_wakeup_status - get pad wakeup status if mux is a=
vailable.
>> + * @oh: struct omap_hwmod *
>> + *
>> + * Returns the wake_up status bit of available pad mux pin.
>> + */
>> +int omap_hmwod_pad_wakeup_status(struct omap_hwmod *oh)
>
> Again, naming here could improve readability. =A0Maybe:
>
> bool omap_hmwod_get_io_wakeup_status(struct omap_hwmod *oh)
>
> From the name and the bool return, it should be clear that this is ju=
st
> checking for the wakeup event. =A0I also think it should be clear tha=
t
> this is checking for IO-ring wakeups, not module wakeups.
>
> Also, in PATCH 5/7, you're calling this hwmod API directly from a
> driver. =A0Drivers should not know anything about hwmods. =A0Any
> OMAP-specific hooks must be called through pdata function pointers.
> Also, they should go through omap_device, which would then call
> omap_hwmod.
>

Agree omap-device level api to pad wakeup check is better.


> Thinking more about this (and how you use it in PATCH 5/7), what is
> needed is an omap_device level API to check if a wakeup occured for t=
hat
> device. =A0That function would check for either module-level wakeup o=
r IO
> pad wakeup. =A0The driver should not need to care about how the wakeu=
p
> occurred.
>

Module level wakeup doesn't seem to work and only
way it seem to wakeup is through using resume_idle
from sram_idle.

One simple way to reproduce the problem with
existing code base also is adding this patch which
will enable module level wakeup always.

https://patchwork.kernel.org/patch/501211/

and with below change.

govindraj@Linux-BSP-Server:~/clones/linux-omap-2.6$ gd
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index 47eef48..6343773 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -380,6 +380,7 @@ static void omap_uart_allow_sleep(struct
omap_uart_state *uart)
        omap_uart_smart_idle_enable(uart, 1);
        uart->can_sleep =3D 1;
        del_timer(&uart->timer);
+       omap_uart_disable_clocks(uart);
 }

We can see module level wakeup doesn't wakeup the uart.
once we set sleep_timeout for uart and timer starts.


>> +{
>> + =A0 =A0 if (oh->mux)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return omap_hwmod_mux_wakeup(oh->mux);
>> + =A0 =A0 return -EINVAL;
>> +}
>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm=
/plat-omap/include/plat/omap_hwmod.h
>> index fedd829..4100be0 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> @@ -588,6 +588,7 @@ int omap_hwmod_for_each_by_class(const char *cla=
ssname,
>> =A0int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 stat=
e);
>> =A0u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>>
>> +int omap_hmwod_pad_wakeup_status(struct omap_hwmod *oh);
>> =A0/*
>> =A0 * Chip variant-specific hwmod init routines - XXX should be conv=
erted
>> =A0 * to use initcalls once the initial boot ordering is straightene=
d out
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
