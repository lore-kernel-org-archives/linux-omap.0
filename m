From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: 2.6.29 and SDP3430
Date: Wed, 15 Apr 2009 01:38:24 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702EAA6A3DF@dbde02.ent.ti.com>
References: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com>
 <20090409100343.71d34c16.jarkko.nikula@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162037BCF18A5@dlee02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0CFFB1EEE1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55009 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220AbZDNUIj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 16:08:39 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFFB1EEE1@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon,
>Nishanth
>Using the following:
>arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2008q3-72) 4.3.2
>
>I am past the lockup on calibration, but it now gets stuck as follows:
>NET: Registered protocol family 15
>RPC: Registered udp transport module.
>RPC: Registered tcp transport module.
>Disabling unused clock "gpt2_ick"
>Disabling unused clock "gpt2_fck"
>Disabling unused clock "wdt2_ick"
>Disabling unused clock "wdt2_fck"
>Disabling unused clock "dpll4_m6x2_ck"
>Disabling unused clock "dpll4_m5x2_ck"
>Disabling unused clock "dpll3_m3x2_ck"
>Disabling unused clock "sys_clkout1"
>variant c rev 1
>implementor 41 architecture 3 part 30 variant c rev 1
>regulator_init_complete: incomplete constraints, leaving VAUX3 on
>

On master of Linux-Omap: 2.6.30-rc1
Board: LDP(3430)
Toolchain version: arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2008q3-72) 4.3.2

I am also seeing a hang at following bootup time:

console [ttyS2] enabled
<6>brd: module loaded
brd: module loaded
<6>loop: module loaded
loop: module loaded
<6>i2c /dev entries driver
i2c /dev entries driver
...

And after a long time I see constant Crash dumps as follows

Mem-info:
Mem-info:
Normal per-cpu:
Normal per-cpu:
CPU    0: hi:   42, btch:   7 usd:   6
CPU    0: hi:   42, btch:   7 usd:   6
Active_anon:0 active_file:0 inactive_anon:0
 inactive_file:0 unevictable:0 dirty:0 writeback:0 unstable:0
 free:133 slab:31174 mapped:0 pagetables:0 bounce:0
Active_anon:0 active_file:0 inactive_anon:0
 inactive_file:0 unevictable:0 dirty:0 writeback:0 unstable:0
 free:133 slab:31174 mapped:0 pagetables:0 bounce:0
Normal free:532kB min:1440kB low:1800kB high:2160kB active_anon:0kB inactive_ano
n:0kB active_file:0kB inactive_file:0kB unevictable:0kB present:130048kB pages_s
canned:0 all_unreclaimable? no
Normal free:532kB min:1440kB low:1800kB high:2160kB active_anon:0kB inactive_ano
n:0kB active_file:0kB inactive_file:0kB unevictable:0kB present:130048kB pages_s
canned:0 all_unreclaimable? no
lowmem_reserve[]:lowmem_reserve[]: 0 0 0 0

Normal: Normal: 1*4kB 1*4kB 0*8kB 0*8kB 1*16kB 1*16kB 0*32kB 0*32kB 0*64kB 0*64k
B 0*128kB 0*128kB 0*256kB 0*256kB 1*512kB 1*512kB 0*1024kB 0*1024kB 0*2048kB 0*2
048kB 0*4096kB 0*4096kB = 532kB
= 532kB
0 total pagecache pages
0 total pagecache pages
0 pages in swap cache
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Free swap  = 0kB
Total swap = 0kB
Total swap = 0kB
32768 pages of RAM
32768 pages of RAM
164 free pages
164 free pages
1371 reserved pages
1371 reserved pages
31174 slab pages
31174 slab pages
0 pages shared
0 pages shared
0 pages swap cached
0 pages swap cached
<4>swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
[<c00322d8>] [<c00322d8>] (unwind_backtrace+0x0/0xdc) (unwind_backtrace+0x0/0xdc
) from [<c007b344>] from [<c007b344>] (__alloc_pages_internal+0x384/0x3a4)
(__alloc_pages_internal+0x384/0x3a4)
[<c007b344>] [<c007b344>] (__alloc_pages_internal+0x384/0x3a4) (__alloc_pages_in
ternal+0x384/0x3a4) from [<c0095550>] from [<c0095550>] (cache_alloc_refill+0x24
0/0x4bc)
(cache_alloc_refill+0x240/0x4bc)
[<c0095550>] [<c0095550>] (cache_alloc_refill+0x240/0x4bc) (cache_alloc_refill+0
x240/0x4bc) from [<c00958cc>] from [<c00958cc>] (kmem_cache_alloc+0x44/0x7c)
(kmem_cache_alloc+0x44/0x7c)
[<c00958cc>] [<c00958cc>] (kmem_cache_alloc+0x44/0x7c) (kmem_cache_alloc+0x44/0x
7c) from [<c005cef0>] from [<c005cef0>] (call_usermodehelper_setup+0x20/0x70)
(call_usermodehelper_setup+0x20/0x70)
[<c005cef0>] [<c005cef0>] (call_usermodehelper_setup+0x20/0x70) (call_usermodehe
lper_setup+0x20/0x70) from [<c0157e54>] from [<c0157e54>] (kobject_uevent_env+0x
30c/0x388)
(kobject_uevent_env+0x30c/0x388)
[<c0157e54>] [<c0157e54>] (kobject_uevent_env+0x30c/0x388) (kobject_uevent_env+0
x30c/0x388) from [<c0196860>] from [<c0196860>] (device_add+0x4f4/0x540)
(device_add+0x4f4/0x540)
[<c0196860>] [<c0196860>] (device_add+0x4f4/0x540) (device_add+0x4f4/0x540) from
 [<c0196938>] from [<c0196938>] (device_create_vargs+0x74/0xa4)
