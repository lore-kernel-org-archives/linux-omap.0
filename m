From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv3 12/14] ARM: dts: omap3 clocks: simplify ssi aliases
Date: Sat, 19 Apr 2014 22:26:55 +0200
Message-ID: <20140419202655.GL5148@amd.pavel.ucw.cz>
References: <1396053110-21639-1-git-send-email-sre@kernel.org>
 <1396053110-21639-13-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59993 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbaDSU05 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Apr 2014 16:26:57 -0400
Content-Disposition: inline
In-Reply-To: <1396053110-21639-13-git-send-email-sre@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Sebastian Reichel <sre@ring0.de>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@debian.org>

On Sat 2014-03-29 01:31:48, Sebastian Reichel wrote:
> From: Sebastian Reichel <sre@debian.org>
> 
> update aliases for the ssi clocks ssi_ssr_fck, ssi_sst_fck and ssi_ick
> to make them consistent for omap34xx and omap36xx. This makes it
> possible to reference the clocks from generic omap3 dts files.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> Acked-by: Tero Kristo <t-kristo@ti.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
