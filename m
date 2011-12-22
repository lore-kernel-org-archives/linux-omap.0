From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 8/9] OMAP4: omap4panda: Enable audio support
Date: Thu, 22 Dec 2011 16:14:34 +0200
Message-ID: <4EF33B4A.2040901@ti.com>
References: <1324557768-8216-1-git-send-email-peter.ujfalusi@ti.com> <1324557768-8216-9-git-send-email-peter.ujfalusi@ti.com> <20111222132426.GS4546@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46960 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750958Ab1LVOOb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 09:14:31 -0500
Received: by mail-lpp01m010-f48.google.com with SMTP id m7so4692981laa.35
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 06:14:30 -0800 (PST)
In-Reply-To: <20111222132426.GS4546@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 12/22/2011 03:24 PM, Mark Brown wrote:
> Is audio the only difference between the two boards?  If there's more
> stuff it might be more sensible to have a single place which decides
> what the differences are rather than scattering it in various places.

I'm not sure, I have only checked the audio. But there could be other
differences.
I'll make this as a generic function.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
