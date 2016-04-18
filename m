From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 00/17] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Mon, 18 Apr 2016 15:31:32 +0300
Message-ID: <5714D3A4.2050405@ti.com>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
 <20160413212500.GD5995@atomide.com> <5710B58C.7050108@ti.com>
 <20160415120942.3131eac1@bbrezillon> <5710C86A.9060108@ti.com>
 <20160415135108.63716f06@bbrezillon> <20160415154139.GS5995@atomide.com>
 <20160415180531.15d790d2@bbrezillon> <20160415161950.GT5995@atomide.com>
 <20160416105711.5310d2d0@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160416105711.5310d2d0@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>
Cc: javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 16/04/16 11:57, Boris Brezillon wrote:
> On Fri, 15 Apr 2016 09:19:51 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
>>
>>> Or should I just pull this immutable branch in my current nand/next and
>>> let you pull the same immutable branch in omap-soc. I mean, would this
>>> prevent conflicts when our branches are merged into linux-next, no
>>> matter the order.
>>
>> Ideally just one or more branches with just minimal changes in
>> them against -rc1. But you may have other dependencies in
>> your NAND tree so that may no longer be doable :) Usually if
>> I merge something that may need to get merged into other
>> branches, I just apply them into a separate branch against -rc1
>> to start with, then merge that branch in.
> 
> Okay, in this case, that's pretty much what I did from the beginning,
> except the immutable branch was provided by Roger (based on 4.6-rc1).
> Thanks for this detailed explanation, I'll try to remember that when
> I'll need to provide an immutable branch for another subsystem.
> 
> Roger, my request remains, could you check/test my conflict resolution
> (branch nand/next-with-gpmc-rework)?

I couldn't test that branch yet as nand/next is broken on omap platforms
(at least on dra7-evm).

The commit where it breaks is:
a662ef4 mtd: nand: omap2: use mtd_ooblayout_xxx() helpers where appropriate

I'm trying to figure out what went wrong there. Failure log below.

--cheers,
-roger

== attaching ubi to mtd9
[   27.173973] ubi0: attaching mtd9
[   27.178311] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.184828] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.191324] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 64 bytes from PEB 0:0, read only 64 bytes, retry
[   27.203378] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.209860] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.216388] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 64 bytes from PEB 0:0, read only 64 bytes, retry
[   27.228468] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.234976] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.241471] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 64 bytes from PEB 0:0, read only 64 bytes, retry
[   27.253802] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.260278] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.266812] ubi0 error: ubi_io_read: error -74 (ECC error) while reading 64 bytes from PEB 0:0, read 64 bytes
[   27.277254] CPU: 0 PID: 2032 Comm: ubiattach Not tainted 4.6.0-rc1-00053-ga662ef4 #625
[   27.285549] Hardware name: Generic DRA74X (Flattened Device Tree)
[   27.291949] [<c010feec>] (unwind_backtrace) from [<c010c110>] (show_stack+0x10/0x14)
[   27.300083] [<c010c110>] (show_stack) from [<c0470f24>] (dump_stack+0xac/0xe0)
[   27.307664] [<c0470f24>] (dump_stack) from [<c05a5f8c>] (ubi_io_read+0x11c/0x2fc)
[   27.315511] [<c05a5f8c>] (ubi_io_read) from [<c05a6388>] (ubi_io_read_ec_hdr+0x44/0x228)
[   27.323989] [<c05a6388>] (ubi_io_read_ec_hdr) from [<c05aaef8>] (ubi_attach+0x138/0x149c)
[   27.332579] [<c05aaef8>] (ubi_attach) from [<c059fc78>] (ubi_attach_mtd_dev+0x3d0/0xbe4)
[   27.341063] [<c059fc78>] (ubi_attach_mtd_dev) from [<c05a15d4>] (ctrl_cdev_ioctl+0xe4/0x224)
[   27.349928] [<c05a15d4>] (ctrl_cdev_ioctl) from [<c029e380>] (do_vfs_ioctl+0x90/0xa2c)
[   27.358242] [<c029e380>] (do_vfs_ioctl) from [<c029ed88>] (SyS_ioctl+0x6c/0x7c)
[   27.365910] [<c029ed88>] (SyS_ioctl) from [<c0107840>] (ret_fast_syscall+0x0/0x1c)
[   27.374541] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.381025] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.387551] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 512 bytes from PEB 0:512, read only 512 bytes, retry
[   27.399953] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.406465] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.412950] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 512 bytes from PEB 0:512, read only 512 bytes, retry
[   27.425349] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.431837] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.438356] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 512 bytes from PEB 0:512, read only 512 bytes, retry
[   27.450735] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.457243] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.463739] ubi0 error: ubi_io_read: error -74 (ECC error) while reading 512 bytes from PEB 0:512, read 512 bytes
[   27.474526] CPU: 0 PID: 2032 Comm: ubiattach Not tainted 4.6.0-rc1-00053-ga662ef4 #625
[   27.482824] Hardware name: Generic DRA74X (Flattened Device Tree)
[   27.489218] [<c010feec>] (unwind_backtrace) from [<c010c110>] (show_stack+0x10/0x14)
[   27.497348] [<c010c110>] (show_stack) from [<c0470f24>] (dump_stack+0xac/0xe0)
[   27.504923] [<c0470f24>] (dump_stack) from [<c05a5f8c>] (ubi_io_read+0x11c/0x2fc)
[   27.512772] [<c05a5f8c>] (ubi_io_read) from [<c05a65b8>] (ubi_io_read_vid_hdr+0x4c/0x230)
[   27.521355] [<c05a65b8>] (ubi_io_read_vid_hdr) from [<c05ab04c>] (ubi_attach+0x28c/0x149c)
[   27.530024] [<c05ab04c>] (ubi_attach) from [<c059fc78>] (ubi_attach_mtd_dev+0x3d0/0xbe4)
[   27.538517] [<c059fc78>] (ubi_attach_mtd_dev) from [<c05a15d4>] (ctrl_cdev_ioctl+0xe4/0x224)
[   27.547409] [<c05a15d4>] (ctrl_cdev_ioctl) from [<c029e380>] (do_vfs_ioctl+0x90/0xa2c)
[   27.555736] [<c029e380>] (do_vfs_ioctl) from [<c029ed88>] (SyS_ioctl+0x6c/0x7c)
[   27.563415] [<c029ed88>] (SyS_ioctl) from [<c0107840>] (ret_fast_syscall+0x0/0x1c)
[   27.572208] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.579160] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.586560] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.593311] omap2-nand omap2-nand.0: uncorrectable bit-flips found
[   27.600038] omap2-nand omap2-nand.0: uncorrectable bit-flips found
