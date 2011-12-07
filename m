From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
Date: Wed, 07 Dec 2011 10:45:25 +0200
Message-ID: <4EDF27A5.7090909@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com> <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com> <20111203112206.GE6043@opensource.wolfsonmicro.com> <4EDCCAE0.2000009@ti.com> <20111205154611.GV11150@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:59355 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752721Ab1LGIpU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 03:45:20 -0500
Received: by lagw12 with SMTP id w12so26025lag.30
        for <linux-omap@vger.kernel.org>; Wed, 07 Dec 2011 00:45:17 -0800 (PST)
In-Reply-To: <20111205154611.GV11150@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 12/05/2011 05:46 PM, Mark Brown wrote:
> And what I'm saying is that my main concern is that you're publishing
> documenting a binding which isn't intended to be the the final bindin=
g
> and which there's no intention that anyone should use directly anyway=
=2E

I felt it is the right thing to document the current situation.
The documentation will be updated as we can move away from the
"ti,hwmods" tag from DT.
I can place comment in the documentation for omap-dmic, omap-mcpdm
stating that the use of "ti,hwmods" is required at the moment, but it i=
s
temporally solution.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
