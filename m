From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 15/16] OMAP2+: UART: Enable back uart clocks with runtime API for early console
Date: Wed, 12 Oct 2011 17:00:15 -0700
Message-ID: <871uuhn4kw.fsf@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-6-git-send-email-govindraj.raja@ti.com>
	<87pqi3z19z.fsf@ti.com>
	<CAAL8m4xmGQaQZm5Oz8B5e6Mt7VP7c_VwQ=AnfpKotZRci32JiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4xmGQaQZm5Oz8B5e6Mt7VP7c_VwQ=AnfpKotZRci32JiQ@mail.gmail.com>
	(Govindraj's message of "Wed, 12 Oct 2011 19:34:12 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Wed, Oct 12, 2011 at 2:36 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> For the early console probing we had avoided hwmod reset and idling
>>> and uart was idled using hwmod API and enabled back using omap_devi=
ce API
>>> after omap_device registration.
>>>
>>> Now since we are using runtime API's to enable back uart, move hwmo=
d
>>> idling and use runtime API to enable back UART.
>>>
>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>
>> Now that the driver is using runtime PM. =C2=A0Why do we still need
>> HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET?
>>
>> The comment in the code says:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * During UAR=
T early init, device need to be probed
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * to determi=
ne SoC specific init before omap_device
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * is ready. =
=C2=A0Therefore, don't allow idle here
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>>
>> This was true when using the 8250 driver because it was not using
>> runtime PM so could not know how to (re)enable the device.
>>
>> However, since the driver is now runtime PM adapted, any device acce=
ss
>> should be contained within a runtime PM get/put block, so there shou=
ld
>> no longer be a reason not allow the IP blocks to be reset during boo=
t.
>>
>
> Forgot to add, this is still needed for
> earlyprintk(CONFIG_EARLY_PRINTK) use case,

Ah, right.  I forgot about that.  Please update the changelog (and
comment in the code) to reflect that.

> The initial boot prints until a console driver is available is from
> "arch/arm/kernel/early_printk.c" which does a tx on uart console
> and relies on configuration from bootloader.
>
> during bootup earlyprink does a tx on uart console and if  uart drive=
r
> is not available yet
> uart reset or idle done by hwmod layer can cause boot failures.
>
> --> put_char from earlyprintk.c
>      --> reset/idle from hwmod layer
>           --> put_char from earlyprintk.c
>
>
> So console_uart reset or clock gating must be done only after uart
> driver is available or be prevented using these available hwmod_flags=
=2E

So why not leave the driver out of it and solve it like the current cod=
e
does?

The current codes use the hwmod flags, then waits until the UART driver
is available (after omap_device_build) and uses omap_hwmod_idle() to do
an clean idle of the device.=20

Notably this is inside a console_lock/console_unlock block so that
prints are buffered.

The current code then does an omap_device_enable() to re-enable the
device, but you shouldn't need that after the driver is converted to
runtime PM.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
