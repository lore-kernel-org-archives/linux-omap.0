From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
Date: Tue, 19 May 2015 07:55:26 -0700
Message-ID: <20150519145526.GO10274@atomide.com>
References: <1431525001-5747-1-git-send-email-robertcnelson@gmail.com>
 <20150513141658.GB6605@localhost>
 <20150513144846.GC6605@localhost>
 <CAALWOA-hkgrMi+OeNrmwaVpdEfNadFn0R-QbpXi9LU-4sbakJQ@mail.gmail.com>
 <20150518152108.GE10274@atomide.com>
 <CAALWOA-OwUuAbc7Wd_SV-14mVbOCVWvKwKgb3eOjVGEery28og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAALWOA-OwUuAbc7Wd_SV-14mVbOCVWvKwKgb3eOjVGEery28og-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150519 00:27]:
> On 18 May 2015 at 17:21, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > If some of these depend on the SoC revision and cannot be detected
> > based on the RTC driver revision register, that information should
> > be be passed to the RTC driver in platform data.
> 
> The SoC revision is easy enough to check via the control module as
> usual, but is not really the biggest issue. Even on SoC rev 1.0
> RTC-only sleep still has some functionality (the RTC freezes if PMIC
> enters sleep-state, but that may still be preferred compared to
> complete loss of date and time), so I'm not even sure I'd bother with
> this check.

OK
 
> The serious problems however depend on the PCB: Entering RTC-only
> sleep is only properly supported on some early prototype series
> (pre-A6) of the BeagleBone Black. Since rev A6A (which includes all
> production versions) it is not supported at all.
> 
> On rev A6 of the Black, as well as (afaik) all versions of the White
> (if anyone cares, since they normally have SoC rev 1.0), the impact of
> entering RTC-only sleep is heavily dependent on external connections
> and hardware, most of which not really detectable. It is possible to
> go from "hmm, annoying standby current" to a recipe for stir-fried I/O
> pin simply by connecting a console cable while the device is in sleep.
> This is not something the kernel can foresee or prevent.
> 
> I'm pretty sure the sane thing to do here is disable RTC-only sleep by
> default. People who care about it can still enable it after they
> verified the particular combination of pcb revision, external
> hardware, and usage scenario is safe (or patched the hardware to make
> it safe, or decided they're willing to take the risk.)

Makes sense to me. Robert, care to update your patch to summarize
some of the "why" parts?

> It may be useful to leave some references for those who seek guidance:
> 
> 1. The issues with AM335x rev 1.0 SoCs are documented in the errata.
> 
> 2. Unfortunately I still have no idea why TI altered the connection
> diagram w.r.t. "VDDS" (and as a consequence officially defeatured
> RTC-only sleep) when the TPS65217C/D PMIC for AM335x + DDR3/3L memory
> is used. Maybe I'll still get an answer from TI on E2E, but I'm also
> planning to do more thorough testing this week especially w.r.t.
> current consumption patterns during boot and shutdown.
> 
> 3. The BeagleBone regulator problem is particularly notorious among
> people who (try to) use the PMIC's battery power support, since the
> problem then also surfaces during full shutdown. It has a long
> discussion thread here:
> https://groups.google.com/d/topic/beagleboard/7sxPePT7wkM/discussion
> which includes two posts by me with fairly detailed analysis along
> with scope pics:
> https://groups.google.com/d/msg/beagleboard/7sxPePT7wkM/3vFMPydR20IJ
> https://groups.google.com/d/msg/beagleboard/7sxPePT7wkM/V1Ft-xxh0agJ

OK thanks for the good summary.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
