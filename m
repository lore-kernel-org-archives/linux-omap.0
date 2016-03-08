From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 0/6] ARM: am335x/am437x/dra7: Add PWM support for
 DRA7
Date: Tue, 8 Mar 2016 06:55:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603080642400.4974@utopia.booyaka.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457400224-24797-1-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Franklin

On Mon, 7 Mar 2016, Franklin S Cooper Jr wrote:

> This patch series adds support for PWM for DRA7. The IP is same as that
> present in AM33XX and AM437XX.
> 
> However, before doing so remove unnecessary hwmod entries for eCAP, ePWM
> and eQEP.
> 
> This series is almost identical to v4. Only difference is the addition of
> eCAP DT nodes in the dra7.dtsi file.
> 
> This series was tested on AM335x GP, AM437x GP and X15 + LCD screen for
> PWM based backlight.
> 
> This series was also verified to be backwards compatible with old dtbs.

Looking at these to see what I can pick for v4.7, I'm curious about the 
dependencies.  Can I take patches 2 and 3 before 1 is merged, or does 1 
need to be merged first?

- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
