From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: Regression in next with filesystem context concept
Date: Thu, 6 Sep 2018 23:41:50 +0530
Message-ID: <CA+G9fYvhZmqmqQvM7Waxw6mqw6iXkg=zHOZPPJB_sFGovha=xA@mail.gmail.com>
References: <20180906164358.GI5659@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906164358.GI5659@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-omap@vger.kernel.org

On 6 September 2018 at 22:13, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> Looks like next-20180906 now has a regression where mounting
> root won't work with commit fd0002870b45 ("vfs: Implement a
> filesystem superblock creation/configuration context").

I have noticed this problem on beaglebone x15 running next-20180906.

>
> Here's what happens for me on MMC for example:
>
> Waiting for root device /dev/mmcblk0p2...
> mmc0: host does not support reading read-only switch, assuming write-enable
> mmc1: new SDIO card at address 0001
> mmc0: new high speed SDXC card at address e624
> mmcblk0: mmc0:e624 SU64G 59.5 GiB
>  mmcblk0: p1 p2 p3
> VFS: Cannot open root device "mmcblk0p2" or unknown-block(179,2): error -2
> Please append a correct "root=" boot option; here are the available partitions:
> ...
>   b302        60298240 mmcblk0p2 000b9930-02
> ...
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(179,2)
>
> And NFSroot fails with:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = (ptrval)
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc1-00104-gfd0002870b45 #867
> Hardware name: Generic OMAP4 (Flattened Device Tree)
> PC is at nfs_fs_mount+0x4d4/0x9dc
> LR is at nfs_fs_mount+0x450/0x9dc
> pc : [<c04100c0>]    lr : [<c041003c>]    psr: 60000153
> sp : ee8bde10  ip : 00000000  fp : 00000400
> r10: 00001000  r9 : 00008001  r8 : 00000000
> r7 : eefc7110  r6 : c0d08948  r5 : eefdc000  r4 : eefc7000
> r3 : 00000000  r2 : 00000002  r1 : eefc71a0  r0 : eefc710c
> Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 8000404a  DAC: 00000051
> Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
> ...
> [<c04100c0>] (nfs_fs_mount) from [<c031c4f0>] (legacy_get_tree+0x2c/0xe4)
> [<c031c4f0>] (legacy_get_tree) from [<c02e014c>] (vfs_get_tree+0x70/0x1a0)
> [<c02e014c>] (vfs_get_tree) from [<c0305a98>] (do_mount+0x788/0xb18)
> [<c0305a98>] (do_mount) from [<c03061e4>] (ksys_mount+0x8c/0xb4)
> [<c03061e4>] (ksys_mount) from [<c0c01988>] (mount_root+0x70/0x158)
> [<c0c01988>] (mount_root) from [<c0c01bd0>] (prepare_namespace+0x160/0x1c4)
> [<c0c01bd0>] (prepare_namespace) from [<c0c012a4>] (kernel_init_freeable+0x444/0x4b4)
> [<c0c012a4>] (kernel_init_freeable) from [<c08f0558>] (kernel_init+0x8/0x114)
> [<c08f0558>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> Exception stack(0xee8bdfb0 to 0xee8bdff8)
> dfa0:                                     00000000 00000000 00000000 00000000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> Code: e352000a 1a000001 e6bf3fb3 e1c730b2 (e5d83000)
>
> Regards,
>
> Tony

- Naresh
