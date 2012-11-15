From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH 7/8] ARM: OMAP: Remove unnecessary inclusion of dmtimer.h
Date: Thu, 15 Nov 2012 14:42:13 -0600
Message-ID: <CALLhW=5wiTd9u0PorwDH_68K7XRS8_ajDSDOLB7x8F2qvtJvaA@mail.gmail.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
 <1352830403-1706-8-git-send-email-jon-hunter@ti.com>
 <50A3BE85.5000804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50A3BE85.5000804@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On 14 November 2012 09:53, Jon Hunter <jon-hunter@ti.com> wrote:
>> diff --git a/drivers/staging/tidspbridge/core/ue_deh.c b/drivers/staging/tidspbridge/core/ue_deh.c
>> index 3d28b23..6aea6f1 100644
>> --- a/drivers/staging/tidspbridge/core/ue_deh.c
>> +++ b/drivers/staging/tidspbridge/core/ue_deh.c
>> @@ -19,7 +19,6 @@
>>
>>  #include <linux/kernel.h>
>>  #include <linux/interrupt.h>
>> -#include <plat/dmtimer.h>
>>
>>  #include <dspbridge/dbdefs.h>
>>  #include <dspbridge/dspdeh.h>
>
> Hi Omar, I should have had you in copy on this one. Are you ok with the
> removal of the above dmtimer.h include? It does not appear that this
> file needs to include dmtimer.h.

Indeed, we don't use it here.

> Is it ok for this to go through Tony's tree? If so, care to ACK?

Looks fine to me, but I believe you will want to let Greg know if this
patch will bypass staging tree.

Acked-by: Omar Ramirez Luna <omar.luna@linaro.org>

Cheers,

Omar
