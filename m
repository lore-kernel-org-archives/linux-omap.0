From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: dm816x: Correct NAND support nodes
Date: Mon, 26 Jun 2017 02:38:36 -0700
Message-ID: <20170626093835.GU3730@atomide.com>
References: <1498045347-27324-1-git-send-email-trini@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498045347-27324-1-git-send-email-trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Mihail Grigorov <michael.grigorov-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org> [170621 04:42]:
> The ELM node in dm816x.dtsi needs to declare the correct compatible
> value here as per the binding only one value is correct, and the current
> driver handles it correctly.  We then add pinmux information for the
> NAND found on the EVM so that we do not rely on the ROM to do this for
> us, and also so that we do not try and probe NAND before we probe the
> ELM.

OK applying into omap-for-v4.13/dt as it's a fix. Only taking fixes
until -rc1 FYI all.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
