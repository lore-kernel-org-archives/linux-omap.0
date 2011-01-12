From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH v2 2/4] ASoC: DMIC codec: Adding a generic
 DMIC codec
Date: Wed, 12 Jan 2011 00:54:48 +0000
Message-ID: <1294793688.3338.484.camel@odin>
References: <1294322439-16305-1-git-send-email-dlambert@ti.com>
	 <1294322439-16305-3-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34710 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406Ab1ALAyy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 19:54:54 -0500
Received: by wwa36 with SMTP id 36so53085wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Jan 2011 16:54:53 -0800 (PST)
In-Reply-To: <1294322439-16305-3-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Thu, 2011-01-06 at 08:00 -0600, David Lambert wrote:
> This codec is to be used by the DMIC driver to
> control the DMIC codec.  This driver will be used on future
> implementations of the DMIC driver to support codec specific
> features.
> 
> At this time, the codec driver just registers the codec DAI.
> 
> Signed-off-by: David Lambert <dlambert@ti.com>
> ---
>  sound/soc/codecs/Kconfig  |    3 ++
>  sound/soc/codecs/Makefile |    2 +
>  sound/soc/codecs/dmic.c   |   81 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/dmic.c
> 


Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

