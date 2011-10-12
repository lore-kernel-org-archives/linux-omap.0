From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 11/16] OMAP2+: UART: Move errata handling from serial.c
 to omap-serial
Date: Wed, 12 Oct 2011 16:13:11 +0530
Message-ID: <CAAL8m4zRsoto+ZNDh_y4WpHgv4QP_RaXGZ99mE-55s6ZkrpqOg@mail.gmail.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
 <1317380561-661-2-git-send-email-govindraj.raja@ti.com> <871uuj1bvk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <871uuj1bvk.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 12, 2011 at 2:31 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Move the errata handling mechanism from serial.c to omap-serial file
>> and utilise the same func in driver file.
>>
>> Errata i202, i291 are moved to be handled with omap-serial
>> Moving the errata macro from serial.c file to driver header file
>> as from on errata will be handled in driver file itself.
>>
>> Corrected errata id from chapter reference 2.15 to errata id i291.
>>
>> Acked-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> The errata handling for i291 is moved from device code to driver code
> but it's functionality is also changed (but not described.)
>
> In the current mainline code, The workaround for i291 is done wheneve=
r
> UART clocks are about to be cut. =A0When the clocks are (re)enabled, =
the
> device is put back into no-idle.
>
> This patch puts the device into force-idle just before the idle/suspe=
nd
> transistion, but never puts it back into no-idle. =A0So after the fir=
st
> idle/suspend transition, the IP remains in force-idle forever. =A0I d=
on't
> think that's what we want.
>

I was thinking no_idle will be done once we re-enable uart clocks
from omap_device_enable but that's not the case looking into the code.

Will correct it will add no_idle call from .runtime_resume as done earl=
y
where we put into no_idle(sysc) while enabling the clocks.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
