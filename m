From: <msinger@eastcoreng.com>
Subject: RE: Suspend to RAM broken on BeagleBoard =?UTF-8?Q?=3F?=
Date: Fri, 10 Sep 2010 13:28:28 -0700
Message-ID: <20100910132828.a6cb228ce30b55731ad61a39b8aeb07d.a44784d212.wbe@email00.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpoutwbe10.prod.mesa1.secureserver.net ([208.109.78.26]:56493
	"HELO smtpoutwbe10.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751453Ab0IJU2a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Sep 2010 16:28:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


-------- Original Message --------
Subject: Suspend to RAM broken on BeagleBoard ?
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Fri, September 10, 2010 11:48 am
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

I've tested the current linux-omap Git tree and Kevin's pm-core branch
on a BeagleBoard using the omap3_defconfig, and when trying a suspend
to RAM, I get a "Class driver suspend failed for cpu0" :

# echo mem > /sys/power/state 
[ 93.395050] PM: Syncing filesystems ... done.
[ 93.410827] Freezing user space processes ... (elapsed 0.01 seconds)
done.
[ 93.434570] Freezing remaining freezable tasks ... (elapsed 0.01
seconds) done.
[ 93.458557] Suspending console(s) (use no_console_suspend to debug)
[ 93.590728] PM: suspend of devices complete after 119.629 msecs
[ 93.593902] PM: late suspend of devices complete after 3.112 msecs
[ 93.594421] Class driver suspend failed for cpu0
[ 93.595153] PM: early resume of devices complete after 0.518 msecs
[ 93.887603] PM: resume of devices complete after 292.052 msecs
[ 93.922851] Restarting tasks ... done.

Is this a known issue ?

I also have a problem with USB support, both on linux-omap and Kevin's
pm-core branch. My USB Ethernet adapter, supported by the asix driver,
isn't detected anymore. With a pm git tree of a couple of weeks ago, it
was working. This is again with just a plain omap3_defconfig.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com



Same on an Overo.  And ondemand cpufreq doesnt work either anymore.




