From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: Re: tidspbridge build fails
Date: Mon, 24 Sep 2012 17:13:46 -0500
Message-ID: <CAJ6Av5M4BWy709qLLz5HOjXL87GjTqyF6qQku-DSW1B2hNJxJQ@mail.gmail.com>
References: <CAOSRfZ7FsVw+MOUfGZZFiCrg2Ec1iSgypdY=Lijzn_x8NpkhLw@mail.gmail.com>
	<loom.20120924T183345-467@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52721 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab2IXWNs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 18:13:48 -0400
Received: by ieak13 with SMTP id k13so12308107iea.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 15:13:46 -0700 (PDT)
In-Reply-To: <loom.20120924T183345-467@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Selso LIBERADO <sli@cioinfoindus.fr>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hi,

On Mon, Sep 24, 2012 at 11:37 AM, Selso LIBERADO <sli@cioinfoindus.fr> wrote:
...
>>   CC [M]  drivers/staging/tidspbridge/core/tiomap3430.o
>> drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_start':
>> drivers/staging/tidspbridge/core/tiomap3430.c:421:25: error:
>> 'OMAP343X_CTRL_BASE' undeclared (first use in this function)
>> drivers/staging/tidspbridge/core/tiomap3430.c:421:25: note: each
>> undeclared identifier is reported only once for each function it
>> appears in
>> make[3]: *** [drivers/staging/tidspbridge/core/tiomap3430.o] Error 1
...
> This definition has moved to : arch/arm/mach-omap2/omap34xx.h
> I don't know if we can include directly this file in tiomap3430.c (I'm newbie)
>
> However there is still the symbole  OMAP34XX_WDT3_BASE in
> 'drivers/staging/tidspbridge/core/wdt.c' that is not resolved.

This should be solved by Tony's patch:

https://patchwork.kernel.org/patch/1435311/

Right now it is on staging-next.

Regards,

Omar
