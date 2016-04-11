From: Pavel Machek <pavel@ucw.cz>
Subject: 4.6-rc2: regression with omap video and lockdep (was Re: 4.4, 4.6:
 camera and unlock buttons produce tons of interrupts (was Re: N900 sleep
 mode))
Date: Mon, 11 Apr 2016 10:27:42 +0200
Message-ID: <20160411082742.GA1993@amd>
References: <20160404213056.GA25912@amd>
 <20160404220748.GA16484@atomide.com>
 <20160405142250.GA6429@amd>
 <20160405152916.GE16484@atomide.com>
 <20160405205137.GA10196@amd>
 <20160407174019.GM16484@atomide.com>
 <20160407194828.GA13338@amd>
 <20160407213229.GO16484@atomide.com>
 <20160407230150.GA16552@amd>
 <20160407234134.GQ16484@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160407234134.GQ16484@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > > Nothing idling for me with your .config.. And it seems slower to boot
> > > compared to omap2plus_defconfig? Maybe because of the extra GPIO
> > > interrupts?
> > 
> > Extra interrupts only happen when enable_off_mode is 1, so that should
> > not be an issue during boot.
> 
> OK maybe it's just the extra driver probe time then.

Heh. I had earlyprintk enabled. That should explain it.

> Well I've been just using omap2plus_defconfig with:
> 
> # modprobe tsc2005
> # modprobe gpio_backlight
> # modprobe panel_sony_acx565akm
> # modprobe omapfb
> 
> # echo 255 > /sys/class/backlight/acx565akm/brightness
> 
> And then the following to blank for idle:
> 
> # echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank
> 
> But in the world of eternal regressions, I'm not seeing anything
> on the framebuffer with v4.6-rc2 :( No idea what broke it or when
> as my n900 is in the rack.

Can you try this patch to your config -- disabling lockdep? It should
fix the video for you. (And if you have the serial console... do you
see any warnings from lockdep?)

Thanks,
								Pavel
								
--- config.def	2016-04-08 21:50:04.519622137 +0200
+++ .config	2016-04-11 10:22:52.988193318 +0200
@@ -4183,15 +4183,12 @@
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
-CONFIG_DEBUG_LOCK_ALLOC=y
-CONFIG_PROVE_LOCKING=y
-CONFIG_LOCKDEP=y
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
 # CONFIG_LOCK_STAT is not set
-# CONFIG_DEBUG_LOCKDEP is not set
 # CONFIG_DEBUG_ATOMIC_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_LOCK_TORTURE_TEST is not set
-CONFIG_TRACE_IRQFLAGS=y
 CONFIG_STACKTRACE=y
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
@@ -4204,8 +4201,7 @@
 #
 # RCU Debugging
 #
-CONFIG_PROVE_RCU=y
-# CONFIG_PROVE_RCU_REPEATEDLY is not set
+# CONFIG_PROVE_RCU is not set
 # CONFIG_SPARSE_RCU_POINTER is not set
 # CONFIG_TORTURE_TEST is not set
 # CONFIG_RCU_TORTURE_TEST is not set




-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
