From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 5/5] usb: musb: dsps: indentation and whitespace fixes
Date: Mon, 25 Nov 2013 20:59:03 +0100
Message-ID: <5293AC07.9030705@gmail.com>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com> <1385408393-19707-6-git-send-email-zonque@gmail.com> <20131125194906.GC18046@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:55613 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934Ab3KYT7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 14:59:06 -0500
In-Reply-To: <20131125194906.GC18046@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de

On 11/25/2013 08:49 PM, Felipe Balbi wrote:
> On Mon, Nov 25, 2013 at 08:39:53PM +0100, Daniel Mack wrote:
>> Just a cosmetic thing, no functional change.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>>  drivers/usb/musb/musb_dsps.c | 23 +++++++++++------------
>>  1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
>> index 361ddf8..b27c072 100644
>> --- a/drivers/usb/musb/musb_dsps.c
>> +++ b/drivers/usb/musb/musb_dsps.c
>> @@ -131,9 +131,9 @@ struct dsps_context {
>>  struct dsps_glue {
>>  	struct device *dev;
>>  	struct platform_device *musb;	/* child musb pdev */
>> -	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
>> +	const struct dsps_musb_wrapper *wrp;	/* wrapper register offsets */
>>  	struct timer_list timer;	/* otg_workaround timer */
>> -	unsigned long last_timer;    /* last timer data for each instance */
>> +	unsigned long last_timer;	/* last timer data for each instance */
>>  
>>  	struct dsps_context context;
>>  };
>> @@ -213,7 +213,7 @@ static void dsps_musb_disable(struct musb *musb)
>>  
>>  	dsps_writel(reg_base, wrp->coreintr_clear, wrp->usb_bitmap);
>>  	dsps_writel(reg_base, wrp->epintr_clear,
>> -			 wrp->txep_bitmap | wrp->rxep_bitmap);
>> +		    wrp->txep_bitmap | wrp->rxep_bitmap);
> 
> quite frankly, I don't what checkpatch.pl is trying to force here. I
> much prefer a tab-only indentation, matching with ( characters forces us
> to add some spaces. I would rather not take this patch.
> 

Alright, I really don't care much. I'll drop the patch when resending.

