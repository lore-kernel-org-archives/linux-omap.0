From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2] clocksource: arm_global_timer: fix suspend resume
Date: Fri, 20 Nov 2015 11:11:51 -0800
Message-ID: <CALAqxLVMtL+Vkao1i61zQFzcPK3VE3ZtUyu1B1TuPQppOGcUNQ@mail.gmail.com>
References: <1448027861-21472-1-git-send-email-grygorii.strashko@ti.com>
	<564F570C.7030409@oracle.com>
	<564F67ED.9000905@ti.com>
	<564F6A92.7080006@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <564F6A92.7080006@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, santosh shilimkar <santosh.shilimkar@oracle.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel@stlinux.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 20, 2015 at 10:46 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> This patch has a very specific purpose: instructing the core code that
> this timer will never stop ticking, ever. It is really targeted at
> virtual machines, whose timer is backed by the host timer, even when the
> VM is not running.
>
> Using it on actual hardware is may not be the best idea, specially in
> the presence of PM.

And actually, the CLOCK_SOURCE_SUSPEND_NONSTOP flag was added to
support real hardware, so its not just limited to VMs. But that
hardware does have to keep the lights on for the counter backing the
clocksource, and I'm not sure how common it ever became.

thanks
-john
