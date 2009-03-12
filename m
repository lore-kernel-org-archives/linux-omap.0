From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: ioremap bug? (was RE: DSPBRIDGE: segmentation fault after reloading dspbridge several times due to a memory leak.)
Date: Thu, 12 Mar 2009 10:27:16 -0700
Message-ID: <87zlfq6497.fsf@deeprootsystems.com>
References: <496565EC904933469F292DDA3F1663E60287CA6EC4@dlee06.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0CFF51DF41@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60926 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250AbZCLR1X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 13:27:23 -0400
Received: by gxk7 with SMTP id 7so429605gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 10:27:20 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF51DF41@dlee02.ent.ti.com> (Nishanth Menon's message of "Thu\, 12 Mar 2009 11\:39\:50 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Ameya Palande <ameya.palande@nokia.com>

"Menon, Nishanth" <nm@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Guzman Lugo, Fernando
>> Sent: Thursday, March 12, 2009 2:04 AM
>> To: linux-omap@vger.kernel.org
>> Subject: DSPBRIDGE: segmentation fault after reloading dspbridge sev=
eral
>> times due to a memory leak.
>> =A0=A0=A0=A0=A0=A0=A0 Reloading the dspbridge several times I am get=
ting a Segmentation
>> fault. Seeing the log it seems that the memory was exhausted
>>=20
>> The error happens when ioremap is called
>>=20
>> void MEM_ExtPhysPoolInit(u32 poolPhysBase, u32 poolSize)
>> {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 poolVirtBase;
>>=20
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* get the virtual address for the=
 physical memory pool passed
>> */
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 poolVirtBase =3D (u32)ioremap(pool=
PhysBase, poolSize);
>> .
>>=20
>> Putting some printk's and printing the address returned by ioremap, =
I
>> realized that address returned by ioremap each time I reload the dsp=
bridge
>> is different, in fact the address is increasing. I also put a printk=
 where
>> iounmap is called to make sure it is called and yes it is actually c=
alled.
>> However testing with a kernel + bridge for linux 23x I always get th=
e same
>> address for pool memory. Any idea what the problem is? I have includ=
ed the
>> console output where you can see the address increasing.
>
> I duplicated this with the following dummy driver which ioremaps as p=
er the same allocations that the bridge driver would have done:
>
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/slab.h>
> #include <linux/mm.h>
> #include <linux/dma-mapping.h>
>
> #define BASE 0x87000000
> #define SIZE 0x600000
>
> struct mem_s{
>         void * vir;
>         u32 phy;
>         u32 size;
> };
>
> struct mem_s b[]=3D{
>         {0,BASE,SIZE},
>         {0,0x48306000,4096},
>         {0,0x48004000,4096},
>         {0,0x48094000,4096},
>         {0,0x48002000,4096},
>         {0,0x5c7f8000,98304},
>         {0,0x5ce00000,32768},
>         {0,0x5cf04000,81920},
>         {0,0x48005000,4096},
>         {0,0x48307000,4096},
>         {0,0x48306a00,4096},
>         {0,0x5d000000,4096},
> };

Nishant,

Which of these physical addresses causes an increasing virtual
address?  The addresses in the 0x48xxxxxx (L4, L4_WKUP) range should
just trigger static mapping via the arch-specific ioremap, so those
should always map to the same virt address.=20

Could you do the experiment with a smaller number of mappings?  Maybe
just one at a time of the non L4 mappings?  Probably starting with
only the BASE,SIZE mapping.

Kevin

>
> static int __init dummy_init(void)
> {
>         int i;
>         for (i=3D0;i<(sizeof(b)/sizeof(struct mem_s));i++) {
>                 b[i].vir =3D ioremap(b[i].phy,b[i].size);
>                 if(b[i].vir =3D=3D NULL) {
>                         printk(KERN_ERR "Allocation failed idx=3D%d\n=
",i);
>                         /* Free up all the prev allocs */
>                         i--;
>                         while(i>=3D0) {
>                                 iounmap(b[i].vir);
>                                 i--;
>                         }
>                         return -ENOMEM;
>
>                 }
>         }
>         return 0;
> }
> module_init(dummy_init);
> static void __exit dummy_exit(void)
> {
>         int i;
>         for (i=3D0;i<(sizeof(b)/sizeof(struct mem_s));i++) {
>                 iounmap(b[i].vir);
>         }
> }
> module_exit(dummy_exit);
> MODULE_LICENSE("GPL");
>
>
> Regression script:
> #!/bin/bash
> i=3D0
> slee()
> {
>         echo "Sleep "
> #sleep 5
> }
> while [ $i -lt 100 ]; do
>         echo "insmod $i"
>         insmod  ./dummy.ko
>         if [ $? -ne 0 ]; then
>                 echo "QUIT IN INSMOD $i"
>                 exit 1;
>         fi
>         slee
>         echo "rmmod $i"
>         rmmod dummy
>         if [ $? -ne 0 ]; then
>                 echo "QUIT IN RMMOD $i"
>                 exit 1;
>         fi
>         i=3D`expr $i + 1`
>         slee
> done
>
>
>
> after around 38 iterations:
> <4>vmap allocation failed: use vmalloc=3D<size> to increase size.
> vmap allocation failed: use vmalloc=3D<size> to increase size.
> <3>Allocation failed idx=3D0
> Allocation failed idx=3D0
>
> However cat /proc/meminfo after this error is:
> cat /proc/meminfo
> MemTotal:          61920 kB
> MemFree:           56900 kB
> Buffers:               0 kB
> Cached:             2592 kB
> SwapCached:            0 kB
> Active:             1920 kB
> Inactive:           1252 kB
> Active(anon):        580 kB
> Inactive(anon):        0 kB
> Active(file):       1340 kB
> Inactive(file):     1252 kB
> Unevictable:           0 kB
> Mlocked:               0 kB
> SwapTotal:             0 kB
> SwapFree:              0 kB
> Dirty:                 0 kB
> Writeback:             0 kB
> AnonPages:           616 kB
> Mapped:              688 kB
> Slab:               1296 kB
> SReclaimable:        480 kB
> SUnreclaim:          816 kB
> PageTables:           96 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:       30960 kB
> Committed_AS:       2932 kB
> VmallocTotal:     319488 kB
> VmallocUsed:           8 kB
> VmallocChunk:     319448 kB
>
>
> We seem to have more than enough vmalloc space according to this.. am=
 I right in thinking this is a kernel vmalloc handling issue?
>
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
