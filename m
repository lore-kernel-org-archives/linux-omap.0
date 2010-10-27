From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 0/9] OMAP3: Adding Smartreflex and Voltage driver support
Date: Wed, 27 Oct 2010 12:21:19 -0500
Message-ID: <4CC85F8F.8020705@ti.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32836 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675Ab0J0RVW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Oct 2010 13:21:22 -0400
In-Reply-To: <1288195856-11011-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

Gopinath, Thara had written, on 10/27/2010 11:10 AM, the following:
> This patch series introduces smartreflex and voltage driver support
> for OMAP3430 and OMAP3630. SmartReflex modules do adaptive voltage
> control for real-time voltage adjustments.
[..]
thanks for the revamped set
> 
> This patch series is based against lo-master with the following additional
> patches applied.
> 	https://patchwork.kernel.org/patch/266911/
> 	https://patchwork.kernel.org/patch/266921/
> 	https://patchwork.kernel.org/patch/266931/
> 	https://patchwork.kernel.org/patch/183712/
> 	https://patchwork.kernel.org/patch/285872/
> 
> The entire series with the dependencies are available at
>         http://dev.omapzoom.org/?p=thara/omap-dvfs.git;a=summary
>         head: thara-pm-sr
> 
> This patch series has been tested on OMAP3430 SDP with omap2plus_defconfig
> with the following menuconfig options enabled.
> System type -> TI OMAP Implementations -> Smartreflex Support
> System type -> TI OMAP Implementations ->
> 		Class 3 mode of Smartreflex Implementation
> 
Thanks for hosting the branch, Looking at:
http://dev.omapzoom.org/?p=thara/omap-dvfs.git;a=shortlog;h=refs/heads/thara-pm-sr
I am guessing DVFS is missing in this branch? Is it possible to give it 
a test drive?

Also curious should:
"OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code should probably be 
" dropped with "OMAP3: PM: Register TWL4030 pmic info with the voltage" ?

[...]

my 2cents: If that tree were organized based on branches which depend on 
each other it will be easier to identify the dependencies :)
probably:
kernel.org (now that l-o is merged - potential 2.6.37-rc1)
  |- clock patches  -\
  |- DVFS series    -|
  |- OMAP OPP series |
                     |-merged-based -
				 |-voltage layer & SR series perhaps
				 	|- twl optimization
						|- board changes
						*** final code ***
Just 2 cents to make it easier for folks who are not in PM mostly to see 
how everything falls together in place..

-- 
Regards,
Nishanth Menon
