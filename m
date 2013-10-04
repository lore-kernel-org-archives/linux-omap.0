From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Fri, 4 Oct 2013 18:34:39 +0300
Message-ID: <524EE00F.7010208@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380098922-30340-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Just a gentle reminder, anybody have any comments on this series or 
should we start queuing stuff?

-Tero

On 09/25/2013 11:48 AM, Tero Kristo wrote:
> Hi all,
>
> Version 7 contains following high level changes:
> - Dropped support for basic bindings from Mike Turquette, instead using
>    vendor specific bindings for all clocks
> - Mux clock + divider clock vendor specific bindings get rid of use
>    of the bit-masks, instead these are generated runtime based on parent
>    clock / divider min/max info, see individual patches for details
> - Added support for dummy_ck nodes, was missing from previous version
> - Fixed support for omap3630
> - Added support for new clock node type: ti,mux-gate-clock (using composite
>    clock type)
> - OMAP4 / OMAP5 only build fixes (compiler flag checks added to some files)
> - most of the of_omap_* calls renamed to of_ti_*
> - Rebased on top of v3.12-rc2
>
> Some detailed comments about patch level changes (if no mention, no major
> changes):
> - Patch #1:
>    * removed use of reg-names property, instead registers mapped using
>      compatible string
>    * removed ti,modes property, instead uses DPLL mode flags now
>    * separated AM33XX DPLLs under their own compatible strings
> - Patch #4 & #5: new patches
> - Patch #6: merged basic gate support from Mike to this patch as vendor
>    specific gate clock support
> - Patch #9 & #10: new patches
> - Patch #11: dummy clocks added, USB / ABE DPLL setup ordering changed
> - Patch #14: dummy clocks added
> - Patch #20: dropped usage of reg-names property
> - Patch #21: dummy clocks added
> - Patch #22 & #23: new patches
> - Patch #30: AM35XX clock data added to this patch
> - Patch #31:
>    * dummy clocks added
>    * added missing 3630 clocks
>
> Test branch available here:
> https://github.com/t-kristo/linux-pm.git
> branch: mainline-3.12-rc2-ti-dt-clks-v7
>
> Testing done:
> - am335x-bone : boot only
> - omap5-sevm : boot only
> - dra7-evm : boot only
> - omap3-beagle : boot + suspend/resume (ret + off)
> - omap4-panda-es : boot + suspend/resume
>
> Nishanth has also been doing some tests with omap3-beagle-xm with some WIP
> versions of this branch, but not with this latest one. Nishanth, maybe you
> can provide test results to this one also?
>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
