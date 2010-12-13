From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add omap_device latency information
Date: Mon, 13 Dec 2010 09:45:46 +0100
Message-ID: <4D05DD3A.2050807@ti.com>
References: <1292032266-29460-1-git-send-email-omar.ramirez@ti.com>	<1292032266-29460-6-git-send-email-omar.ramirez@ti.com> <AANLkTi=cQVr-T1mJeq9uaRn5VyXxBG-xcp79z898E6nx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37868 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677Ab0LMIqG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 03:46:06 -0500
In-Reply-To: <AANLkTi=cQVr-T1mJeq9uaRn5VyXxBG-xcp79z898E6nx@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "Varadarajan, Charulatha" <charu@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12/11/2010 4:25 PM, Ramirez Luna, Omar wrote:
> On Fri, Dec 10, 2010 at 7:51 PM, Omar Ramirez Luna<omar.ramirez@ti.com>  wrote:
>> From: Felipe Contreras<felipe.contreras@gmail.com>
>>
>> So that we can enable the main clock.
>
> This should be:
>
> Subject: OMAP: mailbox: use runtime pm for clk and sysc handling
>
> Use runtime pm APIs to enable/disable mailbox clocks and to configure
> SYSCONFIG registers.
>
> And if someone agrees, device_latency can be merged with the previous
> patch for device_build. I'll wait for comments and resubmit.

Yes, you're right, the device latency has nothing to do in that patch. 
It should be in the previous patch: [PATCH v3 4/5] OMAP: mailbox: build 
device using omap_device/omap_hwmod.

regards,
Benoit

