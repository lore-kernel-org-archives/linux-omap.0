From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: AM43XX: Remove min and max voltage values
 for dcdc3
Date: Tue, 6 Jun 2017 00:32:07 -0700
Message-ID: <20170606073207.GV3730@atomide.com>
References: <1496395441-29526-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1496395441-29526-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [170602 02:27]:
> dcdc3 supplies to DDR on AM43x series. When we set both
> min and max values to the same value. The regulator framework
> sets that particular voltage. This is bad as we are changing
> the ddr voltage when executing from ddr. Hence remove the min and
> max values. The ddr supply voltage shall be set from bootloader
> when not executing from ddr and not while executing from kernel.
> 
> The previous discussion can be found here:
> 
> http://www.spinics.net/lists/devicetree/msg56399.html
> 
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

Applying into omap-for-v4.13/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
