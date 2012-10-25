From: Balaji T K <balajitk@ti.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial
 stuff)
Date: Thu, 25 Oct 2012 21:35:46 +0530
Message-ID: <5089635A.5040107@ti.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk> <20121023101036.GA1542@n2100.arm.linux.org.uk> <20121025010917.GL11928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59282 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758741Ab2JYQF4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 12:05:56 -0400
In-Reply-To: <20121025010917.GL11928@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Thursday 25 October 2012 06:39 AM, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121023 03:12]:
>> On Fri, Oct 12, 2012 at 04:54:34PM +0100, Russell King - ARM Linux wrote:
>> omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
>> omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
>> omap_hsmmc omap_hsmmc.4: Failed to get debounce clk
Hi,

Posted a patch to remove this warning, as debounce clock is not
applicable for most platforms and optional for omap2430.

https://patchwork.kernel.org/patch/1645461/

>> omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
>> omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.
>> mmc1: host does not support reading read-only switch. assuming write-enable.
>>
>> This looks much better compared to the previous set, but we could still
>> do with getting a "\n" on at least one of those messages...
>
> Kevin, do you have a patch for some of this?
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

