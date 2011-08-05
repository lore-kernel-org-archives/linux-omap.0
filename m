From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 2/4] regulator: omap smps regulator driver
Date: Fri, 05 Aug 2011 12:33:41 -0700
Message-ID: <87wrersley.fsf@ti.com>
References: <1311853739-18984-1-git-send-email-t-kristo@ti.com>
	<1311853739-18984-3-git-send-email-t-kristo@ti.com>
	<20110729094853.GC13218@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:34178 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753904Ab1HETdt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 15:33:49 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6949844pzk.15
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 12:33:47 -0700 (PDT)
In-Reply-To: <20110729094853.GC13218@opensource.wolfsonmicro.com> (Mark
	Brown's message of "Fri, 29 Jul 2011 10:48:54 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Todd Poynor <toddpoynor@google.com>, Liam Girdwood <lrg@ti.com>, Graeme Gregory <gg@slimlogic.co.uk>

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Thu, Jul 28, 2011 at 02:48:57PM +0300, Tero Kristo wrote:
>> OMAP SMPS regulator driver provides access to OMAP voltage processor
>> controlled regulators. These include VDD_MPU and VDD_CORE for OMAP3 and
>> additionally VDD_IVA for OMAP4. SMPS regulators use the OMAP voltage
>> layer for the actual voltage regulation operations.
>> 
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Do you prefer we merge this via OMAP trees (along with the
infrastructure) or would you like to merge it.

At this point, it's probably best to merge it along with the voltage
infrastructure, which still might change slightly at the API level.

Kevin
