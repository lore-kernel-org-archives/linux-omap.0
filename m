From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: bluetooth in v4.13-rc1: lock init missing somewhere?
Date: Fri, 21 Jul 2017 11:57:36 +0200
Message-ID: <022531FF-11AA-4D6B-A92B-146F5E6BE31F@holtmann.org>
References: <20170721085551.GA22993@amd>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170721085551.GA22993@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, linux-bluetooth@vger.kernel.org, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

> Is bluetooth expected to work on n900?
> 
> It looks like lock init is missing somewhere:
> 
> [  402.901031] of_get_named_gpiod_flags: parsed
> 'bluetooth-wakeup-gpios' property of node
> '/ocp@68000000/serial@4806c000/bluetooth[0]' - status (0)
> [  403.042022] BUG: rwlock bad magic on CPU#0, kworker/u3:0/3898,
> c34b8848
> [  403.042053] CPU: 0 PID: 3898 Comm: kworker/u3:0 Tainted: G        W
> 4.13.0-rc1-12941-g013595c-dirty #92
> [  403.042083] Hardware name: Nokia RX-51 board
> [  403.042114] Workqueue: hci0 hci_power_on
> [  403.042205] [<c010d5dc>] (unwind_backtrace) from [<c010ae18>]
> (show_stack+0x10/0x14)
> [  403.042327] [<c010ae18>] (show_stack) from [<c0154d74>]
> (do_raw_read_lock+0x20/0x2c)
> [  403.042358] [<c0154d74>] (do_raw_read_lock) from [<c04ea070>]
> (hci_uart_tx_wakeup+0x14/0x84)
> [  403.042419] [<c04ea070>] (hci_uart_tx_wakeup) from [<bf00089c>]
> (nokia_setup+0x210/0x640 [hci_nokia])
> [  403.042449] [<bf00089c>] (nokia_setup [hci_nokia]) from
> [<c04ea6fc>] (hci_uart_setup+0x7c/0x15c)
> [  403.042480] [<c04ea6fc>] (hci_uart_setup) from [<c063c1a0>]
> (hci_dev_do_open+0x420/0x5a0)
> [  403.042510] [<c063c1a0>] (hci_dev_do_open) from [<c063db40>]
> (hci_power_on+0x30/0x228)
> [  403.042541] [<c063db40>] (hci_power_on) from [<c013ad5c>]
> (process_one_work+0x10c/0x330)
> [  403.042572] [<c013ad5c>] (process_one_work) from [<c013b120>]
> (worker_thread+0x168/0x498)
> [  403.042602] [<c013b120>] (worker_thread) from [<c014035c>]
> (kthread+0x10c/0x148)
> [  403.042633] [<c014035c>] (kthread) from [<c01076b8>]
> (ret_from_fork+0x14/0x3c)
> root@n900:/my/modules#
> 
> If I put the driver built-in, firmware loading failed. But I can't get
> it to "hciconfig up" phase even with driver being modular. .. that
> worked at one point IIRC.

any chance you can test this with "btmgmt power on" and have "btmon" run in the background. I wonder how far it gets with the init sequence.

Regards

Marcel
