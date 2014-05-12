From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: am335x-bone-common: Add i2c2 definition
Date: Mon, 12 May 2014 15:57:40 -0500
Message-ID: <CAOCHtYgg7jwxswH+mqF3RA7-0RP-nGuft+Ze-GRwu1fbA6+0Bw@mail.gmail.com>
References: <1399686184-1594-1-git-send-email-mranostay@gmail.com>
	<20140512195050.GB5668@atomide.com>
	<CAOCHtYiYwx_bEsyqkbUTTAbhBYESzvfBOOYeVuFXPS1dDy0ZKA@mail.gmail.com>
	<20140512201517.GC5668@atomide.com>
	<CAOCHtYg6XpF0Gbo4iFqsFvP=QSivQQvCzov8UfxeLXMzrRYEWw@mail.gmail.com>
	<20140512204213.GD5668@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140512204213.GD5668@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tom Rini <trini@ti.com>, Matt Ranostay <mranostay@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, Matt Porter <matt.porter@linaro.org>
List-Id: linux-omap@vger.kernel.org

>> Either case if fine with me.  As who knows when the dtc "overlay" will
>> every truly make it mainline, as the capemgr was the only real kernel
>> user of the i2c/at24 eeprom information.
>
> Sounds like we should keep it disabled though so u-boot can be used
> to toggle it while waiting for the capemgr. That's because the board
> has a header for pins, so it's not exactly limited to just the capes.
>
> Anybody working on enabling/disabling cape dtb configurations in u-boot?

Well,

Would Tom even approve of that in mainline u-boot? He didn't want my
"invert" the gpio to enable the usb hub on the older beagle xm A/B..

http://lists.denx.de/pipermail/u-boot/2014-January/172154.html

http://lists.denx.de/pipermail/u-boot/2014-January/172274.html

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
