From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] ARM: dts: dra7: fix DSS PLL clock mux registers
Date: Thu, 13 Nov 2014 08:09:43 +0200
Message-ID: <54644B27.8010701@ti.com>
References: <1413190241-13527-1-git-send-email-tomi.valkeinen@ti.com> <20141112152401.GF26481@atomide.com> <20141112152549.GG26481@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45837 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbaKMGJX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2014 01:09:23 -0500
In-Reply-To: <20141112152549.GG26481@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Somnath Mukherjee <somnath@ti.com>

On 11/12/2014 05:25 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [141112 07:26]:
>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [141013 01:52]:
>>> The clock nodes for DSS VIDEO1/2 and HDMI have wrong register addresses.
>>> This patch fixes the addresses so that they point to
>>> CM_CLKSEL_VIDEO1_PLL_SYS, CM_CLKSEL_VIDEO2_PLL_SYS and
>>> CM_CLKSEL_HDMI_PLL_SYS.
>>>
>>> Reported-by: Somnath Mukherjee <somnath@ti.com>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>
>> Applying into omap-for-v3.19/fixes-not-urgent thanks.
>
> Actually this one would be good to have an ack from Tero
> as he may need to fix his scripts generating these entries.

Acked-by: Tero Kristo <t-kristo@ti.com>

>
> So dropping for now.
>
> Regards,
>
> Tony
>

