From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 15/16] OMAP2+: UART: Enable back uart clocks with runtime API for early console
Date: Fri, 14 Oct 2011 10:12:18 -0700
Message-ID: <8739evebv1.fsf@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-6-git-send-email-govindraj.raja@ti.com>
	<87pqi3z19z.fsf@ti.com>
	<CAAL8m4xmGQaQZm5Oz8B5e6Mt7VP7c_VwQ=AnfpKotZRci32JiQ@mail.gmail.com>
	<871uuhn4kw.fsf@ti.com>
	<CAAL8m4wzT-ecmVeU--EQGF1PxuZuB6WZj54MmVAk-kCtFUcUSg@mail.gmail.com>
	<8739ewk3m0.fsf@ti.com>
	<CAAL8m4wgLbmm-3eqku1+0oa77_fxVoFzR1ujF9nwAQRavfqLfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4wgLbmm-3eqku1+0oa77_fxVoFzR1ujF9nwAQRavfqLfg@mail.gmail.com>
	(Govindraj's message of "Fri, 14 Oct 2011 19:48:51 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

[...]

>
> I did some study into the approaches you suggested,
> Below are my observation, Please correct me if I missed out
> any thing in my below observation,
>
>
>> 1) Use the a custom activate_func in the omap_device pm_lats struct
>> =C2=A0 to idle the first time.
>>
>
> same activate func gets called for all uarts, how to determine the
> activate func. was called for first time for the given uart.
>
> (use od->pdev->dev.name strcmp with uart name for first name
> and maintain a state machine ? confused)
>
> Then should we have different activate funcs?

You would only need to install a custom activate_func for the console
UART device.  After the first call, you could set the activate_func bac=
k
to the default.

>> 2) Use a bus notifier so the device init can be notified when the
>> =C2=A0 real driver is available. =C2=A0I think you're probably wanti=
ng
>> =C2=A0 the BUS_NOTIFY_BIND_DRIVER event, which would happen right
>> =C2=A0 before probe. =C2=A0There's also BUS_NOTIFY_BOUND_DRIVER whic=
h
>> =C2=A0 happens right after probe. =C2=A0 You might actually want to =
use
>> =C2=A0 both. =C2=A0e.g. =C2=A0 console_lock(); omap_hwmod_idle() in =
BIND
>> =C2=A0 and console_unlock() in 'BOUND'.
>
> bus_register_notifier is for all drivers within the bus,
> omap-uart is registered as platform bus and there a lot more
> devices that register under platform bus,
>
> So registering the notifier for platform bus will call notifier
> for all probes withing platform bus,
>
> Is there a way to have notifier per device or given device?

The notifier callback passes the device pointer.  You just have to take
action for the devices you care about, and return for the others.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
