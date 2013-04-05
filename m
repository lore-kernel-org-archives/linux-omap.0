From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3] driver: serial: prevent UART console idle on suspend while using "no_console_suspend"
Date: Fri, 05 Apr 2013 10:40:29 -0700
Message-ID: <87mwtclvua.fsf@linaro.org>
References: <1365167733-28083-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1365167733-28083-1-git-send-email-sourav.poddar@ti.com> (Sourav
	Poddar's message of "Fri, 5 Apr 2013 18:45:33 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Rajendra nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Sourav Poddar <sourav.poddar@ti.com> writes:

> With dt boot, uart wakeup after suspend is non functional while using
> "no_console_suspend" in the bootargs. With "no_console_suspend" used, we
> should prevent the runtime suspend of the uart port which is getting used
> as an console.
>
> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Cc: Felipe Balbi<balbi@ti.com>
> Cc: Rajendra nayak<rnayak@ti.com>
> Tested on omap5430evm, omap4430sdp.
>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

Rather than make these special checks inside the driver's runtime PM
callbacks, you should just disable runtime PM (pm_runtime_disable())

Then, this should be broken into 2 patches.

1) serial core: add the '->is_console' flag.  (nit on naming: don't call
   it port_is_console, since the struct is already a uart_port)

2) In the OMAP UART driver's ->prepare callback, check the is_console flag
   and pm_runtime_disable() accordingly  (then pm_runtime_enable() in
   the drivers's ->complete callback.

Kevin
