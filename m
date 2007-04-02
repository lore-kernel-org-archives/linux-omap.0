From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Please subscribe me into this GROUP
Date: Sun, 1 Apr 2007 23:19:35 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4794A6BF@dlee13.ent.ti.com>
References: <B9F9AF34C9B5F743996B82EF46DF07CD053B6E51@BLR-EC-MBX04.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <B9F9AF34C9B5F743996B82EF46DF07CD053B6E51@BLR-EC-MBX04.wipro.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: varla.prasad@wipro.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Use the below link to register. And please do a google before sending
such mails to list.

http://linux.omap.com/mailman/listinfo/linux-omap-open-source

Regards,
Khasim

>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-
>open-source-bounces@linux.omap.com] On Behalf Of varla.prasad@wipro.com
>Sent: Sunday, April 01, 2007 10:49 PM
>To: linux-omap-open-source@linux.omap.com
>Subject: Please subscribe me into this GROUP
>
>Please subscribe me into this GROUP
>
>
>Have a Great Day
>
>Prasad.V
>varla.prasad@wipro.com
>VOIP: 8082625
>Tel:+91-80-30299686 xtn:19686
>Cell: +91-9945183686
>
>-----Original Message-----
>From:
>linux-omap-open-source-bounces+varla.prasad=3Dwipro.com@linux.omap.com
>[mailto:linux-omap-open-source-bounces+varla.prasad=3Dwipro.com@linux.om=
a
p
>.com] On Behalf Of linux-omap-open-source-request@linux.omap.com
>Sent: Sunday, April 01, 2007 10:30 PM
>To: linux-omap-open-source@linux.omap.com
>Subject: Linux-omap-open-source Digest, Vol 36, Issue 1
>
>Send Linux-omap-open-source mailing list submissions to
>	linux-omap-open-source@linux.omap.com
>
>To subscribe or unsubscribe via the World Wide Web, visit
>	http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>or, via email, send a message with subject or body 'help' to
>	linux-omap-open-source-request@linux.omap.com
>
>You can reach the person managing the list at
>	linux-omap-open-source-owner@linux.omap.com
>
>When replying, please edit your Subject line so it is more specific
than
>"Re: Contents of Linux-omap-open-source digest..."
>
>
>Today's Topics:
>
>   1. Re: [PATCH] SD working on OMAP platforms (Carlos Aguiar)
>   2. MMU FWK changes break OMAP1 compilation (Dirk Behme)
>   3. Pending March patches (Dirk Behme)
>
>
>----------------------------------------------------------------------
>
>Message: 1
>Date: Sat, 31 Mar 2007 18:07:40 -0400
>From: Carlos Aguiar <carlos.aguiar@indt.org.br>
>Subject: Re: [PATCH] SD working on OMAP platforms
>To: ext Pierre Ossman <drzeus-list@drzeus.cx>
>Cc: omap-linux <linux-omap-open-source@linux.omap.com>,	ext
Philip
>	Langdale <philipl@overt.org>
>Message-ID: <460EDBAC.9050301@indt.org.br>
>Content-Type: text/plain; charset=3D"iso-8859-1"
>
>ext Pierre Ossman wrote:
>> Carlos Aguiar wrote:
>>
>>> On CMD3, response type is R6 to SD cards and R1 to MMC cards.
>>> This fix ignores the buggy SD handling on CMD3.
>>>
>>> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
>>>
>>>
>>>
>>
>> NAK. Includes opcodes.
>>
>> I assume 0x4000 is that darn CERR, so have the if-statement test just
>> (status =3D=3D 0x4000).
>>
>> Rgds
>>
>>
>Ok,
>
>Now, without opcodes and if-statement test just (status =3D=3D 0x4000).
>
>BR,
>
>Carlos.
>
>--
>Carlos Eduardo
>Nokia Institute of Technology - INdT
>Open Source Mobile Research Center - OSMRC
>Phone: +55 92 2126-1079
>Mobile: +55 92 8127-1797
>E-mail: carlos.aguiar@indt.org.br
>
>-------------- next part --------------
>On CMD3, response type is R6 to SD cards and R1 to MMC cards.
>This fix ignores the buggy SD handling on CMD3.
>
>Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
>
>Index: linux-omap/drivers/mmc/omap.c
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>--- linux-omap.orig/drivers/mmc/omap.c	2007-03-30 09:39:08.000000000
>-0400
>+++ linux-omap/drivers/mmc/omap.c	2007-03-31 18:03:49.000000000
>-0400
>@@ -462,6 +462,12 @@ static irqreturn_t mmc_omap_irq(int irq,
> 		mmc_omap_report_irq(status);
> 		printk("\n");
> #endif
>+		if (status =3D=3D 0x4000) {
>+			dev_dbg(mmc_dev(host->mmc),
>+				"buggy SD handling, ignoring it\n");
>+			status =3D 0x0001;
>+		}
>+
> 		if (host->total_bytes_left) {
> 			if ((status & OMAP_MMC_STAT_A_FULL) ||
> 			    (status & OMAP_MMC_STAT_END_OF_DATA))
>
>------------------------------
>
>Message: 2
>Date: Sun, 01 Apr 2007 11:31:11 +0200
>From: Dirk Behme <dirk.behme@googlemail.com>
>Subject: MMU FWK changes break OMAP1 compilation
>To: Linux OMAP ML <linux-omap-open-source@linux.omap.com>,
>	Hiroshi.DOYU@nokia.com
>Message-ID: <460F7BDF.4060105@googlemail.com>
>Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed
>
>
>Recent MMU FWK changes [1] and [2] break at least OMAP1 compilation.
>
>Issues:
>
>- omap1_mmu_interrupt() in arch/arm/mach-omap1/mmu.c uses various
>MMU_xxx macros, but in arch/arm/mach-omap1/mmu.h they are called
>OMAP_MMU_xxx.
>
>- omap1_mmu_interrupt() uses MK32 macro, which is defined in
>./plat-omap/dsp/dsp.h, which isn't included.
>
>- omap1_mmu_interrupt() still uses MMUFAULT_MASK, which is removed from
>arch/arm/plat-omap/dsp/mmu.h by [2]. So [1] introduces MMUFAULT_MASK to
>mach-omap1/mmu.c while [2] removes it from dsp/mmu.h.
>
>- dsp_mmu_itack() in arch/arm/plat-omap/dsp/mmu.h still uses
>dsp_fault_adr which is removed in same file by [2].
>
>- Some compiler warnings:
>
>arch/arm/plat-omap/dsp/dsp_mem.c: In function 'dsp_mem_ioctl':
>arch/arm/plat-omap/dsp/dsp_mem.c:348: warning: unused variable 'ret'
>arch/arm/plat-omap/dsp/dsp_mem.c:347: warning: unused variable 'dspadr'
>arch/arm/plat-omap/dsp/mmu.h:88: warning: 'dspadr' is used
uninitialized
>in this function
>
>Anybody with a fix for these?
>
>Cheers
>
>Dirk
>
>[1]
><http://source.mvista.com/git/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dcomm=
it;
h
>=3D6b13d95d4979ca9df91420fb5ab18fbfee3f9386>
>
>[2]
><http://source.mvista.com/git/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dcomm=
it;
h
>=3D68a575f924dbe0326ee1e4178f854cfed7933492>
>
>
>------------------------------
>
>Message: 3
>Date: Sun, 01 Apr 2007 17:41:17 +0200
>From: Dirk Behme <dirk.behme@googlemail.com>
>Subject: Pending March patches
>To: linux-omap-open-source@linux.omap.com
>Message-ID: <460FD29D.7070707@googlemail.com>
>Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed
>
>
>Please find below my list of pending OMAP patches for March
>2007. As ususal, if you think anything is wrong, missing or
>already applied, please correct.
>
>
>Pending OMAP patches March 2007
>-------------------------------
>
>1. [PATCH] Display Controller Library for OMAP2420/2430/3430
>platforms.
>http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/00918
2
>.html
>
>2. [PATCH] add ssi/Kconfig to arch/arm/Kconfig
>http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/00922
0
>.html
>
>2. [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
>http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/00929
0
>.html
>
>3. [PATCH 1/1] OMAP: Add TWL support for omap mmu framework
>http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/00931
3
>.html
>
>4. [PATCH 1/2] ARM:OMAP: Integrated blk request queues for
>mbox fwk
>http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/00935
5
>.html
>
>5. [PATCH 2/2] ARM: OMAP: Restructuring mailbox blk queues
>http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/00935
6
>.html
>
>6. [PATCH 1/2] OMAP: DSP: N800: remaining updates for dsp parts
>http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/00935
9
>.html
>
>7. [PATCH 2/2] OMAP: MBOX: N800: remaining updates for
>mailbox parts
>http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/00935
8
>.html
>
>8. [PATCH] ARM: OMAP: Fix warnings in devices.c for 2430sdp
>config
>http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/00938
0
>.html
>
>9. [RFC/PATCH] ARM: OMAP: OneNAND support for 2430SDP
>http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/00938
6
>.html
>
>
>"Dave, can you have a look" patches ;)
>--------------------------------------
>
>1. [review] OMAP2 USB device DMA support
>http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/00
8
>342.html
>
>2. [PATCH] MUSB HDRC: RMMOD fixing
>http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008
8
>53.html
>
>
>
>Best regards
>
>Dirk
>
>
>
>------------------------------
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>End of Linux-omap-open-source Digest, Vol 36, Issue 1
>*****************************************************
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
