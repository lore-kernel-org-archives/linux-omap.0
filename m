From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v2 5/5] [RFC] omapdss: remove FEAT_DPI_USES_VDDS_DSI from
 omap3
Date: Wed, 22 Jan 2014 16:21:26 -0300
Message-ID: <52E01A36.40502@collabora.co.uk>
References: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com> <1390417460-3134-6-git-send-email-chf.fritz@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40671 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbaAVTVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jan 2014 14:21:36 -0500
In-Reply-To: <1390417460-3134-6-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Nishanth Menon <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, bcousson@baylibre.com, "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <zonque@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hello Christoph,

On 01/22/2014 04:04 PM, Christoph Fritz wrote:
> DBB056 doesn't use DSI for its display, but omap3 forces this
> erroneously for all its boards:
> 
>   | OMAP DSS rev 2.0
>   | omapdss DPI error: can't get VDDS_DSI regulator
>   | omapfb omapfb: failed to connect default display
>   | omapfb omapfb: failed to init overlay connections
>   | omapfb omapfb: failed to setup omapfb
>   | platform omapfb: Driver omapfb requests probe deferral
> 
> So this patch just disables it for omap3. Consider this as a hack!
> Is there a proper fix for this issue?

It is also a hack but I solved on the IGEPv2 board by adding a regulator-name =
"vdds_dsi" to the VPLL2 regulator as suggested by Tony.

Look at commit 2f2befd8 ("ARM: dts: omap3-igep0020: name twl4030 VPLL2 regulator
as vdds_dsi")

Having the workaround in the Device Tree is better IMHO since this is a
per-board configuration. That can be later removed once the DSS DT bindings are
added to mainline.

Thanks a lot and best regards,
Javier
