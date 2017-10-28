From: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: WL1283 device Tree Bluetooth and WiFi Coexistence Question
Date: Sat, 28 Oct 2017 06:49:45 -0500
Message-ID: <CAHCN7x+wWdhva2UpgiqwbDeF6r-hQ6tdE+Ze=XyNEonvHhAoCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Satish Patel <satish.patel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The Logic PD Torpedo uses a WL1283 chip for Bluetooth and WiFi.

Using the older, Shared Transport driver and pdata quirks, This worked.

With the HCI_LL driver now able to handle the shared transport stuff,
I was hoping to be able to move the stuff pdata quirks to device tree.

I have enabled the CONFIG_SERIAL_DEV_BUS,
CONFIG_SERIAL_DEV_CTRL_TTYPORT, CONFIG_BT_HCIUART, and
CONFIG_BT_HCIUART_LL configs enabled and I added the following to my
device tree:

bluetooth {
compatible = "ti,wl1283-st";
enable-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;
vio-supply = <&wl12xx_vmmc>;
};

The problem is that now, neither the WiFi nor the Bluetooth work.  By
removing the Bluetooth portion, the WiFi returns to a functional
state.

The HCI portions appear to crash and eventually timeout when trying to
load firmware :
[    7.614410] Workqueue: hci0 hci_cmd_work [bluetooth]
[    7.619689] [<c0110bd8>] (unwind_backtrace) from [<c010cc54>] (show_stack+0x1
0/0x14)
[    7.627838] [<c010cc54>] (show_stack) from [<c0826e5c>] (dump_stack+0xb0/0xe8
)
[    7.635437] [<c0826e5c>] (dump_stack) from [<c0193c24>] (register_lock_class+
0x36c/0x5ec)
[    7.644042] [<c0193c24>] (register_lock_class) from [<c01971c8>] (__lock_acqu
ire+0x74/0x1928)
[    7.653015] [<c01971c8>] (__lock_acquire) from [<c019937c>] (lock_acquire+0xc
c/0x238)
[    7.661254] [<c019937c>] (lock_acquire) from [<c0842f88>] (_raw_read_lock+0x3
0/0x40)
[    7.669464] [<c0842f88>] (_raw_read_lock) from [<bf2ac02c>] (hci_uart_tx_wake
up+0x14/0x74 [hci_uart])
[    7.679199] [<bf2ac02c>] (hci_uart_tx_wakeup [hci_uart]) from [<bf2acdb0>] (h
ci_uart_send_frame+0x20/0x28 [hci_uart])
[    7.690582] [<bf2acdb0>] (hci_uart_send_frame [hci_uart]) from [<bf184f38>] (
hci_send_frame+0x6c/0xb0 [bluetooth])
[    7.701812] [<bf184f38>] (hci_send_frame [bluetooth]) from [<bf184ff4>] (hci_
cmd_work+0x78/0xdc [bluetooth])
[    7.712341] [<bf184ff4>] (hci_cmd_work [bluetooth]) from [<c01554d8>] (proces
s_one_work+0x28c/0x770)
[    7.721954] [<c01554d8>] (process_one_work) from [<c01559f0>] (worker_thread+
0x34/0x54c)
[    7.730468] [<c01559f0>] (worker_thread) from [<c015c224>] (kthread+0x138/0x1
50)
[    7.738250] [<c015c224>] (kthread) from [<c0107f88>] (ret_from_fork+0x14/0x2c
)


The WiFi functions also appear to crash when Bluetooth is added:

[   12.660186] CPU: 0 PID: 52 Comm: kworker/0:2 Not tainted 4.14.0-rc6-dirty #2
[   12.667633] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[   12.674255] Workqueue: events request_firmware_work_func
[   12.679931] [<c0110bd8>] (unwind_backtrace) from [<c010cc54>] (show_stack+0x1
0/0x14)
[   12.688110] [<c010cc54>] (show_stack) from [<c0826e5c>] (dump_stack+0xb0/0xe8
)
[   12.695770] [<c0826e5c>] (dump_stack) from [<c01375ec>] (__warn+0xd8/0x104)
[   12.703155] [<c01375ec>] (__warn) from [<c01376c4>] (warn_slowpath_null+0x20/
0x28)
[   12.711151] [<c01376c4>] (warn_slowpath_null) from [<bf355378>] (wl12xx_sdio_
raw_read+0xa8/0x138 [wlcore_sdio])
[   12.721954] [<bf355378>] (wl12xx_sdio_raw_read [wlcore_sdio]) from [<bf6fec40
>] (wl12xx_get_mac+0xf0/0x278 [wl12xx])
[   12.733459] [<bf6fec40>] (wl12xx_get_mac [wl12xx]) from [<bf6cb744>] (wlcore_
nvs_cb+0x1dc/0xb08 [wlcore])
[   12.743804] [<bf6cb744>] (wlcore_nvs_cb [wlcore]) from [<c059be0c>] (request_
firmware_work_func+0x3c/0x64)
[   12.753997] [<c059be0c>] (request_firmware_work_func) from [<c01554d8>] (proc
ess_one_work+0x28c/0x770)
[   12.763824] [<c01554d8>] (process_one_work) from [<c01559f0>] (worker_thread+
0x34/0x54c)
[   12.772399] [<c01559f0>] (worker_thread) from [<c015c224>] (kthread+0x138/0x1
50)
[   12.780212] [<c015c224>] (kthread) from [<c0107f88>] (ret_from_fork+0x14/0x2c
)
[   12.788024] ---[ end trace a75131d1e0b49878 ]---
[   12.792938] wl1271_sdio mmc2:0001:2: sdio read failed (-110)

If I remove the Bluetooth portion of the device tree, the WiFi returns
to normal.

I see a few of the beaglebones are using the wl1835-st and the
omap4-droid4 uses the wl1285-st. I was wondering if any of them
support Bluetooth and WiFi simultaneously with any luck?

adam
