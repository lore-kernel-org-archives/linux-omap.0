From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v3 1/2] regulator: twl: adapt twl-regulator driver to
 dt
Date: Fri, 24 Feb 2012 09:18:56 +0530
Message-ID: <4F4708A8.8080608@ti.com>
References: <1329996954-27083-1-git-send-email-rnayak@ti.com> <1329996954-27083-2-git-send-email-rnayak@ti.com> <20120223153127.GD4553@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:55571 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754719Ab2BXDtF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 22:49:05 -0500
Received: by yhfq11 with SMTP id q11so1688078yhf.1
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 19:49:04 -0800 (PST)
In-Reply-To: <20120223153127.GD4553@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org, Tero Kristo <t-kristo@ti.com>

On Thursday 23 February 2012 09:01 PM, Mark Brown wrote:
> On Thu, Feb 23, 2012 at 05:05:53PM +0530, Rajendra Nayak wrote:
>> Modify the twl regulator driver to extract the regulator_init_data from
>> device tree when passed, instead of getting it through platform_data
>> structures (on non-DT builds)
>
> This doesn't apply to current -next, I expect because of the SMPS
> regulator changes which went in.  Please always submit patches against
> -next.  There's also a patch from Tero adding support for some
> additional regulators which is floating around and would conflict with
> this.  Could you guys please coordinate with each other on this?

Sure, I will co-ordinate with Tero and post my patches against -next.
