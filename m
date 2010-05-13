From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v2 1/2] DSS2: Allow FB_OMAP2 to build without VRFB
Date: Thu, 13 May 2010 18:00:27 +0200
Message-ID: <EBB422FB-C763-4EBE-AAD3-02AE86D4FF05@student.utwente.nl>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com> <1273764028-25822-2-git-send-email-svadivu@ti.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:35517 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab0EMQAd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 12:00:33 -0400
In-Reply-To: <1273764028-25822-2-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Senthilvadivu Guruswamy <svadivu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com, hvaibhav@ti.com


Op 13 mei 2010, om 17:20 heeft Senthilvadivu Guruswamy het volgende geschreven:

> FB_OMAP2 can work without VRFB, but currently does not build. Fix this.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---
> arch/arm/plat-omap/include/plat/vrfb.h |   16 ++++++++++++++++
> 1 file changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/vrfb.h b/arch/arm/plat-omap/include/plat/vrfb.h
> index d8a03ce..3792bde 100644
> --- a/arch/arm/plat-omap/include/plat/vrfb.h
> +++ b/arch/arm/plat-omap/include/plat/vrfb.h
> @@ -35,6 +35,7 @@ struct vrfb {
> 	bool yuv_mode;
> };
> 
> +#ifdef CONFIG_OMAP2_VRFB

That is still a compiletime option, not a runtime check. You need something like if(is_omap3()), not #ifdef 

regards,

Koen