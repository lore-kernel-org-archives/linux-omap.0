From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv5 1/4] regulator: omap smps regulator driver
Date: Tue, 27 Sep 2011 13:06:35 -0700
Message-ID: <87bou5zr5g.fsf@ti.com>
References: <1314803478-15634-1-git-send-email-t-kristo@ti.com>
	<1314803478-15634-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:47404 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751429Ab1I0UGl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 16:06:41 -0400
Received: by mail-yx0-f179.google.com with SMTP id 8so5971695yxk.10
        for <linux-omap@vger.kernel.org>; Tue, 27 Sep 2011 13:06:40 -0700 (PDT)
In-Reply-To: <1314803478-15634-2-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Wed, 31 Aug 2011 18:11:15 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Todd Poynor <toddpoynor@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Graeme Gregory <gg@slimlogic.co.uk>

Tero Kristo <t-kristo@ti.com> writes:

> OMAP SMPS regulator driver provides access to OMAP voltage processor
> controlled regulators. These include VDD_MPU and VDD_CORE for OMAP3 and
> additionally VDD_IVA for OMAP4. SMPS regulators use the OMAP voltage
> layer for the actual voltage regulation operations.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Todd Poynor <toddpoynor@google.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Graeme Gregory <gg@slimlogic.co.uk>

I believe this was already ack'd by Mark.  Have there been any
significan changes since then?

Kevin
