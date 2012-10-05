From: kishon <kishon@ti.com>
Subject: Re: MUSB regression in linux next at least for pandboard
Date: Fri, 5 Oct 2012 10:46:40 +0530
Message-ID: <506E6D38.1060105@ti.com>
References: <20121004173107.GD3874@atomide.com> <20121004175742.GB9702@arwen.pp.htv.fi> <20121005013910.GI3874@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51928 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037Ab2JEGko (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 02:40:44 -0400
In-Reply-To: <20121005013910.GI3874@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org

Hi,

On Friday 05 October 2012 07:09 AM, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [121004 11:04]:
>> Hi,
>>
>> On Thu, Oct 04, 2012 at 10:31:08AM -0700, Tony Lindgren wrote:
>>> Hi Felipe & Kishon,
>>>
>>> Looks like musb is broken at least on pandaboard es
>>> in current linux next while it works with v3.6:
>>>
>>> [    1.933074] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
>>> [    1.939422] unable to find transceiver of type USB2 PHYrouping on.  Total pages: 251648
>>> [    1.945190] HS USB OTG: no transceiver configured
>>> [    1.950134] musb-hdrc musb-hdrc.0: musb_init_controller failed with status -19
>>> [    1.958160] couldn't find an available UDC
>>>
>>> I do have CONFIG_OMAP_USB2 set.
>>>
>>> Note that we won't be able to flip omap4 over to be
>>> device tree only probably until v3.9 because of the
>>> bindings we're still missing from usability point of
>>> view. So this regression should be fixed.
>>
>> I see. Kishon, can you cook a patch adding platform_data until we
>> actually move to DT-only for OMAP4 ?

Sure.

Thanks
Kishon
