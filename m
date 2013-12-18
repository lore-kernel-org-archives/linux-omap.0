From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: Add basic devices for AM3517-craneboard
Date: Wed, 18 Dec 2013 11:02:02 -0600
Message-ID: <52B1D50A.50406@ti.com>
References: <1386626150-23504-1-git-send-email-nm@ti.com> <52B0A9C8.7070201@ti.com> <52B1D3DC.1010304@baylibre.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:42450 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab3LRRCI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 12:02:08 -0500
In-Reply-To: <52B1D3DC.1010304@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/18/2013 10:57 AM, Benoit Cousson wrote:
> On 17/12/2013 20:45, Nishanth Menon wrote:
>> On 12/09/2013 03:55 PM, Nishanth Menon wrote:
>>> Craneboard is a hardware development platform based on the Sitara
>>> AM3517 ARM Cortex - A8 microprocessor device - see [1] for more
>>> details. Add basic devices for craneboard as replacement for the board
>>> file scheduled for removal as part of device tree conversion
>>>
>>> [1] http://craneboard.org
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>
>> gentle ping.. had'nt seen a response on this patch. Could we queue
>> this up for v3.14-rc1?
>
> Yep, it looks good to me.
Thanks benoit.

> But if you don't mind I'll start pushing my branch after Xmas :-).

As long as Tony is ok with it, I have no issues either - will be great 
to have dt only boot in .14-rc1 though.
Regards,
Nishanth Menon

