From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 01/16] OMAP2+: hwmod: Add API to enable IO ring wakeup.
Date: Tue, 04 Oct 2011 14:03:29 -0700
Message-ID: <8762k48o66.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<4E871883.4010207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4E871883.4010207@ti.com> (Rajendra Nayak's message of "Sat, 01
	Oct 2011 19:11:23 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Rajendra,

Rajendra Nayak <rnayak@ti.com> writes:

> On Friday 30 September 2011 04:31 PM, Govindraj.R wrote:
>> Add API to enable IO pad wakeup capability based on mux dynamic pad and
>> wake_up enable flag available from hwmod_mux initialization.
>>
>> Use the wakeup_enable flag and enable wakeup capability
>> for the given pads. Wakeup capability will be enabled/disabled
>> during hwmod idle transition based on whether wakeup_flag is
>> set or cleared.
>>
>> Call the omap_hwmod_set_ioring_wakeup from hwmod_wakeup_enable/disable.
>>
>> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod.c |   59 ++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 59 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index 84cc0bd..e751dd9 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -2062,6 +2062,34 @@ static int __init omap_hwmod_setup_all(void)
>>   core_initcall(omap_hwmod_setup_all);
>>
>>   /**
>> + * omap_hwmod_set_ioring_wakeup - enable io pad wakeup flag.
>> + * @oh: struct omap_hwmod *
>> + * @set: bool value indicating to set or clear wakeup status.
>> + *
>> + * Set or Clear wakeup flag for the io_pad.
>> + */
>> +static int omap_hwmod_set_ioring_wakeup(struct omap_hwmod *oh, bool set_wake)
>> +{
>> +	struct omap_device_pad *pad;
>> +	int ret = -EINVAL, j;
>> +
>> +	if (oh->mux&&  oh->mux->enabled) {
>> +		for (j = 0; j<  oh->mux->nr_pads_dynamic; j++) {
>> +			pad = oh->mux->pads_dynamic[j];
>> +			if (pad->flags&  OMAP_DEVICE_PAD_WAKEUP) {
>> +				if (set_wake)
>> +					pad->idle |= OMAP_WAKEUP_EN;
>> +				else
>> +					pad->idle&= ~OMAP_WAKEUP_EN;
>
> I think apart from enabling/disabling the IO wakeup's at the pad
> level, there is also a need to trigger the IO daisy chain control
> (Wu clock) by programming the PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN
> bit and waiting on the PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN) bit,
> which is done by the omap3_enable/disable_io_chain function.
> This is still done in the cpuidle path, but it makes sense to
> move that over here, since it should be done every time a pad
> level wakeup is enabled or disabled.

So should it be done just here or also in the idle path?  In general,
I'm certainly for moving things out of the idle path into the places
where they belong.

However, I don't get from the TRM description below that it should be
done every time a pad-level wake is enabled or disabled.  Can you
clarify what part of the TRM description you mean?

All I understand is that it has to be done before PER domain
transisions.

Also, if this were to happen, are there side-effects of having the IO
daisy chain armed outside the idle path?

Kevin

> See section 3.5.7.2.2 I/O Wake-Up Mechanism of 36xx TRM revA.
>
> "The I/O wake-up scheme is enabled by triggering the I/O daisy chain
> control (Wu clock) by
> programming a dedicated register (PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN)
> in the PRCM module.Software must wait for the I/O daisy chain to
> complete before it transitions the PER domain to a
> nonfunctional state. This is done by polling a dedicated status bit in
> the PRCM module
> (PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN). This status bit must be cleared
> by software when the bit is
> read to 1."
