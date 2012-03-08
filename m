From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [BUG] Compile error with CONFIG_SND_OMAP_SOC_OMAP4_HDMI
Date: Thu, 8 Mar 2012 12:49:39 -0600
Message-ID: <1331232579.2035.6.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
References: <8DA1E7C4-0402-4FFF-9896-397513C88329@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40529 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab2CHSub (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 13:50:31 -0500
In-Reply-To: <8DA1E7C4-0402-4FFF-9896-397513C88329@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Graf <agraf@suse.de>
Cc: linux-omap@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

Hi Alex,

On Thu, 2012-03-08 at 15:08 +0100, Alexander Graf wrote:
> Hi list,
> 
> Trying to compile 3.3-rc6 with the following option combination fails:
> 
> CONFIG_SND_OMAP_SOC_OMAP4_HDMI=m
> CONFIG_SND_OMAP_SOC_HDMI=m
> CONFIG_OMAP2_DSS=y
> 
> drivers/built-in.o: In function `omapdss_hdmihw_remove':
> /home/abuild/rpmbuild/BUILD/kernel-omap2plus-3.3.rc6/linux-3.3-rc6/drivers/video/omap2/dss/hdmi.c:879: undefined reference to `snd_soc_unregister_codec'
> drivers/built-in.o: In function `omapdss_hdmihw_probe':
> /home/abuild/rpmbuild/BUILD/kernel-omap2plus-3.3.rc6/linux-3.3-rc6/drivers/video/omap2/dss/hdmi.c:863: undefined reference to `snd_soc_register_codec'
> 
> However, we do want to have DSS compiled into the kernel to ensure that graphics are available, but since audio is not quite as crucial for debugging, that one should live as a module.
> 
> According to Takashi, it shouldn't be all that hard to split the HDMI audio code from dss/hdmi.c, but I'm currently lacking the time to do so. If anyone's interested in picking it up, I'd very much appreciate it!

I have started working on moving the HDMI audio part to /sound
(http://www.spinics.net/lists/linux-omap/msg64477.html) and the
relocation discussion has lead to proposing an interface to provide
funtionality in DSS for displays that support audio (DisplayPort and
HDMI, atm, http://www.spinics.net/lists/linux-omap/msg64744.html).

I am about to send a set of patches to DSS for this and then have the
audio driver use the proposed DSS functionality.

> 
> Thanks a lot,
> 
> Alex
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


