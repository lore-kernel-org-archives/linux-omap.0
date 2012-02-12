From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 0/5] OMAPDSS: Relocate ASoC HDMI codec to sound
Date: Sat, 11 Feb 2012 18:34:40 -0600
Message-ID: <1329006880.2035.1.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
References: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39128 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547Ab2BLAfC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Feb 2012 19:35:02 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1C0Z2E0006628
	for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 18:35:02 -0600
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1C0Z14h003802
	for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 18:35:02 -0600 (CST)
In-Reply-To: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, "K, Mythri P" <mythripk@ti.com>
Cc: s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org

Hi,
On Sat, 2012-02-11 at 17:55 -0600, Ricardo Neri wrote:
> Hello,
> 
> In order to give to the OMAP HDMI code a more logical arrangement, the audio
> part is moved to /sound. Only the IP-specific functions remain in the DSS HDMI
> IP library. These patches introduce modifications to expose the DSS functio-
> nality that is going to be required by the ASoC driver.
> 
> This relocation is split in two parts. This is first part. The second part
> is for ASoC and is to be submitted to the ALSA list. The purpose of
> this split is to ease the integration of these patches first to DSS
> and then to ASoC.

The ASoC part has also been submitted and can be consulted here:

http://mailman.alsa-project.org/pipermail/alsa-devel/2012-February/049058.html

Ricardo
> 
> This work is also based on the patches previously sent for HDMI audio MCLK
> support:
> 
> http://www.spinics.net/lists/linux-omap/msg64302.html
> 
> and was implemented on top of:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git v3.3-rc3
> 
> Thanks,
> 
> Ricardo
> 
> Ricardo Neri (5):
>   OMAPDSS: HDMI: Add function to get the HDMI mode
>   OMAPDSS: HDMI: Rename audio functions in HDMI IP library
>   OMAPDSS: HDMI: Add audio config functions to HDMI IP ops
>   OMAPDSS: Export functions to enable dynamic linking
>   OMAPDSS/ASoC: Relocate ASoC HDMI codec. Part 1
> 
>  drivers/video/omap2/dss/dss.h             |    1 +
>  drivers/video/omap2/dss/dss_features.c    |   10 +-
>  drivers/video/omap2/dss/hdmi.c            |  236 +----------------------------
>  drivers/video/omap2/dss/ti_hdmi.h         |   26 +++-
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   63 +--------
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |   13 --
>  6 files changed, 41 insertions(+), 308 deletions(-)
> 


