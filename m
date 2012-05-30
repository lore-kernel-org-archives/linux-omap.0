From: Xiao Jiang <jgq516@gmail.com>
Subject: Compile err when enable CONFIG_SND_OMAP_SOC_OMAP_HDMI
Date: Wed, 30 May 2012 15:14:45 +0800
Message-ID: <4FC5C8E5.7060108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51623 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665Ab2E3GWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 May 2012 02:22:43 -0400
Received: by vcbf11 with SMTP id f11so2623834vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 23:22:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jgq516@gmail.com

Hello,

After enable SND_OMAP_SOC_OMAP_HDMI with omap2plus_defconfig, I got some 
err infos with latest
Linus's tree, does somebody also has the same issue?

sound/soc/omap/omap-hdmi.c:45:24: error: field 'dss_audio' has 
incomplete type
sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_startup':
sound/soc/omap/omap-hdmi.c:67:27: error: 'struct omap_dss_driver' has no 
member named 'audio_supported'
sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_prepare':
sound/soc/omap/omap-hdmi.c:79:29: error: 'struct omap_dss_driver' has no 
member named 'audio_enable'
sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_hw_params':
sound/soc/omap/omap-hdmi.c:208:28: error: 'struct omap_dss_driver' has 
no member named 'audio_config'
sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_trigger':
sound/soc/omap/omap-hdmi.c:224:29: error: 'struct omap_dss_driver' has 
no member named 'audio_start'
sound/soc/omap/omap-hdmi.c:229:23: error: 'struct omap_dss_driver' has 
no member named 'audio_stop'
sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_shutdown':
sound/soc/omap/omap-hdmi.c:242:22: error: 'struct omap_dss_driver' has 
no member named 'audio_disable'
sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_prepare':
sound/soc/omap/omap-hdmi.c:80:1: warning: control reaches end of 
non-void function

Regards,
Xiao

