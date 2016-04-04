From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Mon, 4 Apr 2016 15:07:49 -0700
Message-ID: <20160404220748.GA16484@atomide.com>
References: <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com>
 <20160207212316.GA6147@amd>
 <20160209172403.GK19432@atomide.com>
 <20160323123801.GC32031@amd>
 <20160330191208.GW9329@atomide.com>
 <20160404213056.GA25912@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160404213056.GA25912@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [160404 14:31]:
> 
> Display off, on wifi:
> 
> 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> f7de7ebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00218042
> 0000000d 48004a28 (fa004a28) cm_idlest3_core
> 
> 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> ffde7ebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00218042
> 
> 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> ffdffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200042
> 
> ..so I believe gadget bits are still set.

Nope, you got PM working now for the USB as it's now ending with 0x42
instead of 0x62 :) You still have bit 21 blocking, sorry don't
remember what that one is, but that's in the TRM for idlest1
register.

Regards,

Tony
