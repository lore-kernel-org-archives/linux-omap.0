From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 REPOST 3/5] omap4: Unconditionally require l2x0 L2
 cache controller support
Date: Wed, 14 Dec 2011 15:01:41 -0600
Message-ID: <4EE90EB5.9070502@gmail.com>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org> <1323862781-3465-4-git-send-email-dave.martin@linaro.org> <20111214181425.GB32251@atomide.com> <20111214183030.GB9331@linaro.org> <20111214183952.GG32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111214183952.GG32251-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Anton Vorontsov <avorontsov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, John Linn <john.linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 12/14/2011 12:39 PM, Tony Lindgren wrote:
> * Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [111214 09:58]:
>> On Wed, Dec 14, 2011 at 10:14:25AM -0800, Tony Lindgren wrote:
>>> * Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [111214 03:08]:
>>>> If running in the Normal World on a TrustZone-enabled SoC, Linux
>>>> does not have complete control over the L2 cache controller
>>>> configuration.  The kernel cannot work reliably on such platforms
>>>> without the l2x0 cache support code built in.
>>>
>>> There are HS and GP omaps (High Security and General Purpose).
>>> GP omaps do have full control of the L2. Also HS omaps most likely
>>> provide control over enabling and disabling L2 depending how the
>>> secure code is implemented.
>>>
>>> BTW, the real problem is that because the secure code is implemented
>>> in various ways, we don't really have any handling for it in Linux.
>>>
>>> The SMI instruction numbers don't seem to be standardized at all,
>>> and can mean different things on different boards, even different
>>> board versions :(
>>>
>>> Sounds like devicetree is the only safe way to deal with the L2
>>> control options.
>>>
>>> Regards,
>>>
>>> Tony
>>>
>>>  
>>>> This patch unconditionally enables l2x0 support for the OMAP4 SoCs.
>>>>
>>>> Thanks to Rob Herring for this suggestion. [1]
>>>>
>>>> Signed-off-by: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>
>>>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074495.html
>>>> ---
>>>>  arch/arm/mach-omap2/Kconfig |    2 +-
>>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>>>> index bb1b670..94e568a 100644
>>>> --- a/arch/arm/mach-omap2/Kconfig
>>>> +++ b/arch/arm/mach-omap2/Kconfig
>>>> @@ -41,11 +41,11 @@ config ARCH_OMAP4
>>>>  	bool "TI OMAP4"
>>>>  	default y
>>>>  	depends on ARCH_OMAP2PLUS
>>>> +	select CACHE_L2X0
>>>>  	select CPU_V7
>>>>  	select ARM_GIC
>>>>  	select HAVE_SMP
>>>>  	select LOCAL_TIMERS if SMP
>>>> -	select MIGHT_HAVE_CACHE_L2X0
>>>>  	select PL310_ERRATA_588369
>>>>  	select PL310_ERRATA_727915
>>>>  	select ARM_ERRATA_720789
>>>> -- 
>>>> 1.7.4.1
>>>>
>>
>> To clarify, are you suggesting we retain this patch, or not?
> 
> I think we should keep L2 configurable for omaps until we have some
> way of getting the configuration dynamically or from device tree.
>  

This already exists with l2x0_of_init. OMAP just needs to start using
it. It will initialize the l2 if present in the DT and skip it if not
present.

Rob

>> (If we only know what l2x0 support will be needed once the dts is
>> parsed at runtime, there could be an argument for keeping the
>> select CACHE_L2X0 here -- unless we have specific kconfigs for
>> the different security variants of omap.)
> 
> Well we can detect if it's an HS omap, but we may not know what
> SMI it uses for enabling and disabling L2.. That can depend on
> the board version.
> 
> Is there some problem keeping MIGHT_HAVE_CACHE_L2X0? This is
> pretty important from debugging cache issues point of view.
> 
> Regards,
> 
> Tony
