From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3 02/12] OMAP2+: UART: Remove uart clock handling code
	from serial.c
Date: Mon, 27 Jun 2011 18:19:55 +0530
Message-ID: <BANLkTim1fEnfqu4KaN6FkG_CT93=joZC_w@mail.gmail.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-3-git-send-email-govindraj.raja@ti.com>
	<877h8ax3ss.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <877h8ax3ss.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 25, 2011 at 3:58 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Cleanup serial.c file in preparation to addition of runtime api's in oma=
p-serial
>> file. Remove all clock handling mechanism as this will be taken care with
>> pm runtime api's in omap-serial.c file itself.
>>
>> 1.) Remove omap-device enable and disable. We can can use get_sync/put_s=
ync api's
>> 2.) Remove context save/restore can be done with runtime_resume callback=
 for
>> =A0 =A0 get_sync call. No need to save context as all reg details availa=
ble in
>> =A0 =A0 uart_port structure can be used for restore, so add missing regs=
 in
>> =A0 =A0 uart port struct.
>> 3.) Add func to identify console uart.
>> 4.) Erratum handling informed as flag to driver and func to handle errat=
um
>> =A0 =A0 can be moved to omap-serial driver itself.
>>
>> Acked-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> [...]
>
>> @@ -47,65 +40,9 @@
>> =A0#include "control.h"
>> =A0#include "mux.h"
>>
>> -#define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV =A00x52
>> -#define UART_OMAP_WER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x17 =A0 =A0/* Wak=
e-up enable register */
>> -
>> -#define UART_ERRATA_FIFO_FULL_ABORT =A0(0x1 << 0)
>> -#define UART_ERRATA_i202_MDR1_ACCESS (0x1 << 1)
>> -
>> -/*
>> - * NOTE: By default the serial timeout is disabled as it causes lost ch=
aracters
>> - * over the serial ports. This means that the UART clocks will stay on =
until
>> - * disabled via sysfs. This also causes that any deeper omap sleep stat=
es are
>> - * blocked.
>> - */
>> -#define DEFAULT_TIMEOUT 0
>> -
>> -#define MAX_UART_HWMOD_NAME_LEN =A0 =A0 =A0 =A0 =A0 =A0 =A016
>> +#define MAX_UART_HWMOD_NAME_LEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A016
>
> Minor: only whitespace change here, you converted tabs to spaces.

yes, will correct this.

--
Govindraj.R

>
> Rest of this looks fine.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
