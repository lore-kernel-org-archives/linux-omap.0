From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 2/4] regulator: omap smps regulator driver
Date: Mon, 22 Aug 2011 15:39:01 -0700
Message-ID: <87ty99gjga.fsf@ti.com>
References: <1311853739-18984-1-git-send-email-t-kristo@ti.com>
	<1311853739-18984-3-git-send-email-t-kristo@ti.com>
	<20110729094853.GC13218@opensource.wolfsonmicro.com>
	<87wrersley.fsf@ti.com> <4E3F9E24.1040808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:54170 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753980Ab1HVWjH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 18:39:07 -0400
Received: by mail-gx0-f182.google.com with SMTP id 28so4412211gxk.41
        for <linux-omap@vger.kernel.org>; Mon, 22 Aug 2011 15:39:05 -0700 (PDT)
In-Reply-To: <4E3F9E24.1040808@ti.com> (Liam Girdwood's message of "Mon, 8 Aug
	2011 09:28:20 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Kristo, Tero" <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Todd Poynor <toddpoynor@google.com>, Graeme Gregory <gg@slimlogic.co.uk>

Liam Girdwood <lrg@ti.com> writes:

> On 05/08/11 20:33, Hilman, Kevin wrote:
>> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
>> 
>>> On Thu, Jul 28, 2011 at 02:48:57PM +0300, Tero Kristo wrote:
>>>> OMAP SMPS regulator driver provides access to OMAP voltage processor
>>>> controlled regulators. These include VDD_MPU and VDD_CORE for OMAP3 and
>>>> additionally VDD_IVA for OMAP4. SMPS regulators use the OMAP voltage
>>>> layer for the actual voltage regulation operations.
>>>>
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>
>>> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> 
>> Do you prefer we merge this via OMAP trees (along with the
>> infrastructure) or would you like to merge it.
>> 
>> At this point, it's probably best to merge it along with the voltage
>> infrastructure, which still might change slightly at the API level.
>> 
>
> Ok, lets merge with the voltage infrastructure.
>

OK, shall I take this is an Ack from you then?

Kevin
