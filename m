From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Problem with DSS clocks & accessing registers
Date: Mon, 7 Mar 2011 15:52:35 +0100
Message-ID: <4D74F133.5020101@ti.com>
References: <1299486149.2281.77.camel@deskari> <4D74E2D5.2000705@ti.com> <90dc32aa0eb6d68d2a56424de664653d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36931 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab1CGOwk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 09:52:40 -0500
In-Reply-To: <90dc32aa0eb6d68d2a56424de664653d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Taneja, Archit" <archit@ti.com>

On 3/7/2011 3:05 PM, Shilimkar, Santosh wrote:
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Cousson, Benoit
>>
>> + Rajendra
>>
>> Hi Tomi,
>>
>> On 3/7/2011 9:22 AM, Valkeinen, Tomi wrote:
>>> Hi Kevin, Paul,
>>>
>>> We currently have a small problem with OMAP4 DSS. When we enable
>> the DSS
>>> clocks, it seems that the DSS registers are not always accessible
>> right
>>> after the clock enable.
>>
>> What clocks are you talking about? As you know, the DSS has a bunch
>> of functional clocks available depending of the use case.
>>
>>> I understood that on OMAP4 the clock framework doesn't guarantee
>> that
>>> the registers are accessible after enabling clocks, and pm_runtime
>> will handle this. Is this correct?
>>
>
> This seems to the question about a so called optional clock (DSS_CLK)
> which really not an optional clock :)
> This clock needs to be enabled and disabled along with interface and
> functional clock for the registers access to work.

To be more accurate, this clock is one of the functional clock available 
for the DSS (the other being the SYS_CLK).

You can use dss_clk or sys_clk (through dsi pll) to generate the 
functional clock of the DSS. The issue, as I said is that the 
availability status of the DSS is bound to the DSS module mode, not to 
any of this DSS clock.

Benoit


