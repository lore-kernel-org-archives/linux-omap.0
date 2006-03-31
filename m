From: Amit kumar sharma <amitsharma91@yahoo.com>
Subject: Re: Linux-omap-open-source Digest, Vol 23, Issue 61
Date: Fri, 31 Mar 2006 08:44:48 +0100 (BST)
Message-ID: <20060331074449.46962.qmail@web8404.mail.in.yahoo.com>
References: <20060329030544.6A1D28062C@linux.omap.com>
Reply-To: amitsharma91@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060329030544.6A1D28062C@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All
  =20
  I am using montavista linux on omap 5912 ,i am using memcpy  for data t=
ransfer.i have one question if during data transfer through memcpy extern=
al interrupt  or any  other higher priority DMA channel interrupt comes ,=
How driver can manage data corruption ,My device connected in memcpy proc=
essing is configured with 16 bit bus and other device is 32 bit.
  =20
  thanks
  Amit

linux-omap-open-source-request@linux.omap.com wrote:
  Send Linux-omap-open-source mailing list submissions to
linux-omap-open-source@linux.omap.com

To subscribe or unsubscribe via the World Wide Web, visit
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
or, via email, send a message with subject or body 'help' to
linux-omap-open-source-request@linux.omap.com

You can reach the person managing the list at
linux-omap-open-source-owner@linux.omap.com

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Linux-omap-open-source digest..."


Today's Topics:

1. Re: [PATCH] Fix USB host on 1510/5910? (Jonathan McDowell)
2. palmte lcd warnings (Komal Shah)
3. Re: [PATCH] fix MMC response types (Carlos Aguiar)
4. Re: palmte lcd warnings (andrzej zaborowski)
5. About dct4x4 transform on 55x dsp,who can provide a good way?
(=3D?gb2312?B?zfWxprHy?=3D)
6. Stack pointer register accesing problem with monta- vista
linux 2.4 on OMAP 730 (chandrashekhar singh)


----------------------------------------------------------------------

Message: 1
Date: Tue, 28 Mar 2006 20:05:19 +0100
From: Jonathan McDowell=20
Subject: Re: [PATCH] Fix USB host on 1510/5910?
To: linux-omap-open-source@linux.omap.com
Message-ID: <20060328190519.GS26949@earth.li>
Content-Type: text/plain; charset=3Dus-ascii

On Tue, Mar 28, 2006 at 05:44:03PM +0100, Jonathan McDowell wrote:
> I'm not quite sure if this is necessary or not. I've found I need it to
> get USB working correctly on the Amstrad E3, which is an OMAP5910. From
> my reading of ohci-omap.c usb_dc_ck is requested for the 1510 as well,
> and if it can't be obtained an error is returned.
>=20
> Does anyone have USB working correctly on a 1510/5910 with latest git
> without something like the below?

Scratch that for the moment. I'm now getting:

ohci ohci: Unlink after no-IRQ? Controller is probably using the wrong IR=
Q.

even with this patch, whereas it worked fine for 2.6.15-omap1.

I'd still like to know if anyone's having success with a 1510/5910 and
latest git though, as I've had someone else tell me they were seeing
similar problems on a platform that wasn't the E3 (unfortunately it was
on IRC and I don't have their details. :( ).

J.

