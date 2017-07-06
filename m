From: Pavel Machek <pavel@ucw.cz>
Subject: v4.13-rc0 on nokia n900: spinlock bad magic
Date: Thu, 6 Jul 2017 20:03:37 +0200
Message-ID: <20170706180337.GA26875@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I don't think this is new in v4.13, but perhaps someone knows how to
debug it?

[ 5611.801147] g_ether gadget: packet filter 0e
[ 5611.801177] g_ether gadget: ecm req21.43 v000e i0000 l0
[ 5668.771453] BUG: spinlock bad magic on CPU#0, kworker/u2:3/9745
[ 5668.771850]  lock: 0xce63ef20, .magic: 00000000, .owner: <none>/-1,
=2Eowner_cpu: 0
[ 5668.772277] CPU: 0 PID: 9745 Comm: kworker/u2:3 Tainted: G        W
4.12.0-03002-gec979a4-dirty #40
[ 5668.772796] Hardware name: Nokia RX-51 board
[ 5668.773071] Workqueue: phy1 wl1251_irq_work
[ 5668.773345] [<c010c9e4>] (unwind_backtrace) from [<c010a274>]
(show_stack+0x10/0x14)
[ 5668.773803] [<c010a274>] (show_stack) from [<c01545a4>]
(do_raw_spin_lock+0x6c/0xa0)
[ 5668.774230] [<c01545a4>] (do_raw_spin_lock) from [<c06ca578>]
(_raw_spin_lock_irqsave+0x10/0x18)
[ 5668.774658] [<c06ca578>] (_raw_spin_lock_irqsave) from [<c048c010>]
(wl1251_op_tx+0x38/0x5c)
[ 5668.775115] [<c048c010>] (wl1251_op_tx) from [<c06a12e8>]
(ieee80211_tx_frags+0x188/0x1c0)
[ 5668.775543] [<c06a12e8>] (ieee80211_tx_frags) from [<c06a138c>]
(__ieee80211_tx+0x6c/0x130)
[ 5668.775970] [<c06a138c>] (__ieee80211_tx) from [<c06a3dbc>]
(ieee80211_tx+0xdc/0x104)
[ 5668.776367] [<c06a3dbc>] (ieee80211_tx) from [<c06a4af0>]
(__ieee80211_subif_start_xmit+0x454/0x8c8)
[ 5668.776824] [<c06a4af0>] (__ieee80211_subif_start_xmit) from
[<c06a4f94>] (ieee80211_subif_start_xmit+0x30/0x2fc)
[ 5668.777343] [<c06a4f94>] (ieee80211_subif_start_xmit) from
[<c0578848>] (dev_hard_start_xmit+0x80/0x118)
[ 5668.777832] [<c0578848>] (dev_hard_start_xmit) from [<c059a114>]
(sch_direct_xmit+0xf4/0x18c)
[ 5668.778259] [<c059a114>] (sch_direct_xmit) from [<c0579b50>]
(__dev_queue_xmit+0x2c8/0x5d4)
[ 5668.778656] [<c0579b50>] (__dev_queue_xmit) from [<c05bdd2c>]
(ip_finish_output2+0x1c8/0x36c)
[ 5668.779083] [<c05bdd2c>] (ip_finish_output2) from [<c05bec40>]
(ip_output+0xec/0xfc)
[ 5668.779479] [<c05bec40>] (ip_output) from [<c05be3d4>]
(ip_local_out+0x38/0x3c)
[ 5668.779876] [<c05be3d4>] (ip_local_out) from [<c05d6628>]
(tcp_transmit_skb+0x488/0x8b0)
[ 5668.780273] [<c05d6628>] (tcp_transmit_skb) from [<c05d2f40>]
(tcp_rcv_established+0x208/0x720)
[ 5668.780700] [<c05d2f40>] (tcp_rcv_established) from [<c05dbe4c>]
(tcp_v4_do_rcv+0x110/0x174)
[ 5668.781127] [<c05dbe4c>] (tcp_v4_do_rcv) from [<c05de030>]
(tcp_v4_rcv+0xacc/0xb0c)
[ 5668.790191] [<c05de030>] (tcp_v4_rcv) from [<c05b9490>]
(ip_local_deliver_finish+0x94/0x28c)
[ 5668.799346] [<c05b9490>] (ip_local_deliver_finish) from
[<c05b985c>] (ip_local_deliver+0xb8/0xc4)
[ 5668.808563] [<c05b985c>] (ip_local_deliver) from [<c05b92a0>]
(ip_rcv_finish+0x244/0x3a0)
[ 5668.817749] [<c05b92a0>] (ip_rcv_finish) from [<c05b9b4c>]
(ip_rcv+0x2e4/0x484)
[ 5668.826843] [<c05b9b4c>] (ip_rcv) from [<c0573534>]
(__netif_receive_skb_core+0x2bc/0x8b8)
[ 5668.835906] [<c0573534>] (__netif_receive_skb_core) from
[<c05789d4>] (netif_receive_skb_internal+0x30/0x2ac)
[ 5668.854187] [<c05789d4>] (netif_receive_skb_internal) from
[<c069a1dc>] (ieee80211_deliver_skb+0x160/0x1a8)
[ 5668.873046] [<c069a1dc>] (ieee80211_deliver_skb) from [<c069b568>]
(ieee80211_rx_handlers+0xeec/0x20cc)
[ 5668.892242] [<c069b568>] (ieee80211_rx_handlers) from [<c069ce24>]
(ieee80211_prepare_and_rx_handle+0x6dc/0xff4)
[ 5668.911804] [<c069ce24>] (ieee80211_prepare_and_rx_handle) from
[<c069df48>] (ieee80211_rx_napi+0x80c/0x934)
[ 5668.931762] [<c069df48>] (ieee80211_rx_napi) from [<c048e1b4>]
(wl1251_rx+0x31c/0x494)
[ 5668.941925] [<c048e1b4>] (wl1251_rx) from [<c048c734>]
(wl1251_irq_work+0x144/0x1b0)
[ 5668.951965] [<c048c734>] (wl1251_irq_work) from [<c013a70c>]
(process_one_work+0x10c/0x330)
[ 5668.961914] [<c013a70c>] (process_one_work) from [<c013aad0>]
(worker_thread+0x168/0x498)
[ 5668.971740] [<c013aad0>] (worker_thread) from [<c013fca0>]
(kthread+0x10c/0x148)
[ 5668.981445] [<c013fca0>] (kthread) from [<c01076d8>]
(ret_from_fork+0x14/0x3c)

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllee3kACgkQMOfwapXb+vJVZQCgha0ZoY+OMmfEFOiYdnv0yxi/
/3EAn2ec/G0WS6uIMHCqxO1bJgrYXR4b
=v+Q8
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
