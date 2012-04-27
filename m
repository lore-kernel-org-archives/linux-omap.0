From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: Build error: undefined reference to `snd_soc_unregister_codec'
Date: Fri, 27 Apr 2012 10:16:47 -0500
Message-ID: <4F9AB85F.3020107@ti.com>
References: <20120427132818.GO24211@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57781 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760363Ab2D0PRH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 11:17:07 -0400
In-Reply-To: <20120427132818.GO24211@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi Rusell,

On 04/27/2012 08:28 AM, Russell King - ARM Linux wrote:
> When building ALSA as modules:
>
> drivers/built-in.o: In function `omapdss_hdmihw_remove':
> omap_hwspinlock.c:(.text+0x23da8): undefined reference to `snd_soc_unregister_codec'
> drivers/built-in.o: In function `omapdss_hdmihw_probe':
> omap_hwspinlock.c:(.text+0x24248): undefined reference to `snd_soc_register_codec'
>
> (the filename is inaccurate).
>
> This happens because drivers/video/omap2/dss/hdmi.c is built-in and uses
> ASoC services, but ASoC and ALSA are modular.

As you mention, this happens because the ASoC HDMI codec is embeeded in 
the DSS driver. There is a set of patches currently under discussion to 
decouple the ASoC HDMI codec from DSS[1]. This will fix the issue.

BR,
[1]http://www.spinics.net/lists/linux-omap/msg67307.html

Ricardo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

