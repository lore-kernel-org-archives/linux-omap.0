From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v7 11/21] OMAP2+: UART: Move errata handling from serial.c
 to omap-serial
Date: Fri, 11 Nov 2011 15:44:54 +0530
Message-ID: <CAAL8m4yz74_daeV+Bp8p24u2UnfwpAHskQW+=xeQbN6xUgymZQ@mail.gmail.com>
References: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com>
 <1318951576-10165-12-git-send-email-govindraj.raja@ti.com> <4EBC61DB.9020402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4EBC61DB.9020402@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On Fri, Nov 11, 2011 at 5:14 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> Hi Govindraj,
>
> On 10/18/2011 10:26, Govindraj.R wrote:
>>
>> Move the errata handling mechanism from serial.c to omap-serial file
>> and utilise the same func in driver file.
>>
>> Errata i202, i291 are moved to be handled with omap-serial
>> Moving the errata macro from serial.c file to driver header file
>> as from on errata will be handled in driver file itself.
>> Corrected errata id from chapter reference 2.15 to errata id i291.
>>
>> Removed errata and dma_enabled feilds from omap_uart_state struct
>> as they are no more needed with errata handling done within omap-ser=
ial.
>>
>> Acked-by: Alan Cox<alan@linux.intel.com>
>> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 97
>> +++++++------------------
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A06 ++
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 66 ++++++++++++++++-
>> =A03 files changed, 95 insertions(+), 74 deletions(-)
>
> [snip]
>
>> + =A0 =A0 =A0 /* Enable the MDR1 errata for OMAP3 */
>> + =A0 =A0 =A0 if (cpu_is_omap34xx()&& =A0!cpu_is_ti816x())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_up.errata |=3D UART_ERRATA_i202_M=
DR1_ACCESS;
>
> This errata (i202) is applicable to all devices from OMAP2430 to OMAP=
4460
> (apparently this one is not getting fixed). So could you make sure th=
is is
> enabled for 2430, 3430, 3630, 4430 and 4460?
>
> [snip]

Thanks for the info, Have posted a updated the patch [1]

>
>> +/*
>> + * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)
>
> We should update the comment to be "Work Around for Errata i202 (2430=
, 3430,
> 3630, 4430 and 4460)". The "1.12" and "1.6" are just the section refe=
rences
> in the errata docs, but I think that you can drop these as you can ju=
st
> search for the errata ID which is i202.
>

yes corrected [1]

--
Thanks,
Govindraj.R

[1]:
http://www.spinics.net/lists/linux-serial/msg04841.html
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
