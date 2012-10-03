From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: SmartReflex: pass device dependent data
 via platform data
Date: Wed, 3 Oct 2012 17:51:27 +0200
Message-ID: <CAORVsuX6HS6GPSjq8+htPg8XcFAshCa3s=9fCRQZ=arBTGEOQQ@mail.gmail.com>
References: <1348496201-6378-3-git-send-email-j-pihet@ti.com>
 <1349271133-18458-1-git-send-email-j-pihet@ti.com>
 <87391v39zn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87391v39zn.fsf@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: tony@atomide.com, J Keerthy <j-keerthy@ti.com>, Anton Vorontsov <cbou@mail.ru>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Kevin,

On Wed, Oct 3, 2012 at 4:29 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Remove the device dependent code (ex. cpu_is_xxx()) and settings
>> from the driver code and instead pass them via the platform
>> data. This allows a clean separation of the driver code and the platform
>> code, as required by the move of the platform header files to
>> include/linux/platform_data.
>>
>> Note about the smartreflex functional clocks: the smartreflex fclks
>> are derived from sys_clk and are named "smartreflex.%d". Since the
>> smartreflex device names and the functional clock names are identical
>> the device driver code uses them to control the functional clocks.
>
> Thanks for adding this part.
>
> One more nit below, then please resend this patch as a combined series
> with the "align fclk names" patch.
Just re-sent the new series.

> (note: The previous patch 1 from this
> series I've queued separately as a fix for v3.7-rc.  )
Thanks! The new series is based on mainline 3.6.0 with this patch applied.

...
>> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
>> index 24768a2..829467f 100644
>> --- a/drivers/power/avs/smartreflex.c
>> +++ b/drivers/power/avs/smartreflex.c
>> @@ -133,14 +133,11 @@ static void sr_set_clk_length(struct omap_sr *sr)
>>       struct clk *sys_ck;
>>       u32 sys_clk_speed;
>>
>> -     if (cpu_is_omap34xx())
>> -             sys_ck = clk_get(NULL, "sys_ck");
>> -     else
>> -             sys_ck = clk_get(NULL, "sys_clkin_ck");
>> +     sys_ck = clk_get(&sr->pdev->dev, "fck");
>
> nit: since this isn't the sys_clk anymore, could you s/sys_ck/fck/  ?
Done!

>
> Thanks,
>
> Kevin
>

Thanks,
Jean
