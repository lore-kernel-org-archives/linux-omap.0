From: "chandrashekhar singh" <cp_singh@faith.co.jp>
Subject: Stack pointer register accesing problem with monta- vista linux 2.4
	on OMAP 730
Date: Wed, 29 Mar 2006 12:04:02 +0900
Message-ID: <001e01c652dd$a25cab30$5811a80a@cpsingh>
References: <20060328180002.AF9828062C@linux.omap.com>
Reply-To: chandrashekhar singh <cp_singh@faith.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Dear all,

I'm facing a very strange problem with Monta-Vista linux 2.4 which is running on
OMAP 730.
 
I have some assembler code which uses stack pointer register to load or store
the intermediate value of variables. The source code work well on linux 2.6 running
on OMAP 2420 but when I execute it on Monta-Vista linux 2.4 running on OMAP 730
it gives 'segmentation fault'.

I've noticed that problem lies in stack pointer register as when i tries to access stack pointer 
register directaly it gives segmentation fault. Following snippet does not work on Monta-vista
linux 2.4 running on OMAP 730 but work well on Linux 2.6 running on OMAP2420.

.set FRAMEPROC_ASM_STACK, 48

FRAMEPROC_DUMMY:
 stmdb   sp!, {r4-r11, lr}
 sub   sp, sp, #FRAMEPROC_ASM_STACK
  mov    r5, #5
 str    r5, [sp, #12]
 add    sp, sp, #FRAMEPROC_ASM_STACK
ldmia     sp!, {r4-r11, pc}

The have modified the assembler code as follows and tested it on both target then it works well 
on both target. I'm not getting why ?

.set FRAMEPROC_ASM_STACK, 48

FRAMEPROC_DUMMY:
 stmdb   sp!, {r4-r11, lr}
 sub   sp, sp, #FRAMEPROC_ASM_STACK
 
   mov  r14, sp
  mov    r5, #5
  str    r5, [r14,#12]
@str    r5, [sp, #12]
 add    sp, sp, #FRAMEPROC_ASM_STACK
ldmia     sp!, {r4-r11, pc}

Though I've got temporary solution but my assembler source code is 
quite big and it is very difficult to rewrite it as i dont have free register
in actual source to map the stack pointer register to another register.

Can any body put some light as why it happening on Monta-vista linux ???

Thanks in advance
chandrasheskhar
cp_singh@faith.co.jp

----- Original Message ----- 
From: <linux-omap-open-source-request@linux.omap.com>
To: <linux-omap-open-source@linux.omap.com>
Sent: Wednesday, March 29, 2006 3:00 AM
Subject: Linux-omap-open-source Digest, Vol 23, Issue 60


> Send Linux-omap-open-source mailing list submissions to
> linux-omap-open-source@linux.omap.com
> 
> To subscribe or unsubscribe via the World Wide Web, visi
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> or, via email, send a message with subject or body 'help' to
> linux-omap-open-source-request@linux.omap.com
> 
> You can reach the person managing the list at
> linux-omap-open-source-owner@linux.omap.com
> 
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linux-omap-open-source digest..."
> 
> 
> Today's Topics:
> 
>   1. About to tag 2.6.16-omap1 & current patch status (Tony Lindgren)
>   2. RE: U-boot 1.1.4 compilation problem (Giron, Jeremy)
>   3. RE: DSP Gateway for OMAP5912 (Kiyotaka.Takahashi@nokia.com)
>   4. [PATCH] Fix USB host on 1510/5910? (Jonathan McDowell)
> 
> 
> ----------------------------------------------------------------------
> 
> Message: 1
> Date: Tue, 28 Mar 2006 07:35:02 -0800
> From: Tony Lindgren <tony@atomide.com>
> Subject: About to tag 2.6.16-omap1 & current patch status
> To: linux-omap-open-source@linux.omap.com
> Message-ID: <20060328153500.GF28751@atomide.com>
> Content-Type: text/plain; charset=us-ascii
> 
> Hi all,
> 
> We're about to ready to tag 2.6.16-omap1. Let's do some testing
> and try to get few issues fixed. Currently there's at least the MMC
> issue with I2C powered sockets that we should fix before tagging
> 2.6.16-omap1.
> 
> Please report any issues that should be fixed for 2.6.16-omap1 to this
> thread.
> 
> Also following is a summary of the currently applied and pending patches. 
> 
> Applied patches
> 
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
> Komal Shah [PATCH] Fix OV9640 sensor and add h4 sensor power functions 
> Jonathan McDowell [PATCH] Add support for Amstrad Delta (E3) Videophone
> 
> 
> Pending patches for post 2.6.16-omap1
> 
> Komal Shah [PATCH] OMAP2 MCSPI Use resources
> Hiroshi DOYU [patch 1/5] MMC BUGFIX TRIVIAL STUFFS
> Richard Woodruff [PATCH] : Fix annoying 'too much work for irq72' serial
> Richard Woodruff [PATCH] OMAP2: timer+irq fix up
> David Cohen [PATCH] omap24xxcamera
> Carlos Aguiar [PATCH] fix MMC response types
> Komal Shah [PATCH] OMAP2: ov9640 updates for H4
> Komal Shah [PATCH] omap24xx camera cleanup
> Komal Shah [PATCH] CBUS: various cleanups
> Komal Shah [PATCH] OMAP: MMC: Move set_power to platform data
> Komal Shah [PATCH] OMAP: FB: Use blocking notifier apis
> 
> Regards,
> 
> Tony
> 
> 
> ------------------------------
> 
> Message: 2
> Date: Tue, 28 Mar 2006 08:47:31 -0700
> From: "Giron, Jeremy" <jwgiron@sandia.gov>
> Subject: RE: U-boot 1.1.4 compilation problem
> To: "Hiroki Kaminaga" <kaminaga@sm.sony.co.jp>
> Cc: linux-omap-open-source@linux.omap.com
> Message-ID:
> <C4DF42131A1F374CA3675F7B2EF03ECB0223992C@ES22SNLNT.srn.sandia.gov>
> Content-Type: text/plain; charset=us-ascii
> 
> Hiroki,
> Yes, you are correct. I'm not sure how it worked without it.
> 
> It should mimic omap1510imm.h:
> 
> #define PHYS_FLASH_1 0x00000000 /* Flash Bank #1 */
> 
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
> 
> 
> Result:
> OMAP5912 OSK # flinfo
> 
> 
> 
> Bank # 1: CFI conformant FLASH (16 x 16)  Size: 16 MB in 128 Sectors
> 
> Erase timeout 16384 ms, write timeout 2 ms, buffer write timeout 2048
> ms, buffe
> r size 32
> 
>  Sector Start Addresses:
> 
>    00000000 (RO) 00020000 (RO) 00040000      00060000      00080000
> 
>    000A0000      000C0000      000E0000      00100000      00120000
> 
>    <...>
>    00F00000      00F20000      00F40000      00F60000      00F80000
> 
>    00FA0000      00FC0000      00FE0000
> 
> 
> 
> Bank # 2: CFI conformant FLASH (16 x 16)  Size: 16 MB in 128 Sectors
> 
> Erase timeout 16384 ms, write timeout 2 ms, buffer write timeout 2048
> ms, buffe
> r size 32
> 
>  Sector Start Addresses:
> 
>    01000000      01020000      01040000      01060000      01080000
> 
>    010A0000      010C0000      010E0000      01100000      01120000
> 
>    <...>            
>    01F00000      01F20000      01F40000      01F60000      01F80000
> 
>    01FA0000      01FC0000      01FE0000  
> 
> Best regards,
> Jeremy
> 
> -----Original Message-----
> From: Hiroki Kaminaga [mailto:kaminaga@sm.sony.co.jp] 
> Sent: Sunday, March 26, 2006 11:48 PM
> To: Giron, Jeremy
> Cc: chief@verat.net; linux-omap-open-source@linux.omap.com;
> kaminaga@sm.sony.co.jp
> Subject: Re: U-boot 1.1.4 compilation problem
> 
> Hi,
> 
> sorry for late reply,
> 
>> It is also necessary to change CFG_MAX_FLASH_BANKS to 2 (from 1).
>> Otherwise the CFI driver will only detect a single 16MB bank, rather 
>> than the full 16MBx2 = 32MB.
> 
> Umm, that's right. Also if you change to 2, you also need to set
> CFG_FLASH_BANKS_LIST too?
> 
> 
> Best Regards,
> 
> (Hiroki Kaminaga)
> t
> --
> 
> 
> 
> 
> ------------------------------
> 
> Message: 3
> Date: Wed, 29 Mar 2006 01:32:19 +0900
> From: <Kiyotaka.Takahashi@nokia.com>
> Subject: RE: DSP Gateway for OMAP5912
> To: <nagubk82@gmail.com>, <linux-omap-open-source@linux.omap.com>
> Message-ID:
> <7AF192DA69C59243838FF62851F64F5502107672@toebe101.NOE.Nokia.com>
> Content-Type: text/plain; charset="US-ASCII"
> 
> Hi,
> 
> I'm using Linux 2.6.12 + OMAP patch from www.muru.com with DSP Gateway
> 3.3 on OSK5912. But I have not seen such problem so far... Did you try
> the other sample program (e.g. task_test?, hellotimer, etc.)? 
> 
> BR,
> Kiyotaka
> 
> -----Original Message-----
> From:
> linux-omap-open-source-bounces+kiyotaka.takahashi=nokia.com@linux.omap.c
> om
> [mailto:linux-omap-open-source-bounces+kiyotaka.takahashi=nokia.com@linu
> x.omap.com] On Behalf Of ext naga rajan
> Sent: Tuesday, March 28, 2006 7:37 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: DSP Gateway for OMAP5912
> 
> Hi all,
> 
> 
>         I like to proceed with DSP gateway for DSP applications
> development. I like to know the exact kernel, DSP gateway version and
> the
> exact patches for kernel 2.6 series and for DSP gateway.I tried with
> kernel
> 2.6.12 and DSP gateway 3.3. While executing the application, I m getting
> the
> following error
> 
> 
> # dspctl start demo_console.out
> 
> loading demo_console.out...
> 
> dspgw_task      : adr = 0x00c440, size=   36
> 
> dspgw_version   : adr = 0x000000, size=    8  ... ignored.
> 
> Unable to handle kernel paging request at virtual address e0010000
> 
> pgd = c1d30000
> 
> [e0010000] *pgd=00000000
> 
> Internal error: Oops: 805 [#1]
> 
> Modules linked in:
> 
> CPU: 0
> 
> PC is at .cfu_0fupi+0x10/0x50
> 
> LR is at intmem_write+0x8c/0xdc
> 
> pc : [<c01009d8>]    lr : [<c003ca04>]    Not tainted
> 
> sp : c1cf7ed8  ip : 00000000  fp : c1cf7f1c
> 
> r10: e0010000  r9 : c024c6dc  r8 : c1cf7f74
> 
> r7 : 00000008  r6 : 00000008  r5 : 00000008  r4 : be913d5c
> 
> r3 : 00000000  r2 : 00000004  r1 : be913d60  r0 : e0010000
> 
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  Segment user
> 
> Control: 5317F  Table: 11D30000  DAC: 00000015
> 
> Process dspctl (pid: 723, stack limit = 0xc1cf6194)
> 
> Stack: (0xc1cf7ed8 to 0xc1cf8000)
> 
> 7ec0:                                                       e0010000
> 00000008
> 
> 7ee0: be913d5c 00000008 00000008 00000008 c003ca04 00028000 00000000
> c1cf7f74
> 
> 7f00: be913d5c 00000008 e0010000 c02ea760 c1cf7f48 c1cf7f20 c003cbb0
> c003c988
> 
> 7f20: 00000008 00000000 be913d5c c02ea760 c1cf6000 00000000 c1cf7f74
> c1cf7f70
> 
> 7f40: c1cf7f4c c00851fc c003cb40 c02ea784 fffffff7 c02ea760 c1cf7f74
> 00010000
> 
> 7f60: 4014bafc c1cf7fa4 c1cf7f74 c0085338 c0085148 00010000 00000000
> 00000000
> 
> 7f80: be913eb4 4001df40 0000c570 00000004 c0022e04 c1cf6000 00000000
> c1cf7fa8
> 
> 7fa0: c0022c80 c00852f8 be913eb4 c0029c18 00000005 be913d5c 00000008
> be913d5c
> 
> 7fc0: be913eb4 4001df40 0000c570 00000003 4014e1d0 000089f0 4014bafc
> be913db8
> 
> 7fe0: 00000000 be913d54 00003f64 400ec830 60000010 00000005 00000000
> 00000000
> 
> Backtrace:
> 
> [<c003c978>] (intmem_write+0x0/0xdc) from [<c003cbb0>]
> (dsp_mem_write+0x80/0xb4)
> 
> 
> 
> [<c003cb30>] (dsp_mem_write+0x0/0xb4) from [<c00851fc>]
> (vfs_write+0xc4/0x13c)
> 
> [<c0085138>] (vfs_write+0x0/0x13c) from [<c0085338>]
> (sys_write+0x50/0x74)
> 
> [<c00852e8>] (sys_write+0x0/0x74) from [<c0022c80>]
> (ret_fast_syscall+0x0/0x2c)
> 
> r9 = C1CF6000  r8 = C0022E04  r7 = 00000004  r6 = 0000C570
> 
> r5 = 4001DF40  r4 = BE913EB4
> 
> Code: e2522004 4282c004 4a000026 e4b13004 (e4803004)
> 
> Segmentation fault
> 
> 
> 
>                                   I tried with patches mentioned in the
> source forge.net. If you have succeeded this problem,I like to know the
> details such as kernel.DSP gateway and patches you used. Please help me
> in
> this regard.
> 
> 
> 
> Thanks in advance,
> 
> B.Nagarajan,
> 
> SANDS.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> 
> ------------------------------
> 
> Message: 4
> Date: Tue, 28 Mar 2006 17:44:03 +0100
> From: Jonathan McDowell <noodles@earth.li>
> Subject: [PATCH] Fix USB host on 1510/5910?
> To: linux-omap-open-source@linux.omap.com
> Message-ID: <20060328164403.GL26949@earth.li>
> Content-Type: text/plain; charset=us-ascii
> 
> I'm not quite sure if this is necessary or not. I've found I need it to
> get USB working correctly on the Amstrad E3, which is an OMAP5910. From
> my reading of ohci-omap.c usb_dc_ck is requested for the 1510 as well,
> and if it can't be obtained an error is returned.
> 
> Does anyone have USB working correctly on a 1510/5910 with latest git
> without something like the below?
> 
> Signed-Off-By: Jonathan McDowell <noodles@earth.li>
> 
> -----
> diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
> index b7c6881..db48d73 100644
> --- a/arch/arm/mach-omap1/clock.h
> +++ b/arch/arm/mach-omap1/clock.h
> @@ -633,7 +633,7 @@ static struct clk usb_dc_ck = {
>  .name = "usb_dc_ck",
>  /* Direct from ULPD, no parent */
>  .rate = 48000000,
> - .flags = CLOCK_IN_OMAP16XX | RATE_FIXED,
> + .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | RATE_FIXED,
>  .enable_reg = (void __iomem *)SOFT_REQ_REG,
>  .enable_bit = 4,
>  .enable = &omap1_clk_enable_generic,
> -----
> 
> J.
> 
> -- 
> 
> 
> ------------------------------
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> 
> End of Linux-omap-open-source Digest, Vol 23, Issue 60
> ******************************************************
>
