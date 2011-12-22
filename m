From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v2 1/9] include: platform_data: Platform data header for
 OMAP4 ASoC audio
Date: Thu, 22 Dec 2011 15:42:53 +0000
Message-ID: <1324568573.4138.5.camel@odin>
References: <1324557768-8216-1-git-send-email-peter.ujfalusi@ti.com>
	 <1324557768-8216-2-git-send-email-peter.ujfalusi@ti.com>
	 <20111222130453.GQ4546@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:47632 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753060Ab1LVPm6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 10:42:58 -0500
Received: by mail-we0-f172.google.com with SMTP id b14so5570862wer.17
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 07:42:57 -0800 (PST)
In-Reply-To: <20111222130453.GQ4546@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Thu, 2011-12-22 at 13:04 +0000, Mark Brown wrote:
> On Thu, Dec 22, 2011 at 02:42:40PM +0200, Peter Ujfalusi wrote:
> 
> >  include/linux/platform_data/omap-abe-twl6040.h |   48 ++++++++++++++++++++++++
> 
> omap-abe-mcpdm-twl6040 please.  Seriously, just drop the abe - it's not
> an optional feature of the OMAP and the names are getting quite long.

ABE can be an optional feature on OMAP (and quite an important one when
it is used). Fwiw, we do have a mixture of users, most use the ABE but
some don't, so it's best to specify ABE in the naming to avoid any
confusion.

This patch looks fine to me.

Regards

Liam


