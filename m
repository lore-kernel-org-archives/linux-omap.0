From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] DSS2 Include VRFB into omap2-3build only
Date: Mon, 10 May 2010 09:39:55 +0200
Message-ID: <1A2F53DA-903A-4667-A27F-492A3499F7ED@student.utwente.nl>
References: <1273474110-22451-1-git-send-email-svadivu@ti.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:58319 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362Ab0EJHkB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 03:40:01 -0400
Received: by ewy20 with SMTP id 20so808515ewy.1
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 00:39:59 -0700 (PDT)
In-Reply-To: <1273474110-22451-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Senthilvadivu Guruswamy <svadivu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, tony@atomide.com, tomi.valkeinen@nokia.com, v-hiremath@ti.com


Op 10 mei 2010, om 08:48 heeft Senthilvadivu Guruswamy het volgende geschreven:

> Exclude VRFB from OMAP4 onwards and include only for
> OMAP2 and OMAP3 builds.  In OMAP4 VRFB HW IP is replaced
> with a new HW IP "TILER"
> 
> --- a/drivers/video/omap2/Kconfig
> +++ b/drivers/video/omap2/Kconfig
> @@ -3,6 +3,10 @@ config OMAP2_VRAM
> 
> config OMAP2_VRFB
> 	bool
> +	depends on FB_OMAP2 && (!ARCH_OMAP4)
> +	default y if (ARCH_OMAP2 || ARCH_OMAP3)
> +	help
> +	  OMAP VRFB buffer support is efficient for rotation

How does this work for multi-omap kernels, e.g. building a kernel with beagle and panda support?

regards,

Koen