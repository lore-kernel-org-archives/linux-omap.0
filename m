From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 1/5] ARM: mm: cache-l2x0: Add base address argument to
 write_sec callback
Date: Wed, 11 Jun 2014 18:07:24 +0200
Message-ID: <53987EBC.70307@samsung.com>
References: <1402500612-4778-1-git-send-email-t.figa@samsung.com>
 <1402500612-4778-2-git-send-email-t.figa@samsung.com>
 <CAJgR-BhgZ7k_Uk_Md79pkZKQXTZUjspqq0u9sa9D69Kixy7DhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAJgR-BhgZ7k_Uk_Md79pkZKQXTZUjspqq0u9sa9D69Kixy7DhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Loeliger <loeliger@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Robin Holt <holt@sgi.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11.06.2014 18:00, Jon Loeliger wrote:
>> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
>> index 060a75e..ddaebcd 100644
>> --- a/arch/arm/include/asm/mach/arch.h
>> +++ b/arch/arm/include/asm/mach/arch.h
>> @@ -46,7 +46,8 @@ struct machine_desc {
>>         enum reboot_mode        reboot_mode;    /* default restart mode */
>>         unsigned                l2c_aux_val;    /* L2 cache aux value   */
>>         unsigned                l2c_aux_mask;   /* L2 cache aux mask    */
>> -       void                    (*l2c_write_sec)(unsigned long, unsigned);
>> +       void                    (*l2c_write_sec)(void __iomem *,
>> +                                                unsigned long, unsigned);
>>         struct smp_operations   *smp;           /* SMP operations       */
>>         bool                    (*smp_init)(void);
>>         void                    (*fixup)(struct tag *, char **);
> 
>> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
>> index efc5cab..1695eab 100644
>> --- a/arch/arm/mm/cache-l2x0.c
>> +++ b/arch/arm/mm/cache-l2x0.c
>> @@ -72,7 +72,7 @@ static void l2c_write_sec(unsigned long val, void __iomem *base, unsigned reg)
>>         if (val == readl_relaxed(base + reg))
>>                 return;
>>         if (outer_cache.write_sec)
>> -               outer_cache.write_sec(val, reg);
>> +               outer_cache.write_sec(base, val, reg);
>>         else
>>                 writel_relaxed(val, base + reg);
>>  }
> 
> The parameter order (base, val, reg) seems very non-intuitive.
> Are you matching some existing prototype or adhering to some
> backwards compatibility issue?  If not wouldn't, say, (base, reg, val)
> or (val, base, reg) be more intuitive?

Hmm, I didn't think too much about this, so this order is just whatever
first came to my mind, probably because I'm used to xxx_write(ctx, val,
reg) accessors found in many drivers.

Anyway, l2c_write_sec() in arm/mm/cache-l2x0.c, which calls
outer_cache.write_sec(), already uses (val, base, reg) convention, so
probably this one would be most suitable. I'll change in v2.

Best regards,
Tomasz
