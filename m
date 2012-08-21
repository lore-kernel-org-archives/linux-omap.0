From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/5] ARM: OMAP4: Add L2 Cache Controller in Device Tree
Date: Tue, 21 Aug 2012 16:16:25 +0530
Message-ID: <CAMQu2gyGfeh6f+Nbg4KfvPtkQYa_KBv7gk0DGTxdY1NbXaUmDg@mail.gmail.com>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
 <1344855623-14879-5-git-send-email-santosh.shilimkar@ti.com>
 <503240EF.4050805@ti.com> <CAMQu2gxgSasF4mmEFiZq-gsZfQwYn07DKyVGBVPWqjYkTSTu6g@mail.gmail.com>
 <CAMQu2gyL4-j9QSKMpNi5QQFsLqex8Q=bW9uNQtsewXVyrTumOQ@mail.gmail.com>
 <20120821102455.GM10347@arwen.pp.htv.fi> <CAMQu2gy46sVEBH0hvaXrwOLMfcKH+fwyExFmwzAPzxQKoYwhhA@mail.gmail.com>
 <5033667E.5060907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:57009 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756567Ab2HUKqr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 06:46:47 -0400
Received: by yenm5 with SMTP id m5so6810809yen.17
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 03:46:46 -0700 (PDT)
In-Reply-To: <5033667E.5060907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.or, tony@atomide.com

On Tue, Aug 21, 2012 at 4:14 PM, Benoit Cousson <b-cousson@ti.com> wrote:
> Hi Santosh,
>

[...]

>>>> From 91d6cb4f999061c8cfc844a3916ee3384f2e488a Mon Sep 17 00:00:00 2001
>>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> Date: Wed, 4 Jul 2012 17:57:34 +0530
>>>> Subject: [PATCH 1/2 v2] ARM: OMAP4: Add L2 Cache Controller in Device Tree
>>>>
>>>> This provides PL310 Level 2 Cache Controller Device Tree
>>>> support for OMAP4 based devices.
>>>>
>>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> nice work :-)
>>>
>>> FWIW this looks good to me:
>>>
>>> Acked-by: Felipe Balbi <balbi@ti.com>
>>>
>> Thanks.
>>
>>> just one thing, will a similar patch for omap3 be sent ?
>>>
>> OMAP3 has an integrated L2 cache controller so there
>> won't any additional DT node for L2.
>>
>> OMAP3 CPU DT node can be updated with l1/l2 cache
>> size etc related information though.
>
> That's not needed if the information is available from the HW.
> DT is only there to provide information that cannot be extracted from HW.
>
Good to know.

> If CP15 registers already contains the details about caches, then there
> is no need to add them in the DT file.
>
True. In that case as you said, there is no need to add that information
in DT.

Regards
Santosh
