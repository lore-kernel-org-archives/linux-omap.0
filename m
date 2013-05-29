From: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: omap: correct usage of the interrupt enable register
Date: Wed, 29 May 2013 10:22:59 -0700
Message-ID: <878v2x7lak.fsf@linaro.org>
References: <1369812944-685-1-git-send-email-oleksandr.dmytryshyn@ti.com>
	<1369812944-685-2-git-send-email-oleksandr.dmytryshyn@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369812944-685-2-git-send-email-oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org>
	(Oleksandr Dmytryshyn's message of "Wed, 29 May 2013 10:35:44 +0300")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksandr Dmytryshyn <oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Oleksandr Dmytryshyn <oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org> writes:

> Starting from the OMAP chips with version2 registers scheme there are
> 2 registers (I2C_IRQENABLE_SET and I2C_IRQENABLE_CLR) to manage
> interrupts instead of the older OMAP chips with old scheme which have
> only one register (I2C_IE).  Now we should use I2C_IRQENABLE_SET
> register for enabling interrupts and I2C_IRQENABLE_CLR register for
> disabling interrupts.

Why?  (changelogs should always answer the "why" question)

IOW, what is broken without this change, how does it fail?  And equally
important, how is it currently working?

Kevin
