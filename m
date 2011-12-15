From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 4/4] ARM: omap: pass minimal SoC/board data for UART
 from dt
Date: Thu, 15 Dec 2011 11:06:15 +0100
Message-ID: <4EE9C697.4010604@ti.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com> <1323863746-18145-5-git-send-email-rnayak@ti.com> <20111214192509.GH32251@atomide.com> <4EE99923.4030902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56313 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758738Ab1LOKGg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 05:06:36 -0500
In-Reply-To: <4EE99923.4030902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com

Hi Tony,

On 12/15/2011 7:52 AM, Rajendra Nayak wrote:
> On Thursday 15 December 2011 12:55 AM, Tony Lindgren wrote:
>> * Rajendra Nayak<rnayak@ti.com> [111214 03:24]:
>>> Pass minimal data needed for console boot, from dt, for
>>> OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
>>> static initialization from generic board file.
>>>
>>> Acked-by: Rob Herring<rob.herring@calxeda.com>
>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>
>> This we can't merge because this breaks serial console for
>> omap2 because you're not adding the omap2 specific dtsi
>> entries for omap2..
>
> But we never had omap2 working with DT, because we never added
> a .dtsi file for omap2 or a .dts file for any omap2 board variants.
>
> Until now the DT support on OMAP has been limited to OMAP3 and OMAP4
> with boards limited to omap3beagle/omap4Panda and omap4sdp.
>
> So when we do add base support for omap2, we could update those
> with the serial entries.

I'm quite confused as well... Have you tried the current 3.2 kernel on 
an OMAP2 board?

So far I've been taking care of keeping the OMAP2 support into the 
board-generic.c file, but I've never added any omap2.dtsi or 
omap2-board.dts file to support it.

Regards,
Benoit
