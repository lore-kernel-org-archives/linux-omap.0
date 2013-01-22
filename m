From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v3 00/12] video: da8xx-fb: am335x DT support
Date: Tue, 22 Jan 2013 18:03:58 +0100
Message-ID: <02F0A27B-B16B-42F8-A0BC-29726732226D@dominion.thruhere.net>
References: <cover.1358871750.git.afzal@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1358871750.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-omap@vger.kernel.org


Op 22 jan. 2013, om 17:51 heeft Afzal Mohammed <afzal@ti.com> het volgende geschreven:

> Hi,
> 
> This series adds DT support to da8xx-fb driver (device found on
> DaVinci and AM335x SoC's). It does certain cleanup's in the process.
> 
> This series as compared to previous version handles configuration of
> the LCDC clock rate by modelling as a clock divider of CCF. This would
> take effect only if CCF is selected, if not, no change to  existing
> method.
> 
> This makes use of Steffen Trumtrar's v16 of display timing DT support.

Wouldn't it be better to delete da8xx-fb.* and switch to Rob Clarks DRM based driver for this IP block?

regards,

Koen