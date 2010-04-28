From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP3: PM: Add milliseconds interface to suspend wakeup timer
Date: Wed, 28 Apr 2010 11:51:18 -0700
Message-ID: <87d3xje7h5.fsf@deeprootsystems.com>
References: <1269245454-24254-1-git-send-email-Ext-Ari.Kauppi@nokia.com>
	<1269327899-22541-1-git-send-email-Ext-Ari.Kauppi@nokia.com>
	<20100323083248.GA18857@pcarmody-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:45573 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab0D1SvW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 14:51:22 -0400
Received: by pxi17 with SMTP id 17so2848920pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 11:51:21 -0700 (PDT)
In-Reply-To: <20100323083248.GA18857@pcarmody-desktop> (Phil Carmody's message of "Tue\, 23 Mar 2010 10\:32\:49 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

Phil Carmody <ext-phil.2.carmody@nokia.com> writes:

> On 23/03/10 08:04 +0100, Kauppi Ari (EXT-Ixonos/Oulu) wrote:
>> Millisecond resolution is possible and there are use cases for it
>> (automatic testing).
>> 
>> Seconds-based interface is preserved for compatibility.
>> 
>> Signed-off-by: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
>>
>> ---
>> v2: Keep seconds and milliseconds interfaces strictly separate:
>>  - Consistent interface, setting/getting seconds and milliseconds
>>    is always accurate
>>  - Fixes potential overflow issues in omap2_pm_wakeup_on_timer
>>  - Cleaner patch
>
> Nice one. Just what we need, nothing more, nothing less.
>
> Reviewed-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
>

Thanks, tested on omap3evm.

Pulling into PM branch queueing for 2.6.35.

Kevin
