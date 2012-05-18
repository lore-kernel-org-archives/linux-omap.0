From: Maxim Podbereznyy <lisarden@gmail.com>
Subject: Re: tps65910
Date: Fri, 18 May 2012 19:46:26 +0300
Message-ID: <CAP3+TEp8mu386GNGMgQsdwy9cDysGvUthPJT1gtRMOKtD_K1Hw@mail.gmail.com>
References: <CAP3+TErDaA9Sdf2yf9asu1kNqRowTAga6NksVW9j4c+fzi9v=Q@mail.gmail.com>
	<C8443D0743D26F4388EA172BF4E2A7A93E98DDAD@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56447 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965120Ab2ERQq2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 12:46:28 -0400
Received: by lahd3 with SMTP id d3so2217643lah.19
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 09:46:26 -0700 (PDT)
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E98DDAD@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Mohammed!

Thanks a lot! This code certainly can be used as a reference. I just
wonder why it was not possible to rewrite tps65910 driver to comply
with current twl interface? For example tps65910 API for the
Craneboard is 100% the same as for OMAP3 and therefore porting
features from Beagleboard to any board with tps65910 would be like
1-2-3. am33xx BSP is supported by TI, omap3evm is supported by TI,
though both BSPs have absolutely different PMIC API in spite of they
implement the same features..

Max

2012/5/18 Mohammed, Afzal <afzal@ti.com>:
> Hi Maxim,
>
> On Fri, May 18, 2012 at 13:23:53, Maxim Podbereznyy wrote:
>> Hey guys!
>>
>> Who knows how to initialize and use tps65910 driver in linux with
>> am3517? I designed a board using the Craneboard schematic as a
>> reference. Mistral provides the kernel 2.6.32 and it works fine. Now
>> I'm porting the BSP to kernel 3.0.17 and don't know how to implement
>> voltage regulator features with the tps65910 driver (it appeared in
>> kernel 3.0 ) under kernel 3.0 environment.
>>
>> I'm watching board-omap3beagle.c as a reference and tps65910.c driver
>> and can't find any correlation. Any suggestions?
>>
>> Any help is appreciated!
>
> AM335X EVM (support not yet in mainline) works with tps65910, in case AM335X
> release helps you,
>
> git://arago-project.org/git/projects/linux-am33x.git v3.2_AM335xPSP_04.06.00.07
>
> Regards
> Afzal
