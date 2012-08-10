From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH] staging: omapdrm: Fix DMM sparse warnings
Date: Fri, 10 Aug 2012 11:29:34 +0530
Message-ID: <CAB2ybb8n9QToFvPEMEXUgHk4U_1ucd9bJT4UJfbGG+nac021sA@mail.gmail.com>
References: <1344489296-16722-1-git-send-email-andy.gross@ti.com> <CAF6AEGtVAGHd__H5_JQ0+FrYTkz7A6C4c1yr_=X_X_KbYuvM4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51359 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753002Ab2HJF74 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Aug 2012 01:59:56 -0400
Received: by pbbrp2 with SMTP id rp2so2235393pbb.13
        for <linux-omap@vger.kernel.org>; Thu, 09 Aug 2012 22:59:55 -0700 (PDT)
In-Reply-To: <CAF6AEGtVAGHd__H5_JQ0+FrYTkz7A6C4c1yr_=X_X_KbYuvM4g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Andy Gross <andy.gross@ti.com>, Greg Kroah-Hartman <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thu, Aug 9, 2012 at 10:26 PM, Rob Clark <rob.clark@linaro.org> wrote:
> On Thu, Aug 9, 2012 at 12:14 AM, Andy Gross <andy.gross@ti.com> wrote:
>> Fix the following sparse warnings:
>>
>> drivers/staging/omapdrm/omap_dmm_tiler.c:123:13:
>>    warning: symbol 'omap_dmm_irq_handler' was not declared.
>>    Should it be static?
>>
>> drivers/staging/omapdrm/omap_dmm_tiler.c:370:24:
>>    warning: Using plain integer as NULL pointer
>>
>> Signed-off-by: Andy Gross <andy.gross@ti.com>
>
> Signed-off-by: Rob Clark <rob.clark@linaro.org>
Reviewed-by: Sumit Semwal <sumit.semwal@ti.com>
>
>> ---
>>  drivers/staging/omapdrm/omap_dmm_tiler.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.c b/drivers/staging/omapdrm/omap_dmm_tiler.c
>> index 8619783..ec7a5c8 100644
>> --- a/drivers/staging/omapdrm/omap_dmm_tiler.c
>> +++ b/drivers/staging/omapdrm/omap_dmm_tiler.c
>> @@ -120,7 +120,7 @@ static int wait_status(struct refill_engine *engine, uint32_t wait_mask)
>>         return 0;
>>  }
>>
>> -irqreturn_t omap_dmm_irq_handler(int irq, void *arg)
>> +static irqreturn_t omap_dmm_irq_handler(int irq, void *arg)
>>  {
>>         struct dmm *dmm = arg;
>>         uint32_t status = readl(dmm->base + DMM_PAT_IRQSTATUS);
>> @@ -367,7 +367,7 @@ struct tiler_block *tiler_reserve_1d(size_t size)
>>         int num_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>>
>>         if (!block)
>> -               return 0;
>> +               return ERR_PTR(-ENOMEM);
>>
>>         block->fmt = TILFMT_PAGE;
>>
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
