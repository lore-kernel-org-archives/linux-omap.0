From: Pavel Machek <pavel@ucw.cz>
Subject: Re: musb-hdrc: "Vbus off, timeout 1100 msec" message does not belong
 in sysfs
Date: Thu, 9 Jul 2015 23:46:10 +0200
Message-ID: <20150709214610.GA20890@amd>
References: <20150709213922.GA32698@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150709213922.GA32698@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>, balbi@ti.com, bigeasy@linutronix.de, george.cherian@ti.com, varkabhadram@gmail.com, linux-kernel@vger.kernel.org
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

On Thu 2015-07-09 23:39:22, Pavel Machek wrote:
> Hi!
> 
> sysfs should contain one value per file. This one has at least two,
> with nice english sentence as a bonus.
> 
> root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
> cat vbus
> Vbus off, timeout 1100 msec
> 
> :-(.

Plus, documentation for this is nowhere to be seen:

pavel@amd:/data/l/linux-n900$ grep -ri musb Documentation/ABI/
pavel@amd:/data/l/linux-n900$

..which is a shame, because it is not really clear how to use this
one:

root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
cat mode
b_idle
root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
echo a_suspend > mode
-bash: echo: write error: Invalid argument
root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
echo a > mode
-bash: echo: write error: Invalid argument
root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
echo a_host > mode
-bash: echo: write error: Invalid argument
root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
echo b_host > mode
-bash: echo: write error: Invalid argument
root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
echo a_idle > mode
-bash: echo: write error: Invalid argument
root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
echo b_wait_acon > mode
-bash: echo: write error: Invalid argument
root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#


									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
