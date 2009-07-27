From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Camera Interface VS/HS Issue
Date: Mon, 27 Jul 2009 08:05:04 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A16E999@dlee02.ent.ti.com>
References: <a187869d0907270546m2be3542cla72366acfc62fb64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43949 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbZG0NBb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2009 09:01:31 -0400
In-Reply-To: <a187869d0907270546m2be3542cla72366acfc62fb64@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: matthias schwarz <matthias.schw@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of matthias schwarz
> Sent: Monday, July 27, 2009 7:47 AM
> To: linux-omap@vger.kernel.org
> Subject: Camera Interface VS/HS Issue
> 
> Hi there,
> 
> i just recently ran into a problem when trying to let the ISP
> (OMAP3530) generate HS/VS signals in SYNC mode.
> I am building a module to do so.
> 
> It basically enables the three clocks (cam_ick, cam_mclk and
> csi2_96m_fck),
> then sets
> 
> ISPCCDC_PIX_LINES_PPLN
> ISPCCDC_PIX_LINES_HLPRF
> ISPCCDC_HD_VD_WID_VDW
> ISPCCDC_HD_VD_WID_HDW
> ISPCCDC_SYN_MODE_VDHDEN
> ISPCCDC_SYN_MODE_VDHDOUT
> ISPCCDC_CFG_VDLC
> ISPTCTRL_CTRL_DIVA
> ISPTCTRL_CTRL_DIVB
> ISPCCDC_PCR
> 
> via some calls to ioremap and ioread32/iowrite32.
> My question now is the following:
> when i hook an oscilloscope to the corresponding pins (CAM_VS, CAM_HS,
> CAM_XCLKA) i can see that only the CAM_XCLKA is working correctly,
> also at the configured frequency.
> Both, CAM_VS and CAM_HS remain at low voltage all the time, even when
> i switch their polarities (ISPCCDC_SYN_MODE_VDPOL,
> ISPCCDC_SYN_MODE_HDPOL) that behavior does not change and signals
> always remain at low voltage.
> 
> Could someone help me out, or give me a hint what i might be missing
> to generate those output signals correctly?

Matthias,

Can you please provide a register dump of the above values?

Looks like you're touching the adequate registers though... But I can help you more looking at the values.

Regards,
Sergio
> 
> Thank you very much,
> Matthias
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

