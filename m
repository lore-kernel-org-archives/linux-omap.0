From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v1] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Wed, 27 Apr 2016 22:06:41 +0100
Message-ID: <20160427210641.GV5783@n2100.arm.linux.org.uk>
References: <1461684532-16848-1-git-send-email-grygorii.strashko@ti.com>
 <20160426160245.GI28464@e106497-lin.cambridge.arm.com>
 <571FC2EC.9090605@ti.com>
 <20160427104110.GU5783@n2100.arm.linux.org.uk>
 <5720BF19.6040600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5720BF19.6040600@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, kernel@stlinux.com, linux-arm-kernel@axis.com, Florian Fainelli <f.fainelli@gmail.com>, Wei Xu <xuwei5@hisilicon.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sudeep Holla <sudeep.holla@arm.com>, Jun Nie <jun.nie@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson <lar>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 27, 2016 at 04:31:05PM +0300, Grygorii Strashko wrote:
> Sorry, but this patch doesn't disable anything. It provides possibility
> to do a custom build with disabled ARM GT driver without Kernel code
> modification - in my case RT-kernel and non-RT Kernel should run on same
> HW and RT kernel should use ARM GT as clocksource/sched_clock, but 
> non-RT Kernel shouldn't.
> 
> I think RT can't be part of single zImage - it make no sense.
> 
> > 
> > Maybe a linux-specific property is needed here - "linux,low-power-unstable"
> > or something like that?
> > 
> 
> I've tried smth. like this [1]
> 
> And it is not "unstable", it's will just stop in C3 (CPUIdle) and there no possibility 
> (at least I've not found how to do this) to adjust Freq in case of CPUFreq.
> [above is about clocksource/sched_clock]
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386858.html

Don't think I'm going to follow URLs - I don't use a desktop mail
client, and as I'm several days behind with email, I don't have time
to go looking through a crappy pipermail web archive at the moment
either.

Anyway, why can't we use the priority system for clocksources?  If
ARM GT is problematical, we need a way to register it with a lower
priority than the preferred time keeping source.  That's exactly
what the clocksource priority field is for.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
