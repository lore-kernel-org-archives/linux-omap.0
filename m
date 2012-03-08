From: Alexander Graf <agraf@suse.de>
Subject: [BUG] Compile error with CONFIG_SND_OMAP_SOC_OMAP4_HDMI
Date: Thu, 8 Mar 2012 15:08:58 +0100
Message-ID: <8DA1E7C4-0402-4FFF-9896-397513C88329@suse.de>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56815 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab2CHOJA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 09:09:00 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 8D5468BB22
	for <linux-omap@vger.kernel.org>; Thu,  8 Mar 2012 15:08:59 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>

Hi list,

Trying to compile 3.3-rc6 with the following option combination fails:

CONFIG_SND_OMAP_SOC_OMAP4_HDMI=m
CONFIG_SND_OMAP_SOC_HDMI=m
CONFIG_OMAP2_DSS=y

drivers/built-in.o: In function `omapdss_hdmihw_remove':
/home/abuild/rpmbuild/BUILD/kernel-omap2plus-3.3.rc6/linux-3.3-rc6/drivers/video/omap2/dss/hdmi.c:879: undefined reference to `snd_soc_unregister_codec'
drivers/built-in.o: In function `omapdss_hdmihw_probe':
/home/abuild/rpmbuild/BUILD/kernel-omap2plus-3.3.rc6/linux-3.3-rc6/drivers/video/omap2/dss/hdmi.c:863: undefined reference to `snd_soc_register_codec'

However, we do want to have DSS compiled into the kernel to ensure that graphics are available, but since audio is not quite as crucial for debugging, that one should live as a module.

According to Takashi, it shouldn't be all that hard to split the HDMI audio code from dss/hdmi.c, but I'm currently lacking the time to do so. If anyone's interested in picking it up, I'd very much appreciate it!


Thanks a lot,

Alex

