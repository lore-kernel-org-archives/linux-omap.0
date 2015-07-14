From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: configure regulators for Gumstix Pepper
Date: Mon, 13 Jul 2015 23:49:31 -0700
Message-ID: <20150714064931.GC17550@atomide.com>
References: <1436481477-18002-1-git-send-email-adam.yh.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436481477-18002-1-git-send-email-adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ashcharles-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org, arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150709 15:40]:
> Boot process is halting in midway because some of the necessary voltage
> regulators are deemed unused and subsequently powered off, leading to
> a completely unresponsive system.
> 
> Most of the device nodes had correct voltage regulator attachments.
> Yet these nodes had to set stricter enforcement on them through
> 'regulator-boot-on' and 'regulator-always-on' to function correctly.
> 
> The consumers of the regulators this commit affect are the followings:
> 
> 	DCDC1: vdd_1v8 system supply, USB-PHY, and ADC
> 	DCDC2: Core domain
> 	DCDC3: MPU core domain
> 	 LDO1: RTC
> 	 LDO2: 3v3 IO domain
> 	 LDO3: USB-PHY; not a boot-time requirement
> 	 LDO4: LCD [16:23]
> 
> All but LDO3 need to be always-on for the system to be functional.
> 
> Additionally regulator-name properties have been added for the kernel to
> display the name from the schematic. This will improve diagnostics.

Thanks for updating the description, applying this into
omap-for-v4.2/fixes.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
