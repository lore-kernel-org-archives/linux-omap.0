From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 15/16] OMAP2+: UART: Enable back uart clocks with
 runtime API for early console
Date: Thu, 13 Oct 2011 06:52:04 +0530
Message-ID: <CAAL8m4wzT-ecmVeU--EQGF1PxuZuB6WZj54MmVAk-kCtFUcUSg@mail.gmail.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
 <1317380561-661-6-git-send-email-govindraj.raja@ti.com> <87pqi3z19z.fsf@ti.com>
 <CAAL8m4xmGQaQZm5Oz8B5e6Mt7VP7c_VwQ=AnfpKotZRci32JiQ@mail.gmail.com> <871uuhn4kw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45797 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab1JMBWZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Oct 2011 21:22:25 -0400
In-Reply-To: <871uuhn4kw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Thu, Oct 13, 2011 at 5:30 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Wed, Oct 12, 2011 at 2:36 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>
>>>> For the early console probing we had avoided hwmod reset and idlin=
g
>>>> and uart was idled using hwmod API and enabled back using omap_dev=
ice API
>>>> after omap_device registration.
>>>>
>>>> Now since we are using runtime API's to enable back uart, move hwm=
od
>>>> idling and use runtime API to enable back UART.
>>>>
>>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>>
>>> Now that the driver is using runtime PM. =A0Why do we still need
>>> HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET?
>>>
>>> The comment in the code says:
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * During UART early init, device ne=
ed to be probed
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * to determine SoC specific init be=
fore omap_device
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * is ready. =A0Therefore, don't all=
ow idle here
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>>>
>>> This was true when using the 8250 driver because it was not using
>>> runtime PM so could not know how to (re)enable the device.
>>>
>>> However, since the driver is now runtime PM adapted, any device acc=
ess
>>> should be contained within a runtime PM get/put block, so there sho=
uld
>>> no longer be a reason not allow the IP blocks to be reset during bo=
ot.
>>>
>>
>> Forgot to add, this is still needed for
>> earlyprintk(CONFIG_EARLY_PRINTK) use case,
>
> Ah, right. =A0I forgot about that. =A0Please update the changelog (an=
d
> comment in the code) to reflect that.
>
>> The initial boot prints until a console driver is available is from
>> "arch/arm/kernel/early_printk.c" which does a tx on uart console
>> and relies on configuration from bootloader.
>>
>> during bootup earlyprink does a tx on uart console and if =A0uart dr=
iver
>> is not available yet
>> uart reset or idle done by hwmod layer can cause boot failures.
>>
>> --> put_char from earlyprintk.c
>> =A0 =A0 =A0--> reset/idle from hwmod layer
>> =A0 =A0 =A0 =A0 =A0 --> put_char from earlyprintk.c
>>
>>
>> So console_uart reset or clock gating must be done only after uart
>> driver is available or be prevented using these available hwmod_flag=
s.
>
> So why not leave the driver out of it and solve it like the current c=
ode
> does?
>
> The current codes use the hwmod flags, then waits until the UART driv=
er
> is available (after omap_device_build) and uses omap_hwmod_idle() to =
do
> an clean idle of the device.
>
> Notably this is inside a console_lock/console_unlock block so that
> prints are buffered.
>
> The current code then does an omap_device_enable() to re-enable the
> device, but you shouldn't need that after the driver is converted to
> runtime PM.

Yes similar approach here, We are not doing hwmod idle
until console driver is available, once omap-serial is available
from probe doing hwmod_idle* and then get_sync.

hwmod idle in serial.c will still cause problems if ealryprintk tries t=
o print
until omap-uart console driver is not available, as now with rumtime ad=
aptation
only driver can enable back clocks. So have added a function pointer
to pdata which
calls hwmod_idle implemented in serial.c calling omap_hwmod_idle.

--
Thanks,
Govindraj.R

*function pointer implemented in serial.c not directly calling
omap_hmwod_idle API.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
