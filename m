From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 15/16] OMAP2+: UART: Enable back uart clocks with
 runtime API for early console
Date: Fri, 14 Oct 2011 19:48:51 +0530
Message-ID: <CAAL8m4wgLbmm-3eqku1+0oa77_fxVoFzR1ujF9nwAQRavfqLfg@mail.gmail.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
 <1317380561-661-6-git-send-email-govindraj.raja@ti.com> <87pqi3z19z.fsf@ti.com>
 <CAAL8m4xmGQaQZm5Oz8B5e6Mt7VP7c_VwQ=AnfpKotZRci32JiQ@mail.gmail.com>
 <871uuhn4kw.fsf@ti.com> <CAAL8m4wzT-ecmVeU--EQGF1PxuZuB6WZj54MmVAk-kCtFUcUSg@mail.gmail.com>
 <8739ewk3m0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50194 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632Ab1JNOTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Oct 2011 10:19:13 -0400
In-Reply-To: <8739ewk3m0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Fri, Oct 14, 2011 at 2:31 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Thu, Oct 13, 2011 at 5:30 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> Govindraj <govindraj.ti@gmail.com> writes:
>>>
>>>> On Wed, Oct 12, 2011 at 2:36 AM, Kevin Hilman <khilman@ti.com> wro=
te:
>>>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>>>
>>>>>> For the early console probing we had avoided hwmod reset and idl=
ing
>>>>>> and uart was idled using hwmod API and enabled back using omap_d=
evice API
>>>>>> after omap_device registration.
>>>>>>
>>>>>> Now since we are using runtime API's to enable back uart, move h=
wmod
>>>>>> idling and use runtime API to enable back UART.
>>>>>>
>>>>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>>>>
>>>>> Now that the driver is using runtime PM. =A0Why do we still need
>>>>> HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET?
>>>>>
>>>>> The comment in the code says:
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * During UART early init, device =
need to be probed
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * to determine SoC specific init =
before omap_device
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * is ready. =A0Therefore, don't a=
llow idle here
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>>>>>
>>>>> This was true when using the 8250 driver because it was not using
>>>>> runtime PM so could not know how to (re)enable the device.
>>>>>
>>>>> However, since the driver is now runtime PM adapted, any device a=
ccess
>>>>> should be contained within a runtime PM get/put block, so there s=
hould
>>>>> no longer be a reason not allow the IP blocks to be reset during =
boot.
>>>>>
>>>>
>>>> Forgot to add, this is still needed for
>>>> earlyprintk(CONFIG_EARLY_PRINTK) use case,
>>>
>>> Ah, right. =A0I forgot about that. =A0Please update the changelog (=
and
>>> comment in the code) to reflect that.
>>>
>>>> The initial boot prints until a console driver is available is fro=
m
>>>> "arch/arm/kernel/early_printk.c" which does a tx on uart console
>>>> and relies on configuration from bootloader.
>>>>
>>>> during bootup earlyprink does a tx on uart console and if =A0uart =
driver
>>>> is not available yet
>>>> uart reset or idle done by hwmod layer can cause boot failures.
>>>>
>>>> --> put_char from earlyprintk.c
>>>> =A0 =A0 =A0--> reset/idle from hwmod layer
>>>> =A0 =A0 =A0 =A0 =A0 --> put_char from earlyprintk.c
>>>>
>>>>
>>>> So console_uart reset or clock gating must be done only after uart
>>>> driver is available or be prevented using these available hwmod_fl=
ags.
>>>
>>> So why not leave the driver out of it and solve it like the current=
 code
>>> does?
>>>
>>> The current codes use the hwmod flags, then waits until the UART dr=
iver
>>> is available (after omap_device_build) and uses omap_hwmod_idle() t=
o do
>>> an clean idle of the device.
>>>
>>> Notably this is inside a console_lock/console_unlock block so that
>>> prints are buffered.
>>>
>>> The current code then does an omap_device_enable() to re-enable the
>>> device, but you shouldn't need that after the driver is converted t=
o
>>> runtime PM.
>>
>> Yes similar approach here, We are not doing hwmod idle
>> until console driver is available, once omap-serial is available
>> from probe doing hwmod_idle* and then get_sync.
>
>> hwmod idle in serial.c will still cause problems if ealryprintk trie=
s
>> to print until omap-uart console driver is not available,
>
> It will try, but note that current code takes the console_lock() duri=
ng
> that time, so those prints will be buffered.
>
>> as now with rumtime adaptation only driver can enable back clocks.
>
> I'm not sure why you're calling this "enable back clocks." =A0This pa=
tch
> is just trying to decide where to idle the hwmod (that is, disable th=
e
> clocks.)
>

Yes correct, its about where exactly to do hwmod_idle for
avoiding hmwod_reset/idle from boot up.


> Re: only the driver can do it, I can think of at least 2 ways to keep
> this out of the driver.
>

I did some study into the approaches you suggested,
Below are my observation, Please correct me if I missed out
any thing in my below observation,


> 1) Use the a custom activate_func in the omap_device pm_lats struct
> =A0 to idle the first time.
>

same activate func gets called for all uarts, how to determine the
activate func. was called for first time for the given uart.

(use od->pdev->dev.name strcmp with uart name for first name
and maintain a state machine ? confused)

Then should we have different activate funcs?


> 2) Use a bus notifier so the device init can be notified when the
> =A0 real driver is available. =A0I think you're probably wanting
> =A0 the BUS_NOTIFY_BIND_DRIVER event, which would happen right
> =A0 before probe. =A0There's also BUS_NOTIFY_BOUND_DRIVER which
> =A0 happens right after probe. =A0 You might actually want to use
> =A0 both. =A0e.g. =A0 console_lock(); omap_hwmod_idle() in BIND
> =A0 and console_unlock() in 'BOUND'.
>

bus_register_notifier is for all drivers within the bus,
omap-uart is registered as platform bus and there a lot more
devices that register under platform bus,

So registering the notifier for platform bus will call notifier
for all probes withing platform bus,

Is there a way to have notifier per device or given device?

Since bus notifier seems to be notify for all devices
registered within the given bus.

--
Thanks,
Govindraj.R


>> So have added a function pointer to pdata which calls hwmod_idle
>> implemented in serial.c calling omap_hwmod_idle.
>
> Yes, I saw that in the patch, and that's what I don't like.
>
> Fixing up after earlyprintk is not the responsiblity of the driver, a=
nd
> the driver should not know or care whether earlyprintk was or wasn't
> used before it was loaded. =A0This needs to be handled in device init=
 code
> as it is today.
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
