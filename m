From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Date: Thu, 9 Jan 2014 13:02:47 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EDB18E1@DBDE04.ent.ti.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com>
 <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
 <52CE5C1A.3070603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35616 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbaAINDY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jan 2014 08:03:24 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>



> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Thursday, January 09, 2014 2:01 PM
> To: Valkeinen, Tomi; Ivaylo Dimitrov
> Cc: Tony Lindgren; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-fbdev@vger.kernel.org
> Subject: RE: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
> 
> 
> > -----Original Message-----
> > From: Valkeinen, Tomi
> > Sent: Thursday, January 09, 2014 1:52 PM
> > To: Hiremath, Vaibhav; Ivaylo Dimitrov
> > Cc: Tony Lindgren; linux-omap@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-fbdev@vger.kernel.org
> > Subject: Re: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
> >
> > On 2014-01-09 07:06, Hiremath, Vaibhav wrote:
> >
> > > I am seeing underflow issue on AM43x device if I use omapfb_vram
> argument.
> > > Did you see this on OMAP?
> > >
> > > I am using "omapfb_vram=10M@0xA0000000", and I believe it is correct
> > > way
> > of usage.
> >
> > Hmm ok... The AM4x seems to have issues anyway, as we're seeing
> > underflows easily in other situations also.
> >
> > Well, there's a small difference in the allocation. The normal dma
> > alloc uses
> > dma_alloc_attrs() and passes DMA_ATTR_WRITE_COMBINE as a flag, whereas
> > allocating from the absolute address just uses the piece of memory. I
> > couldn't find how to set write-combine for the abs memory area.
> >
> > Then again, that's for CPU caching, so I don't see why it would affect
> > DSS as such (but that's still something we should measure, cpu
> > read/write perf for normal and abs allocation).
> >
> > The only thought I have is that somehow the reserved memory area is
> > missing some configuration that is done for the rest of the memory.
> > But that's purely a guess, this is totally out of my area of expertise...
> >
> > Vaibhav, just to be sure, can you run both with normal dma_alloc and
> > with the reserve, and verify that the dispc register dumps are the same?
> > I don't see how they could be different, but just to be sure.
> >
> 
> Will check and update you shortly.
> 

I checked both the DSS configuration in both scenarios and they look same to me.


