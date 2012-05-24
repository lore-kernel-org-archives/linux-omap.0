From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP3+: dpll: optimize noncore dpll locking logic
Date: Thu, 24 May 2012 08:09:33 -0500
Message-ID: <CAOMWX4c7T+8TcnjvcMonEQwAbpBFJXRhiBu_cu4i36W81AgLWg@mail.gmail.com>
References: <1337369838-15185-1-git-send-email-nm@ti.com> <alpine.DEB.2.00.1205240147510.2572@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:52085 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753699Ab2EXNJ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 09:09:56 -0400
Received: by wgbds1 with SMTP id ds1so7794496wgb.6
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 06:09:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205240147510.2572@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, Mike Turquette <mturquette@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, May 24, 2012 at 2:49 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Nishanth
>
> On Fri, 18 May 2012, Nishanth Menon wrote:
>
>> From: Vikram Pandita <vikram.pandita@ti.com>
>>
>> If the dpll is already locked, code can be optimized
>> to return much earlier than doing redundent set of lock mode
>> and wait on idlest.
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Jon Hunter <jon-hunter@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Mike Turquette <mturquette@ti.com>
>> Cc: linux-omap@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>
> Did you intend to add your Signed-off-by: to this patch?

Other than forwarding the patch over(since it seems to have slipped
through the fingers of folks monitoring the product trees), I have had
no other contributions to the patch.

> Also, just FYI, no need to add the Cc: lines for the mailing lists in the
> bottom of the patch description.
>
Thanks. point taken. will take care of that in future patches.

Regards,
Nishanth Menon
