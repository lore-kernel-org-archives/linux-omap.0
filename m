From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Wed, 30 Mar 2016 12:12:09 -0700
Message-ID: <20160330191208.GW9329@atomide.com>
References: <20160126172527.GY3500@atomide.com>
 <20160130200244.GA30429@amd>
 <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com>
 <20160207212316.GA6147@amd>
 <20160209172403.GK19432@atomide.com>
 <20160323123801.GC32031@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160323123801.GC32031@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [160323 05:38]:
> 
> Ok, another attempt at shutting USB down:
> 
> 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> f7dffe9d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200062
> 0000000d 48004a28 (fa004a28) cm_idlest3_core
> 
> Tried again today:
> 
> 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> f7dffe9d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200062
> 0000000d 48004a28 (fa004a28) cm_idlest3_core
> pavel@n900:/my/tui/ofone$ sleep test
> 
> 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> ffde7e9d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00218062
> 0000000d 48004a28 (fa004a28) cm_idlest3_core
> 
> 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> fedffe9d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 01200062
> 0000000d 48004a28 (fa004a28) cm_idlest3_core
> 
> 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> ffde7e9d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00218062
> 0000000d 48004a28 (fa004a28) cm_idlest3_core
> 
> Is there documentation for the cm_idlest1_ bits?

Yes, see the TRM.

> How idle system do I need to have? Screen is blanked and machine
> should be mostly idle, but there's X running on another vt with Mate
> desktop, and some python scripts... GSM modem should be online.

Well I think it's the USB only you have blocking deeper idle states.

Are you sure you rmmod:ed all the USB related modules like in my
test script?

MUSB currently has an unresolved issue where it blocks idle states
if loaded.

> Are you booting over USB from NOLO?

I'm booting over smc91x using u-boot.

Regards,

Tony
