From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and
 charging of backup battery
Date: Fri, 8 Jan 2016 10:15:51 -0800
Message-ID: <20160108181551.GX12777@atomide.com>
References: <cover.1451995297.git.hns@goldelico.com>
 <b4a6fe205cbb1a9eddc4e5f63fa05d299641313d.1451995297.git.hns@goldelico.com>
 <568C5451.8070709@ti.com>
 <20160106010011.GG12777@atomide.com>
 <8FE6954B-6411-4593-9CE5-717A469A6AA8@goldelico.com>
 <20160106164136.GI12777@atomide.com>
 <2AC46952-3758-458A-B0A5-1794C207BD4C@goldelico.com>
 <20160106170925.GK12777@atomide.com>
 <66F37918-EA7F-4D83-8B5F-A6B5C0CD7623@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <66F37918-EA7F-4D83-8B5F-A6B5C0CD7623@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Nishanth Menon <nm@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [160108 09:50]:
> Tony,
> it is strange. It now works under unknown conditions - without any obvoius change.
> 
> Am 06.01.2016 um 18:09 schrieb Tony Lindgren <tony@atomide.com>:
> > 
> > OK. It could be also some .config change with something built-in?
> 
> I have compared /proc/config.gz from both systems and /sys/firmware/fdt
> with no significant and obvious change.
> 
> Then I booted the 4.4-rc8 again and this time it worked.
> 
> To verify, I have checked out linux-next this morning, cherry-picked this palmas
> rtc patch, compiled with omap2plus defconfig, and used the omap5-uevm.dtb. And
> hwclock works after doing a modprobe rtc_palmas.

Weird. No luck here with current linux next or anything.

> Then I did the same with official v4.4-rc8 and hwclock hangs. And now our
> 4.4-rc8 production kernel hangs again as well. Even if I use the
> DTB from the 4.3 kernel.

I'm not seeing the RTC second increase in u-boot either, this
should show it:

# i2c md 0x48 0x100

Of course the rtc may not be enabled in u-boot unlike for x15.

> So I think it is something which is unstable in 4.4-rc8 that is (probably) fixed in
> linux-next and unrelated to this DT patch.
> 
> But I have no hint or idea what it is.

Or something hangs the RTC? And the back-up battery has to drain to
reset the RTC somehow?

Regards,

Tony
