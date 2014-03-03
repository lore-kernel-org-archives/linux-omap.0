From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC PATCH v1 0/2] clock and HWMOD changes for USIM module
Date: Mon, 3 Mar 2014 09:16:18 +0200
Message-ID: <53142C42.1020809@ti.com>
References: <1389010351-17320-1-git-send-email-satish.patel@ti.com> <52CE59C8.6040409@ti.com> <20140228215936.GE13624@atomide.com> <53141CB7.20906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50709 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbaCCHQr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Mar 2014 02:16:47 -0500
In-Reply-To: <53141CB7.20906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Satish Patel <satish.patel@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/03/2014 08:09 AM, Satish Patel wrote:
>
>
> On 3/1/2014 3:29 AM, Tony Lindgren wrote:
>> * Satish Patel <satish.patel@ti.com> [140109 00:13]:
>>>
>>>
>>> On 1/6/2014 5:42 PM, Satish Patel wrote:
>>>> Patch set includes clock and HWMOD entries for AM43x's USIM modoule.
>>>>
>>>> Note: I am in process of mainlining usim driver.
>>>>
>>>> Satish Patel (2):
>>>>    ARM: dts: AM43xx-clocks: Entries added for ti-usim
>>>>    ARM: OMAP: AM43xx: HWMOD changes added for ti-usim
>>>>
>>>
>>> Tony,
>>>
>>> Can you pull in these patches if there are no comments?
>>
>> Would like to see acks from Benoit/Tero/Paul first.
>>
> Benoit/Tero/Paul:
> Can you please review and ack this patch series,
> so that tony can pick it up.

NAK, patch #1 is broken.

>
> Thanks
> satish
>> Regards,
>>
>> Tony
>>

