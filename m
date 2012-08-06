From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: v3.6-rc1 DSS issues/regression
Date: Tue, 7 Aug 2012 00:09:48 +0300
Message-ID: <20120806210948.GC1298@harshnoise.musicnaut.iki.fi>
References: <20120806164732.GB1298@harshnoise.musicnaut.iki.fi>
 <1344273868.12136.50.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:41175 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab2HFVKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 17:10:06 -0400
Content-Disposition: inline
In-Reply-To: <1344273868.12136.50.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, archit@ti.com

Hi,

On Mon, Aug 06, 2012 at 08:24:28PM +0300, Tomi Valkeinen wrote:
> On Mon, 2012-08-06 at 19:47 +0300, Aaro Koskinen wrote:
> > Hi,
> > 
> > I can't get the display on N900 (SDI, acx565akm) to work with v3.6-rc1
> > kernel, it's just full of flicker/noise.
> > 
> > According to git-bisect, the problem is introduced by the commit:
> > 
> >     commit f476ae9dab3234532d41d36beb4ba7be838fa786
> >     Author: Archit Taneja <archit@ti.com>
> >     Date:   Fri Jun 29 14:37:03 2012 +0530
> > 
> >     OMAPDSS: APPLY: Remove DISPC writes to manager's lcd parameters in interface
> > 
> > Any ideas?
> 
> Looks strange, that particular commit more or less just moves the
> writing of the configs to another place. And it works for DPI and DSI,
> at least.
> 
> Can you take a dump of debugfs/omapdss/dss and debugfs/omapdss/dispc,
> for both working and non-working versions, to see if there's a diff?

Here's a diff:

--- dss-n900-ok	2012-08-06 23:54:07.000000000 +0300
+++ dss-n900-broken	2012-08-06 23:51:08.000000000 +0300
@@ -1,150 +1,150 @@
 # cat clk
 - DSS -
 dpll4_ck 432000000
 DSS_FCK (DSS1_ALWON_FCLK) = 432000000 / 12 * 2 = 72000000
 - DISPC -
 dispc fclk source = DSS_FCK (DSS1_ALWON_FCLK)
 fck		72000000        
 - LCD -
 LCD clk source = DSS_FCK (DSS1_ALWON_FCLK)
 lck		72000000        lck div	1
 pck		24000000        pck div	3
 # cat dispc
 DISPC_REVISION                                     00000030
 DISPC_SYSCONFIG                                    00002015
 DISPC_SYSSTATUS                                    00000001
 DISPC_IRQSTATUS                                    000100a2
 DISPC_IRQENABLE                                    0000d640
 DISPC_CONTROL                                      38018309
 DISPC_CONFIG                                       00004204
 DISPC_CAPABLE                                      000003ff
-DISPC_LINE_STATUS                                  00000036
+DISPC_LINE_STATUS                                  000000bf
 DISPC_LINE_NUMBER                                  00000000
 DISPC_GLOBAL_ALPHA                                 000000ff
 DISPC_DEFAULT_COLOR(LCD)                           00000000
 DISPC_TRANS_COLOR(LCD)                             00000000
 DISPC_SIZE_MGR(LCD)                                01df031f
 DISPC_DEFAULT_COLOR(LCD)                           00000000
 DISPC_TRANS_COLOR(LCD)                             00000000
 DISPC_TIMING_H(LCD)                                01701b03
 DISPC_TIMING_V(LCD)                                00400302
 DISPC_POL_FREQ(LCD)                                00033000
 DISPC_DIVISORo(LCD)                                00010003
 DISPC_SIZE_MGR(LCD)                                01df031f
 DISPC_DATA_CYCLE1(LCD)                             00000000
 DISPC_DATA_CYCLE2(LCD)                             00000000
 DISPC_DATA_CYCLE3(LCD)                             00000000
 DISPC_CPR_COEF_R(LCD)                              00000000
 DISPC_CPR_COEF_G(LCD)                              00000000
 DISPC_CPR_COEF_B(LCD)                              00000000
 DISPC_DEFAULT_COLOR(TV)                            00000000
 DISPC_TRANS_COLOR(TV)                              00000000
 DISPC_SIZE_MGR(TV)                                 00000000
 DISPC_OVL_BA0(GFX)                                 8f000000
 DISPC_OVL_BA1(GFX)                                 8f000000
 DISPC_OVL_POSITION(GFX)                            00000000
 DISPC_OVL_SIZE(GFX)                                01df031f
 DISPC_OVL_ATTRIBUTES(GFX)                          000000ad
 DISPC_OVL_FIFO_THRESHOLD(GFX)                      0bff03c0
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
 DISPC_OVL_FIFO_THRESHOLD(VID1)                     00000000
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
 DISPC_OVL_FIFO_THRESHOLD(VID2)                     00000000
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
 # cat dss
 DSS_REVISION                        00000020
 DSS_SYSCONFIG                       00000001
 DSS_SYSSTATUS                       00000001
 DSS_CONTROL                         00000018
 DSS_SDI_CONTROL                     00078006
 DSS_PLL_CONTROL                     01c45968
-DSS_SDI_STATUS                      000000a5
+DSS_SDI_STATUS                      000000bd

A.
