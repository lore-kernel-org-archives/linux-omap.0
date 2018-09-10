From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Regression in next with filesystem context concept
Date: Mon, 10 Sep 2018 11:31:46 -0700
Message-ID: <20180910183146.GA17726@roeck-us.net>
References: <20180907161023.GF5662@atomide.com>
 <20180906164358.GI5659@atomide.com>
 <9053.1536310046@warthog.procyon.org.uk>
 <11959.1536420266@warthog.procyon.org.uk>
 <20180910160836.GT5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180910160836.GT5662@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 10, 2018 at 09:08:36AM -0700, Tony Lindgren wrote:
> * David Howells <dhowells@redhat.com> [180908 15:28]:
> > Tony Lindgren <tony@atomide.com> wrote:
> > 
> > > > > Looks like next-20180906 now has a regression where mounting
> > > > > root won't work with commit fd0002870b45 ("vfs: Implement a
> > > > > filesystem superblock creation/configuration context").
> > > > 
> > > > Am I right in thinking you're not using any of the LSMs?
> > > 
> > > Assuming LSM as in Documentation/lsm.txt, right not using any.
> > 
> > The default return value for security_fs_context_parse_param() should be
> > -ENOPARAM, both in security.h and security.c.
> > 
> > I've fixed my tree and Al has pulled it, but we're now waiting on Stephen
> > Rothwell to refresh linux/next.
> 
> OK thanks for tracking that down, next-20180910 boots again
> for me.
> 

Did you try to shutdown and/or reboot ?

You might see something like the attached if you try.

Guenter

---
Unable to handle kernel paging request at virtual address 0000000000000030
umount(92): Oops 0
pc = [<fffffc000041200c>]  ra = [<fffffc00004121cc>]  ps = 0000    Not tainted
pc is at reconfigure_super+0x7c/0x2c0
ra is at reconfigure_super+0x23c/0x2c0
v0 = 0000000000000000  t0 = 0000000000000000  t1 = fffffc000743c030
t2 = fffffc000743c0a0  t3 = 0000000000000020  t4 = fffffffffffffdff
t5 = 0000000000000200  t6 = fffffc0000b9d9f8  t7 = fffffc000749c000
s0 = fffffc000743c000  s1 = fffffc000749fe08  s2 = 0000000000000000
s3 = 0000000000000001  s4 = 0000000120114ba0  s5 = fffffc0007027220
s6 = 0000000000000000
a0 = fffffc000743c000  a1 = fffffc00070072a0  a2 = fffffc00074e4b80
a3 = fffffc000743c800  a4 = 0000000000000001  a5 = fffffc000040ed50
t8 = 0000000000000001  t9 = 000000000abd5213  t10= 000000000748c000
t11= 0000000000000100  pv = fffffc0000439300  at = 0000000000000000
gp = fffffc0000b8d9f8  sp = (____ptrval____)
Disabling lock debugging due to kernel taint
Trace:
[<fffffc0000437d1c>] do_umount_root+0x9c/0xe0
[<fffffc000043a0d8>] ksys_umount+0x308/0x510
[<fffffc000043a2fc>] sys_umount+0x1c/0x30
[<fffffc00003115d4>] entSys+0xa4/0xc0

