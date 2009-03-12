From: "Alejandro Blanca G." <alex.blanca@gmail.com>
Subject: Re: ioremap bug? (was RE: DSPBRIDGE: segmentation fault after
	reloading dspbridge several times due to a memory leak.)
Date: Thu, 12 Mar 2009 11:49:59 -0600
Message-ID: <b6ab3a160903121049l471e705cj4c81ea8dcff137fb@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E60287CA6EC4@dlee06.ent.ti.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF51DF41@dlee02.ent.ti.com>
	 <87zlfq6497.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:20337 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbZCLRuB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 13:50:01 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1099375rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 10:49:59 -0700 (PDT)
In-Reply-To: <87zlfq6497.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Ameya Palande <ameya.palande@nokia.com>

My 2 cents on this, and based on previous experience (which may be
outdated), are there any limits (physical, virtual) regarding memory
space being crossed with these values?

I.e., are you in the limits of a memory page or the limits of a memory =
bank?

Just an idea. If I'm totally lost, my apologies. Just wanted to be of h=
elp.

Best regards,

Alex B.

On Thu, Mar 12, 2009 at 11:27 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Menon, Nishanth" <nm@ti.com> writes:
>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Guzman Lugo, Fernando
>>> Sent: Thursday, March 12, 2009 2:04 AM
>>> To: linux-omap@vger.kernel.org
>>> Subject: DSPBRIDGE: segmentation fault after reloading dspbridge se=
veral
>>> times due to a memory leak.
>>> =A0=A0=A0=A0=A0=A0=A0 Reloading the dspbridge several times I am ge=
tting a Segmentation
>>> fault. Seeing the log it seems that the memory was exhausted
>>>
>>> The error happens when ioremap is called
>>>
>>> void MEM_ExtPhysPoolInit(u32 poolPhysBase, u32 poolSize)
>>> {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 poolVirtBase;
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* get the virtual address for th=
e physical memory pool passed
>>> */
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 poolVirtBase =3D (u32)ioremap(poo=
lPhysBase, poolSize);
>>> .
>>>
>>> Putting some printk's and printing the address returned by ioremap,=
 I
>>> realized that address returned by ioremap each time I reload the ds=
pbridge
>>> is different, in fact the address is increasing. I also put a print=
k where
>>> iounmap is called to make sure it is called and yes it is actually =
called.
>>> However testing with a kernel + bridge for linux 23x I always get t=
he same
>>> address for pool memory. Any idea what the problem is? I have inclu=
ded the
>>> console output where you can see the address increasing.
>>
>> I duplicated this with the following dummy driver which ioremaps as =
per the same allocations that the bridge driver would have done:
>>
>> #include <linux/kernel.h>
>> #include <linux/module.h>
>> #include <linux/slab.h>
>> #include <linux/mm.h>
>> #include <linux/dma-mapping.h>
>>
>> #define BASE 0x87000000
>> #define SIZE 0x600000
>>
>> struct mem_s{
>> =A0 =A0 =A0 =A0 void * vir;
>> =A0 =A0 =A0 =A0 u32 phy;
>> =A0 =A0 =A0 =A0 u32 size;
>> };
>>
>> struct mem_s b[]=3D{
>> =A0 =A0 =A0 =A0 {0,BASE,SIZE},
>> =A0 =A0 =A0 =A0 {0,0x48306000,4096},
>> =A0 =A0 =A0 =A0 {0,0x48004000,4096},
>> =A0 =A0 =A0 =A0 {0,0x48094000,4096},
>> =A0 =A0 =A0 =A0 {0,0x48002000,4096},
>> =A0 =A0 =A0 =A0 {0,0x5c7f8000,98304},
>> =A0 =A0 =A0 =A0 {0,0x5ce00000,32768},
>> =A0 =A0 =A0 =A0 {0,0x5cf04000,81920},
>> =A0 =A0 =A0 =A0 {0,0x48005000,4096},
>> =A0 =A0 =A0 =A0 {0,0x48307000,4096},
>> =A0 =A0 =A0 =A0 {0,0x48306a00,4096},
>> =A0 =A0 =A0 =A0 {0,0x5d000000,4096},
>> };
>
> Nishant,
>
> Which of these physical addresses causes an increasing virtual
> address? =A0The addresses in the 0x48xxxxxx (L4, L4_WKUP) range shoul=
d
> just trigger static mapping via the arch-specific ioremap, so those
> should always map to the same virt address.
>
> Could you do the experiment with a smaller number of mappings? =A0May=
be
> just one at a time of the non L4 mappings? =A0Probably starting with
> only the BASE,SIZE mapping.
>
> Kevin
>
>>
>> static int __init dummy_init(void)
>> {
>> =A0 =A0 =A0 =A0 int i;
>> =A0 =A0 =A0 =A0 for (i=3D0;i<(sizeof(b)/sizeof(struct mem_s));i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 b[i].vir =3D ioremap(b[i].phy,b[i].s=
ize);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(b[i].vir =3D=3D NULL) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "All=
ocation failed idx=3D%d\n",i);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Free up all the p=
rev allocs */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i--;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while(i>=3D0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioun=
map(b[i].vir);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i--;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 return 0;
>> }
>> module_init(dummy_init);
>> static void __exit dummy_exit(void)
>> {
>> =A0 =A0 =A0 =A0 int i;
>> =A0 =A0 =A0 =A0 for (i=3D0;i<(sizeof(b)/sizeof(struct mem_s));i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(b[i].vir);
>> =A0 =A0 =A0 =A0 }
>> }
>> module_exit(dummy_exit);
>> MODULE_LICENSE("GPL");
>>
>>
>> Regression script:
>> #!/bin/bash
>> i=3D0
>> slee()
>> {
>> =A0 =A0 =A0 =A0 echo "Sleep "
>> #sleep 5
>> }
>> while [ $i -lt 100 ]; do
>> =A0 =A0 =A0 =A0 echo "insmod $i"
>> =A0 =A0 =A0 =A0 insmod =A0./dummy.ko
>> =A0 =A0 =A0 =A0 if [ $? -ne 0 ]; then
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "QUIT IN INSMOD $i"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit 1;
>> =A0 =A0 =A0 =A0 fi
>> =A0 =A0 =A0 =A0 slee
>> =A0 =A0 =A0 =A0 echo "rmmod $i"
>> =A0 =A0 =A0 =A0 rmmod dummy
>> =A0 =A0 =A0 =A0 if [ $? -ne 0 ]; then
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "QUIT IN RMMOD $i"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit 1;
>> =A0 =A0 =A0 =A0 fi
>> =A0 =A0 =A0 =A0 i=3D`expr $i + 1`
>> =A0 =A0 =A0 =A0 slee
>> done
>>
>>
>>
>> after around 38 iterations:
>> <4>vmap allocation failed: use vmalloc=3D<size> to increase size.
>> vmap allocation failed: use vmalloc=3D<size> to increase size.
>> <3>Allocation failed idx=3D0
>> Allocation failed idx=3D0
>>
>> However cat /proc/meminfo after this error is:
>> cat /proc/meminfo
>> MemTotal: =A0 =A0 =A0 =A0 =A061920 kB
>> MemFree: =A0 =A0 =A0 =A0 =A0 56900 kB
>> Buffers: =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 kB
>> Cached: =A0 =A0 =A0 =A0 =A0 =A0 2592 kB
>> SwapCached: =A0 =A0 =A0 =A0 =A0 =A00 kB
>> Active: =A0 =A0 =A0 =A0 =A0 =A0 1920 kB
>> Inactive: =A0 =A0 =A0 =A0 =A0 1252 kB
>> Active(anon): =A0 =A0 =A0 =A0580 kB
>> Inactive(anon): =A0 =A0 =A0 =A00 kB
>> Active(file): =A0 =A0 =A0 1340 kB
>> Inactive(file): =A0 =A0 1252 kB
>> Unevictable: =A0 =A0 =A0 =A0 =A0 0 kB
>> Mlocked: =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 kB
>> SwapTotal: =A0 =A0 =A0 =A0 =A0 =A0 0 kB
>> SwapFree: =A0 =A0 =A0 =A0 =A0 =A0 =A00 kB
>> Dirty: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 kB
>> Writeback: =A0 =A0 =A0 =A0 =A0 =A0 0 kB
>> AnonPages: =A0 =A0 =A0 =A0 =A0 616 kB
>> Mapped: =A0 =A0 =A0 =A0 =A0 =A0 =A0688 kB
>> Slab: =A0 =A0 =A0 =A0 =A0 =A0 =A0 1296 kB
>> SReclaimable: =A0 =A0 =A0 =A0480 kB
>> SUnreclaim: =A0 =A0 =A0 =A0 =A0816 kB
>> PageTables: =A0 =A0 =A0 =A0 =A0 96 kB
>> NFS_Unstable: =A0 =A0 =A0 =A0 =A00 kB
>> Bounce: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 kB
>> WritebackTmp: =A0 =A0 =A0 =A0 =A00 kB
>> CommitLimit: =A0 =A0 =A0 30960 kB
>> Committed_AS: =A0 =A0 =A0 2932 kB
>> VmallocTotal: =A0 =A0 319488 kB
>> VmallocUsed: =A0 =A0 =A0 =A0 =A0 8 kB
>> VmallocChunk: =A0 =A0 319448 kB
>>
>>
>> We seem to have more than enough vmalloc space according to this.. a=
m I right in thinking this is a kernel vmalloc handling issue?
>>
>> Regards,
>> Nishanth Menon
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
