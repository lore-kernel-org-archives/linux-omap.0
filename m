From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] serial: omap: fix runtime-pm handling on unbind
Date: Mon, 10 Apr 2017 09:15:24 -0700
Message-ID: <20170410161524.GA5339@atomide.com>
References: <20170410092139.11441-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170410092139.11441-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan@kernel.org> [170410 02:27]:
> An unbalanced and misplaced synchronous put was used to suspend the
> device on driver unbind, something which with a likewise misplaced
> pm_runtime_disable leads to external aborts when an open port is being
> removed.
> 
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa024010
> ...
> [<c046e760>] (serial_omap_set_mctrl) from [<c046a064>] (uart_update_mctrl+0x50/0x60)
> [<c046a064>] (uart_update_mctrl) from [<c046a400>] (uart_shutdown+0xbc/0x138)
> [<c046a400>] (uart_shutdown) from [<c046bd2c>] (uart_hangup+0x94/0x190)
> [<c046bd2c>] (uart_hangup) from [<c045b760>] (__tty_hangup+0x404/0x41c)
> [<c045b760>] (__tty_hangup) from [<c045b794>] (tty_vhangup+0x1c/0x20)
> [<c045b794>] (tty_vhangup) from [<c046ccc8>] (uart_remove_one_port+0xec/0x260)
> [<c046ccc8>] (uart_remove_one_port) from [<c046ef4c>] (serial_omap_remove+0x40/0x60)
> [<c046ef4c>] (serial_omap_remove) from [<c04845e8>] (platform_drv_remove+0x34/0x4c)
> 
> Fix this up by resuming the device before deregistering the port and by
> suspending and disabling runtime pm only after the port has been
> removed.
> 
> Also make sure to disable autosuspend before disabling runtime pm so
> that the usage count is balanced and device actually suspended before
> returning.
> 
> Note that due to a negative autosuspend delay being set in probe, the
> unbalanced put would actually suspend the device on first driver unbind,
> while rebinding and again unbinding would result in a negative
> power.usage_count.
> 
> Fixes: 7e9c8e7dbf3b ("serial: omap: make sure to suspend device before remove")
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Tony Lindgren <tony@atomide.com>
