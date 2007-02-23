From: prashant bansal <prashantbansal81@yahoo.com>
Subject: Driver crash on OMAP 5912 kernel 2.6
Date: Fri, 23 Feb 2007 04:36:02 -0800 (PST)
Message-ID: <518868.66775.qm@web51508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi,
   
  I am trying to run a driver on kernel 2.6 for OMAP5912. But as soon as my code does a read or write to the memory the driver crashes.
   
  I am using linux kernel 2.6.8-rc3 patched for OMAP5912 and I downloaded it from http://linux.omap.com/pub/kernel/osk/
   
  The toolchain used is arm-linux-gcc-3.3.2 also from http://linux.omap.com/pub/toolchain/
   
  The driver runs perfectly on OMAP5912 kernel 2.4 
  I ported it to Kernel 2.6 but the crash happens always.
   
  The capture of the crash is given below. 
   
  Unable to handle kernel paging request at virtual address 0fff5008
  pgd = c1c24000
  [0fff5008] *pgd=00000000
  Internal error: Oops: 805 [#1]
  Modules linked in: ga_linuxdrv_omap5912
  CPU: 0
  PC is at spi2_initOmap5912+0x54/0xc0 [ga_linuxdrv_omap5912]
  LR is at 0x0
  pc : [<bf011040>] lr : [<00000000>] Tainted: P 
  sp : c1c2d8b4 ip : 00000001 fp : c1c2d8c4
  r10: c1ce9bec r9 : c0263220 r8 : bf00b07c
  r7 : c1cfc800 r6 : c1ce9be0 r5 : 00000000 r4 : c1d13a60
  r3 : 0fff5008 r2 : bf091b28 r1 : fffffff7 r0 : c1d13a60
  Flags: NzCv IRQs on FIQs on Mode SVC_32 Segment user
  Control: 5717F Table: 11C24000 DAC: 00000015
  Process insmod (pid: 22, stack limit = 0xc1c2c190)
  Stack: (0xc1c2d8b4 to 0xc1c2e000)
  d8a0: c1d13a60 c1c2d8d8 c1c2d8c8 
  d8c0: bf011f9c bf010ffc bf091ab4 c1c2d900 c1c2d8dc bf011734 bf011f98 c1d13a60 
  d8e0: 00000004 c1cfc800 00000000 bf091ab4 c0263220 c1c2d930 c1c2d904 bf00e87c 
  d900: bf01168c 00000000 c1cfc800 000006f8 c1ce9bf4 bf090b90 bf009aa0 00000000 
  d920: c00202a4 c1c2def4 c1c2d934 bf009b84 bf00e798 1101a8c0 00000000 00000000 
  d940: 00000000 00000000 00000000 00000000 00000000 00000000 00000011 01082003 
  d960: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 1101a8c0 
  d980: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
  d9a0: 00000011 01082003 00000000 00000000 00000000 00000000 00000000 c1d4d0c0 
  d9c0: c1c2d9e4 1101a8c0 00000000 00000000 c1d50d60 c1c2db24 00000074 c1c2da64 
  d9e0: c1d1a360 c1c2db24 00000000 c1c2da18 c1c2d9fc c0152950 c014ab84 c1c2db24 
  da00: 00000074 c1c2da64 c01a8fd0 c1c2dac8 c1c2da1c c010cf40 c0152904 c0263800 
  da20: c1c2da60 c1c2da30 00000074 c1d8e740 c0263800 00000000 c1c2db24 00003333 
  da40: 00000004 c01dcbfc c1d19800 00000008 00000000 c1c2da88 c1c2da64 c0116a9c 
  da60: c0128afc c0263800 c01dc9d0 00000000 00000001 ffffffff 00000000 c0017350 
  da80: 00000000 c0116b94 00000000 c01dcac8 c01dc9d0 c1d55a80 ffff9887 c019919c 
  daa0: ffffffff c1de4800 c1c2da1c c1c2c000 bf000000 00000000 00000074 c1c2dae0 
  dac0: c1c2dacc c010cfa4 c010cec0 c0305000 00000074 c1c2db68 c1c2dae4 c016bc34 
  dae0: c010cf74 00000074 00000000 00000010 c1de4c1c c1d8e740 c0305048 c1d1a35c 
  db00: c0305000 00000074 00000074 c1d1a384 c1c2db48 c1c2db20 c00ab28c c016b77c 
  db20: c1cff5e4 c1de4c40 c1c2db4c c1c2db38 c01632dc c003a498 c1de4c00 00000000 
  db40: c1c2db68 c1c2db50 c01603f4 c016325c 00000003 00000000 c1d1a35c c1c2dba0 
  db60: c1c2db6c c0161d44 c0160398 00000000 00000040 c1de4800 c1cff5e4 c1de4800 
  db80: c1c2dc0c c1cff714 c1c2dc5c 00000f1f c1cff5e4 c1c2dbb4 c1c2dba4 c015f8b0 
  dba0: c003a498 c1cff5e4 c1c2dc08 c1c2dbb8 c0163720 c003a498 c00adb68 c015f1a4 
  dbc0: c019fc4c c1cff744 c1cff764 c1da77a0 c019fc4c c1cff744 c1cff764 c1da77a0 
  dbe0: c1c2dc08 c1c2dbf0 c015f00c c003eea0 c1cff5e4 c1de4800 c1c2dc0c c1c2dc2c 
  dc00: c1c2dc0c c00ae4f4 c015efe8 00000000 00000000 c1c2dc5c 00000000 c1cff5e0 
  dc20: c1c2dc58 c1c2dc30 c00ae7fc c00ae4b8 00000000 c1c2dc94 c1c2dc5c 00000003 
  dc40: 00000001 c1d53a80 00000003 c1c2dc84 c1c2dc5c c00ae878 c00ae6fc c1c2dc5c 
  dc60: c1c2dc5c 00000000 c1c2dc94 c1c4f2a0 c0230ae0 c1c4f434 c1c2dcbc c1c2dc88 
  dc80: c00aee54 c00ae82c 60000093 c1c2dc94 c1d53a80 c1c2dc94 c1c2dc94 c1c2dccc 
  dca0: c1c2dcac c0032c9c c0032a70 c01cf4f4 00989680 00000000 c0017220 c01cf4c4 
  dcc0: c1c2dd08 c1c2dd00 c1c2dcd4 c0052c20 c0052668 0000182e c019ca7c 00000000 
  dce0: 00000000 60000093 00000001 c019c990 00000000 c1c2dd2c c1c2dd04 0000182f 
  dd00: c019ca7c 00000000 00000000 60000093 00000001 c019c990 00000000 c1c2dd54 
  dd20: c1c2dd2c c0052cec c0052b5c c019c990 c019ca6c c019c990 00000000 00000000 
  dd40: c1d55a80 c019c990 c1c2dd7c c1c2c000 c1c2dd84 c1c2dd60 c0033310 c0024804 
  dd60: 00000000 c1c2dd84 c1c2dd74 c003e160 c003e064 c01e30a0 c01e3110 00000000 
  dd80: c1c2ddb4 c1c2dd90 c00584bc c0058318 00000000 00000000 c01d49b0 c1c2ddc8 
  dda0: c1c2ddac c003db90 c003da78 00000000 c01d49b0 c1c2ddcc c019919c c1c2ddf4 
  ddc0: c1c2ddcc c003e464 c003db24 c1c2ddcc c1c2ddcc c01ca5d8 00000001 c01d4788 
  dde0: c1c2c000 c019c990 c1c2de1c c1c2ddf8 c0053190 c0052ae8 c01e34a0 c019c990 
  de00: c019ccfc 00000001 000000d0 00000000 c1c2de58 c1c2de20 c00534e8 c0052eac 
  de20: 00000000 c1c2c000 00000010 c01db804 c01e34a0 c01e34a0 c01e34ac 00000020 
  de40: 000000d0 00000001 00000010 c1c2de68 c1c2de5c c005351c c00531b4 c1c2de7c 
  de60: c1ce9020 c01e34a0 c1ce9000 00000020 c1c2dea8 c1c2de80 c00578f0 c0057724 
  de80: c1dff2c0 c1de3000 c01e34ac c01e34a0 000000d0 c1c2c000 00000002 c1c2decc 
  dea0: c1c2deac c0057b30 c0057824 60000013 c0263220 bf009aa0 00000000 c00202a4 
  dec0: c1c2dee0 c1c2ded0 c0057fbc 00000000 c0263220 bf009aa0 00000000 c00202a4 
  dee0: c1c2c000 00000002 c1c2df18 c1c2def8 bf00c970 bf009ab0 c1ce9be0 000000c0 
  df00: 00000000 bf090cac bf090b90 c1c2df70 c1c2df1c bf0934fc bf00c8fc 00000000 
  df20: 00000004 00000010 bf048b68 bf048b74 000038e8 bf048b1c bf048b28 bf048b2c 
  df40: bf048b34 bf048b38 bf048b3c bf048b44 bf048b48 bf048b58 c019c7a8 bf08f8e0 
  df60: c019c790 c1c2df84 c1c2df74 bf0936ac bf093010 c019c7a8 c1c2dfa4 c1c2df88 
  df80: c004ca14 bf0936ac 00000004 00000000 0000000b 00000080 00000000 c1c2dfa8 
  dfa0: c0020120 c004c888 00000000 0000000b 00900080 40001000 00099f1f 000e72e0 
  dfc0: 00000004 00000000 0000000b befffeb4 000e72c0 000e72a0 00000002 befffe6c 
  dfe0: beffda18 beffda0c 0001be04 00072e10 00000010 00900080 00000000 00000000 
  Backtrace: 
  [<bf010fec>] (spi2_initOmap5912+0x0/0xc0 [ga_linuxdrv_omap5912]) from [<bf011f9c>] (spi2_init+0x14/0x30 [ga_linuxdrv_omap5912])
  r4 = C1D13A60 
  [<bf011f88>] (spi2_init+0x0/0x30 [ga_linuxdrv_omap5912]) from [<bf011734>] (HhalPlatformInitPreBoot+0xb8/0xe8 [ga_linuxdrv_omap5912])
  r4 = BF091AB4 
  [<bf01167c>] (HhalPlatformInitPreBoot+0x0/0xe8 [ga_linuxdrv_omap5912]) from [<bf00e87c>] (PhgHhalInitialize+0xf4/0x460 [ga_linuxdrv_omap5912])
  r7 = C0263220 r6 = BF091AB4 r5 = 00000000 r4 = C1CFC800
  [<bf00e788>] (PhgHhalInitialize+0x0/0x460 [ga_linuxdrv_omap5912]) from [<bf009b84>] (drvPhase2Init+0xe4/0x4a8 [ga_linuxdrv_omap5912])
  r8 = C00202A4 r7 = 00000000 r6 = BF009AA0 r5 = BF090B90
  r4 = C1CE9BF4 
  [<bf009aa0>] (drvPhase2Init+0x0/0x4a8 [ga_linuxdrv_omap5912]) from [<bf00c970>] (PhgOsalRegInit+0x84/0xb0 [ga_linuxdrv_omap5912])
  [<bf00c8ec>] (PhgOsalRegInit+0x0/0xb0 [ga_linuxdrv_omap5912]) from [<bf0934fc>] (drv_Init+0x4fc/0x69c [ga_linuxdrv_omap5912])
  r6 = BF090B90 r5 = BF090CAC r4 = 00000000 
  [<bf093000>] (drv_Init+0x0/0x69c [ga_linuxdrv_omap5912]) from [<bf0936ac>] (drvInit+0x10/0x40 [ga_linuxdrv_omap5912])
  r6 = C019C790 r5 = BF08F8E0 r4 = C019C7A8 
  [<bf09369c>] (drvInit+0x0/0x40 [ga_linuxdrv_omap5912]) from [<c004ca14>] (sys_init_module+0x19c/0x300)
  r4 = C019C7A8 
  [<c004c878>] (sys_init_module+0x0/0x300) from [<c0020120>] (ret_fast_syscall+0x0/0x2c)
  r7 = 00000080 r6 = 0000000B r5 = 00000000 r4 = 00000004
  Code: e5c23010 e59f3060 e582e018 e582e014 (e1c310b0) 
  Segmentation fault
   
   

 
---------------------------------
TV dinner still cooling?
Check out "Tonight's Picks" on Yahoo! TV.
