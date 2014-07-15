From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/5] Add gta04 board variants
Date: Tue, 15 Jul 2014 05:04:56 -0700
Message-ID: <20140715120455.GC28715@atomide.com>
References: <1405369228-27197-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405369228-27197-1-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [140714 13:22]:
> This patch series completes the GTA04 device tree to describe all hardware
> components that are on the different variants of the GTA04 boards.
> 
> Marek Belisko (5):
>   arm: dts: omap3-gta04: Add missing nodes to fully describe gta04 board
>   arm: dts: omap3-gta04: Rename gta04.dts to gta04.dtsi and add a4 model
>   arm: dts: Add gta04a3 model
>   arm: dts: Add gta04+b2 model bindings
>   arm: dts: Add gta04+b3 model bindings

Hmm at least the first patch won't apply:

Hunk #4 FAILED at 143.
Hunk #5 succeeded at 142 with fuzz 2 (offset -26 lines).
Hunk #6 succeeded at 287 (offset -26 lines).
Hunk #7 succeeded at 364 (offset -26 lines).
Hunk #8 succeeded at 433 (offset -26 lines).
Hunk #9 succeeded at 472 (offset -26 lines).
Hunk #10 succeeded at 485 (offset -26 lines).
Hunk #11 succeeded at 556 (offset -26 lines).
Hunk #12 FAILED at 720.
2 out of 12 hunks FAILED -- rejects in file arch/arm/boot/dts/omap3-gta04.dts

Can you please repost against let's say v3.16-rc1? Maybe also
check they apply cleanly against omap-for-v3.17/dt branch that
I just pushed out to:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap-for-v3.17/dt

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
