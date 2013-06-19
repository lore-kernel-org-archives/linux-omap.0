From: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: omap: fix spurious IRQs: disable/enable IRQ at INTC when idle
Date: Wed, 19 Jun 2013 13:01:28 -0700
Message-ID: <878v257tuv.fsf@linaro.org>
References: <1370630768-4077-1-git-send-email-grygorii.strashko@ti.com>
	<1370630768-4077-2-git-send-email-grygorii.strashko@ti.com>
	<87li6llk4w.fsf@linaro.org> <51C1F9FA.9000502@ti.com>
	<20130619193111.GD4779@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130619193111.GD4779-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org> (Felipe Balbi's message
	of "Wed, 19 Jun 2013 22:31:11 +0300")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:

[...]

> If you have 200 pm_runtime_get() followed by 200 pm_runtime_put() (put
> is called only after 200 gets, no put-get ping-pong), your
> ->runtime_resume() gets called once, your ->runtime_suspend() gets
> called once but your ->runtime_idle() will get called 200 times.

No. The driver's ->runtime_idle() will only be called when the usecount
goes to zero.

Kevin
