From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Mon, 4 Apr 2016 17:03:03 -0700
Message-ID: <20160405000303.GA15936@localhost>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
 <20160204224128.GG4215@xsjsorenbubuntu>
 <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
 <20160204233950.GH4215@xsjsorenbubuntu>
 <56D04D17.6030502@ti.com>
 <20160226152714.GD3173@xsjsorenbubuntu>
 <56DEAFB7.50105@ti.com>
 <56EAB44D.7020902@linaro.org>
 <5702845E.90606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5702845E.90606@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: S??ren Brinkmann <soren.brinkmann@xilinx.com>, Olof Johansson <olof@lixom.net>, Moritz Fischer <moritz.fischer@ettus.com>, kernel@stlinux.com, tony@atomide.com, nsekhar@ti.com, Masahiro Yamada <yamada.masahiro@socionext.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Wei Xu <xuwei5@hisilicon.com>, linux-rockchip@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, Liviu Dudau <liviu.dudau@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxime Coquelin <maxime.coquelin@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 04, 2016 at 06:12:30PM +0300, Grygorii Strashko wrote:
> Hi Daniel,
> On 03/17/2016 03:42 PM, Daniel Lezcano wrote:
> > On 03/08/2016 11:55 AM, Grygorii Strashko wrote:
> >> Yeah. Thanks
> >>
> >> I'll re-send it after 4.6-rc.
> >> But What I'm not fully understand is how to get it merged taking into 
> >> account that
> >> it touches few maches & clocksource :(
> > 
> > This is not a problem. Send it based on timers/core from the tip tree 
> > and Cc the maintainers for the maches dir. As soon as they ack the 
> > patches, I will merge it through my tree.
> > 
> 
> I've rebased my patch on top of 4.6-rc2 and extended it on new mach
> arch/arm/mach-artpec.
> 
> Then, as you've suggested, I've tried to apply it on top of 
> kernel-tip/timers/core
> kernel-tip := git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> 
> but seems timers/core is obsolete (It doesn't contain arch/arm/mach-artpec yet).
> 
> Should I wait more or can resend it basing on top of  4.6-rc2?
> 

Yes, wait a bit the tip tree is updated.

Thanks

  -- Daniel