(device_create_vargs+0x74/0xa4)
[<c0196938>] [<c0196938>] (device_create_vargs+0x74/0xa4) (device_create_vargs+0
x74/0xa4) from [<c0196984>] from [<c0196984>] (device_create+0x1c/0x24)
(device_create+0x1c/0x24)
[<c0196984>] [<c0196984>] (device_create+0x1c/0x24) (device_create+0x1c/0x24) fr
om [<c01a0c84>] from [<c01a0c84>] (i2cdev_attach_adapter+0x94/0xe8)
(i2cdev_attach_adapter+0x94/0xe8)
[<c01a0c84>] [<c01a0c84>] (i2cdev_attach_adapter+0x94/0xe8) (i2cdev_attach_adapt
er+0x94/0xe8) from [<c01a076c>] from [<c01a076c>] (__attach_adapter+0x28/0x30)
(__attach_adapter+0x28/0x30)
[<c01a076c>] [<c01a076c>] (__attach_adapter+0x28/0x30) (__attach_adapter+0x28/0x
30) from [<c0198dc8>] from [<c0198dc8>] (class_for_each_device+0x6c/0xac)
(class_for_each_device+0x6c/0xac)
[<c0198dc8>] [<c0198dc8>] (class_for_each_device+0x6c/0xac) (class_for_each_devi
ce+0x6c/0xac) from [<c01a0018>] from [<c01a0018>] (i2c_register_driver+0xd0/0xf0
)
(i2c_register_driver+0xd0/0xf0)
[<c01a0018>] [<c01a0018>] (i2c_register_driver+0xd0/0xf0) (i2c_register_driver+0
xd0/0xf0) from [<c0018058>] from [<c0018058>] (i2c_dev_init+0x50/0xa0)
(i2c_dev_init+0x50/0xa0)
[<c0018058>] [<c0018058>] (i2c_dev_init+0x50/0xa0) (i2c_dev_init+0x50/0xa0) from
 [<c002c27c>] from [<c002c27c>] (do_one_initcall+0x54/0x194)
(do_one_initcall+0x54/0x194)
[<c002c27c>] [<c002c27c>] (do_one_initcall+0x54/0x194) (do_one_initcall+0x54/0x1
94) from [<c000852c>] from [<c000852c>] (kernel_init+0x70/0xe4)
(kernel_init+0x70/0xe4)
[<c000852c>] [<c000852c>] (kernel_init+0x70/0xe4) (kernel_init+0x70/0xe4) from [
<c0051c20>] from [<c0051c20>] (do_exit+0x0/0x574)
(do_exit+0x0/0x574)
[<c0051c20>] [<c0051c20>] (do_exit+0x0/0x574) (do_exit+0x0/0x574) from [<0000000
1>] from [<00000001>] (0x1)
(0x1)

>
>>
>> I wonder if the timer stopped ticking.  If you connect with emulator take
>> a look at GPT1 registers and see if time base is moving.
>>
>> Another quick test is to shut off tickles, nohz=off.
>nohz=off did not work with either 2007q3 or 2008q3.. have'nt looked at the GPT regs though..
>
>Regards,
>Nishanth Menon
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

