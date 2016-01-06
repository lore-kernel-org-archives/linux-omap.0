From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Wed, 6 Jan 2016 20:01:13 +0200
Message-ID: <568D5669.4040801@gmail.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali> <20160104174001.GD12777@atomide.com>
 <568AC0F9.2010304@gmail.com> <20160105041356.GE12777@atomide.com>
 <20160105084947.GG22661@pali> <20160105224929.GF12777@atomide.com>
 <20160106174039.GA14271@earth> <20160106174713.GL12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160106174713.GL12777@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, pavel@ucw.cz, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org



On  6.01.2016 19:47, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [160106 09:41]:
>> Hi,
>>
>> On Tue, Jan 05, 2016 at 02:49:29PM -0800, Tony Lindgren wrote:
>>> Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug")
>>> unified the GPMC debug for the SoCs with GPMC. The commit also left
>>> out the option for HWMOD_INIT_NO_RESET as we now require proper timings
>>> for GPMC to be able to remap GPMC devices out of address 0.
>>>
>>> Unfortunately on 900, onenand now only partially works with the device
>>
>> You may want to change 900 to n900 (maybe even Nokia N900) before
>> actually committing this.
>
> Thanks will do.
>
> Tony
>
>

Unfortunately, it seems there is more to be fixed. It booted several 
times to the userspace, but after a couple of shutdowns, rootfs became 
corrupted again. I flashed, installed linux 4.4, but the same happened 
after the first shutdown with 4.4:

<5>[    8.159179] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" stops
<3>[    8.184631] UBIFS error (ubi0:0 pid 1): ubifs_read_node: bad node 
type (255 but expected 9)
<3>[    8.197937] UBIFS error (ubi0:0 pid 1): ubifs_read_node: bad node 
at LEB 1934:6936, LEB mapping status 0
<3:[    8.216522] Not a node, first 24 bytes:
<3>[    8.220520] 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff ff ff ff ff ff ff                          ........................
<4>[    8.247772] CPU: 0 PID: 1 Comm: swapper Not tainted 4.4.0-rc7+ #4
<4>[    8.258911] Hardware name: Nokia RX-51 board
<4>[    8.268096] [<c0013a98>] (unwind_backtrace) from Y<c0011db8>] 
(show_stack+0x10/0x14)
<4>[    8.281097] [<c0011db8>] (show_stack) from [<c01aa7b4>] 
(ubifs_read_node+0x29c/0x2d4)
<4>[    8.294097] [<c01aa7b4>] (ubifs_read_node) from [<c01b2ae0>] 
(dbg_old_index_check_init+0x60/0x9c)
<4>[    8.308258] [<c01b2ae0>] (dbg_old_index_check_init) from 
[<c01a6d00>] (ubifs_mount+0xd90/0x15f0)
<4>[    8.322357] [<c01a6d00>] (ubifs_mount) from [<c00df77c>] 
(mount_fs+0x70/0x148)
<4>[    8.334747] [<c00df77c>] (mount_fs) from [<c00f86bc>] 
(vfs_kern_mount+0x4c/0x110)
<4>[    8.347412] [<c00f86bc>] (vfs_kern_mount) from [<c00fb5c4>] 
(do_mount+0xadc/0xc34)
<4>[    8.360168] [<c00fb5c4>] (do_mount) from [<c00fb940>] 
(SyS_mount+0x70/0x9c)
<4>[    8.372253] [<c00fb940>] (SyS_mount) from [<c0602038>] 
(mount_block_root+0xf0/0x28c)
<4>[    8.385162] [<c0602038>] (mount_block_root) from [<c06023b8>] 
(prepare_namespace+0x88/0x1bc)
<4>[    8.398834] [<c06023b8>] (prepare_namespace) from [<c0601df4>] 
(kernel_init_freeable+0x178/0x1c4)
<4>[    8.412963] [<c0601df4>] (kernel_init_freeabme) from [<c04375d8>] 
(kernel_init+0x8/0xe4)
<4>[    8.426300] [<c04375d8>] (kernel_init) from [<c000f098>] 
(ret_from_fork+0x14/0x3c)

P.S.
(Pali, sorry for not having time to read the kernel docs re e-mail 
clients :) )
