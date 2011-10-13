From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 15/16] OMAP2+: UART: Enable back uart clocks with runtime API for early console
Date: Thu, 13 Oct 2011 14:01:43 -0700
Message-ID: <8739ewk3m0.fsf@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-6-git-send-email-govindraj.raja@ti.com>
	<87pqi3z19z.fsf@ti.com>
	<CAAL8m4xmGQaQZm5Oz8B5e6Mt7VP7c_VwQ=AnfpKotZRci32JiQ@mail.gmail.com>
	<871uuhn4kw.fsf@ti.com>
	<CAAL8m4wzT-ecmVeU--EQGF1PxuZuB6WZj54MmVAk-kCtFUcUSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:47644 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752366Ab1JMVBs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 17:01:48 -0400
In-Reply-To: <CAAL8m4wzT-ecmVeU--EQGF1PxuZuB6WZj54MmVAk-kCtFUcUSg@mail.gmail.com>
	(Govindraj's message of "Thu, 13 Oct 2011 06:52:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Govindraj <govindraj.ti@gmail.com> writes:

> On Thu, Oct 13, 2011 at 5:30 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Govindraj <govindraj.ti@gmail.com> writes:
>>
>>> On Wed, Oct 12, 2011 at 2:36 AM, Kevin Hilman <khilman@ti.com> wrot=
e:
>>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>>
>>>>> For the early console probing we had avoided hwmod reset and idli=
ng
>>>>> and uart was idled using hwmod API and enabled back using omap_de=
vice API
>>>>> after omap_device registration.
>>>>>
>>>>> Now since we are using runtime API's to enable back uart, move hw=
mod
>>>>> idling and use runtime API to enable back UART.
>>>>>
>>>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>>>
>>>> Now that the driver is using runtime PM. =C2=A0Why do we still nee=
d
>>>> HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET?
>>>>
>>>> The comment in the code says:
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * During U=
ART early init, device need to be probed
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * to deter=
mine SoC specific init before omap_device
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * is ready=
=2E =C2=A0Therefore, don't allow idle here
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>>>>
>>>> This was true when using the 8250 driver because it was not using
>>>> runtime PM so could not know how to (re)enable the device.
>>>>
>>>> However, since the driver is now runtime PM adapted, any device ac=
cess
>>>> should be contained within a runtime PM get/put block, so there sh=
ould
>>>> no longer be a reason not allow the IP blocks to be reset during b=
oot.
>>>>
>>>
>>> Forgot to add, this is still needed for
>>> earlyprintk(CONFIG_EARLY_PRINTK) use case,
>>
>> Ah, right. =C2=A0I forgot about that. =C2=A0Please update the change=
log (and
>> comment in the code) to reflect that.
>>
>>> The initial boot prints until a console driver is available is from
>>> "arch/arm/kernel/early_printk.c" which does a tx on uart console
>>> and relies on configuration from bootloader.
>>>
>>> during bootup earlyprink does a tx on uart console and if =C2=A0uar=
t driver
>>> is not available yet
>>> uart reset or idle done by hwmod layer can cause boot failures.
>>>
>>> --> put_char from earlyprintk.c
>>> =C2=A0 =C2=A0 =C2=A0--> reset/idle from hwmod layer
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --> put_char from earlyprintk.c
>>>
>>>
>>> So console_uart reset or clock gating must be done only after uart
>>> driver is available or be prevented using these available hwmod_fla=
gs.
>>
>> So why not leave the driver out of it and solve it like the current =
code
>> does?
>>
>> The current codes use the hwmod flags, then waits until the UART dri=
ver
>> is available (after omap_device_build) and uses omap_hwmod_idle() to=
 do
>> an clean idle of the device.
>>
>> Notably this is inside a console_lock/console_unlock block so that
>> prints are buffered.
>>
>> The current code then does an omap_device_enable() to re-enable the
>> device, but you shouldn't need that after the driver is converted to
>> runtime PM.
>
> Yes similar approach here, We are not doing hwmod idle
> until console driver is available, once omap-serial is available
> from probe doing hwmod_idle* and then get_sync.

> hwmod idle in serial.c will still cause problems if ealryprintk tries
> to print until omap-uart console driver is not available,=20

It will try, but note that current code takes the console_lock() during
that time, so those prints will be buffered.

> as now with rumtime adaptation only driver can enable back clocks.

I'm not sure why you're calling this "enable back clocks."  This patch
is just trying to decide where to idle the hwmod (that is, disable the
clocks.)

Re: only the driver can do it, I can think of at least 2 ways to keep
this out of the driver.

1) Use the a custom activate_func in the omap_device pm_lats struct
   to idle the first time.

2) Use a bus notifier so the device init can be notified when the
   real driver is available.  I think you're probably wanting
   the BUS_NOTIFY_BIND_DRIVER event, which would happen right
   before probe.  There's also BUS_NOTIFY_BOUND_DRIVER which
   happens right after probe.   You might actually want to use
   both.  e.g.   console_lock(); omap_hwmod_idle() in BIND
   and console_unlock() in 'BOUND'.

> So have added a function pointer to pdata which calls hwmod_idle
> implemented in serial.c calling omap_hwmod_idle.

Yes, I saw that in the patch, and that's what I don't like.

=46ixing up after earlyprintk is not the responsiblity of the driver, a=
nd
the driver should not know or care whether earlyprintk was or wasn't
used before it was loaded.  This needs to be handled in device init cod=
e
as it is today.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
