From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial
 stuff)
Date: Tue, 16 Oct 2012 21:24:51 +0200
Message-ID: <507DB483.3090906@ti.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk> <20121012162452.GD30339@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9FCAAF@DBDE01.ent.ti.com> <20121016181252.GE15569@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34748 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398Ab2JPTZC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Oct 2012 15:25:02 -0400
In-Reply-To: <20121016181252.GE15569@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>

Hi Tony,

On 10/16/2012 08:12 PM, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [121014 23:00]:
>> Hi,
>>
>> On Fri, Oct 12, 2012 at 21:54:52, Tony Lindgren wrote:
>>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121012 08:56]:
>>
>>>> omap-gpmc omap-gpmc: error: clk_get
>>>> omap-gpmc: probe of omap-gpmc failed with error -2
>>>
>>> I think Afzal posted something about this already? Looks
>>> like this too could be sparse IRQ related regression..
>>
>> Patch has been posted to resolve the issue,
>> "ARM: OMAP4: hwmod data: gpmc main clk".
> 
> OK thanks I'll pick that up.

In fact you should not pick that one, the one I sent superseded it:

[PATCH] ARM: OMAP2+: clock data: Add dev-id for the omap-gpmc dummy fck

BTW, I cannot find your omap-for-v3.7-rc1/fixes-part2 branch, did you
already pushed it?

Regards,
Benoit

