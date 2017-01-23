From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove duplicate definition of
 omap_test_timeout
Date: Mon, 23 Jan 2017 15:43:59 +0200
Message-ID: <97761042-4a61-9abe-8b6f-a306936cb513@ti.com>
References: <20170120185151.1630-1-tony@atomide.com>
 <130610aa-ed1a-b363-fac5-6aaaf4d8e930@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <130610aa-ed1a-b363-fac5-6aaaf4d8e930@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 23/01/17 12:22, Lokesh Vutla wrote:
> + Tero,
>
> On Saturday 21 January 2017 12:21 AM, Tony Lindgren wrote:
>> We have the same defined already in common.h.
>
>
> This is reverting what has been introduced in this[1] series. Probably
> Tero can comment more here.

Yeah, the point of introducing that was to get rid of common.h include 
from the prcm files. See commit 250e27ee950bf67ceeb812eb4c8f2fea58d3e2b6.

-Tero

>
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg102131.html
>
> Thanks and regards,
> Lokesh
>
>>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>  arch/arm/mach-omap2/cm2xxx.c                |  1 +
>>  arch/arm/mach-omap2/cm33xx.c                |  1 +
>>  arch/arm/mach-omap2/cm3xxx.c                |  1 +
>>  arch/arm/mach-omap2/cminst44xx.c            |  1 +
>>  arch/arm/mach-omap2/powerdomains3xxx_data.c |  1 +
>>  arch/arm/mach-omap2/prcm-common.h           | 22 ----------------------
>>  arch/arm/mach-omap2/prm2xxx_3xxx.c          |  1 +
>>  arch/arm/mach-omap2/prm33xx.c               |  1 +
>>  8 files changed, 7 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
>> --- a/arch/arm/mach-omap2/cm2xxx.c
>> +++ b/arch/arm/mach-omap2/cm2xxx.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/err.h>
>>  #include <linux/io.h>
>>
>> +#include "common.h"
>>  #include "prm2xxx.h"
>>  #include "cm.h"
>>  #include "cm2xxx.h"
>> diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
>> --- a/arch/arm/mach-omap2/cm33xx.c
>> +++ b/arch/arm/mach-omap2/cm33xx.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/err.h>
>>  #include <linux/io.h>
>>
>> +#include "common.h"
>>  #include "clockdomain.h"
>>  #include "cm.h"
>>  #include "cm33xx.h"
>> diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
>> --- a/arch/arm/mach-omap2/cm3xxx.c
>> +++ b/arch/arm/mach-omap2/cm3xxx.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/err.h>
>>  #include <linux/io.h>
>>
>> +#include "common.h"
>>  #include "prm2xxx_3xxx.h"
>>  #include "cm.h"
>>  #include "cm3xxx.h"
>> diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
>> --- a/arch/arm/mach-omap2/cminst44xx.c
>> +++ b/arch/arm/mach-omap2/cminst44xx.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/err.h>
>>  #include <linux/io.h>
>>
>> +#include "common.h"
>>  #include "clockdomain.h"
>>  #include "cm.h"
>>  #include "cm1_44xx.h"
>> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/init.h>
>>  #include <linux/bug.h>
>> +#include <linux/delay.h>
>>
>>  #include "soc.h"
>>  #include "powerdomain.h"
>> diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
>> --- a/arch/arm/mach-omap2/prcm-common.h
>> +++ b/arch/arm/mach-omap2/prcm-common.h
>> @@ -434,28 +434,6 @@
>>  #define MAX_IOPAD_LATCH_TIME			100
>>  # ifndef __ASSEMBLER__
>>
>> -#include <linux/delay.h>
>> -
>> -/**
>> - * omap_test_timeout - busy-loop, testing a condition
>> - * @cond: condition to test until it evaluates to true
>> - * @timeout: maximum number of microseconds in the timeout
>> - * @index: loop index (integer)
>> - *
>> - * Loop waiting for @cond to become true or until at least @timeout
>> - * microseconds have passed.  To use, define some integer @index in the
>> - * calling code.  After running, if @index == @timeout, then the loop has
>> - * timed out.
>> - */
>> -#define omap_test_timeout(cond, timeout, index)			\
>> -({								\
>> -	for (index = 0; index < timeout; index++) {		\
>> -		if (cond)					\
>> -			break;					\
>> -		udelay(1);					\
>> -	}							\
>> -})
>> -
>>  /**
>>   * struct omap_prcm_irq - describes a PRCM interrupt bit
>>   * @name: a short name describing the interrupt type, e.g. "wkup" or "io"
>> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
>> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
>> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/err.h>
>>  #include <linux/io.h>
>>
>> +#include "common.h"
>>  #include "powerdomain.h"
>>  #include "prm2xxx_3xxx.h"
>>  #include "prm-regbits-24xx.h"
>> diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
>> --- a/arch/arm/mach-omap2/prm33xx.c
>> +++ b/arch/arm/mach-omap2/prm33xx.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/err.h>
>>  #include <linux/io.h>
>>
>> +#include "common.h"
>>  #include "powerdomain.h"
>>  #include "prm33xx.h"
>>  #include "prm-regbits-33xx.h"
>>
