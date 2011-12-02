From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
Date: Fri, 2 Dec 2011 13:29:13 +0100
Message-ID: <4ED8C499.2080002@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com> <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com> <20111202122558.GM8245@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52275 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755012Ab1LBM3n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Dec 2011 07:29:43 -0500
In-Reply-To: <20111202122558.GM8245@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 12/2/2011 1:25 PM, Mark Brown wrote:
> On Fri, Dec 02, 2011 at 11:52:56AM +0200, Peter Ujfalusi wrote:
>
>> +Required properties:
>> +  - compatible : "ti,omap4-dmic"
>> +  - ti,hwmods  : List of hwmod names associated with DMIC, in most case
>> +		 it is "dmic".
>
> Shouldn't there also be a regs property giving the register window?

Not for the moment, because we are still using the hwmod database to 
retrieve the base address + irq + dma.

I need to have the support for resource name before replacing the hwmod 
data by a real "reg" + "reg-names" attributes.

I'll send a series with that ASAP.

Regards,
Benoit
