From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
Date: Wed, 4 May 2016 10:26:35 -0700
Message-ID: <20160504172634.GS5995@atomide.com>
References: <1461925297-9734-1-git-send-email-peter.ujfalusi@ti.com>
 <6ee9d67a-e907-715a-f3f5-d90a470314c3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6ee9d67a-e907-715a-f3f5-d90a470314c3-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Adding Nishanth to Cc.

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160429 05:15]:
> ldo7_reg, obviously ;)
> 
> > 	status = "okay";
> > 	regulator-min-microvolt = <1800000>;
> > 	regulator-max-microvolt = <1800000>;
> > };

It really seems to be ldo7, otherwise there's no HDMI output. I don't
have the schematics either.

But it seems we have at least two other regressions in Linux next that
prevent me from testing this properly:

1. On igepv5, I get this for the MMC regulator

ldo9: bypassed regulator has no supply!
ldo9: failed to get the current voltage(-517)
palmas-pmic 48070000.i2c:palmas@48:palmas_pmic: failed to register 48070000.i2c:palmar

I'm pretty sure it really is using the ldo9 for MMC just like
omap5-uevm.. Nishanth suggested it may use something else, but
why would it as ldo9 has a nice voltage range?

2. On both omap5-uevm and igepv5, NFSroot hangs

It seems that NFSroot boots to the point where PM runtime now
just shuts down some regulator affecting the USB connected
smsc Ethernet adapter?

Regards,

Tony


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
