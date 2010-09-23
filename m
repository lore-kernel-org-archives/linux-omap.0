From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 10/13 v2] OMAP3: serial: Fix uart4 handling for 3630
Date: Thu, 23 Sep 2010 16:45:20 +0530
Message-ID: <AANLkTikYO5=3PE9YbkFteJ63hsR4n1zE80voNz23P+6X@mail.gmail.com>
References: <37596.172.24.137.131.1285168469.squirrel@dbdmail.itg.ti.com>
	<87d3s5a5k7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87d3s5a5k7.fsf@deeprootsystems.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 23, 2010 at 1:56 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> This patch makes the following:
>> =A0- Adds missing wakeup padding register handling.
>> =A0- Fixes a hardcode to use PER module ONLY on UART3.
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/serial.c | =A0 =A08 ++++++--
>> =A01 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index 72b5c98..c1404af 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -57,7 +57,7 @@
>> =A0 * disabled via sysfs. This also causes that any deeper omap slee=
p states are
>> =A0 * blocked.
>> =A0 */
>> -#define DEFAULT_TIMEOUT 0
>> +#define DEFAULT_TIMEOUT 5
>
> Oops
>
> Please leave this at zero.

Yes my mistake.
Will correct this.

>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
