From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv5 3/6] ARM: OMAP4 PM: Add IO Daisychain support
Date: Mon, 12 Mar 2012 11:40:06 +0530
Message-ID: <4F5D933E.2070200@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <1331046702-2472-4-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1203092051140.30879@utopia.booyaka.com> <4F5D8F2A.1070602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:50330 "HELO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752218Ab2CLGKN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 02:10:13 -0400
Received: by mail-yw0-f41.google.com with SMTP id 47so2614079yhr.0
        for <linux-omap@vger.kernel.org>; Sun, 11 Mar 2012 23:10:12 -0700 (PDT)
In-Reply-To: <4F5D8F2A.1070602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Monday 12 March 2012 11:22 AM, Rajendra Nayak wrote:
>>
>> From: Rajendra Nayak<rnayak@ti.com>
>> Date: Fri, 2 Mar 2012 17:17:52 +0200
>> Subject: [PATCH 3/6] ARM: OMAP4: PRM: Add IO Daisychain support
>>
>> IO daisychain is a mechanism that allows individual IO pads to generate
>> wakeup events on their own based on a switch of an input signal level.
>> This allows the hardware module behind the pad to be powered down, but
>> still have device level capability to detect IO events, and once this
>> happens the module can be powered back up to resume IO. See section
>> 3.9.4 in OMAP4430 Public TRM for details.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com> is just bad
> documentation.
>
>> Signed-off-by: Tero Kristo<t-kristo@ti.com>
>> [paul@pwsan.com: removed MAX_IOPAD_LATCH_TIME declaration; renamed
>
> But the code below still seems to use it. Is it now defined in some
> common header so the same value is used in omap3 and omap4?

never mind, just saw the other updates from you. The patches look good
to me, except for the comment I add to add the second timeout back in
omap3.

Tero, was there a specific reason you got rid of it for omap3 in your
latest patch-set?