With normal dma_alloc:
===================
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~# cat /proc/cmdline
console=ttyO0,115200n8 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait mem=128M consoleblank=0 clocksource=gp_timer consoleblank=0 earlyprintk
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~# cat /sys/kernel/debug/omapdss/dss
DSS_REVISION                        00000020
DSS_SYSCONFIG                       00000001
DSS_SYSSTATUS                       00000001
DSS_CONTROL                         00000018
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~# cat /sys/kernel/debug/omapdss/clk
- DSS -
DSS_FCK (DSS_FCLK1) = 198000000
- DISPC -
dispc fclk source = DSS_FCK (DSS_FCLK1)
fck             198000000
- LCD -
LCD clk source = DSS_FCK (DSS_FCLK1)
lck             198000000       lck div 1
pck             33000000        pck div 6
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~# cat /sys/kernel/debug/omapdss/dispc_irq
period 44780 ms
irqs 1
FRAMEDONE                     0
VSYNC                         1
EVSYNC_EVEN                   1
EVSYNC_ODD                    1
ACBIAS_COUNT_STAT             0
PROG_LINE_NUM                 1
GFX_FIFO_UNDERFLOW            0
GFX_END_WIN                   1
PAL_GAMMA_MASK                0
OCP_ERR                       0
VID1_FIFO_UNDERFLOW           0
VID1_END_WIN                  0
VID2_FIFO_UNDERFLOW           0
VID2_END_WIN                  0
SYNC_LOST                     0
SYNC_LOST_DIGIT               0
WAKEUP                        0
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~# cat /sys/kernel/debug/omapdss/dispc
DISPC_REVISION                                     00000030
DISPC_SYSCONFIG                                    00002011
DISPC_SYSSTATUS                                    00000001
DISPC_IRQSTATUS                                    000000ae
DISPC_IRQENABLE                                    0000d640
DISPC_CONTROL                                      00018309
DISPC_CONFIG                                       00000204
DISPC_CAPABLE                                      000003ff
DISPC_LINE_STATUS                                  000000b1
DISPC_LINE_NUMBER                                  00000000
DISPC_GLOBAL_ALPHA                                 000000ff
DISPC_DEFAULT_COLOR(LCD)                           00000000
DISPC_TRANS_COLOR(LCD)                             00000000
DISPC_SIZE_MGR(LCD)                                01df031f
DISPC_DEFAULT_COLOR(LCD)                           00000000
DISPC_TRANS_COLOR(LCD)                             00000000
DISPC_TIMING_H(LCD)                                00f0d11d
DISPC_TIMING_V(LCD)                                00a0160c
DISPC_POL_FREQ(LCD)                                00003000
DISPC_DIVISORo(LCD)                                00010006
DISPC_SIZE_MGR(LCD)                                01df031f
DISPC_DATA_CYCLE1(LCD)                             00000000
DISPC_DATA_CYCLE2(LCD)                             00000000
DISPC_DATA_CYCLE3(LCD)                             00000000
DISPC_CPR_COEF_R(LCD)                              00000000
DISPC_CPR_COEF_G(LCD)                              00000000
DISPC_CPR_COEF_B(LCD)                              00000000
DISPC_OVL_BA0(GFX)                                 86900000
DISPC_OVL_BA1(GFX)                                 86900000
DISPC_OVL_POSITION(GFX)                            00000000
DISPC_OVL_SIZE(GFX)                                01df031f
DISPC_OVL_ATTRIBUTES(GFX)                          00000091
DISPC_OVL_FIFO_THRESHOLD(GFX)                      03ff03c0
DISPC_OVL_FIFO_SIZE_STATUS(GFX)                    00000400
DISPC_OVL_ROW_INC(GFX)                             00000001
DISPC_OVL_PIXEL_INC(GFX)                           00000001
DISPC_OVL_PRELOAD(GFX)                             00000100
DISPC_OVL_WINDOW_SKIP(GFX)                         00000000
DISPC_OVL_TABLE_BA(GFX)                            00000000
DISPC_OVL_BA0(VID1)                                00000000
DISPC_OVL_BA1(VID1)                                00000000
DISPC_OVL_POSITION(VID1)                           00000000
DISPC_OVL_SIZE(VID1)                               00000000
DISPC_OVL_ATTRIBUTES(VID1)                         00008000
DISPC_OVL_FIFO_THRESHOLD(VID1)                     03ff03c0
DISPC_OVL_FIFO_SIZE_STATUS(VID1)                   00000400
DISPC_OVL_ROW_INC(VID1)                            00000001
DISPC_OVL_PIXEL_INC(VID1)                          00000001
DISPC_OVL_PRELOAD(VID1)                            00000100
DISPC_OVL_FIR(VID1)                                00000000
DISPC_OVL_PICTURE_SIZE(VID1)                       00000000
DISPC_OVL_ACCU0(VID1)                              00000000
DISPC_OVL_ACCU1(VID1)                              00000000
DISPC_OVL_PRELOAD(VID1)                            00000100
DISPC_OVL_BA0(VID2)                                00000000
DISPC_OVL_BA1(VID2)                                00000000
DISPC_OVL_POSITION(VID2)                           00000000
DISPC_OVL_SIZE(VID2)                               00000000
DISPC_OVL_ATTRIBUTES(VID2)                         00008000
DISPC_OVL_FIFO_THRESHOLD(VID2)                     03ff03c0
DISPC_OVL_FIFO_SIZE_STATUS(VID2)                   00000400
DISPC_OVL_ROW_INC(VID2)                            00000001
DISPC_OVL_PIXEL_INC(VID2)                          00000001
DISPC_OVL_PRELOAD(VID2)                            00000100
DISPC_OVL_FIR(VID2)                                00000000
DISPC_OVL_PICTURE_SIZE(VID2)                       00000000
DISPC_OVL_ACCU0(VID2)                              00000000
DISPC_OVL_ACCU1(VID2)                              00000000
DISPC_OVL_PRELOAD(VID2)                            00000100
DISPC_OVL_FIR_COEF_H_0(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_1(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_2(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_3(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_4(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_5(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_6(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_7(VID1)                       00000000
DISPC_OVL_FIR_COEF_HV_0(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_1(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_2(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_3(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_4(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_5(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_6(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_7(VID1)                      00000000
DISPC_OVL_CONV_COEF_0(VID1)                        0199012a
DISPC_OVL_CONV_COEF_1(VID1)                        012a0000
DISPC_OVL_CONV_COEF_2(VID1)                        079c0730
DISPC_OVL_CONV_COEF_3(VID1)                        0000012a
DISPC_OVL_CONV_COEF_4(VID1)                        00000205
DISPC_OVL_FIR_COEF_V_0(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_1(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_2(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_3(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_4(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_5(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_6(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_7(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_0(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_1(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_2(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_3(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_4(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_5(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_6(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_7(VID2)                       00000000
DISPC_OVL_FIR_COEF_HV_0(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_1(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_2(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_3(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_4(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_5(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_6(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_7(VID2)                      00000000
DISPC_OVL_CONV_COEF_0(VID2)                        0199012a
DISPC_OVL_CONV_COEF_1(VID2)                        012a0000
DISPC_OVL_CONV_COEF_2(VID2)                        079c0730
DISPC_OVL_CONV_COEF_3(VID2)                        0000012a
DISPC_OVL_CONV_COEF_4(VID2)                        00000205
DISPC_OVL_FIR_COEF_V_0(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_1(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_2(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_3(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_4(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_5(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_6(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_7(VID2)                       00000000
root@am43xx-epos-evm:~#




With Reserved memory for FB:
============================
root@am43xx-epos-evm:~# cat /proc/cmdline
console=ttyO0,115200n8 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait mem=128M consoleblank=0 clocksource=gp_timer consoleblank=0 earlyprintk omapfb_vram=10M@0xA0000000
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~# cat /sys/kernel/debug/omapdss/dss
DSS_REVISION                        00000020
DSS_SYSCONFIG                       00000001
DSS_SYSSTATUS                       00000001
DSS_CONTROL                         00000018
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~# cat /sys/kernel/debug/omapdss/clk
- DSS -
DSS_FCK (DSS_FCLK1) = 198000000
- DISPC -
dispc fclk source = DSS_FCK (DSS_FCLK1)
fck             198000000
- LCD -
LCD clk source = DSS_FCK (DSS_FCLK1)
lck             198000000       lck div 1
pck             33000000        pck div 6
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~# cat /sys/kernel/debug/omapdss/dispc_irq
period 48010 ms
irqs 2
FRAMEDONE                     0
VSYNC                         2
EVSYNC_EVEN                   2
EVSYNC_ODD                    2
ACBIAS_COUNT_STAT             0
PROG_LINE_NUM                 2
GFX_FIFO_UNDERFLOW            2
GFX_END_WIN                   2
PAL_GAMMA_MASK                0
OCP_ERR                       0
VID1_FIFO_UNDERFLOW           0
VID1_END_WIN                  0
VID2_FIFO_UNDERFLOW           0
VID2_END_WIN                  0
SYNC_LOST                     0

SYNC_LOST_DIGIT               0
WAKEUP                        0
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~#
root@am43xx-epos-evm:~# cat /sys/kernel/debug/omapdss/dispc
DISPC_REVISION                                     00000030
DISPC_SYSCONFIG                                    00002011
DISPC_SYSSTATUS                                    00000001
DISPC_IRQSTATUS                                    0000002e
DISPC_IRQENABLE                                    0000d640
DISPC_CONTROL                                      00018309
DISPC_CONFIG                                       00000204
DISPC_CAPABLE                                      000003ff
DISPC_LINE_STATUS                                  0000011d
DISPC_LINE_NUMBER                                  00000000
DISPC_GLOBAL_ALPHA                                 000000ff
DISPC_DEFAULT_COLOR(LCD)                           00000000
DISPC_TRANS_COLOR(LCD)                             00000000
DISPC_SIZE_MGR(LCD)                                01df031f
DISPC_DEFAULT_COLOR(LCD)                           00000000
DISPC_TRANS_COLOR(LCD)                             00000000
DISPC_TIMING_H(LCD)                                00f0d11d
DISPC_TIMING_V(LCD)                                00a0160c
DISPC_POL_FREQ(LCD)                                00003000
DISPC_DIVISORo(LCD)                                00010006
DISPC_SIZE_MGR(LCD)                                01df031f
DISPC_DATA_CYCLE1(LCD)                             00000000
DISPC_DATA_CYCLE2(LCD)                             00000000
DISPC_DATA_CYCLE3(LCD)                             00000000
DISPC_CPR_COEF_R(LCD)                              00000000
DISPC_CPR_COEF_G(LCD)                              00000000
DISPC_CPR_COEF_B(LCD)                              00000000
DISPC_OVL_BA0(GFX)                                 a0000000
DISPC_OVL_BA1(GFX)                                 a0000000
DISPC_OVL_POSITION(GFX)                            00000000
DISPC_OVL_SIZE(GFX)                                01df031f
DISPC_OVL_ATTRIBUTES(GFX)                          00000090
DISPC_OVL_FIFO_THRESHOLD(GFX)                      03ff03c0
DISPC_OVL_FIFO_SIZE_STATUS(GFX)                    00000400
DISPC_OVL_ROW_INC(GFX)                             00000001
DISPC_OVL_PIXEL_INC(GFX)                           00000001
DISPC_OVL_PRELOAD(GFX)                             00000100
DISPC_OVL_WINDOW_SKIP(GFX)                         00000000
DISPC_OVL_TABLE_BA(GFX)                            00000000
DISPC_OVL_BA0(VID1)                                00000000
DISPC_OVL_BA1(VID1)                                00000000
DISPC_OVL_POSITION(VID1)                           00000000
DISPC_OVL_SIZE(VID1)                               00000000
DISPC_OVL_ATTRIBUTES(VID1)                         00008000
DISPC_OVL_FIFO_THRESHOLD(VID1)                     03ff03c0
DISPC_OVL_FIFO_SIZE_STATUS(VID1)                   00000400
DISPC_OVL_ROW_INC(VID1)                            00000001
DISPC_OVL_PIXEL_INC(VID1)                          00000001
DISPC_OVL_PRELOAD(VID1)                            00000100
DISPC_OVL_FIR(VID1)                                00000000
DISPC_OVL_PICTURE_SIZE(VID1)                       00000000
DISPC_OVL_ACCU0(VID1)                              00000000
DISPC_OVL_ACCU1(VID1)                              00000000
DISPC_OVL_PRELOAD(VID1)                            00000100
DISPC_OVL_BA0(VID2)                                00000000
DISPC_OVL_BA1(VID2)                                00000000
DISPC_OVL_POSITION(VID2)                           00000000
DISPC_OVL_SIZE(VID2)                               00000000
DISPC_OVL_ATTRIBUTES(VID2)                         00008000
DISPC_OVL_FIFO_THRESHOLD(VID2)                     03ff03c0
DISPC_OVL_FIFO_SIZE_STATUS(VID2)                   00000400
DISPC_OVL_ROW_INC(VID2)                            00000001
DISPC_OVL_PIXEL_INC(VID2)                          00000001
DISPC_OVL_PRELOAD(VID2)                            00000100
DISPC_OVL_FIR(VID2)                                00000000
DISPC_OVL_PICTURE_SIZE(VID2)                       00000000
DISPC_OVL_ACCU0(VID2)                              00000000
DISPC_OVL_ACCU1(VID2)                              00000000
DISPC_OVL_PRELOAD(VID2)                            00000100
DISPC_OVL_FIR_COEF_H_0(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_1(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_2(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_3(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_4(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_5(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_6(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_7(VID1)                       00000000
DISPC_OVL_FIR_COEF_HV_0(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_1(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_2(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_3(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_4(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_5(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_6(VID1)                      00000000
DISPC_OVL_FIR_COEF_HV_7(VID1)                      00000000
DISPC_OVL_CONV_COEF_0(VID1)                        0199012a
DISPC_OVL_CONV_COEF_1(VID1)                        012a0000
DISPC_OVL_CONV_COEF_2(VID1)                        079c0730
DISPC_OVL_CONV_COEF_3(VID1)                        0000012a
DISPC_OVL_CONV_COEF_4(VID1)                        00000205
DISPC_OVL_FIR_COEF_V_0(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_1(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_2(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_3(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_4(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_5(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_6(VID1)                       00000000
DISPC_OVL_FIR_COEF_V_7(VID1)                       00000000
DISPC_OVL_FIR_COEF_H_0(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_1(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_2(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_3(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_4(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_5(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_6(VID2)                       00000000
DISPC_OVL_FIR_COEF_H_7(VID2)                       00000000
DISPC_OVL_FIR_COEF_HV_0(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_1(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_2(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_3(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_4(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_5(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_6(VID2)                      00000000
DISPC_OVL_FIR_COEF_HV_7(VID2)                      00000000
DISPC_OVL_CONV_COEF_0(VID2)                        0199012a
DISPC_OVL_CONV_COEF_1(VID2)                        012a0000
DISPC_OVL_CONV_COEF_2(VID2)                        079c0730
DISPC_OVL_CONV_COEF_3(VID2)                        0000012a
DISPC_OVL_CONV_COEF_4(VID2)                        00000205
DISPC_OVL_FIR_COEF_V_0(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_1(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_2(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_3(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_4(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_5(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_6(VID2)                       00000000
DISPC_OVL_FIR_COEF_V_7(VID2)                       00000000
root@am43xx-epos-evm:~#

