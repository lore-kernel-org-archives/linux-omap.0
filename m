From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan
 node
Date: Mon, 5 Jan 2015 11:33:50 -0600
Message-ID: <54AACAFE.7050609@ti.com>
References: <1420475549-28492-1-git-send-email-nm@ti.com> <20150105172737.GK19336@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41366 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbbAEReR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Jan 2015 12:34:17 -0500
In-Reply-To: <20150105172737.GK19336@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, sre@kernel.org

On 01/05/2015 11:27 AM, Felipe Balbi wrote:
> On Mon, Jan 05, 2015 at 10:32:29AM -0600, Nishanth Menon wrote:
>> TPS gpio now controls a 5v 500mA TL5209 regulator which may be supply
>> a fan (such as AFB02505HHB) over J1 connector for various purposes.
>> Provide device tree node to enable the same.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> V4: Change format of the speed-map used.
>> V3: https://patchwork.kernel.org/patch/5562121/
>> V2: https://patchwork.kernel.org/patch/5445111/
>> V1: https://patchwork.kernel.org/patch/5444911/
>>
>> Enable and disable can be controlled by (post the RPM, it finds
>> closest match - even a 1 will do)
>>
>> echo '13000' > /sys/class/hwmon/hwmon0/fan1_target
>> and
>> echo '0' > /sys/class/hwmon/hwmon0/fan1_target
>>
>> Test log: http://slexy.org/view/s2T0ajh46z
>>
>> requires CONFIG_GPIO_PALMAS and CONFIG_SENSORS_GPIO_FAN to be operational
> 
> oh, perhaps add these as modules to omap2plus_defconfig ?
> 

In a different patch I suppose if Tony wants it that way.


-- 
Regards,
Nishanth Menon
