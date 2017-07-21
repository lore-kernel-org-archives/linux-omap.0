From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: bluetooth in v4.13-rc1: lock init missing somewhere?
Date: Fri, 21 Jul 2017 13:25:06 +0200
Message-ID: <D0C772B3-4C90-414C-84E5-1DE14054A40A@holtmann.org>
References: <20170721085551.GA22993@amd>
 <022531FF-11AA-4D6B-A92B-146F5E6BE31F@holtmann.org>
 <20170721111058.GB9448@amd>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170721111058.GB9448@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, linux-bluetooth@vger.kernel.org, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

>>> Is bluetooth expected to work on n900?
>>> 
>>> It looks like lock init is missing somewhere:
>>> 
>>> [  402.901031] of_get_named_gpiod_flags: parsed
>>> 'bluetooth-wakeup-gpios' property of node
>>> '/ocp@68000000/serial@4806c000/bluetooth[0]' - status (0)
>>> [  403.042022] BUG: rwlock bad magic on CPU#0, kworker/u3:0/3898,
>>> c34b8848
>>> [  403.042053] CPU: 0 PID: 3898 Comm: kworker/u3:0 Tainted: G        W
>>> 4.13.0-rc1-12941-g013595c-dirty #92
>>> [  403.042083] Hardware name: Nokia RX-51 board
>>> [  403.042114] Workqueue: hci0 hci_power_on
>>> [  403.042205] [<c010d5dc>] (unwind_backtrace) from [<c010ae18>]
>>> (show_stack+0x10/0x14)
>>> [  403.042327] [<c010ae18>] (show_stack) from [<c0154d74>]
>>> (do_raw_read_lock+0x20/0x2c)
>>> [  403.042358] [<c0154d74>] (do_raw_read_lock) from [<c04ea070>]
>>> (hci_uart_tx_wakeup+0x14/0x84)
>>> [  403.042419] [<c04ea070>] (hci_uart_tx_wakeup) from [<bf00089c>]
>>> (nokia_setup+0x210/0x640 [hci_nokia])
>>> [  403.042449] [<bf00089c>] (nokia_setup [hci_nokia]) from
>>> [<c04ea6fc>] (hci_uart_setup+0x7c/0x15c)
>>> [  403.042480] [<c04ea6fc>] (hci_uart_setup) from [<c063c1a0>]
>>> (hci_dev_do_open+0x420/0x5a0)
>>> [  403.042510] [<c063c1a0>] (hci_dev_do_open) from [<c063db40>]
>>> (hci_power_on+0x30/0x228)
>>> [  403.042541] [<c063db40>] (hci_power_on) from [<c013ad5c>]
>>> (process_one_work+0x10c/0x330)
>>> [  403.042572] [<c013ad5c>] (process_one_work) from [<c013b120>]
>>> (worker_thread+0x168/0x498)
>>> [  403.042602] [<c013b120>] (worker_thread) from [<c014035c>]
>>> (kthread+0x10c/0x148)
>>> [  403.042633] [<c014035c>] (kthread) from [<c01076b8>]
>>> (ret_from_fork+0x14/0x3c)
>>> root@n900:/my/modules#
>>> 
>>> If I put the driver built-in, firmware loading failed. But I can't get
>>> it to "hciconfig up" phase even with driver being modular. .. that
>>> worked at one point IIRC.
>> 
>> any chance you can test this with "btmgmt power on" and have "btmon" run in the background. I wonder how far it gets with the init sequence.
>> 
> 
> root@n900:/home/pavel# aptitude show bluez
> Package: bluez
> State: installed
> Automatically installed: no
> Version: 4.99-2
> Priority: optional
> Section: admin
> Maintainer: Debian Bluetooth Maintainers
> <pkg-bluetooth-maintainers@lists.alioth.debian.org>
> Uncompressed Size: 2113 k
> ...
> root@n900:/home/pavel# btmon
> bash: btmon: command not found
> root@n900:/home/pavel#
> 
> Aha, but I did compile bluez-5.6, and it seems to have required tools.
> 
> Now it does:
> 
> * Unknown packet (code 14 len 30)                                        [hci65535] 83.969603
>        04 00 00 00 02 00 01 0e 00 01 00 00 00 10 62 74  ..............bt
>        6d 67 6d 74 00 00 00 00 00 00 00 00 00 00        mgmt..........  
> * Unknown packet (code 14 len 30)                                        [hci65535] 83.970976
>        05 00 00 00 02 00 01 0e 00 01 00 00 00 10 62 74  ..............bt
>        6d 67 6d 74 00 00 00 00 00 00 00 00 00 00        mgmt..........  
> * Unknown packet (code 16 len 6)                                         [hci65535] 83.972441
>        04 00 00 00 01 00                                ......          
> * Unknown packet (code 17 len 12)                                        [hci65535] 83.972472
>        04 00 00 00 01 00 01 00 00 01 0e 00              ............    
> * Unknown packet (code 16 len 7)                                             [hci0] 83.973387
>        05 00 00 00 05 00 01                             .......         
> * Unknown packet (code 17 len 9)                                             [hci0] 83.973418
>        05 00 00 00 02 00 05 00 11                       .........       
> * Unknown packet (code 15 len 4)                                         [hci65535] 83.975951
>        05 00 00 00                                      ....            
> * Unknown packet (code 15 len 4)                                         [hci65535] 83.976836
>        04 00 00 00                                      ....            
> 
> I guess output just after boot will be more interesting?
> 
> root@n900:/my/modules# insmod hci_nokia.ko
> root@n900:/my/modules#
> Message from syslogd@localhost at Jul 19 12:24:00 ...
> kernel:[  174.363037] BUG: rwlock bad magic on CPU#0,
> kworker/u3:0/3027, c2665a48
> 
> root@n900:/my/modules# ../bluez-5.26/tools/btmgmt public-addr
> 01:02:03:04:05:06
> Set Public Address for hci0 failed with status 0x0b (Rejected)
> root@n900:/my/modules# ../bluez-5.26/tools/btmgmt power on
> Set Powered for hci0 failed with status 0x11 (Invalid Index)
> root@n900:/my/modules#

