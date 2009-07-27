From: matthias schwarz <matthias.schw@googlemail.com>
Subject: Camera Interface VS/HS Issue
Date: Mon, 27 Jul 2009 14:46:34 +0200
Message-ID: <a187869d0907270546m2be3542cla72366acfc62fb64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f221.google.com ([209.85.218.221]:56615 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbZG0Mvu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2009 08:51:50 -0400
Received: by bwz21 with SMTP id 21so198376bwz.37
        for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2009 05:51:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi there,

i just recently ran into a problem when trying to let the ISP
(OMAP3530) generate HS/VS signals in SYNC mode.
I am building a module to do so.

It basically enables the three clocks (cam_ick, cam_mclk and csi2_96m_fck),
then sets

ISPCCDC_PIX_LINES_PPLN
ISPCCDC_PIX_LINES_HLPRF
ISPCCDC_HD_VD_WID_VDW
ISPCCDC_HD_VD_WID_HDW
ISPCCDC_SYN_MODE_VDHDEN
ISPCCDC_SYN_MODE_VDHDOUT
ISPCCDC_CFG_VDLC
ISPTCTRL_CTRL_DIVA
ISPTCTRL_CTRL_DIVB
ISPCCDC_PCR

via some calls to ioremap and ioread32/iowrite32.
My question now is the following:
when i hook an oscilloscope to the corresponding pins (CAM_VS, CAM_HS,
CAM_XCLKA) i can see that only the CAM_XCLKA is working correctly,
also at the configured frequency.
Both, CAM_VS and CAM_HS remain at low voltage all the time, even when
i switch their polarities (ISPCCDC_SYN_MODE_VDPOL,
ISPCCDC_SYN_MODE_HDPOL) that behavior does not change and signals
always remain at low voltage.

Could someone help me out, or give me a hint what i might be missing
to generate those output signals correctly?

Thank you very much,
Matthias
