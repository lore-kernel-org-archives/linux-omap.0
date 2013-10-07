From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Mon, 7 Oct 2013 11:13:43 -0500
Message-ID: <5252DDB7.9080603@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com> <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com> <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36838 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954Ab3JGQOM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Oct 2013 12:14:12 -0400
In-Reply-To: <20131007154103.GW8949@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/07/2013 10:41 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [131006 23:43]:
>> On 10/07/2013 05:15 AM, Tony Lindgren wrote:
>>> * Tero Kristo <t-kristo@ti.com> [131004 08:42]:
>>>> Hi,
>>>>
>>>> Just a gentle reminder, anybody have any comments on this series or
>>>> should we start queuing stuff?
>>>
>>> Well omap4 seems to work for me just fine, and omap3 in legacy
>>> mode. But looks like omap3 device tree based booting is breaking
>>> after I pulled in your test branch. I get the following on
>>> 3630 based dm3730.
>>
>> Uart4 breaks because of the issue with basic DT blobs. You need at
>> least this patch:
>>
>> http://linux-kernel.2935.n7.nabble.com/RFC-PATCH-ARM-OMAP3630-Add-generic-machine-descriptor-td722791.html
>>
>> ... from Nishanth to get it to work right. Otherwise the clock init
>> tries to use omap3430 clock data for omap3630 which leaves uart4
>> nodes out.
> 
> OK thanks yes that solves it, I was missing the compatible flag
> for my not quite ready test boards (3730-evm and zoom3).
> I'll apply Nishant's fix with some changes.
> 
I will post out an RFC based on Olof's suggestion in a few mins. will
be nice to see any deltas needed.


-- 
Regards,
Nishanth Menon
