From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/4] ARM: OMAP3: Switch to use the unified audio driver
 (omap-twl4030) for selected boards
Date: Thu, 09 Aug 2012 13:21:43 +0300
Message-ID: <50238F37.2030302@ti.com>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com> <1344419650-5389-4-git-send-email-peter.ujfalusi@ti.com> <50225A84.5010008@compulab.co.il> <50225BB5.3000407@ti.com> <50226444.4060100@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39741 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757541Ab2HIKVm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 06:21:42 -0400
Received: by obqv19 with SMTP id v19so1004108obq.16
        for <linux-omap@vger.kernel.org>; Thu, 09 Aug 2012 03:21:41 -0700 (PDT)
In-Reply-To: <50226444.4060100@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, devicetree-discuss@lists.ozlabs.org

On 08/08/2012 04:06 PM, Igor Grinberg wrote:
> Well, yes I know we will need to adjust the user space.
> I wanted to change that for a long time and did not get to it...
> Now, with your patches, it seems like the best time for doing this.

Done for the v2. You will have card named "cm-t3x".

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
