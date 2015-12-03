From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [4.4-rc][PATCH] ARM: dts: am4372: disable arm twd and global
 timer's nodes
Date: Thu, 3 Dec 2015 11:23:10 -0800
Message-ID: <20151203192310.GY23396@atomide.com>
References: <1447855315-419-1-git-send-email-grygorii.strashko@ti.com>
 <20151118141537.GC10644@leverpostej>
 <564C9ACF.6040107@ti.com>
 <20151203163311.GP23396@atomide.com>
 <20151203163708.GR23396@atomide.com>
 <566087DD.2040006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <566087DD.2040006-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, slash.tmp-GANU6spQydw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [151203 10:21]:
> On 12/03/2015 06:37 PM, Tony Lindgren wrote:
> > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [151203 08:34]:
> >>
> >> It seems we should apply this as a fix unless somebody has better ideas.
> > 
> > Actually I think the fix for now is "[4.4-rc][PATCH v2] ARM: dts: am4372: fix
> > clock source for arm twd and global timers" until PM starts working?
> > 
> 
> Yes. if no PM it should work, but PM patches are on the fly for Am43.

OK let's not merge this one then.

> But, again, main reason I've posted this patch is that I do not see the
> way how to enable/disable or limit functionality of these timer by using 
> Kconfig options in case of Muliplatform builds :( (or by boot parameters).
> 
> Example 1 (this is how 4.4 kernel is working):
> 1) OMAP4 has ARM TWD timer and properly supports it, so in Kconfig we have
> "select HAVE_ARM_TWD" and corresponding "local-timer" is defined in DT.
> AM437x has ARM TWD timer, but does not support it yet, so corresponding "local-timer"
> defined in DT and in Kconfig HAVE_ARM_TWD is not selected.
> (patch http://www.spinics.net/lists/arm-kernel/msg459649.html
>  is not merged yet)
> 
> Result: ARM TWD timer will be enabled on AM437x !? :(
> 
> Example 2:
> ARM Global timer can't be used as clocksource device if CPUFreq is enabled
> (this is not supported even by Timekeeping core now).
> 
> So, there are two options:
> 1) update selection for config SOC_AM43XX
> + select ARM_GLOBAL_TIMER if !CPU_FREQ
> 2) updated ARM GT driver and don't register clocksource device if CPUFreq is enabled
> 
> Both options will not work:
> 1) ARM_GLOBAL_TIMER will be selected if any other SoC in multiplatform build
> will select ARM_GLOBAL_TIMER
> 2) clocksource device will never be registered if at least one SoC will
> select CPU_FREQ. And this might break SoC which expect it to be registered,
> because CPU_FREQ is not enabled on these SoCs (no CPUFreq drivers registered).
> 
> So, as alternative to this patch, ARM timers nodes can be disabled in
> platform DTS files, but then all platform DTS files will need to be updated.

Yes I don't see any other option right now until we have the clocksource
switching happening. Only then will the scoring work properly.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
