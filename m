From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 23/33] CLK: OMAP: add interface clock support for OMAP3
Date: Thu, 1 Aug 2013 09:50:38 -0500
Message-ID: <51FA75BE.3080802@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-24-git-send-email-t-kristo@ti.com> <51F820DF.1080306@ti.com> <51F92898.3090206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51170 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab3HAOvG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Aug 2013 10:51:06 -0400
In-Reply-To: <51F92898.3090206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 07/31/2013 10:09 AM, Tero Kristo wrote:
> On 07/30/2013 11:23 PM, Nishanth Menon wrote:
>> On 07/23/2013 02:20 AM, Tero Kristo wrote:
>>> OMAP3 has interface clocks in addition to functional clocks, which
>> is it just OMAP3?
>
> Yea, only omap3 is using this code. Basically because there is control
> for the module specific interface clocks which is absent from omap4+.
> Personally I think modelling the interface clocks in the first place in
> kernel side was a bad idea, and should have just enabled all of them and
> enable autoidles for them at the same point.

Not all autoidles work unfortunately, which is why they got modelled :D 
some even have the weird tendency to hang up L3/L4 interconnect when the 
OCP statemachines required inside the IP block for the autoidle PRCM 
handshake has been, umm... "not well implemented" ;) forcing us to use 
S/w supervised mode of operations.


>
>>
>>> require special handling for the autoidle and idle status register
>>> offsets mainly.
>>
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> ---
>>>   drivers/clk/omap/Makefile    |    2 +-
>>>   drivers/clk/omap/clk.c       |    3 ++
>>>   drivers/clk/omap/interface.c |  110
>>> ++++++++++++++++++++++++++++++++++++++++++
>> should this be isolated off for omap3?
>
> You mean within makefile or?

omap3-interface-clock.c or something more sensible and Makefile? I dont 
really have any strong opinions on this anyways.. interface.c is fine 
with me as well as the nodes are not probed unless compatible flags are 
set..

just trying to save a few bits in code space by building only if OMAP3 
is present.. /me shrugs..


-- 
Regards,
Nishanth Menon
