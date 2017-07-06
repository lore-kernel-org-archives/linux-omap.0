From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: v4.13-rc0 on nokia n900: spinlock bad magic
Date: Thu, 6 Jul 2017 13:45:32 -0700
Message-ID: <CAM_iQpXm8y55p-PVB2wqWxCGeOsMmLZrGgg-ZbozDTxXeSQOCg@mail.gmail.com>
References: <20170706180337.GA26875@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170706180337.GA26875@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 6, 2017 at 11:03 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> I don't think this is new in v4.13, but perhaps someone knows how to
> debug it?
>
> [ 5611.801147] g_ether gadget: packet filter 0e
> [ 5611.801177] g_ether gadget: ecm req21.43 v000e i0000 l0
> [ 5668.771453] BUG: spinlock bad magic on CPU#0, kworker/u2:3/9745
> [ 5668.771850]  lock: 0xce63ef20, .magic: 00000000, .owner: <none>/-1,
> .owner_cpu: 0
> [ 5668.772277] CPU: 0 PID: 9745 Comm: kworker/u2:3 Tainted: G        W
> 4.12.0-03002-gec979a4-dirty #40
> [ 5668.772796] Hardware name: Nokia RX-51 board
> [ 5668.773071] Workqueue: phy1 wl1251_irq_work
> [ 5668.773345] [<c010c9e4>] (unwind_backtrace) from [<c010a274>]
> (show_stack+0x10/0x14)
> [ 5668.773803] [<c010a274>] (show_stack) from [<c01545a4>]
> (do_raw_spin_lock+0x6c/0xa0)
> [ 5668.774230] [<c01545a4>] (do_raw_spin_lock) from [<c06ca578>]
> (_raw_spin_lock_irqsave+0x10/0x18)
> [ 5668.774658] [<c06ca578>] (_raw_spin_lock_irqsave) from [<c048c010>]
> (wl1251_op_tx+0x38/0x5c)
> [ 5668.775115] [<c048c010>] (wl1251_op_tx) from [<c06a12e8>]
> (ieee80211_tx_frags+0x188/0x1c0)

The following one-line fix should work.

diff --git a/drivers/net/wireless/ti/wl1251/main.c
b/drivers/net/wireless/ti/wl1251/main.c
index bbf7604..1c539c8 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1571,6 +1571,7 @@ struct ieee80211_hw *wl1251_alloc_hw(void)

        wl->state = WL1251_STATE_OFF;
        mutex_init(&wl->mutex);
+       spin_lock_init(&wl->wl_lock);

        wl->tx_mgmt_frm_rate = DEFAULT_HW_GEN_TX_RATE;
        wl->tx_mgmt_frm_mod = DEFAULT_HW_GEN_MODULATION_TYPE;
