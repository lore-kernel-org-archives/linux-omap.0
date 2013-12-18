From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: Add basic devices for AM3517-craneboard
Date: Wed, 18 Dec 2013 18:16:22 +0100
Message-ID: <52B1D866.7040300@baylibre.com>
References: <1386626150-23504-1-git-send-email-nm@ti.com> <52B0A9C8.7070201@ti.com> <52B1D3DC.1010304@baylibre.com> <52B1D50A.50406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:57681 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab3LRRQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 12:16:29 -0500
Received: by mail-pd0-f174.google.com with SMTP id x10so317099pdj.33
        for <linux-omap@vger.kernel.org>; Wed, 18 Dec 2013 09:16:29 -0800 (PST)
In-Reply-To: <52B1D50A.50406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 18/12/2013 18:02, Nishanth Menon wrote:
> On 12/18/2013 10:57 AM, Benoit Cousson wrote:
>> On 17/12/2013 20:45, Nishanth Menon wrote:
>>> On 12/09/2013 03:55 PM, Nishanth Menon wrote:
>>>> Craneboard is a hardware development platform based on the Sitara
>>>> AM3517 ARM Cortex - A8 microprocessor device - see [1] for more
>>>> details. Add basic devices for craneboard as replacement for the b=
oard
>>>> file scheduled for removal as part of device tree conversion
>>>>
>>>> [1] http://craneboard.org
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> ---
>>>
>>> gentle ping.. had'nt seen a response on this patch. Could we queue
>>> this up for v3.14-rc1?
>>
>> Yep, it looks good to me.
> Thanks benoit.
>
>> But if you don't mind I'll start pushing my branch after Xmas :-).
>
> As long as Tony is ok with it, I have no issues either - will be grea=
t
> to have dt only boot in .14-rc1 though.

Good point, it is already -rc4.

OK, I'll just queued it and pushed it to for_3.14/dts.

Regards,
Benoit

--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
