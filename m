From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v7 19/21] OMAP2+: UART: Use custom activate func for
 console uart.
Date: Mon, 7 Nov 2011 14:12:49 +0530
Message-ID: <CAAL8m4yoN0MCXSE=Y7qnpywy1m9xVsuHoPoMt6tyM_5_eTs8dw@mail.gmail.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
 <1318952110-10659-5-git-send-email-govindraj.raja@ti.com> <878vnv334f.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53016 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab1KGInL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 03:43:11 -0500
In-Reply-To: <878vnv334f.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org

On Sat, Nov 5, 2011 at 4:30 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Omap-uart can be used as console uart to print early boot
>> messages using earlyprintk so for console uart prevent
>> hwmod reset or idling during bootup.
>>
>> Identify the console_uart set the id and use the custom
>> pm_latency ops for console uart for the first time
>> to idle console uart left enabled from bootup and then enable
>> them back and reset pm_latency ops to default ops.
>>
>> Thanks to Kevin Hilman <khilman@ti.com> for suggesting
>> this approach.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/serial.c | =A0 79 +++++++++++++++++++++++++++=
+-------------
>> =A01 files changed, 54 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index e1eba7f..55903f0 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -63,6 +63,7 @@ struct omap_uart_state {
>>
>> =A0static LIST_HEAD(uart_list);
>> =A0static u8 num_uarts;
>> +static u8 console_uart_id =3D -1;
>>
>> =A0#define DEFAULT_RXDMA_POLLRATE =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 =
=A0 =A0 /* RX DMA polling rate (us) */
>> =A0#define DEFAULT_RXDMA_BUFSIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04096=
 =A0 =A0/* RX DMA buffer size */
>> @@ -87,6 +88,29 @@ static struct omap_device_pm_latency omap_uart_la=
tency[] =3D {
>> =A0 =A0 =A0 },
>> =A0};
>>
>> +static int console_uart_enable_hwmod(struct omap_device *od)
>> +{
>> + =A0 =A0 /* For early console we prevented hwmod reset and idle
>> + =A0 =A0 =A0* So before we enable the uart clocks idle and then
>> + =A0 =A0 =A0*/
>
> minor: fix multi-line comment style (search for multi-line in
> Documentation/CodingStyle). =A0Another one below.
>

will correct this.

> Notice that you're moving existing code here, but also changing the
> functionality without a description as to why. =A0 =A0Based on the ex=
isting code:
>
> You need a console_lock() here...
>
>> + =A0 =A0 omap_hwmod_idle(od->hwmods[0]);
>> + =A0 =A0 omap_hwmod_enable(od->hwmods[0]);
>
> ...and this should be omap_device_enable().
>
> And =A0you need a console_unlock() here.
>
> Yes, you're subsequent patches avoid this problem, but we still need =
a real
> fix other than checking for 'debug/loglevel', and when that happens,
> we'll need a console lock here.
>

yes correct, we need console_lock/unlock binding here will update this.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
