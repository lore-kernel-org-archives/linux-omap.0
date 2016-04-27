From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Wed, 27 Apr 2016 09:24:52 -0700
Message-ID: <20160427162452.GY5995@atomide.com>
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
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Liviu Dudau <liviu.dudau@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, kernel@stlinux.com, linux-arm-kernel@axis.com, Florian Fainelli <f.fainelli@gmail.com>, Wei Xu <xuwei5@hisilicon.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sudeep Holla <sudeep.holla@arm.com>, Jun Nie <jun.nie@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [160427 06:32]:
> Hi Russell,
> 
> On 04/27/2016 01:41 PM, Russell King - ARM Linux wrote:
> > On Tue, Apr 26, 2016 at 10:35:08PM +0300, Grygorii Strashko wrote:
> >> On 04/26/2016 07:02 PM, Liviu Dudau wrote:
> >>> Well, SoC-B has the GT *and* the DT node, so what is the problem with
> >>> enabling it for SoC-B? If there are reasons not to use the Global Timer
> >>> on SoC-B, surely a better option would be to mark it in DT with status = "disabled";
> >>
> >> This was rejected [2]. DT describes HW and if it is functional the status = "disabled"
> >> is not good choice.
> >> ARM GT can't be used as clocksource/sched_clock/clockevent when CPUFreq or
> >> CPUIdle are enabled :(, and this is Linux specific functionality and
> >> not HW description.
> > 
> > Sorry, but we don't want to have to disable drivers in the kernel just
> > because one platform has a problem (consider the single zImage case
> > where it may be required that the global timer is enabled for some
> > platform to boot - it becomes mandatory in single zImage at that point.)
> 
> Sorry, but this patch doesn't disable anything. It provides possibility
> to do a custom build with disabled ARM GT driver without Kernel code modification -
> in my case RT-kernel and non-RT Kernel should run on same HW and 
> RT kernel should use ARM GT as clocksource/sched_clock, but 
> non-RT Kernel shouldn't.

How about a kernel cmdline option for both local timers to disable
the selected timer(s)?

Tony
