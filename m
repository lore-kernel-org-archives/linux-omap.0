From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 02/16] OMAP2+: hwmod: Add API to check IO PAD wakeup status
Date: Mon, 3 Oct 2011 10:30:47 +0530
Message-ID: <CAAL8m4zLz4kv+nNPKHD6zKG0pdXifXpmWiHnLAyn_bq228qHXA@mail.gmail.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
 <1317380495-584-2-git-send-email-govindraj.raja@ti.com> <4E8724D7.6060907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4E8724D7.6060907@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Thanks for the review,


On Sat, Oct 1, 2011 at 8:03 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Friday 30 September 2011 04:31 PM, Govindraj.R wrote:
>>
>> Add API to determine IO-PAD wakeup event status for a given
>> hwmod dynamic_mux pad.
>>
>> Wake up event set will be cleared on pad mux_read.
>
> Are these api's even getting used in this series?

Used in Tero's irq_chaining patches.

http://lkml.org/lkml/2011/9/23/121

--
Thanks,
Govindraj.R


>
>>
>> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/mux.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 30
>> ++++++++++++++++++++++++++
>> =A0arch/arm/mach-omap2/mux.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 13 +++++++++++
>> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
7 ++++++
>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 +
>> =A04 files changed, 51 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
>> index 655e948..fb75aae 100644
>> --- a/arch/arm/mach-omap2/mux.c
>> +++ b/arch/arm/mach-omap2/mux.c
>> @@ -351,6 +351,36 @@ err1:
>> =A0 =A0 =A0 =A0return NULL;
>> =A0}
>>
>> +/**
>> + * omap_hwmod_mux_get_wake_status - omap hwmod check pad wakeup
>> + * @hmux: =A0 =A0 =A0 =A0 =A0 =A0 =A0Pads for a hwmod
>> + *
>> + * Gets the wakeup status of given pad from omap-hwmod.
>> + * Returns true if wakeup capability is set and wakeup event occurr=
ed.
>> + * Returns false if wakeup event has not occurred or pads are not
>> available.
>> + */
>> +bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmu=
x)
>> +{
>> + =A0 =A0 =A0 int i;
>> + =A0 =A0 =A0 unsigned int val;
>> + =A0 =A0 =A0 u8 ret =3D false;
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i< =A0hmux->nr_pads; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_device_pad *pad =3D&hmux->=
pads[i];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pad->flags& =A0OMAP_DEVICE_PAD_WAK=
EUP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D omap_mux_read(=
pad->partition,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pad->mux->reg_offset);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val& =A0OMAP_WAKEU=
P_EVENT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 true;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> =A0/* Assumes the calling function takes care of locking */
>> =A0void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>> =A0{
>> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
>> index 2132308..8b2150a 100644
>> --- a/arch/arm/mach-omap2/mux.h
>> +++ b/arch/arm/mach-omap2/mux.h
>> @@ -225,8 +225,21 @@ omap_hwmod_mux_init(struct omap_device_pad *bpa=
ds,
>> int nr_pads);
>> =A0 */
>> =A0void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
>>
>> +/**
>> + * omap_hwmod_mux_get_wake_status - omap hwmod check pad wakeup
>> + * @hmux: =A0 =A0 =A0 =A0 =A0 =A0 =A0Pads for a hwmod
>> + *
>> + * Called only from omap_hwmod.c, do not use.
>> + */
>> +bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmu=
x);
>> =A0#else
>>
>> +static inline bool
>> +omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
>> +{
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> =A0static inline int omap_mux_init_gpio(int gpio, int val)
>> =A0{
>> =A0 =A0 =A0 =A0return 0;
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>> b/arch/arm/mach-omap2/omap_hwmod.c
>> index e751dd9..a8b24d7 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -2724,3 +2724,10 @@ int omap_hwmod_no_setup_reset(struct omap_hwm=
od
>> *oh)
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>> +
>> +int omap_hwmod_pad_get_wakeup_status(struct omap_hwmod *oh)
>> +{
>> + =A0 =A0 =A0 if (oh&& =A0oh->mux)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return omap_hwmod_mux_get_wake_status(=
oh->mux);
>> + =A0 =A0 =A0 return -EINVAL;
>> +}
>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> index 0e329ca..9a6195c 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> @@ -607,6 +607,7 @@ u32 omap_hwmod_get_context_loss_count(struct
>> omap_hwmod *oh);
>>
>> =A0int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
>>
>> +int omap_hwmod_pad_get_wakeup_status(struct omap_hwmod *oh);
>> =A0/*
>> =A0 * Chip variant-specific hwmod init routines - XXX should be conv=
erted
>> =A0 * to use initcalls once the initial boot ordering is straightene=
d out
>
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
