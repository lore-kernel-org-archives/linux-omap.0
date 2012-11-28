From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 18/22] mfd: omap-usb-host: get rid of cpu_is_omap..()
 macros
Date: Wed, 28 Nov 2012 18:49:31 +0200
Message-ID: <50B6409B.1080009@ti.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com> <1354114150-11941-19-git-send-email-rogerq@ti.com> <20121128163632.GB5312@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56890 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445Ab2K1Qtd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 11:49:33 -0500
In-Reply-To: <20121128163632.GB5312@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 11/28/2012 06:36 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [121128 06:51]:
>> Instead of using cpu_is_omap..() macros in the device driver we
>> rely on information provided in the platform data.
>>
>> The only information we need is whether the USB Host module has
>> a single ULPI bypass control bit for all ports or individual bypass
>> control bits for each port. OMAP3 REV2.1 and earlier have the former.
> 
> Does this depend on the other patches in this series? If not,
> this should be applied first as this is blocking omap multiplatform
> development. And this too needs to be updated for the new location
> of usb-omap.h in linux next.

OK. I'll send this patch separately based on top of linux-next.

> 
> Other than that:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks.

cheers,
-roger
