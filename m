From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: SDP support seems broken in LO
Date: Tue, 18 Aug 2009 18:40:37 +0530
Message-ID: <ce9ab5790908180610l20ebdb5bw458616c409ddba94@mail.gmail.com>
References: <ce9ab5790908180519t644723cbw6876901066f1f213@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02B9DCC60E@dbde02.ent.ti.com>
	<ce9ab5790908180558m184fd48euece1093575160c0c@mail.gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0309BD5C0A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:37931 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbZHRNK5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 09:10:57 -0400
Received: by qyk34 with SMTP id 34so2691083qyk.33
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2009 06:10:58 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309BD5C0A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 18, 2009 at 6:30 PM, Gadiyar, Anand<gadiyar@ti.com> wrote:
>> >> LO seems broken on OMAP3430 SDP platform. I compile latest kernel=
 with
>> >> 'omap_3430sdp_defconfig' config options.
>> >>
>> >> Booting hangs after kernel uncompressed and last message which ap=
pears
>> >> is 'booting the kernel'
>> >>
>> >>
>> >> Thanks and regards,
>> >> vimal
>> >>
>> >> See below log:
>> >>
>> >> ## Booting image at 80000000 ...
>> >> =A0 =A0Image Name: =A0 Linux-2.6.31-rc5-omap1-05896-ge0
>> >> =A0 =A0Image Type: =A0 ARM Linux Kernel Image (uncompressed)
>> >> =A0 =A0Data Size: =A0 =A02520992 Bytes =3D =A02.4 MB
>> >> =A0 =A0Load Address: 80008000
>> >> =A0 =A0Entry Point: =A080008000
>> >> =A0 =A0Verifying Checksum ... OK
>> >> OK
>> >>
>> >> Starting kernel ...
>> >>
>> >> Uncompressing Linux..............................................=
=2E......................
>> >>
>> ..............................................................
>> ............
>> >> ..................
>> >> done, booting the kernel.
>> > Mainly because of frame-buffer and musb. You can try disabling the=
se two and see if it boots.
>>
>> I disabled frame-buffer and usb support fully:
>> # CONFIG_FB is not set
>> # CONFIG_USB_SUPPORT is not set
>>
>> I still get same message.
>>
>> -vimal
>>
>
>
> Do you have CONFIG_DEBUG_LL enabled? If so, could you enable that ple=
ase to
> see if we have a crash somewhere?
>

Here is the log after enabling 'CONFIG_DEBUG_LL':

## Booting image at 80000000 ...
   Image Name:   Linux-2.6.31-rc5-omap1-05896-ge0
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2303384 Bytes =3D  2.2 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux....................................................=
=2E....................................................................=
=2E..........................
done, booting the kernel.
<5>Linux version 2.6.31-rc5-omap1-05896-ge087f6f-dirty
(x0094262@omaplinux2) (gcc version 4.2.1 (CodeSourcery Sourcery G++
Lite 2007q3-51)) #7 Tue Aug 18 18:38:47 IST 2009
CPU: ARMv7 Processor [411fc081] revision 1 (ARMv7), cr=3D10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3430 3430SDP board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>free_area_init_node: node 0, pgdat c048c700, node_mem_map c04da000
<7>  Normal zone: 256 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 32512 pages, LIFO batch:7
<6>OMAP3430 ES2.0
<6>SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32=
512
<5>Kernel command line: mem=3D128M console=3DttyS0,115200n8 noinitrd
root=3D/dev/nfs rw
nfsroot=3D10.24.246.118:/home1/vimal_fs/newfs,nolock,tcp,rsize=3D1024,w=
size=3D1024
ip=3Ddhcp nohz=3Doff
PID hash table entries: 512 (order: 9, 2048 bytes)
<6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 128MB =3D 128MB total
<5>Memory: 124828KB available (4132K code, 529K data, 128K init, 0K hig=
hmem)
<6>SLUB: Genslabs=3D11, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=
=3D1, Nodes=3D1
<6>NR_IRQS:402
<6>Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
<6>Reprogramming SDRC clock to 332000000 Hz
<6>GPMC revision 5.0
<6>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<6>OMAP34xx GPIO hardware version 2.5
<6>OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
<6>Calibrating delay loop...


-vimal

> - Anand
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
