From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 01/39] ARM: OMAP2+: gpmc: driver conversion
Date: Fri, 4 May 2012 11:20:16 -0500
Message-ID: <4FA401C0.7070503@ti.com>
References: <cover.1335874494.git.afzal@ti.com> <363273a9ef82d6836197929157aa9a8eb8f5171a.1335874494.git.afzal@ti.com> <4FA022FC.5040703@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E982967@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E982967-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org" <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Hire
List-Id: linux-omap@vger.kernel.org

Hi Afzal,

On 05/03/2012 03:23 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Tue, May 01, 2012 at 23:23:00, Hunter, Jon wrote:
>> Hi Afzal,
>>
>> Looks good! Some minor comments ...
> 
> Thanks
> 
>>> +#define	GPMC_WAITPIN_IDX0			0x0
>>> +#define	GPMC_WAITPIN_IDX1			0x1
>>> +#define	GPMC_WAITPIN_IDX2			0x2
>>> +#define	GPMC_WAITPIN_IDX3			0x3
>>> +#define	GPMC_NR_WAITPIN				0x4
>>
>> How about an enum here? Also OMAP4 only have 3 wait pins and so the
>> number is device dependent.
> 
> Ok
> 
>>
>>>  #define GPMC_MEM_START		0x00000000
>>>  #define GPMC_MEM_END		0x3FFFFFFF
>>>  #define BOOT_ROM_SPACE		0x100000	/* 1MB */
>>> @@ -64,6 +106,55 @@
>>>  #define ENABLE_PREFETCH		(0x1 << 7)
>>>  #define DMA_MPU_MODE		2
>>>  
>>> +#define	DRIVER_NAME	"omap-gpmc"
>>> +
>>> +#define	GPMC_NR_IRQ		2
>>
>> Why has this been changed to 2? It was 6 in the previous version. As we
>> discussed before the number of IRQs should be detected based upon GPMC
>> IP version.
> 
> As mentioned in the cover letter,
> 
> "Additional features that currently boards in mainline does not make
> use of like, waitpin interrupt handling, changes to leverage revision
> 6 IP differences has not been incorporated."
> 
> Priority in this series is to convert into a driver, get all boards working
> on mainline. Once all boards are working with gpmc driver, these features
> which are not required for currently supported boards can be added later.

Yes, but I meant why 2 and not say 5? Anyway, I think that this should
be marked with a comment like a TODO so it is clear that this needs to
be re-visited.

>>> +struct gpmc_device {
>>> +	char			*name;
>>> +	int			id;
>>> +	void			*pdata;
>>> +	unsigned		pdata_size;
>>> +	struct resource		*per_res;
>>> +	unsigned		per_res_cnt;
>>> +	struct resource		*gpmc_res;
>>> +	unsigned		gpmc_res_cnt;
>>> +	bool			have_waitpin;
>>> +	unsigned		waitpin;
>>> +	int			waitpin_polarity;
>>
>> I think that it make more sense to have the wait-pin information part of
>> the gpmc_cs_data structure for the following reasons ...
> 
> Waitpin information is indeed a part of cs as far as boards are concerned,
> it is only that it gets propogated to device

Why does the device's driver care? From my point of view, the wait-pin
is just part of the interface setup/configuration. The external device
may require this and assumes that this has been setup along with the CS
and interface timing, but the device's driver should not care. Remember
this is just a ready signal used to stall the access. Once configured,
software should be unaware of it.

>> 1. If a device can use multiple CS, then it could use multiple wait signals.
>> 2. Eventually, all board information needs to move to device tree. By
>> having it in the pdata it will be easier to migrate to device tree.
>>
>> It may be nice to have "have_waitpin" be an integer too, that indicates
>> if wait is used for both read and write or just one or the other.
>>
>> Also, any reason why waitpin_polarity is an int? I see you define LOW as
>> -1, but I not sure why LOW cannot be 0 as 0 is programmed into the
>> register for an active low wait signal.
> 
> Only intention is not to alter default waitpin polarity value, i.e. if
> any board does make use of it w/o knowledge of Kernel, I don't want to
> break it, there may be an argument saying that the board code is buggy,
> while if some board does so, it is, but don't want to break working one.
> 
> Here unless user explicitly set the flag, it does nothing on polarity

Ok. Do such scenario's exist today? Please note that board code will be
removed in the future and device-tree will replace. So if there are no
cases today, I would not be concerned. Unless this could be something
that has already been configured by the bootloader. However, in that
case would be even call this function?

>>> +	if (idx != ~0x0) {
>>> +		if (gd->have_waitpin) {
>>> +			if (gd->waitpin != idx ||
>>> +					gd->waitpin_polarity != polarity) {
>>> +				dev_err(gpmc->dev, "error: conflict: waitpin %u with polarity %d on device %s.%d\n",
>>> +					gd->waitpin, gd->waitpin_polarity,
>>> +					gd->name, gd->id);
>>> +				return -EBUSY;
>>> +			}
>>> +		} else {
>>> +			gd->have_waitpin = true;
>>> +			gd->waitpin = idx;
>>> +			gd->waitpin_polarity = polarity;
>>> +		}
>>
>> I am not sure about the above code. What happens if a device has
>> multiple CS signals and uses multiple wait signals?
>>
>> I am also not sure why gpmc_setup_cs_waitpin and gpmc_setup_waitpin
>> cannot be combined. I think that it would be a fair assumption to make
>> that anyone using the waitpin does so inconjunction with the CS (I think
>> that they would have too).
>>
>> However, if there is a reason for splitting it up this way please
>> explain why.
> 
> Initially it was done per CS, the problem happened while trying to
> convert tusb6010. It had multiple CS, but using same waitpin. Problem
> with incorporating this onto CS is we have to sacrifice on wait pin
> conflict prevention capability. The code now handles case of wait pin
> conflict per device, the code can be extended to have multiple
> wait pin per device also. But I prefer to defer it to later, not as
> part of this series, as this feature what you asking for is not required
> for any of the existing boards. I can add it in this series if there is
> a strong opinion in the community for the same in this series.

Ok, yes this does make sense. I wonder if we can clean up the all the
nested if-statements in gpmc_setup_cs_waitpin(). Seems there could be
some redundancy.

> Policy that is being followed here is first sit, then straighten legs, ;)

Ha! Crawl before walking ;-)

