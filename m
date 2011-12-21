From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Is Pandaboard cpuhotplug working stably?
Date: Wed, 21 Dec 2011 09:46:24 +0000
Message-ID: <20111221094624.GB3354@n2100.arm.linux.org.uk>
References: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59149 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab1LUJqd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Dec 2011 04:46:33 -0500
Content-Disposition: inline
In-Reply-To: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-omap@vger.kernel.org, yongsheng.liu@csr.com, linaro-dev <linaro-dev@lists.linaro.org>, peiyu.li@csr.com, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, linux-arm-kernel@lists.infradead.org

On Wed, Dec 21, 2011 at 05:23:48PM +0800, Barry Song wrote:
> Hi guys,
> i tried cpuhotplug on pandaboard for both
> Pandroid_Froyo_L27.8.2_release_pkg and Linaro 11.11. It has failed to
> work stably.
> On Pandroid_Froyo_L27.8.2_release_pkg, unplugging cpu1 works well:
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> CPU1: shutdown
> 
> if i enable the cpu1 again by "echo 1 >
> /sys/devices/system/cpu/cpu1/online", the system will restore to 3
> random status: hang, normal, panic.
> 
> Using  Linaro 11.11 release, "echo 0 >
> /sys/devices/system/cpu/cpu1/online" will make system hang and the
> whole system will not be able to reset by pressing reset key, the only
> way to reset system is pulling out AV power.
> 
> i am sorry i can't get more time to debug and find more clues. just
> want to ask people whether this is a version the cpuhotplug works
> normal on?

cpu hotplug is basically totally buggered - the preconditions placed
upon the bringup code path are basically impossible to satisfy in any
shape or form at the moment.

There's the requirement that the secondary CPU is marked online and
active before interrupts are enabled for the thread migration stuff
to behave correctly.  However, this is incompatible with smp_call_function()
which will wait for online CPUs to respond to an IPI - which this one
won't because interrupts are disabled.

I think there was some discussion about how to fix this but I don't
recall the details.
