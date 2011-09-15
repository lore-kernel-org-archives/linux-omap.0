From: "Stuart Brown" <Stuart.Brown@plexus.com>
Subject: Kernel Halt with framebuffer enabled: omap_mbox_get()
Date: Thu, 15 Sep 2011 13:22:24 +0100
Message-ID: <E7A479031C7DF74280EF342B1F6615F50A448AB8@KELS-MAIL-001.eu.plexus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-outbound-4.plexus.com ([64.215.193.238]:52422 "EHLO
	mail-outbound-4.plexus.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750858Ab1IOMe1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 08:34:27 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Brian Murray <Brian.Murray@plexus.com>

Hi,

We're doing some development with the TI8168 EVM and have followed the =
instructions on the TI wiki for enabling the /dev framebuffer. When we =
do this we end up with a kernel halt during boot (see below for example=
).

Doing some investigation it looks like the for loop in mach-omap2/mailb=
ox.c: omap_mbox_get() might be wrong:

      for(mbox =3D *mboxes; mbox; mbox++)

It looks like this increments the omap_mbox structure rather than the a=
rray? Should the loop actually be something like

       for(mbox =3D *mboxes;  (mbox !=3D NULL); mbox =3D *mboxes++)

I'm hesitant to query this as it looks like this change has been in the=
 kernel for about a year, so perhaps I'm missing something?=20

Stuart

 Kernel Halt

IR RC5 (streamzap) protocol handler initialized
IR LIRC bridge handler initialized
Linux video capture interface: v2.00
OMAP Watchdog Timer Rev 0x00: initial timeout 60 sec
Unable to handle kernel NULL pointer dereference at virtual address 000=
00002
pgd =3D c0004000
[00000002] *pgd=3D00000000
Internal error: Oops: 5 [#1]
last sysfs file:
Modules linked in:
CPU: 0=A0=A0=A0 Not tainted=A0 (2.6.37 #2)
PC is at strcmp+0xc/0x3c
LR is at omap_mbox_get+0x50/0x1f8
pc : [<c0145d70>]=A0=A0=A0 lr : [<c004d704>]=A0=A0=A0 psr: 80000013
sp : c2c25f10=A0 ip : c2c25f20=A0 fp : c2c25f1c
r10: 00000000=A0 r9 : 00000000=A0 r8 : 00000000
r7 : c0322314=A0 r6 : c03a7938=A0 r5 : c03ac6c4=A0 r4 : c0385b8c/mbo/
r3 : 00000064=A0 r2 : 00000076=A0 r1 : c0322314=A0 r0 : 00000002
=46lags: Nzcv=A0 IRQs on=A0 FIQs on=A0 Mode SVC_32=A0 ISA ARM=A0 Segmen=
t kernel
Control: 10c5387d=A0 Table: 80004019=A0 DAC: 00000017
Process swapper (pid: 1, stack limit =3D 0xc2c242e8)
Stack: (0xc2c25f10 to 0xc2c26000)
Stack: (0xc2c25f10 to 0xc2c26000)
5f00:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c2c25f44 c2c25f20 c004d704 c=
0145d70
5f20: c021d3cc c0145d70 c03a78dc c03a7810 c03a78d8 c001e1ac c2c25f6c c2=
c25f48
5f40: c022133c c004d6c0 00000000 00000000 c03ac0c0 c2c24000 c03ac0c0 c0=
056c28
5f60: c2c25f94 c2c25f70 c001e1e8 c0221148 00000000 c2c24000 c03ac0c0 c0=
056c28
5f80: c001e1ac 00000000 c2c25fdc c2c25f98 c002b44c c001e1b8 c2c25fbc 30=
342980
5fa0: 00000036 00000000 c2c25fc4 00000197 c0391998 c0021e34 c0021e84 c0=
056c28
5fc0: 00000013 00000000 00000000 00000000 c2c25ff4 c2c25fe0 c0008998 c0=
02b324
5fe0: 00000000 c00088f8 00000000 c2c25ff8 c0056c28 c0008904 33c53c6c 33=
d53cec
Backtrace:
[<c0145d64>] (strcmp+0x0/0x3c) from [<c004d704>] (omap_mbox_get+0x50/0x=
1f8)
[<c004d6b4>] (omap_mbox_get+0x0/0x1f8) from [<c022133c>] (notify_shm_dr=
v_setup+0x200/0x28c)
r7:c001e1ac r6:c03a78d8 r5:c03a7810 r4:c03a78dc
[<c022113c>] (notify_shm_drv_setup+0x0/0x28c) from [<c001e1e8>] (notify=
_init+0x3c/0x2c8)
r6:c0056c28 r5:c03ac0c0 r4:c2c24000
[<c001e1ac>] (notify_init+0x0/0x2c8) from [<c002b44c>] (do_one_initcall=
+0x134/0x19c)
r8:00000000 r7:c001e1ac r6:c0056c28 r5:c03ac0c0 r4:c2c24000
r3:00000000
[<c002b318>] (do_one_initcall+0x0/0x19c) from [<c0008998>] (kernel_init=
+0xa0/0x14c)
[<c00088f8>] (kernel_init+0x0/0x14c) from [<c0056c28>] (do_exit+0x0/0x6=
44)
r5:c00088f8 r4:00000000
Code: e89da800 e1a0c00d e92dd800 e24cb004 (e4d03001)


end


Plexus Corp.=20
Registered address: Pinnacle Hill, Kelso, Roxburghshire, TD5 8XX.=20
Registered in Scotland: number SC146948.

This email transmission is confidential and intended solely for the per=
son or organisation to whom it is addressed. If you are not the intende=
d recipient, you must not copy, distribute or disseminate the informati=
on, or take any action in reliance of it. Any views expressed in this m=
essage are those of the individual sender, except where the sender spec=
ifically states them to be the views of Plexus Corp. If you have receiv=
ed this message in error, do not open any attachment but please notify =
the sender (above) deleting this message from your system. Please rely =
on your own virus check no responsibility is taken by the sender for an=
y damage rising out of any bug or virus infection.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
