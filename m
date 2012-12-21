From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap_twl: Change TWL4030_MODULE_PM_RECEIVER
 to TWL_MODULE_PM_RECEIVER
Date: Fri, 21 Dec 2012 13:52:02 +0100
Message-ID: <50D45B72.2050300@ti.com>
References: <1352799152-20980-1-git-send-email-peter.ujfalusi@ti.com> <50A4A376.3020703@ti.com> <20121121215234.GB5279@atomide.com> <50ADFDD3.1080508@ti.com> <20121214171800.GO4989@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38750 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab2LUMwH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 07:52:07 -0500
In-Reply-To: <20121214171800.GO4989@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

Hi Tony,

On 12/14/2012 06:18 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [121122 02:28]:
>> Hi Tony,
>>
>> On 11/21/2012 10:52 PM, Tony Lindgren wrote:
>>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [121115 00:12]:
>>>> Hi Tony,
>>>>
>>>> On 11/13/2012 10:32 AM, Peter Ujfalusi wrote:
>>>>> To facilitate upcoming cleanup in twl stack.
>>>>> No functional change.
>>>>
>>>> Would you please consider this patch for 3.8? It would shorten the=
 time I'll
>>>> need to progress on the cleanup regarding to twl-core greatly.
>>>
>>> Please go ahead and merge this with your other patches:
>>>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>>
>>> Or let me know if I still need to queue it.
>>
>> This patch has no dependencies on other patches. It is better to go =
via
>> linux-omap.
>=20
> Applying into omap-for-v3.8/fixes-for-merge-window.

Today I looked at:
omap-for-v3.8/fixes-for-merge-window-part2
omap-for-v3.8/fixes-for-merge-window-v4
omap-for-v3.8/fixes-non-critical-v2

branches as well linux-next, mainline, but I can not find this patch. I=
 want
to send the second part of the twl-core cleanup series which needs this=
 patch
to be in first.
Can you make sure this is going for 3.8?

Thank you,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
