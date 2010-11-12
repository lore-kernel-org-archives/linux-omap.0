From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Subject: Re: [PATCHv2] OMAP: Serial: Define OMAP uart MDR1 register definitions
Date: Fri, 12 Nov 2010 09:51:11 +0200
Message-ID: <AANLkTimL25m4X0Apynis-H7g7FVDLU7Cw8mV+q2fptK8@mail.gmail.com>
References: <1289484812-17278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<87hbfnx2zw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87hbfnx2zw.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Nov 11, 2010 at 6:02 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> writes:
>
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>
>> Define MDR1 register serial definitions used in serial and
>> bluetooth drivers. Remove magic numbers there.
>
> Remove magic numbers where? =A0This patch doesn't remove anything.

We have code which is not yet upstream, it will come through Bluetooth
subtree at some point, I am also going to remove magic in
omapX/serial.c drivers in the next patches.

Do you think I need to add those patches?

>
>> *v2 =A0 added OMAP keyword
>
> This info should go after the '---' as it is not needed in the final
> git history.

OK, will remove it.

>
> Kevin
>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>> =A0include/linux/serial_reg.h | =A0 12 ++++++++++++
>> =A01 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
>> index c7a0ce1..6f38234 100644
>> --- a/include/linux/serial_reg.h
>> +++ b/include/linux/serial_reg.h
>> @@ -341,5 +341,17 @@
>> =A0#define UART_OMAP_SYSS =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x16 =A0 =A0/*=
 System status register */
>> =A0#define UART_OMAP_WER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x17 =A0 =A0=
/* Wake-up enable register */
>>
>> +/*
>> + * These are the definitions for the MDR1 register
>> + */
>> +#define UART_OMAP_MDR1_16X_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A00x00 =A0=
 =A0/* UART 16x mode */
>> +#define UART_OMAP_MDR1_SIR_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A00x01 =A0=
 =A0/* SIR mode */
>> +#define UART_OMAP_MDR1_16X_ABAUD_MODE =A0 =A0 =A0 =A00x02 =A0 =A0/*=
 UART 16x auto-baud */
>> +#define UART_OMAP_MDR1_13X_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A00x03 =A0=
 =A0/* UART 13x mode */
>> +#define UART_OMAP_MDR1_MIR_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A00x04 =A0=
 =A0/* MIR mode */
>> +#define UART_OMAP_MDR1_FIR_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A00x05 =A0=
 =A0/* FIR mode */
>> +#define UART_OMAP_MDR1_CIR_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A00x06 =A0=
 =A0/* CIR mode */
>> +#define UART_OMAP_MDR1_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x07 =A0=
 =A0/* Disable (default state) */
>> +
>> =A0#endif /* _LINUX_SERIAL_REG_H */
>