>>> +static int gpmc_setup_cs_nonres(struct gpmc *gpmc,
>>> +			struct gpmc_device *gd, struct gpmc_cs_data *cs)
>>
>> The name of this function is not 100% clear to me. What do you mean by
>> "nonres"?
> 
> It means anything other than resources like memory & irq, happened for
> want of better name, if you have one, name it, will put it.

Not really, but may be worth adding a comment.

>>> +int gpmc_cs_reconfigure(char *name, int id, struct gpmc_cs_data *cs)
>>
>> What scenario is this function used in? May be worth adding a comment
>> about the function.
> 
> Ok, it was required for OneNAND, as it needs to reconfigure

Ok, but why is that? Unless this is something generic about one-nand I
don't comprehend. I have a high-level understanding of one-nand, but I
am not familiar with the specifics that require it to be reconfigured.

>>> +	for (i = 0, n = gdp->num_cs, cs = gdp->cs_data;
>>> +				i < gdp->num_cs; i++, cs++)
>>> +		n += hweight32(cs->irq_config);
>>
>> As you know I am not a fan of these overloaded for-loops as I find them
>> hard to read ;-)
>>
>> Why not ...
>>
>> n = gdp->num_cs;
>> cs = gdp->cs_data;
> 
> 
> Well, you also know that I am big fan of it; difference of opinion,
> my preference is to keep loop control statements together with "for",
> unless there is a cry from community that it should not be this way.
> I believe that it is not that much unreadable.

Ok.

>>> +	for (i = 0, gdq = gp->device_pdata, gd = gpmc->device;
>>> +			(i < gp->num_device) && (*gdq); i++, gdq++) {
>>
>> You have num_devices now and so do you really need the "&& (*gdq)"?
>> Seems redundant.
> 
> num_device is something that I never wanted to add, was happy with,
> NULL entry termination, only because of your repeated comments,
> I added this. And this additional check now prevents NULL dereference.

Ok, but I would go with one or the other. Make it NULL terminated but
maybe add a comment?

>>> +	gpmc_setup_writeprotect(gpmc);
>>
>> Write protect is a pin and there is only one. Like the waitpins and CS
>> signals this needs to be associated with a device. It would make sense
>> that this is associated with the cs data.
> 
> As far as platform are concerned, it is associated with cs, it is only
> that while configuring CS, it is propagated such that it is done once.

Hmmm ... but here it looks like if write-protect is used you are going
to turn it on. A feature like this seems that it does need to be handled
by the device's driver. Enabling and disabling write-protect are
functions that I would expect are exported to the device's driver and
not directly enabled in the gpmc driver during probe. However, maybe is
could be valid for the write protect to be enabled by default which
could make sense. However, I don't see anywhere else in the driver to
control it.

Shouldn't we warn on multiple devices trying to use write-protect when
parsing their configuration?

>>> +#define	GPMC_READTYPE_ASYNC		BIT(30)
>>> +#define	GPMC_WRITETYPE_ASYNC		BIT(31)
>>> +
>>
>> Please keep in mind that eventually this has to all be moved into device
>> tree and so at that point these configuration flags will have to be
>> re-worked. However, just a FYI.
> 
> On device tree matters, my mind is next to blank, thanks for mentioning it.

No problem. For now lets not worry too much.

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
