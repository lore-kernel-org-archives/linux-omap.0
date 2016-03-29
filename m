From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 13/15] irqchip/gic: Prepare for adding platform driver
Date: Tue, 29 Mar 2016 14:59:21 +0100
Message-ID: <56FA8A39.1000609@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-14-git-send-email-jonathanh@nvidia.com>
 <CAMuHMdVwZgsPNdkWooLHg5H9_Mmv_mKa=zh9T4K-mfjPUEk4CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVwZgsPNdkWooLHg5H9_Mmv_mKa=zh9T4K-mfjPUEk4CQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Geert,

On 29/03/16 14:04, Geert Uytterhoeven wrote:
> Hi Jon,
> 
> On Thu, Mar 17, 2016 at 3:19 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> --- a/drivers/irqchip/irq-gic.c
>> +++ b/drivers/irqchip/irq-gic.c
> 
>> -#ifdef CONFIG_SMP
>> -               set_smp_cross_call(gic_raise_softirq);
>> -               register_cpu_notifier(&gic_cpu_notifier);
>> -#endif
> 
> 
>> +       if (gic_nr == 0) {
>> +               if (IS_ENABLED(CONFIG_SMP)) {
>> +                       set_smp_cross_call(gic_raise_softirq);
> 
> If CONFIG_SMP=n:
> 
> drivers/irqchip/irq-gic.c: In function '__gic_init_bases':
> drivers/irqchip/irq-gic.c:1165:4: error: implicit declaration of
> function 'set_smp_cross_call' [-Werror=implicit-function-declaration]
>     set_smp_cross_call(gic_raise_softirq);
>     ^
> 
> There's no dummy for the CONFIG_SMP=n case, so you either have to
> keep the #ifdef, or add a dummy.
> 
>> +                       register_cpu_notifier(&gic_cpu_notifier);
>> +               }

Thanks. I have already fixed this in my tree locally.

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
