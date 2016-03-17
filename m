From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 3/6] ARM: AM335x/AM437x: hwmod: Remove eQEP, ePWM and
 eCAP hwmod entries
Date: Thu, 17 Mar 2016 10:06:19 -0500
Message-ID: <20160317150619.GA28105@rob-hp-laptop>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-4-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457400224-24797-4-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 07, 2016 at 07:23:41PM -0600, Franklin S Cooper Jr wrote:
> Devices that utilize the OCP registers and/or PRCM registers and
> register bit fields should be modelled using hwmod. Since eQEP, ePWM and

s/modelled/modeled/

> eCAP don't fall under this category, remove their hwmod entries.
> 
> Instead these clocks simply use the clock that is pass through by its
> parent PWMSS. Therefore, PWMSS handles the clock for itself and its
> subdevices.

Are you breaking compatibility with old DTs here? 
 
> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/pwm/pwm-tiecap.txt         |  1 -
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  7 +-
>  .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  | 18 -----
>  .../omap_hwmod_33xx_43xx_interconnect_data.c       | 64 -----------------
>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 84 ----------------------
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  9 ---
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 54 --------------
>  7 files changed, 4 insertions(+), 233 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