--=20
[ noodles is almost a national pastime in japan ]
[ http://www.blackcatnetworks.co.uk/ - IPv6 enabled ADSL/dialup/colo ]


------------------------------

Message: 2
Date: Tue, 28 Mar 2006 12:29:06 -0800 (PST)
From: Komal Shah=20
Subject: palmte lcd warnings
To: linux-omap-open-source@linux.omap.com
Message-ID: <20060328202906.93477.qmail@web32909.mail.mud.yahoo.com>
Content-Type: text/plain; charset=3Diso-8859-1

Build warning from lcd panel source - latest omap-git tree.

...
-c -o drivers/video/omap/lcd_palmte.o drivers/video/omap/lcd_palmte.c
drivers/video/omap/lcd_palmte.c:86: warning: initialization from
incompatible pointer type
drivers/video/omap/lcd_palmte.c:87: warning: initialization from
incompatible pointer type
drivers/video/omap/lcd_palmte.c:88: warning: initialization from
incompatible pointer type
drivers/video/omap/lcd_palmte.c:89: warning: initialization from
incompatible pointer type
drivers/video/omap/lcd_palmte.c:90: warning: initialization from
incompatible pointer type
....

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam? Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


------------------------------

Message: 3
Date: Tue, 28 Mar 2006 16:59:18 -0400
From: Carlos Aguiar=20
Subject: Re: [PATCH] fix MMC response types
To: balrogg@gmail.com
Cc: omap-linux=20

Message-ID: <4429A3A6.5000503@indt.org.br>
Content-Type: text/plain; charset=3D"utf-8"

ext andrzej zaborowski wrote:

>On 27/03/06, Carlos Aguiar wrote:
>=20
>
>>ext andrzej zaborowski wrote:
>>
>>=20
>>
>>>Previously the MMC/SD protocol layer didn't provide command and
>>>response types to mmc_omap_start_command(). In 2.6.16 it does and the
>>>hack that tries to find the correct command/response types based on
>>>flags is no longer needed.
>>>This matters particularly for response types because for command types
>>>this hack worked fine, while it failed to give correct response type
>>>for some SD commands such as CMD3 (in most cases this caused no big
>>>problems because the size of the response matched).
>>>Regards,
>>>Andrzej
>>>--
>>>balrog 2oo6
>>>
>>>Dear Outlook users: Please remove me from your address books
>>>http://www.newsforge.com/article.pl?sid=3D03/08/21/143258
>>>
>>>
>>>----------------------------------------------------------------------=
--
>>>
>>>_______________________________________________
>>>Linux-omap-open-source mailing list
>>>Linux-omap-open-source@linux.omap.com
>>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>>
>>>
>>>=20
>>>
>>Hi Andrzej and folks,
>>
>>Attached to this mail follow my propose of fixing MMC responde types in
>>mmc_omap_start_command().
>>
>>This is based on the patches of the thread '[RFC] mmc: add OMAP driver'
>>that I sent to LKML mailing-list in order to have integrated the MMC
>>OMAP driver on the mainline kernel.
>>
>>Comments and suggestions are welcome.
>>=20
>>
>It looks fine except you forgot about the response type 6. With the
>current version of mmc_omap_start_command() the hack assumes response
>type 1 in place of 6 which merely causes the MMC/SD host controller to
>misinterpret the status flags in the response from the card, but the
>size of the response matches. However with your patch it would assume
>no response at all which would most probably cause breakage.
>
>=20
>
>>BR,
>>
>>Carlos.
>>
>>--
>>Carlos Eduardo
>>Software Engineer
>>Nokia Institute of Technology - INdT
>>Embedded Linux Laboratory - 10LE
>>Phone: +55 92 2126-1079
>>Mobile: +55 92 8127-1797
>>E-mail: carlos.aguiar@indt.org.br
>>
>>
>>
>>
>>=20
>>
>
>Regards,
>Andrew
>--
>balrog 2oo6
>
>Dear Outlook users: Please remove me from your address books
>http://www.newsforge.com/article.pl?sid=3D03/08/21/143258
>=20
>
Hi Andrew and folks,

The response type 6 was included. Thanks for your observation.

BR,

Carlos.

--=20
Carlos Eduardo
Software Engineer
Nokia Institute of Technology - INdT
Embedded Linux Laboratory - 10LE
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br

-------------- next part --------------
A non-text attachment was scrubbed...
Name: mmc_omap_rsp.patch
Type: text/x-patch
Size: 2159 bytes
Desc: not available
Url : http://linux.omap.com/pipermail/linux-omap-open-source/attachments/=
20060328/27111ece/mmc_omap_rsp-0001.bin

------------------------------

Message: 4
Date: Wed, 29 Mar 2006 01:16:09 +0200
From: "andrzej zaborowski"=20
Subject: Re: palmte lcd warnings
To: "Komal Shah"=20
Cc: linux-omap-open-source@linux.omap.com
Message-ID:

Content-Type: text/plain; charset=3D"utf-8"

On 28/03/06, Komal Shah wrote:
> Build warning from lcd panel source - latest omap-git tree.
>
> ...
> -c -o drivers/video/omap/lcd_palmte.o drivers/video/omap/lcd_palmte.c
> drivers/video/omap/lcd_palmte.c:86: warning: initialization from
> incompatible pointer type
> drivers/video/omap/lcd_palmte.c:87: warning: initialization from
> incompatible pointer type
> drivers/video/omap/lcd_palmte.c:88: warning: initialization from
> incompatible pointer type
> drivers/video/omap/lcd_palmte.c:89: warning: initialization from
> incompatible pointer type
> drivers/video/omap/lcd_palmte.c:90: warning: initialization from
> incompatible pointer type
> ....
>
> ---Komal Shah
> http://komalshah.blogspot.com/
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam? Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>

Please find the fix attached. Tested to build and to work.
Regards,
--
balrog 2oo6

Dear Outlook users: Please remove me from your address books
http://www.newsforge.com/article.pl?sid=3D03/08/21/143258
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lcd_palmte-warnings.patch
Type: application/octet-stream
Size: 1196 bytes
Desc: not available
Url : http://linux.omap.com/pipermail/linux-omap-open-source/attachments/=
20060329/5394a5bf/lcd_palmte-warnings-0001.obj

------------------------------

Message: 5
Date: Wed, 29 Mar 2006 10:19:49 +0800
From: =3D?gb2312?B?zfWxprHy?=3D=20
Subject: About dct4x4 transform on 55x dsp,who can provide a good way?
To:=20

Message-ID: <001301c652d7$4235b4a0$9d0aa8c0@yfwangbaobin>
Content-Type: text/plain; charset=3D"gb2312"

hi:
i want to get dct4x4 transform in 55x dsp. And I get some useful informat=
ion from the document " TMS320C55x Hardware Extensions for Image/Video Ap=
plications Programmer=A1=AFs Reference".------you can get it from interne=
t easily.
the document explain how to get dct8x8 transform result step by step.i ha=
ve tested it !right.
In page 2-5 , it tell me some information about how to get dct4x4 tranfor=
me result.but it is
so obscurity that i can't understand how to use it!!
who can give me hands! thanks.
b.w.b=20

------------------------------

Message: 6
Date: Wed, 29 Mar 2006 12:04:02 +0900
From: "chandrashekhar singh"=20
Subject: Stack pointer register accesing problem with monta- vista
linux 2.4 on OMAP 730
To:=20

Message-ID: <001e01c652dd$a25cab30$5811a80a@cpsingh>
Content-Type: text/plain; format=3Dflowed; charset=3D"iso-8859-1";
reply-type=3Doriginal

Dear all,

I'm facing a very strange problem with Monta-Vista linux 2.4 which is run=
ning on
OMAP 730.

I have some assembler code which uses stack pointer register to load or s=
tore
the intermediate value of variables. The source code work well on linux 2=
.6 running
on OMAP 2420 but when I execute it on Monta-Vista linux 2.4 running on OM=
AP 730
it gives 'segmentation fault'.

I've noticed that problem lies in stack pointer register as when i tries =
to access stack pointer=20
register directaly it gives segmentation fault. Following snippet does no=
t work on Monta-vista
linux 2.4 running on OMAP 730 but work well on Linux 2.6 running on OMAP2=
420.

.set FRAMEPROC_ASM_STACK, 48

FRAMEPROC_DUMMY:
stmdb sp!, {r4-r11, lr}
sub sp, sp, #FRAMEPROC_ASM_STACK
mov r5, #5
str r5, [sp, #12]
add sp, sp, #FRAMEPROC_ASM_STACK
ldmia sp!, {r4-r11, pc}

The have modified the assembler code as follows and tested it on both tar=
get then it works well=20
on both target. I'm not getting why ?

.set FRAMEPROC_ASM_STACK, 48

FRAMEPROC_DUMMY:
stmdb sp!, {r4-r11, lr}
sub sp, sp, #FRAMEPROC_ASM_STACK

mov r14, sp
mov r5, #5
str r5, [r14,#12]
@str r5, [sp, #12]
add sp, sp, #FRAMEPROC_ASM_STACK
ldmia sp!, {r4-r11, pc}

Though I've got temporary solution but my assembler source code is=20
quite big and it is very difficult to rewrite it as i dont have free regi=
ster
in actual source to map the stack pointer register to another register.

Can any body put some light as why it happening on Monta-vista linux ???

Thanks in advance
chandrasheskhar
cp_singh@faith.co.jp

----- Original Message -----=20
From:=20

To:=20

Sent: Wednesday, March 29, 2006 3:00 AM
Subject: Linux-omap-open-source Digest, Vol 23, Issue 60


> Send Linux-omap-open-source mailing list submissions to
> linux-omap-open-source@linux.omap.com
>=20
> To subscribe or unsubscribe via the World Wide Web, visi
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> or, via email, send a message with subject or body 'help' to
> linux-omap-open-source-request@linux.omap.com
>=20
> You can reach the person managing the list at
> linux-omap-open-source-owner@linux.omap.com
>=20
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linux-omap-open-source digest..."
>=20
>=20
> Today's Topics:
>=20
> 1. About to tag 2.6.16-omap1 & current patch status (Tony Lindgren)
> 2. RE: U-boot 1.1.4 compilation problem (Giron, Jeremy)
> 3. RE: DSP Gateway for OMAP5912 (Kiyotaka.Takahashi@nokia.com)
> 4. [PATCH] Fix USB host on 1510/5910? (Jonathan McDowell)
>=20
>=20
> ----------------------------------------------------------------------
>=20
> Message: 1
> Date: Tue, 28 Mar 2006 07:35:02 -0800
> From: Tony Lindgren=20
> Subject: About to tag 2.6.16-omap1 & current patch status
> To: linux-omap-open-source@linux.omap.com
> Message-ID: <20060328153500.GF28751@atomide.com>
> Content-Type: text/plain; charset=3Dus-ascii
>=20
> Hi all,
>=20
> We're about to ready to tag 2.6.16-omap1. Let's do some testing
> and try to get few issues fixed. Currently there's at least the MMC
> issue with I2C powered sockets that we should fix before tagging
> 2.6.16-omap1.
>=20
> Please report any issues that should be fixed for 2.6.16-omap1 to this
> thread.
>=20
> Also following is a summary of the currently applied and pending patche=
s.=20
>=20
> Applied patches
>=20
> Komal Shah [PATCH] OMAP: KEYPAD: sem2mutex conversion
> Komal Shah [PATCH] OMAP: Menelaus: sem2mutex conversion
> Komal Shah [PATCH] OMAP: FB: sem2mutex conversion
> Komal Shah [PATCH] OMAP: retu-rtc: sem2mutex conversion
> Komal Shah [PATCH] retu-user: sem2mutex conversion
> Komal Shah [PATCH] OMAP: tahvo usb: sem2mutex conversion
> Komal Shah [PATCH] OMAP: tahvo_user: sem2mutex conversion
> Komal Shah [PATCH] OMAP: OSS: sem2mutex conversion
> Komal Shah [PATCH] OMAP2: Fix H4 keypad
> Komal Shah [PATCH] OMAP1: camera core : Use platform driver structure
> Komal Shah [PATCH] Fix OV9640 sensor and add h4 sensor power functions=20
> Jonathan McDowell [PATCH] Add support for Amstrad Delta (E3) Videophone
>=20
>=20
> Pending patches for post 2.6.16-omap1
>=20
> Komal Shah [PATCH] OMAP2 MCSPI Use resources
> Hiroshi DOYU [patch 1/5] MMC BUGFIX TRIVIAL STUFFS
> Richard Woodruff [PATCH] : Fix annoying 'too much work for irq72' seria=
l
> Richard Woodruff [PATCH] OMAP2: timer+irq fix up
> David Cohen [PATCH] omap24xxcamera
> Carlos Aguiar [PATCH] fix MMC response types
> Komal Shah [PATCH] OMAP2: ov9640 updates for H4
> Komal Shah [PATCH] omap24xx camera cleanup
> Komal Shah [PATCH] CBUS: various cleanups
> Komal Shah [PATCH] OMAP: MMC: Move set_power to platform data
> Komal Shah [PATCH] OMAP: FB: Use blocking notifier apis
>=20
> Regards,
>=20
> Tony
>=20
>=20
> ------------------------------
>=20
> Message: 2
> Date: Tue, 28 Mar 2006 08:47:31 -0700
> From: "Giron, Jeremy"=20
> Subject: RE: U-boot 1.1.4 compilation problem
> To: "Hiroki Kaminaga"=20
> Cc: linux-omap-open-source@linux.omap.com
> Message-ID:
>=20
> Content-Type: text/plain; charset=3Dus-ascii
>=20
> Hiroki,
> Yes, you are correct. I'm not sure how it worked without it.
>=20
> It should mimic omap1510imm.h:
>=20
> #define PHYS_FLASH_1 0x00000000 /* Flash Bank #1 */
>=20
> #define CFG_FLASH_BASE PHYS_FLASH_1
> <...>
> #define CFG_MAX_FLASH_BANKS 2 /* max number of memory banks */
> #define PHYS_FLASH_SIZE 0x01000000 /* 16MB */
> #define PHYS_FLASH_SECT_SIZE (128*1024) /* Size of a sector
> (128kB) */
> #define CFG_MAX_FLASH_SECT (128) /* max number of sectors on one
> chip */
> #define CFG_ENV_ADDR (CFG_FLASH_BASE + PHYS_FLASH_SECT_SIZE)
> #define CFG_MONITOR_BASE CFG_FLASH_BASE /* Monitor at beginning
> of flash */
> #define CFG_MONITOR_LEN PHYS_FLASH_SECT_SIZE /* Reserve 1
> sector */
> #define CFG_FLASH_BANKS_LIST { CFG_FLASH_BASE, CFG_FLASH_BASE +
> PHYS_FLASH_SIZE }
>=20
>=20
> Result:
> OMAP5912 OSK # flinfo
>=20
>=20
>=20
> Bank # 1: CFI conformant FLASH (16 x 16) Size: 16 MB in 128 Sectors
>=20
> Erase timeout 16384 ms, write timeout 2 ms, buffer write timeout 2048
> ms, buffe
> r size 32
>=20
> Sector Start Addresses:
>=20
> 00000000 (RO) 00020000 (RO) 00040000 00060000 00080000
>=20
> 000A0000 000C0000 000E0000 00100000 00120000
>=20
> <...>
> 00F00000 00F20000 00F40000 00F60000 00F80000
>=20
> 00FA0000 00FC0000 00FE0000
>=20
>=20
>=20
> Bank # 2: CFI conformant FLASH (16 x 16) Size: 16 MB in 128 Sectors
>=20
> Erase timeout 16384 ms, write timeout 2 ms, buffer write timeout 2048
> ms, buffe
> r size 32
>=20
> Sector Start Addresses:
>=20
> 01000000 01020000 01040000 01060000 01080000
>=20
> 010A0000 010C0000 010E0000 01100000 01120000
>=20
> <...>=20
> 01F00000 01F20000 01F40000 01F60000 01F80000
>=20
> 01FA0000 01FC0000 01FE0000=20
>=20
> Best regards,
> Jeremy
>=20
> -----Original Message-----
> From: Hiroki Kaminaga [mailto:kaminaga@sm.sony.co.jp]=20
> Sent: Sunday, March 26, 2006 11:48 PM
> To: Giron, Jeremy
> Cc: chief@verat.net; linux-omap-open-source@linux.omap.com;
> kaminaga@sm.sony.co.jp
> Subject: Re: U-boot 1.1.4 compilation problem
>=20
> Hi,
>=20
> sorry for late reply,
>=20
>> It is also necessary to change CFG_MAX_FLASH_BANKS to 2 (from 1).
>> Otherwise the CFI driver will only detect a single 16MB bank, rather=20
>> than the full 16MBx2 =3D 32MB.
>=20
> Umm, that's right. Also if you change to 2, you also need to set
> CFG_FLASH_BANKS_LIST too?
>=20
>=20
> Best Regards,
>=20
> (Hiroki Kaminaga)
> t
> --
>=20
>=20
>=20
>=20
> ------------------------------
>=20
> Message: 3
> Date: Wed, 29 Mar 2006 01:32:19 +0900
> From:=20
> Subject: RE: DSP Gateway for OMAP5912
> To: ,=20

> Message-ID:
> <7AF192DA69C59243838FF62851F64F5502107672@toebe101.NOE.Nokia.com>
> Content-Type: text/plain; charset=3D"US-ASCII"
>=20
> Hi,
>=20
> I'm using Linux 2.6.12 + OMAP patch from www.muru.com with DSP Gateway
> 3.3 on OSK5912. But I have not seen such problem so far... Did you try
> the other sample program (e.g. task_test?, hellotimer, etc.)?=20
>=20
> BR,
> Kiyotaka
>=20
> -----Original Message-----
> From:
> linux-omap-open-source-bounces+kiyotaka.takahashi=3Dnokia.com@linux.oma=
p.c
> om
> [mailto:linux-omap-open-source-bounces+kiyotaka.takahashi=3Dnokia.com@l=
inu
> x.omap.com] On Behalf Of ext naga rajan
> Sent: Tuesday, March 28, 2006 7:37 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: DSP Gateway for OMAP5912
>=20
> Hi all,
>=20
>=20
> I like to proceed with DSP gateway for DSP applications
> development. I like to know the exact kernel, DSP gateway version and
> the
> exact patches for kernel 2.6 series and for DSP gateway.I tried with
> kernel
> 2.6.12 and DSP gateway 3.3. While executing the application, I m gettin=
g
> the
> following error
>=20
>=20
> # dspctl start demo_console.out
>=20
> loading demo_console.out...
>=20
> dspgw_task : adr =3D 0x00c440, size=3D 36
>=20
> dspgw_version : adr =3D 0x000000, size=3D 8 ... ignored.
>=20
> Unable to handle kernel paging request at virtual address e0010000
>=20
> pgd =3D c1d30000
>=20
> [e0010000] *pgd=3D00000000
>=20
> Internal error: Oops: 805 [#1]
>=20
> Modules linked in:
>=20
> CPU: 0
>=20
> PC is at .cfu_0fupi+0x10/0x50
>=20
> LR is at intmem_write+0x8c/0xdc
>=20
> pc : [] lr : [] Not tainted
>=20
> sp : c1cf7ed8 ip : 00000000 fp : c1cf7f1c
>=20
> r10: e0010000 r9 : c024c6dc r8 : c1cf7f74
>=20
> r7 : 00000008 r6 : 00000008 r5 : 00000008 r4 : be913d5c
>=20
> r3 : 00000000 r2 : 00000004 r1 : be913d60 r0 : e0010000
>=20
> Flags: nzCv IRQs on FIQs on Mode SVC_32 Segment user
>=20
> Control: 5317F Table: 11D30000 DAC: 00000015
>=20
> Process dspctl (pid: 723, stack limit =3D 0xc1cf6194)
>=20
> Stack: (0xc1cf7ed8 to 0xc1cf8000)
>=20
> 7ec0: e0010000
> 00000008
>=20
> 7ee0: be913d5c 00000008 00000008 00000008 c003ca04 00028000 00000000
> c1cf7f74
>=20
> 7f00: be913d5c 00000008 e0010000 c02ea760 c1cf7f48 c1cf7f20 c003cbb0
> c003c988
>=20
> 7f20: 00000008 00000000 be913d5c c02ea760 c1cf6000 00000000 c1cf7f74
> c1cf7f70
>=20
> 7f40: c1cf7f4c c00851fc c003cb40 c02ea784 fffffff7 c02ea760 c1cf7f74
> 00010000
>=20
> 7f60: 4014bafc c1cf7fa4 c1cf7f74 c0085338 c0085148 00010000 00000000
> 00000000
>=20
> 7f80: be913eb4 4001df40 0000c570 00000004 c0022e04 c1cf6000 00000000
> c1cf7fa8
>=20
> 7fa0: c0022c80 c00852f8 be913eb4 c0029c18 00000005 be913d5c 00000008
> be913d5c
>=20
> 7fc0: be913eb4 4001df40 0000c570 00000003 4014e1d0 000089f0 4014bafc
> be913db8
>=20
> 7fe0: 00000000 be913d54 00003f64 400ec830 60000010 00000005 00000000
> 00000000
>=20
> Backtrace:
>=20
> [] (intmem_write+0x0/0xdc) from []
> (dsp_mem_write+0x80/0xb4)
>=20
>=20
>=20
> [] (dsp_mem_write+0x0/0xb4) from []
> (vfs_write+0xc4/0x13c)
>=20
> [] (vfs_write+0x0/0x13c) from []
> (sys_write+0x50/0x74)
>=20
> [] (sys_write+0x0/0x74) from []
> (ret_fast_syscall+0x0/0x2c)
>=20
> r9 =3D C1CF6000 r8 =3D C0022E04 r7 =3D 00000004 r6 =3D 0000C570
>=20
> r5 =3D 4001DF40 r4 =3D BE913EB4
>=20
> Code: e2522004 4282c004 4a000026 e4b13004 (e4803004)
>=20
> Segmentation fault
>=20
>=20
>=20
> I tried with patches mentioned in the
> source forge.net. If you have succeeded this problem,I like to know the
> details such as kernel.DSP gateway and patches you used. Please help me
> in
> this regard.
>=20
>=20
>=20
> Thanks in advance,
>=20
> B.Nagarajan,
>=20
> SANDS.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
>=20
> ------------------------------
>=20
> Message: 4
> Date: Tue, 28 Mar 2006 17:44:03 +0100
> From: Jonathan McDowell=20
> Subject: [PATCH] Fix USB host on 1510/5910?
> To: linux-omap-open-source@linux.omap.com
> Message-ID: <20060328164403.GL26949@earth.li>
> Content-Type: text/plain; charset=3Dus-ascii
>=20
> I'm not quite sure if this is necessary or not. I've found I need it to
> get USB working correctly on the Amstrad E3, which is an OMAP5910. From
> my reading of ohci-omap.c usb_dc_ck is requested for the 1510 as well,
> and if it can't be obtained an error is returned.
>=20
> Does anyone have USB working correctly on a 1510/5910 with latest git
> without something like the below?
>=20
> Signed-Off-By: Jonathan McDowell=20
>=20
> -----
> diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
> index b7c6881..db48d73 100644
> --- a/arch/arm/mach-omap1/clock.h
> +++ b/arch/arm/mach-omap1/clock.h
> @@ -633,7 +633,7 @@ static struct clk usb_dc_ck =3D {
> .name =3D "usb_dc_ck",
> /* Direct from ULPD, no parent */
> .rate =3D 48000000,
> - .flags =3D CLOCK_IN_OMAP16XX | RATE_FIXED,
> + .flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | RATE_FIXED,
> .enable_reg =3D (void __iomem *)SOFT_REQ_REG,
> .enable_bit =3D 4,
> .enable =3D &omap1_clk_enable_generic,
> -----
>=20
> J.
>=20
> --=20
>=20
>=20
> ------------------------------
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
>=20
> End of Linux-omap-open-source Digest, Vol 23, Issue 60
> ******************************************************
>


------------------------------

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source


End of Linux-omap-open-source Digest, Vol 23, Issue 61
******************************************************


			=09
---------------------------------
 Jiyo cricket on Yahoo! India cricket
Yahoo! Messenger Mobile Stay in touch with your buddies all the time.
