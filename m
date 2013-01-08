From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: Re: [PATCH 1/2] staging: tidspbridge: fix breakages due to CM reorganization
Date: Mon, 7 Jan 2013 19:03:36 -0600
Message-ID: <CAJ6Av5O8FJjOSDFxZVoMCkt-NZBPR1NAovs1fSTmdgjouOALLA@mail.gmail.com>
References: <1356358225-25557-1-git-send-email-omar.ramirez@copitl.com>
	<20130107230331.GA29943@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:57054 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab3AHBDh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jan 2013 20:03:37 -0500
Received: by mail-ia0-f173.google.com with SMTP id w21so17173825iac.18
        for <linux-omap@vger.kernel.org>; Mon, 07 Jan 2013 17:03:36 -0800 (PST)
In-Reply-To: <20130107230331.GA29943@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, Tony Lindgren <tony@atomide.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

On Mon, Jan 7, 2013 at 5:03 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Dec 24, 2012 at 08:10:24AM -0600, Omar Ramirez Luna wrote:
>> 3.8-rc1 introduced changes in the clock management header files,
>> this resulted in compilation breakages for this driver.
>>
>> Define this locally while APIs are made available, given that driver
>> code shouldn't include mach header files.
>>
>> This fixes:
>> drivers/staging/tidspbridge/core/tiomap3430.c:550:13: error:
>> 'OMAP3430_CM_AUTOIDLE_PLL' undeclared (first use in this function)
>> drivers/staging/tidspbridge/core/tiomap_io.c:416:13: error:
>> 'OMAP3430_CM_CLKEN_PLL' undeclared (first use in this function)
>>
>> Reported-by: Chen Gang <gang.chen@asianux.com>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@copitl.com>
>
> Enric sent me a patch that just includes the proper .h file, which
> should be better than doing this:

It looks better because the driver is already including related
headers in a similar fashion, but in reality those headers are under
arch/arm/mach-omap2 and the driver shouldn't have any business in
including headers from there.

>> --- a/drivers/staging/tidspbridge/core/_tiomap.h
>> +++ b/drivers/staging/tidspbridge/core/_tiomap.h
>> @@ -40,6 +40,14 @@
>>  #include <dspbridge/sync.h>
>>  #include <dspbridge/clk.h>
>>
>> +/*
>> + * XXX These mach-omap2/ defines are wrong and should be removed.  No
>> + * driver should read or write to PRM/CM registers directly; they
>> + * should rely on OMAP core code to do this.
>> + */
>> +#define OMAP3430_CM_AUTOIDLE_PLL     0x0034
>> +#define OMAP3430_CM_CLKEN_PLL                0x0004
>
> Don't define things that are already defined elsewhere...
>
> I'll not apply this.

Ok, not a problem, I'll be working on the real fix which is to get
APIs from the core code for the driver to use.

Cheers,

Omar