if you manage to get a recent btmon then it will also decode all the the unknown packets. That would be interesting since it tells you exactly what mgmt sends and what also legacy tools do at any given time.
> 
> While btmon says:
> 
> ...begining of buffer lost :-(

I really need to find my patches for the monitor ring-buffer and replay support so that you can keep these in kernel memory and configure this with a kernel cmdline option. In theory however starting btmon before insmod should be plenty to get the full trace.

The advantage of getting the initial ones is that with recent btmon, the vendor ones for Broadcom will be also decoded. It is just that at this point the vendor information is unknown.

Actually I just realize that this is special anyway. Since this is Nokia manufacture ID, but Broadcom vendor decoding. I think that we need to add some special handling for this to make sure user space is able to decode this properly.

>        2b 17 d3 0b e0 03 2d 14 d1 fd 77 25 68 01 22     +.....-...w%h." 
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.391814
>      Vendor (0x3f|0x004c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x004c) plen 255                               [hci0] 19.391967
>        ab 6d 08 00 95 43 25 60 e9 06 49 0f cb 07 e1 d5  .m...C%`..I.....
>        0a e0 0b 1c 40 21 0b 43 23 60 01 23 31 68 8b 40  ....@!.C#`.#1h.@
>        10 4a 11 68 19 43 11 60 00 f0 18 fc f0 bd 0a 3e  .J.h.C.`.......>
>        00 6a 94 08 00 30 b5 05 1c 0b 4c ab 00 e0 18 04  .j...0....L.....
>        22 00 21 00 f0 f6 fb ab 00 e0 18 03 68 03 21 0b  ".!.........h.!.
>        43 03 60 ab 00 e0 18 03 68 20 21 0b 43 03 60 30  C.`.....h !.C.`0
>        bd c0 46 9c 1f 08 00 04 9e 08 00 40 21 08 00 08  ..F........@!...
>        25 00 1e 38 bd 01 00 6d f0 b4 fb 23 62 a1 48 12  %..8...m...#b.H.
>        00 a4 94 08 00 0f b4 28 1c ff f7 df ff 0f bc 01  .......(........
>        20 83 43 92 f7 43 fc 08 2f 00 1f 58 c2 01 00 6d   .C..C../..X...m
>        f0 2d f9 ff f7 1f f9 1c 00 b6 94 08 00 0f b4 05  .-..............
>        99 38 1c ff f7 64 ff 0f bc 00 2a 01 d1 92 f7 dc  .8...d....*.....
>        fe 11 1d 00 22 92 f7 c5 fe 08 1d 00 20 ac c5 01  ...."....... ...
>        00 00 b5 6c f0 90 ff 41 48 0a 00 d2 94 08 00 ff  ...l...AH.......
>        f7 75 ff 01 bc 86 46 70 47 0a 1c 00 e0 9c 08 00  .u....FpG.......
>        51 31 00 00 25 49 00 00 f9 60 00 00 cd 78 00     Q1..%I...`...x. 
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.396087
>      Vendor (0x3f|0x004c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x004c) plen 255                               [hci0] 19.396209
>        a6 6e 08 00 00 a1 90 00 00 75 a8 00 00 0a 1c 00  .n.......u......
>        f8 9c 08 00 77 33 00 00 7d 4b 00 00 83 63 00 00  ....w3..}K...c..
>        89 7b 00 00 8f 93 00 00 63 ab 00 00 0a a6 00 04  .{......c.......
>        8e 08 00 f0 b5 83 b0 06 1c 02 91 17 1c b8 68 00  ..............h.
>        90 f8 68 01 90 3a 69 2d 4c 00 2a 00 d0 2d 4c 00  ..h..:i-L.*..-L.
>        9b 02 98 19 18 0c 25 05 20 83 00 e3 58 99 42 02  ......%. ...X.B.
>        db 05 1c 0d 35 01 e0 01 38 f6 d5 6b 1e 26 48 03  ....5...8..k.&H.
>        60 00 2a 2b d0 f1 02 28 1c 0c 01 01 9a 00 2a 11  `.*+...(......*.
>        d0 a2 f7 b7 fe 02 9a 00 99 52 1a 1f 4b d2 18 59  .........R..K..Y
>        11 4a 43 10 18 04 1b 1d 4b 9c 42 16 dc 1d 4b 9c  .JC.....K.B...K.
>        42 14 da 0d e0 a2 f7 a5 fe 20 18 00 9a 02 99 52  B........ .....R
>        18 16 4b d2 18 59 11 4a 43 84 1a 14 4b 9c 42 01  ..K..Y.JC...K.B.
>        dd 01 3e 03 e0 13 4b 9c 42 00 da 01 36 3e 60 28  ..>...K.B...6>`(
>        1c 03 b0 f0 bd 0a 48 00 dc 94 08 00 70 b5 06 1c  ......H.....p...
>        00 25 ff 23 2d 33 6b 43 2a 48 1c 18 e0 69 c3 02  .%.#-3kC*H...i..
>        11 d5 03 06 db 0e 09 2b 0d d1 9b 23 18 5d 04     .......+...#.]. 
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.396667
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.396728
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.396941
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.397002
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.397185
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.397185
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.397368
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.397399
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.397552
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.397582
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.399261
>      Vendor (0x3f|0x004c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x004c) plen 255                               [hci0] 19.399383
>        a1 6f 08 00 28 09 d0 31 1c 20 1c 2c 30 06 22 00  .o..(..1. .,0.".
>        f0 b5 fb 00 28 01 d1 20 1c 03 e0 01 35 09 2d e2  ....(.. ....5.-.
>        db 00 20 70 bd 0a 88 00 20 95 08 00 70 b5 05 1c  .. p.... ...p...
>        1c 4a 10 78 43 07 02 d4 01 23 2b 70 2f e0 0c 1c  .J.xC....#+p/...
>        2e 1c 08 36 e0 1c ff f7 cf ff 17 4a 11 68 88 42  ...6.......J.h.B
>        01 d0 02 23 f1 e7 e1 1c b0 1d 06 22 a2 f7 9e f8  ...#......."....
>        12 4e 63 7a 73 74 a3 7a 30 69 01 21 09 06 88 43  .Nczst.z0i.!...C
>        d9 07 c9 09 08 43 30 61 c3 01 04 d4 10 22 30 1c  .....C0a....."0.
>        00 21 00 f0 77 fb e3 7a b3 74 28 23 02 20 58 55  .!..w..z.t(#. XU
>        06 23 eb 70 91 f7 d2 f8 02 20 90 f7 b8 f9 70 bd  .#.p..... ....p.
>        70 29 08 00 34 04 08 00 5c 39 08 00 18 1f 08 00  p)..4...\9......
>        08 2b 00 21 14 43 02 00 57 49 65 f0 9b f9 03 d1  .+.!.C..WIe.....
>        18 00 50 96 08 00 04 4b 1b 68 db 06 03 d4 4b 79  ..P....K.h....Ky
>        ff 2b 9a f7 5d fe 9a f7 6e fe 08 80 0e 00 08 3f  .+..]...n......?
>        00 22 68 16 01 00 20 1c 77 f0 fd ff 20 1c 2c 00  ."h... .w... .,.
>        68 96 08 00 09 49 09 68 c9 06 0a d5 e1 69 0a     h....I.h.....i. 
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.404815
>      Vendor (0x3f|0x004c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x004c) plen 255                               [hci0] 19.404998
>        9c 70 08 00 06 d2 0e 07 2a 05 d1 8a 00 03 d5 0a  .p......*.......
>        04 01 d4 88 f7 02 f8 88 f7 0b f9 87 f7 f0 ff c0  ................
>        46 b0 05 08 00 0a 70 00 94 96 08 00 30 b5 05 1c  F.....p.....0...
>        0c 1c 63 7b 01 2b 04 d1 e3 7b 03 2b 01 d1 7c f7  ..c{.+...{.+..|.
>        70 fd 2b 6d 10 48 03 40 2b 65 29 1c 48 31 20 1c  p.+m.H.@+e).H1 .
>        48 30 81 f7 58 f9 20 7b 0c 4a 10 60 0c 4a 10 68  H0..X. {.J.`.J.h
>        0c 4a 10 68 43 08 a3 67 20 1c 00 21 7b f7 81 fc  .J.hC..g ..!{...
>        63 7b 01 2b 02 d1 e3 7b 03 2b 03 d0 20 1c 01 21  c{.+...{.+.. ..!
>        7c f7 ff f9 30 bd c0 46 ff fe ff ff 64 82 0e 00  |...0..F....d...
>        88 80 0e 00 90 82 0e 00 08 23 00 23 44 a7 00 00  .........#.#D...
>        18 e0 7e f0 db ff 33 68 10 00 00 97 08 00 0f b4  ..~...3h........
>        20 1c 29 1c ff f7 c5 ff 0f bc 81 f7 2a f8 08 4b   .).........*..K
>        00 24 00 a4 02 00 00 99 5f f0 85 f9 74 49 38 00  .$......_...tI8.
>        10 97 08 00 0b 1c 0c 48 88 42 0a d0 01 30 88 42  .......H.B...0.B
>        06 d0 01 30 88 42 06 d0 01 30 88 42 04 d0 05 e0  ...0.B...0.B....
>        01 39 01 39 01 e0 01 31 01 31 8c 02 00 91 08     .9.9...1.1..... 
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.405364
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.405425
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.405700
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.405730
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.408111
>      Vendor (0x3f|0x004c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x004c) plen 255                               [hci0] 19.408263
>        97 71 08 00 06 00 0e a0 f7 62 fe c0 46 e2 16 00  .q.......b..F...
>        00 0a 88 00 00 98 08 00 70 b5 04 1c 0d 1c 00 2c  ........p......,
>        02 d0 23 68 00 2b 03 d1 00 20 8b f7 0e ff 1f e0  ..#h.+... ......
>        17 48 03 78 00 2b 1b d0 20 1c 00 2d 05 d1 ff f7  .H.x.+.. ..-....
>        8f ff 20 1c 8c f7 83 fa 12 e0 21 68 0e 6b 00 21  .. .......!h.k.!
>        a2 f7 96 fd 0a 28 07 d1 0e 48 83 7e 00 2b 03 d0  .....(...H.~.+..
>        0d 48 03 78 03 2b 03 d0 29 1c 20 1c 8c f7 5e fd  .H.x.+..). ...^.
>        70 bd c0 46 08 80 0e 00 b0 3a 08 00 e4 3a 08 00  p..F.....:...:..
>        b4 80 0e 00 b4 3a 08 00 ff ef ff ff 7a a1 37 05  .....:......z.7.
>        b6 4d 08 00 84 22 08 00 b5 4d 08 00 0a bc 00 48  .M..."...M.....H
>        97 08 00 30 b5 04 1c 21 68 0d 6b 00 21 a2 f7 0c  ...0...!h.k.!...
>        fe 00 06 00 0e 21 68 0b 69 00 2b 15 d0 8b 69 00  .....!h.i.+...i.
>        2b 06 d0 10 28 04 d0 20 1c 00 21 8c f7 f1 fc 43  +...(.. ..!....C
>        e0 61 7b 00 23 10 28 00 d1 01 23 4b 40 01 2b 32  .a{.#.(...#K@.+2
>        d1 35 4d 2b 68 db 06 03 d4 00 20 8b f7 4f ff 33  .5M+h..... ..O.3
>        e0 08 28 16 d1 20 1c 00 29 03 d1 7e 23 1a 5c     ..(.. ..)..~#.\ 
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.411284
>      Vendor (0x3f|0x004c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x004c) plen 255                               [hci0] 19.411437
>        92 72 08 00 01 2a 05 d1 01 29 0d d1 7d 30 00 78  .r...*...)..}0.x
>        01 28 09 d0 a3 7d 02 2b 06 d3 20 1c 00 22 01 21  .(...}.+.. ..".!
>        80 f7 35 fc 00 28 1a d1 25 4a 13 68 25 4a 50 69  ..5..(..%J.h%JPi
>        18 60 25 4a 13 68 01 20 00 03 03 43 13 60 23 4a  .`%J.h. ...C.`#J
>        10 68 03 68 10 21 8b 43 03 60 08 e0 1e 49 0b 68  .h.h.!.C.`...I.h
>        1f 48 03 40 0b 60 1a 49 0b 68 1e 48 18 60 30 bd  .H.@.`.I.h.H.`0.
>        08 1f 00 25 f8 56 01 00 74 f0 c4 f8 23 68 00 2b  ...%.V..t...#h.+
>        0c 00 84 98 08 00 20 1c 29 1c ff f7 ba ff 8b f7  ...... .).......
>        6d ff 0a 90 01 a4 98 08 00 f0 b5 84 b0 0e 1c 13  m...............
>        06 1b 0e 01 93 56 4d 00 27 04 1c 56 48 03 68 0a  .....VM.'..VH.h.
>        3b 55 48 03 70 63 7d 00 2b 04 d0 67 75 2b 78 10  ;UH.pc}.+..gu+x.
>        20 83 43 2b 70 e8 68 00 28 2f d0 69 79 01 29 03   .C+p.h.(/.iy.).
>        d1 83 7d 00 2b 29 d0 0a e0 c3 7c 00 2b 0d d1 06  ..}.+)....|.+...
>        29 01 d0 03 29 10 d1 38 23 59 5d 00 29 03 d1 00  )...)..8#Y].)...
>        20 7c f7 48 fd 19 e0 01 29 04 d0 47 75 2b 78 10   |.H....)..Gu+x.
>        20 83 43 2b 70 01 20 f3 e7 04 29 0e d1 3f 48      .C+p. ...)..?H 
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.411834
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.411895
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.412139
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.412139
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.414886
>      Vendor (0x3f|0x004c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x004c) plen 255                               [hci0] 19.415008
>        8d 73 08 00 03 78 00 2b 0a d0 eb 78 80 20 03 43  .s...x.+...x. .C
>        eb 70 00 20 7c f7 31 fd eb 78 80 20 83 43 eb 70  .p. |.1..x. .C.p
>        20 68 01 6b 8c 46 04 21 20 1c a2 f7 18 fd 00 28   h.k.F.! ......(
>        04 d0 c3 68 00 2b 01 d0 01 21 00 e0 00 21 2b 78  ...h.+...!...!+x
>        80 20 83 43 c8 07 00 0e 03 43 2b 70 0a 2e 01 d0  . .C.....C+p....
>        0b 2e 04 d1 38 23 01 20 58 55 03 26 18 e0 0c 2e  ....8#. XU.&....
>        01 d0 0d 2e 04 d1 38 23 01 20 58 55 06 26 0f e0  ......8#. XU.&..
>        38 23 5f 55 04 2e 0b d1 23 4a 90 78 83 1e 00 d0  8#_U....#J.x....
>        01 23 a9 78 80 20 81 43 d8 07 00 0e 01 43 a9 70  .#.x. .C.....C.p
>        23 7b 58 19 03 78 0f 21 8b 43 31 07 09 0f 0b 43  #{X..x.!.C1....C
>        60 21 8b 43 01 9a 91 07 49 0e 0b 43 03 70 16 4a  `!.C....I..C.p.J
>        13 68 30 20 03 40 18 09 15 4a 10 60 15 4a 13 68  .h0 .@...J.`.J.h
>        02 93 14 4a 10 68 02 90 04 3a 11 68 03 91 80 07  ...J.h...:.h....
>        80 0f 05 d0 03 28 0a d1 09 48 03 78 99 42 06 d3  .....(...H.x.B..
>        00 20 7c f7 ca fc 01 20 68 63 00 20 01 e0 6f 63  . |.... hc. ..oc
>        01 20 04 b0 f0 bd a0 0e 08 00 dc 00 08 00 74     . ............t 
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.420959
>      Vendor (0x3f|0x004c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x004c) plen 255                               [hci0] 19.421050
>        88 74 08 00 01 08 00 b5 4d 08 00 44 1e 08 00 b4  .t......M..D....
>        85 0e 00 64 82 0e 00 88 80 0e 00 90 82 0e 00 08  ...d............
>        27 00 26 d0 5d 00 00 83 f0 5e fd 0b 40 18 09 14  '.&.]....^..@...
>        00 90 98 08 00 20 1c 00 f0 07 f8 00 28 02 d0 e1  ..... ......(...
>        68 7c f7 3a fb 7c f7 4e fb 0a 74 00 30 9a 08 00  h|.:.|.N..t.0...
>        10 b5 83 f7 2b fc 15 49 88 42 26 d3 00 f0 24 f9  ....+..I.B&...$.
>        04 1c 7d f7 df f9 01 28 04 d0 7c f7 79 ff 0f 49  ..}....(..|.y..I
>        88 42 03 d2 20 1c 00 f0 1f f9 16 e0 20 1c 00 f0  .B.. ....... ...
>        1b f9 0b 49 0b 68 0b 49 08 68 1b 18 0a 49 0b 60  ...I.h.I.h...I.`
>        00 f0 0a f9 09 49 0c 68 50 23 1c 40 4b 60 00 f0  .....I.hP#.@K`..
>        0b f9 9a f7 57 ff 05 49 0c 60 10 bd 70 17 00 00  ....W..I.`..p...
>        38 06 08 00 38 18 08 00 f4 41 08 00 10 00 0c 00  8...8....A......
>        0a 08 00 88 9c 08 00 78 47 00 00 0a 08 00 98 9c  .......xG.......
>        08 00 78 47 00 00 0a 10 00 8c 9c 08 00 00 c0 9f  ..xG............
>        e5 1c ff 2f e1 94 7d 02 00 0a 10 00 9c 9c 08 00  .../..}.........
>        00 c0 9f e5 1c ff 2f e1 a8 7d 02 00 08 1b 00     ....../..}..... 
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.425292
>      Vendor (0x3f|0x004c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x004c) plen 255                               [hci0] 19.425414
>        83 75 08 00 27 24 49 02 00 05 d9 65 f0 bb f8 18  .u..'$I....e....
>        4a 08 00 a0 9a 08 00 ff f7 c6 ff 9a f7 45 ff 0a  J............E..
>        2c 00 a8 9a 08 00 10 b5 0c 1c 7e f7 aa ff 01 2c  ,.........~....,
>        0a d1 08 48 03 69 db 05 06 d4 07 48 03 68 01 2b  ...H.i.....H.h.+
>        02 d9 03 68 01 3b 03 60 10 bc 08 bc 18 47 0a 1c  ...h.;.`.....G..
>        00 d0 9a 08 00 03 48 04 49 08 60 70 47 78 21 08  ......H.I.`pGx!.
>        00 58 80 0e 00 a9 9a 08 00 40 02 08 00 0b 04 00  .X.......@......
>        d0 9a 08 00 08 2d 00 28 04 74 01 00 72 f0 70 fb  .....-.(.t..r.p.
>        fa f7 b9 fe 1a 00 e8 9a 08 00 09 d1 30 1c 0e b4  ............0...
>        81 f7 3b fd 0e bc 00 28 02 d0 30 1c 8d f7 85 fc  ..;....(..0.....
>        8d f7 85 fc 08 13 00 29 9c a6 00 00 01 d0 c0 46  .......).......F
>        14 e0 eb 78 00 00 00 00 00 00 0a 30 00 20 9b 08  ...x.......0. ..
>        00 10 b5 04 1c e1 69 0b 06 db 0e 09 2b 03 d3 01  ......i.....+...
>        21 89 f7 6a fe 05 e0 00 29 03 d5 20 1c 00 21 85  !..j....).. ..!.
>        f7 b9 f8 20 1c 00 21 92 f7 31 fd 10 bd 0a 74 00  ... ..!..1....t.
>        4c 9b 08 00 f0 b5 82 b0 06 1c 34 1c 50 34 20     L.........4.P4  
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.429503
>      Vendor (0x3f|0x004c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x004c) plen 255                               [hci0] 19.429656
>        7e 76 08 00 7e 81 f7 cf fb 05 1c e2 7f 01 92 e7  ~v..~...........
>        8a b0 6c 83 08 6a 46 13 80 30 1c 48 30 7b f7 18  ..l..jF..0.H0{..
>        fa e0 8a 01 99 e1 77 e7 82 ba 35 29 78 12 29 13  ......w...5)x.).
>        d1 63 7f 01 2b 10 d9 00 28 0e d0 00 9b 98 07 80  .c..+...(.......
>        0f 0a d0 03 28 08 d0 23 68 05 48 03 40 23 60 07  ....(..#h.H.@#`.
>        23 04 49 0b 70 01 20 00 e0 00 20 02 b0 f0 bd c0  #.I.p. ... .....
>        46 ff fe ff ff b4 4d 08 00 08 1b 00 2a b8 2f 01  F.....M.....*./.
>        00 00 21 76 f0 a2 fd fe f7 08 00 02 9b 08 00 00  ..!v............
>        f0 0d f8 89 f7 68 fa 08 29 00 2b 80 58 00 00 84  .....h..).+.X...
>        f0 43 f9 28 1c 48 30 16 00 0a 9b 08 00 28 1c 00  .C.(.H0......(..
>        f0 1e f8 00 28 01 d0 7b f7 c2 fe 00 23 f3 72 7b  ....(..{....#.r{
>        f7 b2 fe 0a 90 00 bc 9b 08 00 70 b5 82 b0 23 4a  ..........p...#J
>        04 1c 23 4d 2b 68 db 06 39 d4 01 29 29 d1 23 7c  ..#M+h..9..)).#|
>        02 2b 34 d1 20 7b 10 60 1f 4e 33 68 00 93 d1 6a  .+4. {.`.N3h...j
>        00 91 95 6a 01 95 89 07 89 0f 02 29 f2 d0 03 29  ...j.......)...)
>        0f d1 19 49 0b 78 9d 42 0b d9 10 60 16 4d 2b     ...I.x.B...`.M+ 
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.430114
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.430144
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.430388
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.430419
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.430602
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.430633
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.430785
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.430816
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.434814
>      Vendor (0x3f|0x004c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x004c) plen 125                               [hci0] 19.434936
>        79 77 08 00 68 00 93 d1 6a 00 91 93 6a 01 93 8b  yw..h...j...j...
>        07 9b 0f 03 2b f3 d0 20 7e 9a f7 d1 fe 00 28 09  ....+.. ~.....(.
>        d1 01 23 a3 61 0d e0 a3 69 01 2b 0a d1 9a f7 b7  ..#.a...i.+.....
>        fe 00 28 06 d0 01 20 80 03 83 f7 f1 f8 20 1c 7c  ..(... ...... .|
>        f7 d6 fc 02 b0 70 bc 08 bc 18 47 0a 24 00 48 9c  .....p....G.$.H.
>        08 00 05 48 06 49 08 60 70 47 64 82 0e 00 08 80  ...H.I.`pGd.....
>        0e 00 88 80 0e 00 03 9e 08 00 bd 9b 08 00 c4 03  ................
>        08 00 0a 05 00 03 9e 08 00 8e fe 00 00           .............   
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.444854
>      Vendor (0x3f|0x004c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x004e) plen 4                                 [hci0] 19.445006
>        ff ff ff ff                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.450530
>      Vendor (0x3f|0x004e) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x001c) plen 5                                 [hci0] 19.450683
>        00 00 00 01 01                                   .....           
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.453246
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.453277
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.453490
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.453521
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.453673
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.453673
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.492827
>      Vendor (0x3f|0x001c) ncmd 1
>        Status: Success (0x00)
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.493194
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.493255
>        04 00 00 00                                      ....            
> < HCI Command: Vendor (0x3f|0x001e) plen 5                                 [hci0] 19.493560
>        00 00 00 00 00                                   .....           
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.494292
>      Vendor (0x3f|0x001e) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x0022) plen 1                                 [hci0] 19.494414
>        00                                               .               
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.494994
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.495025
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.495360
>      Vendor (0x3f|0x0022) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x0061) plen 5                                 [hci0] 19.495452
>        01 19 1c 19 19                                   .....           
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.495696
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.495727
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.496154
>      Vendor (0x3f|0x0061) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x000b) plen 8                                 [hci0] 19.496276
>        bf ee 0f c6 98 3d 59 82                          .....=Y.        
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.496520
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.496520
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.496978
>      Vendor (0x3f|0x000b) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Write Inquiry Scan Type (0x03|0x0043) plen 1                [hci0] 19.497100
>        Type: Standard Scan (0x00)
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.497344
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.497375
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.497771
>      Write Inquiry Scan Type (0x03|0x0043) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Write Page Scan Type (0x03|0x0047) plen 1                   [hci0] 19.497863
>        Type: Standard Scan (0x00)
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.498076
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.498107
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.498534
>      Write Page Scan Type (0x03|0x0047) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x0001) plen 6                                 [hci0] 19.498626
>        11 11 11 11 11 11                                ......          
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.498839
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.498870
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.499450
>      Vendor (0x3f|0x0001) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x0041) plen 16                                [hci0] 19.499572
>        82 20 4e 15 8d 00 00 0a 00 00 00 00 00 00 00 00  . N.............
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.500243
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.500274
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.500579
>      Vendor (0x3f|0x0041) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Vendor (0x3f|0x000a) plen 9                                 [hci0] 19.500670
>        05 78 00 0f 00 19 1c 19 19                       .x.......       
>> HCI Event: Command Complete (0x0e) plen 5                                [hci0] 19.501403
>      Vendor (0x3f|0x000a) ncmd 1
>        Status: Success (0x00)
>        19                                               .               
> < HCI Command: Vendor (0x3f|0x000a) plen 9                                 [hci0] 19.501647
>        05 e4 00 0f 00 18 18 00 00                       .........       
>> HCI Event: Command Complete (0x0e) plen 5                                [hci0] 19.502746
>      Vendor (0x3f|0x000a) ncmd 1
>        Status: Success (0x00)
>        18                                               .               
> < HCI Command: Vendor (0x3f|0x000a) plen 9                                 [hci0] 19.502837
>        05 90 00 0f 00 00 00 77 00                       .......w.       
>> HCI Event: Command Complete (0x0e) plen 5                                [hci0] 19.503814
>      Vendor (0x3f|0x000a) ncmd 1
>        Status: Success (0x00)
>        00                                               .               
> < HCI Command: Vendor (0x3f|0x0018) plen 6                                 [hci0] 19.503936
>        00 00 13 57 38 00                                ...W8.          
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.504272
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.504302
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 4                                [hci0] 19.504638
>      Vendor (0x3f|0x0018) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Read Local Version Information (0x04|0x0001) plen 0         [hci0] 19.505004
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.525359
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.525420
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.525634
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.525664
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.525817
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.525847
>        04 00 00 00                                      ....            
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.525970
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.526000
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 12                               [hci0] 19.542693
>      Read Local Version Information (0x04|0x0001) ncmd 1
>        Status: Success (0x00)
>        HCI version: Bluetooth 2.1 (0x04) - Revision 192 (0x00c0)
>        LMP version: Bluetooth 2.1 (0x04) - Subversion 16651 (0x410b)
>        Manufacturer: Broadcom Corporation (15)
> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0                           [hci0] 19.542815
> * Unknown packet (code 14 len 30)                                      [hci65535] 19.543120
>        04 00 00 00 00 00 02 16 00 01 00 00 00 10 62 6c  ..............bl
>        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> * Unknown packet (code 15 len 4)                                       [hci65535] 19.543151
>        04 00 00 00                                      ....            
>> HCI Event: Command Complete (0x0e) plen 10                               [hci0] 19.565459
>      Read BD ADDR (0x04|0x0009) ncmd 1
>        Status: Success (0x00)
>        Address: 11:11:11:11:11:11 (OUI 11-11-11)

Can you actually run btmgmt extinfo for me. I wonder if we are not having an issue here with the missing hdev->set_bdaddr support. It should show you support for the public-addr feature.

        if (btdev->man_id == NOKIA_ID_BCM2048) {                                 
                hu->hdev->set_bdaddr = btbcm_set_bdaddr;                         
                set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);            
                dev_dbg(dev, "bcm2048 has invalid bluetooth address!");          
        } 

While we do this the btbcm_set_bdaddr might be actually empty.

config BT_HCIUART_NOKIA                                                          
        tristate "UART Nokia H4+ protocol support"                               
        depends on BT_HCIUART                                                    
        depends on BT_HCIUART_SERDEV                                             
        depends on PM                                                            
        select BT_HCIUART_H4                                                     

This is missing the select BT_BCM like what we have for the hci_bcm.c support.

config BT_HCIUART_BCM                                                            
        bool "Broadcom protocol support"                                         
        depends on BT_HCIUART                                                    
        select BT_HCIUART_H4                                                     
        select BT_BCM

Can you try to enable btbcm.ko module and load that first.

Regards

Marcel
