From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 3/3] DSPBRIDGE: remove hw_prcm module and related
 functions
Date: Tue, 18 May 2010 20:08:36 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB7A83D5@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CAF98C66@dlee06.ent.ti.com>
 <4BF331FB.4040403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40882 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab0ESBIm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 21:08:42 -0400
In-Reply-To: <4BF331FB.4040403@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>


> This patch is preventing dsp to go to OFF state after MMU Fault,As a
> result DSP recovery is not working.
> 
> Here is the reg dump.The value of MAILBOX_IRQENABLE_DSP(0x4809410c)
> should have been 0x1.


@@ -492,12 +452,13 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
        if (DSP_SUCCEEDED(status)) {
                /* Reset and Unreset the RST2, so that BOOTADDR is copied to
                 * IVA2 SYSC register */
-               hw_rst_reset(resources.dw_prm_base, HW_RST2_IVA2);
+               (*pdata->dsp_prm_rmw_bits)(OMAP3430_RST2_IVA2,
+                       OMAP3430_RST1_IVA2, OMAP3430_IVA2_MOD, RM_RSTCTRL);

There is an error in with the second parameter, it has to be OMAP3430_RST2_IVA2 instead of OMAP3430_RST1_IVA2, this is avoiding BOOTADDR of being copied to IVA2 SYSC register. Therefore DSP can not boot after recovery. It works first time because iva mmu is already under reset.

I will send a fix for this issue.

Regards,
Fernando.

> 
> ******* REG DUMP *********************
> CM_FCLKEN_IVA2(0x48004000) = 0x1
> CM_CLKEN_PLL_IVA2(0x48004004) = 0x37
> CM_ICLKEN1_IVA2(0x48004010) = 0x0
> CM_IDLEST_IVA2(0x48004020) = 0x1
> CM_IDLEST_PLL_IVA2(0x48004024) = 0x0
> CM_AUTOIDLE_PLL_IVA2(0x48004034) = 0x1
> CM_CLKSEL1_PLL_IVA2(0x48004040) = 0x9450b
> CM_CLKSTCTRL_IVA2(0x48004048) = 0x3
> CM_CLKSTST_IVA2(0x4800404c) = 0x0
> RM_RSTCTRL_IVA2(0x48306050) = 0x4
> RM_RSTST_IVA2(0x48306058) = 0x305
> PM_PWSTCTRL_IVA2(0x483060e0) = 0xff0f05
> PM_PWSTST_IVA2(0x483060e4) = 0xff7
> CM_ICLKEN1_CORE(0x48306a10) = 0x30000d2
> PM_MPUGRPSEL_PER(0x483070a4) = 0x3e847
> PM_IVA2GRPSEL_PER(0x483070a8) = 0x80
> PRM_IRQSTATUS_IVA2(0x483060f8) = 0x2
> 
> 
> ******* MBX DUMP *********************
> MAILBOX_SYSCONFIG(0x48094010) = 0x11
> MAILBOX_FIFOSTATUS_MPU(0x48094080) = 0x0
> MAILBOX_FIFOSTATUS_DSP(0x48094084) = 0x0
> MAILBOX_MSGSTATUS_MPU(0x480940c0) = 0x0
> MAILBOX_MSGSTATUS_DSP(0x480940c4) = 0x0
> MAILBOX_IRQSTATUS_MPU(0x48094100) = 0xaaa
> MAILBOX_IRQSTATUS_DSP(0x48094108) = 0xaae
> MAILBOX_IRQENABLE_MPU(0x48094104) = 0x4
> MAILBOX_IRQENABLE_DSP(0x4809410c) = 0x0
> 
> Regards,
> Deepak
