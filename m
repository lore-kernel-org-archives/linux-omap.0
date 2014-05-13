From: Tom Rini <trini@ti.com>
Subject: Re: [PATCH v2] ARM: dts: am335x-bone-common: Add i2c2 definition
Date: Tue, 13 May 2014 08:53:39 -0400
Message-ID: <537215D3.70306@ti.com>
References: <1399686184-1594-1-git-send-email-mranostay@gmail.com>	<20140512195050.GB5668@atomide.com>	<CAOCHtYiYwx_bEsyqkbUTTAbhBYESzvfBOOYeVuFXPS1dDy0ZKA@mail.gmail.com>	<20140512201517.GC5668@atomide.com>	<CAOCHtYg6XpF0Gbo4iFqsFvP=QSivQQvCzov8UfxeLXMzrRYEWw@mail.gmail.com>	<20140512204213.GD5668@atomide.com> <CAOCHtYgg7jwxswH+mqF3RA7-0RP-nGuft+Ze-GRwu1fbA6+0Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39215 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932401AbaEMMxx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 May 2014 08:53:53 -0400
In-Reply-To: <CAOCHtYgg7jwxswH+mqF3RA7-0RP-nGuft+Ze-GRwu1fbA6+0Bw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Matt Ranostay <mranostay@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, Matt Porter <matt.porter@linaro.org>

On 05/12/2014 04:57 PM, Robert Nelson wrote:
>>> Either case if fine with me.  As who knows when the dtc "overlay" will
>>> every truly make it mainline, as the capemgr was the only real kernel
>>> user of the i2c/at24 eeprom information.
>>
>> Sounds like we should keep it disabled though so u-boot can be used
>> to toggle it while waiting for the capemgr. That's because the board
>> has a header for pins, so it's not exactly limited to just the capes.
>>
>> Anybody working on enabling/disabling cape dtb configurations in u-boot?
> 
> Well,
> 
> Would Tom even approve of that in mainline u-boot? He didn't want my
> "invert" the gpio to enable the usb hub on the older beagle xm A/B..
> 
> http://lists.denx.de/pipermail/u-boot/2014-January/172154.html
> 
> http://lists.denx.de/pipermail/u-boot/2014-January/172274.html

I would think that using the 'fdt' command in U-Boot to add all
properties of every cape found on a running system would drive someone
to madness quite quickly.  Moving all of Pantelis' work for dynamic
device trees from the kernel to N bootloaders (U-Boot, barebox, UEFI,
etc) sounds like a step in the wrong direction.

-- 
Tom
