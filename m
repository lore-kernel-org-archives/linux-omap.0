From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/8] HDMI: Split hdmi.c to seperate HDMI IP dependant
 code from DSS.
Date: Thu, 23 Jun 2011 12:58:21 +0300
Message-ID: <1308823101.1834.79.camel@deskari>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49630 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759214Ab1FWJ61 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 05:58:27 -0400
Received: by mail-bw0-f45.google.com with SMTP id 16so1605317bwz.4
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 02:58:26 -0700 (PDT)
In-Reply-To: <1308298637-29753-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mythri P K <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2011-06-17 at 13:47 +0530, Mythri P K wrote:
> HDMI IP block is common between TI OMAP4 Procerssor and Netra processor although
> the Display subsytem is different. Thus to reuse the code between these two
> processors , HDMI IP dependant code is seperated out from hdmi.c and moved to
> new library file hdmi_ti_4xxx_ip.c which now resides in /drivers/video a more
> generic location out of omap2/dss folder.
> 
> This patch series does the split and also renames hdmi_omap4_panel.c to
> hdmi_panel.c as that file has nothing specific to OMAP4 and can be reused for
> other OMAP family of processors as well.

These comments are based on the branch you have, not to particular
patches:

include/video/hdmi_ti_4xxx_ip.h:

- This file is in a way the most important one, because it's the public
API of the component. So you should be extra careful with this, and see
that everything in it makes sense, and it's clear how it is to be used.

- hdmi_core_hdmi_dvi is defined but not used. Should it be in the
private header?

- hdmi_pll_pwr seems to be very low level thing. It requires the user to
know HW details about the PLL, I don't think it should be visible to the
users. It is used in parameters for hdmi_ti_4xxx_set_pll_pwr(). When is
it supposed to be used? Why is hdmi_ti_4xxx_wp_video_start() not enough?

- The same goes to hdmi_ti_4xxx_pll_program. Who does the PLL
calculations, omapdss driver? Shouldn't the HDMI driver do it, the PLL
is a HDMI HW thing, not DSS HW? Or if they are defined in the board
file, and omapdss just gives them to the HDMI driver, I think the data
should be somehow passed through omapdss without omapdss actively
participating in the PLL programming. This would be easy if the HDMI
would use a platform device/driver model, the data could be passed via
the device data.

- If the PLL calculations have to be done by omapdss, couldn't the
hdmi_pll_info be part of hdmi_config?

- Is hdmi_ti_4xxx_phy_off the counterpart of hdmi_ti_4xxx_phy_init? If
so, the naming could be better to clearly show this. Like init/uninit,
enable/disable, etc.

- Is the "phy" relevant (from the user's point of view) in
hdmi_ti_4xxx_phy_init and off? Or could they be just init and uninit?

- Perhaps hdmi_ti_4xxx_basic_configure could be just configure, there's
no advanced configure or similar.

- is the "wp" important in hdmi_ti_4xxx_wp_video_start? 

- read_ti_4xxx_edid() is named differently than the other functions.

drivers/video/hdmi_ti_4xxx_ip.c:

- EXPORT_SYMBOL(hdmi_ti_4xxx_phy_init); is not below the function.

drivers/video/omap2/dss/hdmi.c:

- hdmi_ti_4xxx_set_pll_pwr() is only called in power_off(), but never
enabled. I presume the HDMI driver does that internally. That doesn't
sound like a valid use of the function.

- Looking at hdmi_power_on(), I feel that the API of the HDMI driver
could be simpler. Would it be enough to have just one function to setup
the HDMI, and another to turn the output on?

- omapdss_hdmi_display_set_timing() seems to be broken. It just sets
some variables and calls display_enable().

 Tomi


