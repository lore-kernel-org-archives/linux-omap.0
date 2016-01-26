From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Tue, 26 Jan 2016 09:25:28 -0800
Message-ID: <20160126172527.GY3500@atomide.com>
References: <20160123121022.GB12497@amd>
 <20160125163332.GT19432@atomide.com>
 <20160126140010.GA29723@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160126140010.GA29723@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [160126 06:01]:
> 
> It seems like I have rather lot of blocking bits:
> 
> 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000

Looks like most of these are for GPIO banks, that's OK those get saved
and restored in the idle loop.

Here bit 18 UART4 is a mystery though.. It's uart4 on 36xx but reserved
on 34xx. I do have that too on my n900, but it's hitting off mode with
v4.4.

> ffdffe8d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200072
> 0000000d 48004a28 (fa004a28) cm_idlest3_core
> 
> cm_idlest1_core changes periodicall often, to 00218072. The rest seems
> constant.

For cm_idlest1_core 42 is the answer.. Here you have bits 4 and 5
blocking which is for OTG and it's PHY. That's a known issue with
musb and setting pm_runtime_irq_safe() on the MUSB parent.

If you do rmmod omap2430 and phy-twl4030usb chances are the LEDs will
start going off assuming the McSPI bit goes low with WLAN idling.

Looks like we have some regression with v4.5-rc1 where n900 is not
hitting deeper idle states though. I'll run git bisect between
v4.4..v4.5-rc1.

Regards,

Tony
