From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 00/10]HDMI: Split hdmi.c in DSS to seperate OMAP
 dependent
Date: Mon, 05 Sep 2011 15:15:16 +0300
Message-ID: <1315224916.1825.2.camel@lappyti>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56262 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752998Ab1IEMPU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 08:15:20 -0400
Received: by mail-bw0-f48.google.com with SMTP id t2so6376323bka.35
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 05:15:19 -0700 (PDT)
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

The kernel doesn't compile at all after enabling
SND_OMAP_SOC_OMAP4_HDMI. Looks like you didn't move any of the sound
stuff, but just left them in hdmi.c file.

 Tomi


