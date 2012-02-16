From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 4/5] OMAPDSS: Export functions to enable dynamic linking
Date: Wed, 15 Feb 2012 20:46:37 -0600
Message-ID: <1329360397.2016.149.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
References: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
	 <1329004530-28029-5-git-send-email-ricardo.neri@ti.com>
	 <1329140906.2817.6.camel@deskari>
	 <1329264022.2031.1570.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
	 <1329294205.1892.36.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33194 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756909Ab2BPCrF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 21:47:05 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1G2l4tY013504
	for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 20:47:04 -0600
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1G2l4I0022488
	for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 20:47:04 -0600 (CST)
In-Reply-To: <1329294205.1892.36.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org

Hi Tomi,

On Wed, 2012-02-15 at 10:23 +0200, Tomi Valkeinen wrote:
> On Tue, 2012-02-14 at 18:00 -0600, Ricardo Neri wrote:
> > Hi Tomi,
> > 
> > Thanks for your comments.
> > On Mon, 2012-02-13 at 15:48 +0200, Tomi Valkeinen wrote:
> > > Hi,
> > > 
> > > On Sat, 2012-02-11 at 17:55 -0600, Ricardo Neri wrote:
> > > > The functions dss_init_hdmi_ip_ops and dss_has_feature are used by
> > > > the ASoC HDMI codec. Both the ASoC codec and DSS may be built
> > > > as separate kernel modules. Hence, these two functions need to be
> > > > available for dynamic linking.
> > > 
> > > Neither of those functions should be exported, they are omapdss
> > > internal. And you had to hack around to make those usable by adding
> > > drivers/video/omap2/dss into the include path.
> > > 
> > > Anything that is exported from omapdss should be added to
> > > include/video/omapdss.h. Users of omapdss should never include anything
> > > from drivers/video/omap2/dss.
> > > 
> > > But as I said, neither of those functions should be exported, they are
> > > clearly omapdss internal functions. For dss_has_feature we probably need
> > > a new function to convey the information about the hdmi features that
> > > the audio side needs. Or perhaps it can be in the ip_data.
> > I will try to create this new functions and add it to
> > include/video/omapdss.h and resubmit the patch. The approach that I am
> > following is to maintain an hdmi_ip_data structure in the ASoC HDMI
> > codec driver to utilize the functions of the HDMI IP library. If the DSS
> > features are stored in the ip_data then I would need a DSS function
> > (i.e., dss_features_init or similar) to initialize it. This may not be
> > right as that is an omapdss internal function.
> > 
> > > 
> > > For dss_init_hdmi_ip_ops I don't see why the audio part should see it.
> > > Initializing the ops should clearly be done by omapdss automatically.
> > Yes, the DSS HDMI driver already does this for its own struct
> > hdmi_ip_data. However, under my approach, the hdmi_ip_data of the ASoC
> > HDMI driver needs to be initialized as well.
> 
> Ah, I see, you create your own hdmi_ip_data there. I don't think this is
> the right direction to go...
> 
> I have a feeling that this won't be an easy task.

This approach seemed appealing as the ASoC driver only deals with HDMI
audio configuration, requires access only to the HDMI IP library and
minimizes the amount of code to be implemented in DSS. While it is true
that it uses its own hdmi_ip_data, it does not overlap the DSS HDMI
driver functionality nor overwrites any configuration done by DSS.

> 
> > Another approach is to not have an hdmi_ip_data in the ASoC HDMI driver
> > and reuse the ip_data of the DSS HDMI driver. In that case, however, a
> > lot of set/get functions would need to be implemented in DSS to expose
> > audio functionality: HDMI mode, deep color configuration, audio
> > infoframe config and core and wrapper configuration for audio. An
> > example of this is already present in here:
> > 
> > http://www.spinics.net/lists/linux-omap/msg64479.html
> > 
> > Being HDMI special as no other display combines audio and video, maybe a
> > special header file could be created for HDMI.
> 
> We will have the same issue with DisplayPort, so it's not that special.

I spent some time comparing audio support in HDMI and DisplayPort. On
both, audio is based on CEA-861 infoframes and IEC-60958 and IEC-61937
transport frames. Also, both configure clock recovery parameters. Hence,
both will have similar configuration needs and perhaps they can share
the same set of functions exposed by DSS (omap_dss_audio_* maybe?).
Then, DSS will pass this configuration to the appropriate HDMI or
DisplayPort driver.

> The HDMI and DSS architecture doesn't currently have a way to do this
> easily. I'm not even sure how this should be done.
> 
> However, I think the audio driver should be a bit similar conceptually
> than, say, omapfb, but for audio instead of video. What I mean is that
> the audio driver should find the omap_dss_device/driver that it wants to
> use, and then uses the API offered by the device/driver to handle the
> audio.

> This would mean adding a bunch of functions into omap_dss_driver.
> Preferably the functions would be non-HDMI specific, so that DisplayPort
> could use them also, or actually any other display type.
What other display types featuring audio and video should be considered
at this point?
> 
> The audio driver should iterate the dss devices to find the ones (there
> could well be multiple HDMI outputs) that support audio when the driver
> starts.
> 
> Does the above make sense?

At first glance, I think the omapd_dss_audio_* functions should cover
the following:
 * CEA-861 infoframe configuration
 * IEC-60958 configuration (IEC-61937 support added later)
 * audio start/stop
 * whether audio is supported by the current video configuration
 * a notifier power and video events (e.g, DVI/HDMI mode, changes in
pixel clock and deep color configuration) to the ASoC driver. Maybe an
enum can encompass DisplayPort and HDMI events.

I think that this is generic enough to cover DisplayPort and HDMI,
unless you consider that I am missing some important display type.

I can try to make it similar to omapfb.

> Btw, another thing, not directly related:
> 
> I see these in the hdmi driver:
> 
>  #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
>         defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
> 
> If the audio driver is separate, I don't see need for those. In fact, I
> think they are wrong in that case. The HDMI driver should have the audio
> support for any user, which could in theory be some other driver than
> the audio driver you are working on.
> 
> If the amount of audio code is big in the hdmi driver (which I guess it
> isn't), we could have a hidden kernel config option to enable the HDMI
> audio support. And the audio driver would use Kconfig's "select" to
> enable it.

I agree. Actually, I had created a patch (not submitted yet) that made
HDMI audio support available when selecting just the ASoC HDMI codec not
the whole ASoC HDMI audio support. As you say, this can be taken one
step further with a DSS config option for HDMI audio selectable by
anyone that desires it.

Ricardo
> 
>  Tomi
> 


