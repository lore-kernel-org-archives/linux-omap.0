From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 15/16] OMAP2+: UART: Enable back uart clocks with
 runtime API for early console
Date: Wed, 12 Oct 2011 19:34:12 +0530
Message-ID: <CAAL8m4xmGQaQZm5Oz8B5e6Mt7VP7c_VwQ=AnfpKotZRci32JiQ@mail.gmail.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
 <1317380561-661-6-git-send-email-govindraj.raja@ti.com> <87pqi3z19z.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87pqi3z19z.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 12, 2011 at 2:36 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> For the early console probing we had avoided hwmod reset and idling
>> and uart was idled using hwmod API and enabled back using omap_devic=
e API
>> after omap_device registration.
>>
>> Now since we are using runtime API's to enable back uart, move hwmod
>> idling and use runtime API to enable back UART.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> Now that the driver is using runtime PM. =A0Why do we still need
> HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET?
>
> The comment in the code says:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * During UART early init, device need=
 to be probed
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * to determine SoC specific init befo=
re omap_device
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * is ready. =A0Therefore, don't allow=
 idle here
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>
> This was true when using the 8250 driver because it was not using
> runtime PM so could not know how to (re)enable the device.
>
> However, since the driver is now runtime PM adapted, any device acces=
s
> should be contained within a runtime PM get/put block, so there shoul=
d
> no longer be a reason not allow the IP blocks to be reset during boot=
=2E
>

=46orgot to add, this is still needed for
earlyprintk(CONFIG_EARLY_PRINTK) use case,

The initial boot prints until a console driver is available is from
"arch/arm/kernel/early_printk.c" which does a tx on uart console
and relies on configuration from bootloader.

during bootup earlyprink does a tx on uart console and if  uart driver
is not available yet
uart reset or idle done by hwmod layer can cause boot failures.

--> put_char from earlyprintk.c
     --> reset/idle from hwmod layer
          --> put_char from earlyprintk.c


So console_uart reset or clock gating must be done only after uart
driver is available or be prevented
using these available hwmod_flags.

omap_serial_early_init should be now be binded with CONFIG_SERIAL_OMAP =
macro ?

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