---
[   10.059677] BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
[   10.060205] PGD 800000000e37b067 P4D 800000000e37b067 PUD e37c067 PMD 0 
[   10.060960] Oops: 0000 [#1] SMP PTI
[   10.061405] CPU: 0 PID: 1210 Comm: umount Not tainted 4.19.0-rc2-next-20180910 #1
[   10.061727] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
[   10.062946] RIP: 0010:reconfigure_super+0x47/0x210
[   10.063363] Code: d4 01 00 00 44 8b a3 30 02 00 00 45 85 e4 0f 85 9d 01 00 00 a8 01 48 89 fd 75 4f 48 89 df 45 31 ed e8 ad 4f 01 00 48 8b 45 00 <48> 8b 40 30 48 85 c0 0f 84 d3 00 00 00 48 89 ef ff d0 85 c0 0f 84
[   10.064016] RSP: 0018:ffffbdc240123dd0 EFLAGS: 00000246
[   10.064273] RAX: 0000000000000000 RBX: ffffa13b8e310000 RCX: ffffa13b8e3100b8
[   10.064540] RDX: ffffa13b8e310048 RSI: 0000000000000000 RDI: ffffffff99949e28
[   10.064806] RBP: ffffbdc240123e00 R08: 0000000000000179 R09: 0000000000000000
[   10.066145] R10: ffffbdc2400bfd08 R11: 0000000000000001 R12: 0000000000000000
[   10.066432] R13: 0000000000000001 R14: ffffa13b8f370920 R15: 0000000000000000
[   10.066781] FS:  00007fd7ce876500(0000) GS:ffffa13b8f600000(0000) knlGS:0000000000000000
[   10.067107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.067341] CR2: 0000000000000030 CR3: 000000000e3a6000 CR4: 00000000003406f0
[   10.067730] Call Trace:
[   10.068888]  do_umount_root+0x7b/0xb0
[   10.069157]  ksys_umount+0x250/0x3e0
[   10.069352]  ? vfs_write+0x13f/0x190
[   10.069538]  __x64_sys_umount+0xd/0x10
[   10.069742]  do_syscall_64+0x39/0xe0
[   10.069962]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   10.070419] RIP: 0033:0x7fd7ce395b47
[   10.070605] Code: 73 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 11 73 2b 00 f7 d8 64 89 01 48
[   10.071220] RSP: 002b:00007ffea2a29288 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
[   10.071552] RAX: ffffffffffffffda RBX: 00000000011fa8e0 RCX: 00007fd7ce395b47
[   10.071796] RDX: 00007ffea2a29470 RSI: 0000000000000000 RDI: 00000000011fa8e0
[   10.072038] RBP: 00000000011fab40 R08: 00000000011fa920 R09: 00007fd7ce3d36c0
[   10.072291] R10: 000000000000089e R11: 0000000000000206 R12: 00000000011fa8a0
[   10.072543] R13: 00000000011faba0 R14: 0000000000000000 R15: 00007ffea2a29470
[   10.072933] Modules linked in:
[   10.073321] CR2: 0000000000000030
[   10.073869] ---[ end trace 9ae171053580f03c ]---
[   10.074155] RIP: 0010:reconfigure_super+0x47/0x210
[   10.074366] Code: d4 01 00 00 44 8b a3 30 02 00 00 45 85 e4 0f 85 9d 01 00 00 a8 01 48 89 fd 75 4f 48 89 df 45 31 ed e8 ad 4f 01 00 48 8b 45 00 <48> 8b 40 30 48 85 c0 0f 84 d3 00 00 00 48 89 ef ff d0 85 c0 0f 84
[   10.074977] RSP: 0018:ffffbdc240123dd0 EFLAGS: 00000246
[   10.075182] RAX: 0000000000000000 RBX: ffffa13b8e310000 RCX: ffffa13b8e3100b8
[   10.075425] RDX: ffffa13b8e310048 RSI: 0000000000000000 RDI: ffffffff99949e28
[   10.075672] RBP: ffffbdc240123e00 R08: 0000000000000179 R09: 0000000000000000
[   10.075919] R10: ffffbdc2400bfd08 R11: 0000000000000001 R12: 0000000000000000
[   10.076167] R13: 0000000000000001 R14: ffffa13b8f370920 R15: 0000000000000000
[   10.076421] FS:  00007fd7ce876500(0000) GS:ffffa13b8f600000(0000) knlGS:0000000000000000
[   10.076735] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.076955] CR2: 0000000000000030 CR3: 000000000e3a6000 CR4: 00000000003406f0
