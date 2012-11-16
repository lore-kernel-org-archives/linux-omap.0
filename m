From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: AM33XX: Enable system power off control in am335x-bone
Date: Fri, 16 Nov 2012 11:10:04 -0800
Message-ID: <87r4ntcqk3.fsf@deeprootsystems.com>
References: <1353067706-29491-1-git-send-email-anilkumar@ti.com>
	<1353067706-29491-5-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54986 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab2KPTJx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 14:09:53 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2056939pad.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Nov 2012 11:09:53 -0800 (PST)
In-Reply-To: <1353067706-29491-5-git-send-email-anilkumar@ti.com> (AnilKumar
	Ch's message of "Fri, 16 Nov 2012 17:38:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: a.zummo@towertech.it, sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca, broonie@opensource.wolfsonmicro.com, rob.herring@calxeda.com, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

AnilKumar Ch <anilkumar@ti.com> writes:

> Enable system power off control for BeagleBone in am335x-bone.dts file
> under rtc node. RTC is the incharge of controlling the system power.
> This flag is used by the driver to hook up the pm_power_off system call.
>
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone.dts |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index 1d55190..206c3eb 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -52,6 +52,10 @@
>  			};
>  
>  		};
> +
> +		rtc@44e3e000 {
> +			ti,system-power-controller;
> +		};
>  	};

Also, I think this series is missing a patch that allows the RTC driver
to be compiled on AM335x.

Kevin

