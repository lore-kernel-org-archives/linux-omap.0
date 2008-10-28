From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: hsmmc requires data reset after data
	timeout
Date: Tue, 28 Oct 2008 09:59:15 -0700
Message-ID: <20081028165914.GH7539@atomide.com>
References: <48F7438A.8060706@nokia.com> <4906D437.9000607@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64113 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbYJ1Q7V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Oct 2008 12:59:21 -0400
Content-Disposition: inline
In-Reply-To: <4906D437.9000607@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

* Adrian Hunter <ext-adrian.hunter@nokia.com> [081028 01:51]:
> Adrian Hunter wrote:
>> According to TRM a software reset SRD after data timeout
>> is required.
>>
>> Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
>> ---
>> drivers/mmc/host/omap_hsmmc.c |    5 +++++
>> 1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 00b1b68..8fb677e 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -417,6 +417,11 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
>>                     mmc_dma_cleanup(host);
>>                 else
>>                     host->data->error = -EILSEQ;
>> +                OMAP_HSMMC_WRITE(host->base, SYSCTL,
>> +                    OMAP_HSMMC_READ(host->base,
>> +                            SYSCTL) | SRD);
>> +                while (OMAP_HSMMC_READ(host->base,
>> +                            SYSCTL) & SRD) ;
>>                 end_trans = 1;
>>             }
>>         }
>
> Can this and my other 2 patches be applied?

OK, I really want this driver out of the l-o list and submitted via
Pierre. So only fixes at this point.. But I guess these can be
considered fixes, so I'll push them.

BTW, I'll have some patches coming up for the hsmmc.c init to prepare
that for mainline.

Regards,

Tony
