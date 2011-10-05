From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v6 01/16] OMAP2+: hwmod: Add API to enable IO ring wakeup.
Date: Wed, 05 Oct 2011 17:27:04 +0530
Message-ID: <4E8C4610.1040307@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>	<4E871883.4010207@ti.com> <8762k48o66.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:33566 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934221Ab1JEL5P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 07:57:15 -0400
In-Reply-To: <8762k48o66.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Dhavlikar, Nilesh" <dnilesh@ti.com>

Hi Kevin,

On Wednesday 05 October 2011 02:33 AM, Kevin Hilman wrote:
> Hi Rajendra,
>
> Rajendra Nayak<rnayak@ti.com>  writes:
>
>> On Friday 30 September 2011 04:31 PM, Govindraj.R wrote:
>>> Add API to enable IO pad wakeup capability based on mux dynamic pad=
 and
>>> wake_up enable flag available from hwmod_mux initialization.
>>>
>>> Use the wakeup_enable flag and enable wakeup capability
>>> for the given pads. Wakeup capability will be enabled/disabled
>>> during hwmod idle transition based on whether wakeup_flag is
>>> set or cleared.
>>>
>>> Call the omap_hwmod_set_ioring_wakeup from hwmod_wakeup_enable/disa=
ble.
>>>
>>> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
>>> ---
>>>    arch/arm/mach-omap2/omap_hwmod.c |   59 ++++++++++++++++++++++++=
++++++++++++++
>>>    1 files changed, 59 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2=
/omap_hwmod.c
>>> index 84cc0bd..e751dd9 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -2062,6 +2062,34 @@ static int __init omap_hwmod_setup_all(void)
>>>    core_initcall(omap_hwmod_setup_all);
>>>
>>>    /**
>>> + * omap_hwmod_set_ioring_wakeup - enable io pad wakeup flag.
>>> + * @oh: struct omap_hwmod *
>>> + * @set: bool value indicating to set or clear wakeup status.
>>> + *
>>> + * Set or Clear wakeup flag for the io_pad.
>>> + */
>>> +static int omap_hwmod_set_ioring_wakeup(struct omap_hwmod *oh, boo=
l set_wake)
>>> +{
>>> +	struct omap_device_pad *pad;
>>> +	int ret =3D -EINVAL, j;
>>> +
>>> +	if (oh->mux&&   oh->mux->enabled) {
>>> +		for (j =3D 0; j<   oh->mux->nr_pads_dynamic; j++) {
>>> +			pad =3D oh->mux->pads_dynamic[j];
>>> +			if (pad->flags&   OMAP_DEVICE_PAD_WAKEUP) {
>>> +				if (set_wake)
>>> +					pad->idle |=3D OMAP_WAKEUP_EN;
>>> +				else
>>> +					pad->idle&=3D ~OMAP_WAKEUP_EN;
>>
>> I think apart from enabling/disabling the IO wakeup's at the pad
>> level, there is also a need to trigger the IO daisy chain control
>> (Wu clock) by programming the PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN
>> bit and waiting on the PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN) bit,
>> which is done by the omap3_enable/disable_io_chain function.
>> This is still done in the cpuidle path, but it makes sense to
>> move that over here, since it should be done every time a pad
>> level wakeup is enabled or disabled.
>
> So should it be done just here or also in the idle path?  In general,
> I'm certainly for moving things out of the idle path into the places
> where they belong.
>
> However, I don't get from the TRM description below that it should be
> done every time a pad-level wake is enabled or disabled.  Can you
> clarify what part of the TRM description you mean?

+ Nilesh from the PRCM design team, I and Vishwa had a short meeting
with Nilesh just to double confirm our understanding on how IO daisy
should be implemented.

I agree the OMAP3 TRM isn't very clear in mentioning this and overall
there is very limited documentation on this.

The OMAP4 TRM however is a little better and there isn't any difference
in the way IO Daisy is implemented in OMAP3 and OMAP4.

So, I'll try and explain what I meant based on whats in the OMAP4 TRM :=
)

I am referring to OMAP4430_ES2.x Public TRM vO.

refer to Figure 3-74. I/O Pads Daisy-Chain Configuration,
The WUEN signal to each pad (which can be used to enable IO-daisy
for the given pad) is a AND of a signal from PRCM and
one from SCM.
The signal from PRCM can be enabled by writing into
PRM_IO_PMCTRL[16] GLOBAL_WUEN bit (which in our case we keep
enabled always, done early at boot).
The signal from SCM can be enabled by writing to the individual
pad registers in SCM
CONTROL.CONTROL_PADCONF_<IOpad>[14] WAKEUPENABLE0
CONTROL.CONTROL_PADCONF_<IOpad>[30] WAKEUPENABLE1.
This is done by hwmod every time the module is enabled/idled.

This is what is mentioned in the TRM here
"The I/O pad wake-up scheme must be enabled (WUEN signal) globally by=20
setting the
PRM_IO_PMCTRL[16] GLOBAL_WUEN bit and by also setting I/O pad wake-up=20
enabled/disabled
individually (WUEN signal) by writing to the following bit fields in th=
e=20
control module:
=95 CONTROL.CONTROL_PADCONF_<IOpad>[14] WAKEUPENABLE0
=95 CONTROL.CONTROL_PADCONF_<IOpad>[30] WAKEUPENABLE1"

And then the TRM mentions this about the need to trigger WUCLKIN
for every pad enable/disable.
This is needed to reset any spurious wakeups events.

"Once configured, the wake-up scheme within each I/O pad is enabled and=
=20
disabled by triggering a control
(WUCLKIN signal) of the I/O daisy chain. This is done thanks to a=20
dedicated PRCM module register bit
PRM_IO_PMCTRL[8] WUCLK_CTRL. The software must enable the I/O wakeup=20
prior entering a
low-power mode and disable it following a wake-up event.
Writing the PRM_IO_PMCTRL[8] WUCLK_CTRL bit to 1 asserts signal WUCLKIN=
=20
high to reset spurious
wake-up event and to latch the current pad input value. PRCM module=20
register PRM_IO_PMCTRL[9]
WUCLK_STATUS logs the signal WUCLKOUT of the last pad of the I/O ring.=20
Once this status is set to 1,
the software may clear the PRM_IO_PMCTRL[8] WUCLK_CTRL bit to=20
effectively enable or disable the
wake-up feature within each pad."

The controls are exactly the same in case of OMAP3.
There is a global control at PRCM level (PRCM.PM_WKEN_WKUP[8] EN_IO)
and at pad level in SCM.

To assert the WUCLKIN, there is PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN
and to log the signal WUCLKOUT of the last pad there is
PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN.

Its just that the registers in OMAP3 are named weirdly, the digram isn'=
t
any clear and the explanation in the TRM does not help much,
causing confusion.

 > All I understand is that it has to be done before PER domain
 > transisions.

This is mostly coming from pre 3430 es3 days when there was no
control for a WUCLKIN trigger in software. The hardware did this
based on per/core entering sleep states.

With 3430es3.1 and the subsequent 3630/4430/4460 silicons, the software
can decide when to enable/trigger iodaisy and it should ideally be done
before the powerdomain corresponding to the given module transitions to
RET or OFF. Until then the modules async wakeup is expected to generate
a wakeup.

 > Also, if this were to happen, are there side-effects of having the I=
O
 > daisy chain armed outside the idle path?

IO daisy is actually designed so that it can be armed outside of idle,
by providing software control to generate the WUCLKIN pulse.

So as long as a module is clocked, it can generate interrupts, once
its clocks are cut, it can generate an async wakeup, and once the
powerdomain belonging to the module transitions to RET or OFF, it shoul=
d
be programmed to generate IO wakeup, independent of system idle state.

regards,
Rajendra

>
>
>
> Kevin
>
>> See section 3.5.7.2.2 I/O Wake-Up Mechanism of 36xx TRM revA.
>>
>> "The I/O wake-up scheme is enabled by triggering the I/O daisy chain
>> control (Wu clock) by
>> programming a dedicated register (PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN)
>> in the PRCM module.Software must wait for the I/O daisy chain to
>> complete before it transitions the PER domain to a
>> nonfunctional state. This is done by polling a dedicated status bit =
in
>> the PRCM module
>> (PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN). This status bit must be cleared
>> by software when the bit is
>> read to 1."

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
