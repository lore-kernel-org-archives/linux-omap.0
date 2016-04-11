From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4.4, 4.6: camera and unlock buttons produce tons of interrupts
 (was Re: N900 sleep mode)
Date: Mon, 11 Apr 2016 14:10:27 -0700
Message-ID: <20160411211026.GH5995@atomide.com>
References: <20160405142250.GA6429@amd>
 <20160405152916.GE16484@atomide.com>
 <20160405205137.GA10196@amd>
 <20160407174019.GM16484@atomide.com>
 <20160407194828.GA13338@amd>
 <20160407213229.GO16484@atomide.com>
 <20160407230150.GA16552@amd>
 <20160407234134.GQ16484@atomide.com>
 <20160411093023.GC11814@amd>
 <20160411094130.GA5753@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160411094130.GA5753@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Adding Tomi to Cc.

* Pavel Machek <pavel@ucw.cz> [160411 02:42]:
> > I made config with pretty minimal differences from defconfig (making
> > required drivers =y, lockdep off so that video works).
> > 
> > Do you think you could try with my config?

Yeah disabling lockdep by removing PROVE_LOCKING from omap2plus_defconfig
makes n900 LCD work for me again. Not getting any lockdep warnings
during boot with lockdep enabled though. So basically the following
patch makes LCD work on n900 with omap2plus_defconfig.

Tomi, got any ideas?

> Ok, it works now. I was doing tests in daylight so it was poorly
> visible. The right part of keyboard stays lit (but that's expected
> AFAICT), but the left part blinks.

During idle, both should go off and are doing so for me. Both LEDs off
indicates off mode, left LED off is for retention mode. So you still
have something blocking off mode, maybe check:

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode

Regards,

Tony

8< -------------------
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -472,7 +472,6 @@ CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_SCHEDSTATS=y
 CONFIG_TIMER_STATS=y
-CONFIG_PROVE_LOCKING=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
