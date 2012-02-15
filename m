From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 4/5] OMAPDSS: Export functions to enable dynamic linking
Date: Tue, 14 Feb 2012 18:00:22 -0600
Message-ID: <1329264022.2031.1570.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
References: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
	 <1329004530-28029-5-git-send-email-ricardo.neri@ti.com>
	 <1329140906.2817.6.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43750 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755592Ab2BOAAr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 19:00:47 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1F00krZ000517
	for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 18:00:46 -0600
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1F00kA4022300
	for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 18:00:46 -0600 (CST)
In-Reply-To: <1329140906.2817.6.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org

Hi Tomi,

Thanks for your comments.
On Mon, 2012-02-13 at 15:48 +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On Sat, 2012-02-11 at 17:55 -0600, Ricardo Neri wrote:
> > The functions dss_init_hdmi_ip_ops and dss_has_feature are used by
> > the ASoC HDMI codec. Both the ASoC codec and DSS may be built
> > as separate kernel modules. Hence, these two functions need to be
> > available for dynamic linking.
> 
> Neither of those functions should be exported, they are omapdss
> internal. And you had to hack around to make those usable by adding
> drivers/video/omap2/dss into the include path.
> 
> Anything that is exported from omapdss should be added to
> include/video/omapdss.h. Users of omapdss should never include anything
> from drivers/video/omap2/dss.
> 
> But as I said, neither of those functions should be exported, they are
> clearly omapdss internal functions. For dss_has_feature we probably need
> a new function to convey the information about the hdmi features that
> the audio side needs. Or perhaps it can be in the ip_data.
I will try to create this new functions and add it to
include/video/omapdss.h and resubmit the patch. The approach that I am
following is to maintain an hdmi_ip_data structure in the ASoC HDMI
codec driver to utilize the functions of the HDMI IP library. If the DSS
features are stored in the ip_data then I would need a DSS function
(i.e., dss_features_init or similar) to initialize it. This may not be
right as that is an omapdss internal function.

> 
> For dss_init_hdmi_ip_ops I don't see why the audio part should see it.
> Initializing the ops should clearly be done by omapdss automatically.
Yes, the DSS HDMI driver already does this for its own struct
hdmi_ip_data. However, under my approach, the hdmi_ip_data of the ASoC
HDMI driver needs to be initialized as well.

Another approach is to not have an hdmi_ip_data in the ASoC HDMI driver
and reuse the ip_data of the DSS HDMI driver. In that case, however, a
lot of set/get functions would need to be implemented in DSS to expose
audio functionality: HDMI mode, deep color configuration, audio
infoframe config and core and wrapper configuration for audio. An
example of this is already present in here:

http://www.spinics.net/lists/linux-omap/msg64479.html

Being HDMI special as no other display combines audio and video, maybe a
special header file could be created for HDMI.

What do you think?

Ricardo

> 
>  Tomi
> 


