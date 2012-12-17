From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: OMAP2+: Add PMU nodes
Date: Mon, 17 Dec 2012 17:04:14 +0100
Message-ID: <50CF427E.3000804@ti.com>
References: <1355519930-3851-1-git-send-email-jon-hunter@ti.com> <1355519930-3851-3-git-send-email-jon-hunter@ti.com> <50CED4D3.9080106@ti.com> <50CF411F.4060105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47534 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab2LQQEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 11:04:21 -0500
In-Reply-To: <50CF411F.4060105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>

Hi Jon,

On 12/17/2012 04:58 PM, Jon Hunter wrote:
> 
> On 12/17/2012 02:16 AM, Benoit Cousson wrote:
>> Hi Jon,
>>
>> On 12/14/2012 10:18 PM, Jon Hunter wrote:
>>> Add PMU nodes for OMAP2, OMAP3 and OMAP4460 devices.
>>>
>>> Please note that the node for OMAP4460 has been placed in a separate
>>> header file for OMAP4460, because the node is not compatible with
>>> OMAP4430.
>>
>> But where is the omap4430 node then?
> 
> I have left it out deliberately because OMAP4430 is not yet supported by
> PMU as it is dependent on having a driver for the cross-trigger interface.
> 
> If you prefer to stick the node in the omap4.dtsi for now then that is
> ok, but I wanted to make it clear that this is for omap4460.

No, that's fine, I was just wondering. You should just add that comment
in the cover letter to make it explicit.

Thanks,
Benoit

