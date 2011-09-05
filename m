From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 00/10]HDMI: Split hdmi.c in DSS to seperate OMAP
 dependent
Date: Mon, 05 Sep 2011 10:40:20 +0300
Message-ID: <1315208420.2130.31.camel@deskari>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:48422 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931Ab1IEHkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 03:40:25 -0400
Received: by mail-bw0-f49.google.com with SMTP id 17so4846660bke.8
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 00:40:23 -0700 (PDT)
In-Reply-To: <1314960470-2616-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org

On Fri, 2011-09-02 at 16:17 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> HDMI IP block is common between TI OMAP4 Procerssor and Netra processor although
> the Display subsytem is different.Also the IP block in future OMAP may differ
> from the one existing in OMAP4. Thus to reuse the code between these two
> processors , and maintain the multi omap build functionality in DSS.
> HDMI IP dependant code is seperated out from hdmi.c and moved to
> new library file hdmi_ti_4xxx_ip.c.From the DSS dependent HDMI code only the
> function pointer to functionality/features offered by HDMI is called.
> 
> This patch series does the split and also renames hdmi_omap4_panel.c to
> hdmi_panel.c as that file has nothing specific to OMAP4 and can be reused for
> other OMAP family of processors as well.
> 
> This patch series is based on Tomi's LO-DSS2 master branch.
> 
> changes since
> V2: Rename certain files/function to have standard format and handle scenario
> when hdmi is disabled.
> V1: Function pointer approach to call the HDMI IP functions from DSS HDMI

No change log for this version. It'd be nice to have it, so it's easier
to see what changes made into this version.

I also see this when compiling with sparse:

drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c:166:5: warning: symbol
'hdmi_set_pll_pwr' was not declared. Should it be static?

 Tomi


