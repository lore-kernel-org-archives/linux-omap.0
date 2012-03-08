From: Alexander Graf <agraf@suse.de>
Subject: Re: [BUG] Compile error with CONFIG_SND_OMAP_SOC_OMAP4_HDMI
Date: Thu, 8 Mar 2012 23:44:34 +0100
Message-ID: <EE5BA538-733B-4141-AB52-AE5A7D786A1E@suse.de>
References: <8DA1E7C4-0402-4FFF-9896-397513C88329@suse.de> <1331232579.2035.6.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55825 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889Ab2CHWnh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 17:43:37 -0500
In-Reply-To: <1331232579.2035.6.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>



On 08.03.2012, at 19:49, Ricardo Neri <ricardo.neri@ti.com> wrote:

> Hi Alex,
> 
> On Thu, 2012-03-08 at 15:08 +0100, Alexander Graf wrote:
>> Hi list,
>> 
>> Trying to compile 3.3-rc6 with the following option combination fails:
>> 
>> CONFIG_SND_OMAP_SOC_OMAP4_HDMI=m
>> CONFIG_SND_OMAP_SOC_HDMI=m
>> CONFIG_OMAP2_DSS=y
>> 
>> drivers/built-in.o: In function `omapdss_hdmihw_remove':
>> /home/abuild/rpmbuild/BUILD/kernel-omap2plus-3.3.rc6/linux-3.3-rc6/drivers/video/omap2/dss/hdmi.c:879: undefined reference to `snd_soc_unregister_codec'
>> drivers/built-in.o: In function `omapdss_hdmihw_probe':
>> /home/abuild/rpmbuild/BUILD/kernel-omap2plus-3.3.rc6/linux-3.3-rc6/drivers/video/omap2/dss/hdmi.c:863: undefined reference to `snd_soc_register_codec'
>> 
>> However, we do want to have DSS compiled into the kernel to ensure that graphics are available, but since audio is not quite as crucial for debugging, that one should live as a module.
>> 
>> According to Takashi, it shouldn't be all that hard to split the HDMI audio code from dss/hdmi.c, but I'm currently lacking the time to do so. If anyone's interested in picking it up, I'd very much appreciate it!
> 
> I have started working on moving the HDMI audio part to /sound
> (http://www.spinics.net/lists/linux-omap/msg64477.html) and the
> relocation discussion has lead to proposing an interface to provide
> funtionality in DSS for displays that support audio (DisplayPort and
> HDMI, atm, http://www.spinics.net/lists/linux-omap/msg64744.html).
> 
> I am about to send a set of patches to DSS for this and then have the
> audio driver use the proposed DSS functionality.

Ah, very cool! Thanks a lot for working on that :).

Please let me know when that hits mainline, so I can enable HDMI audio output in openSUSE again :)


Alex

