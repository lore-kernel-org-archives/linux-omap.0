From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 9/9] ASoC: Kconfig: OMAP4: Enable support for PandaBoards
Date: Thu, 22 Dec 2011 16:11:44 +0200
Message-ID: <4EF33AA0.2090004@ti.com>
References: <1324557768-8216-1-git-send-email-peter.ujfalusi@ti.com> <1324557768-8216-10-git-send-email-peter.ujfalusi@ti.com> <20111222132658.GT4546@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:36019 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752448Ab1LVOLm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 09:11:42 -0500
Received: by lahc1 with SMTP id c1so4738416lah.22
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 06:11:40 -0800 (PST)
In-Reply-To: <20111222132658.GT4546@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 12/22/2011 03:26 PM, Mark Brown wrote:
> Given that it's now a platform device and there's a reasonable
> expectation that there will be lots of other boards derived from this
> it'd seem sensible to just remove the machine dependencies so people
> don't have to patch the Kconfig.

True, I'll replace the machine dependencies that we only depend on OMAP=
4

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
