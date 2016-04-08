From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3] ARM: dts: dra7: Correct clock tree for sys_32k_ck
Date: Fri, 8 Apr 2016 09:00:34 -0700
Message-ID: <20160408160033.GV16484@atomide.com>
References: <1459748235-27232-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459748235-27232-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lokeshvutla-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [160403 22:38]:
> This is w.r.t J6/J6eco: 32clk is pseudo (erratum i856) - clock source.
> Errata i856 for the AM572x (DRA7xx) points out that the 32.768KHz external
> crystal is not enabled at power up. Instead the CPU falls back to using
> an emulation for the 32KHz clock which is SYSCLK1/610.  SYSCLK1 is usually
> 20MHz on boards so far (which gives an emulated frequency of 32.786KHz)
> 
> Modelling the same in device tree.
> 
> Acked-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> ---
> Errata Document: http://www.ti.com/lit/er/sprz429h/sprz429h.pdf
> Errata number: i856
> 
> Tested the debugfs clock tree nodes on DRA7-EVM.
> 
> Changes in v3:
> 
>   Rebased to 4.6-rc2
>   Tested on top of omap-for-v4.6/fixes-rc1 branch and the patch applied
>   cleanly.

Thanks applying into omap-for-v4.6/fixes.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
