From: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC/PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
Date: Thu, 1 Oct 2015 15:20:18 -0700
Message-ID: <CALAqxLVUDYivs4QKWtFDbwFdWqa2JJX49Aj15p69zpYCb1_SbA@mail.gmail.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
	<1443559446-26969-10-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443559446-26969-10-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 29, 2015 at 1:44 PM, Felipe Balbi <balbi@ti.com> wrote:
> Introduce a new clocksource driver for Texas
> Instruments 32.768 Hz device which is available
> on most OMAP-like devices.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/clocksource/Kconfig        |   8 +++
>  drivers/clocksource/Makefile       |   1 +
>  drivers/clocksource/timer-ti-32k.c | 121 +++++++++++++++++++++++++++++++++++++

Also isn't this somewhat duplicate of the code in
arch/arm/plat-omap/counter_32k.c ?

Was this really a rewrite or just a code migration? Should you
preserve the copyrights from counter_32k.c?

thanks
-john
