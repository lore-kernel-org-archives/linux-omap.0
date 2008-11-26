From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap3evm LCD red-tint workaround
Date: Wed, 26 Nov 2008 09:30:53 -0800
Message-ID: <20081126173043.GO11997@atomide.com>
References: <57322719-1A5A-45DC-9846-5C0A3B6EF346@student.utwente.nl> <1225655779-18934-1-git-send-email-notasas@gmail.com> <D6849C63-01EB-4A13-BD1F-CF2234276907@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63000 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbYKZRaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 12:30:55 -0500
Content-Disposition: inline
In-Reply-To: <D6849C63-01EB-4A13-BD1F-CF2234276907@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org

* Koen Kooi <k.kooi@student.utwente.nl> [081102 14:00]:
>
> Op 2 nov 2008, om 20:56 heeft Grazvydas Ignotas het volgende geschreven:
>
>>> PS: TS is still unusable with the 16x16 pixel resolution
>> This is also the case for Pandora. The patch below fixes the problem,
>> but as I have no other boards to test this on, I haven't sent it.
>> See if it helps you.
>
> This fixes the problem on the EVM as well, thanks!

Guys, please take this discussion to fbdev mailing list and cc
linux-omap list. I'm not going to push any more omap fbdev patches,
so please send the patches against mainline kernel to fbdev list.

Regards,

Tony


>
> regards,
>
> Koen
>
>
>>
>>
>>
>> From 91f3af26bbf751b846e6265d86387e81be7c1364 Mon Sep 17 00:00:00 2001
>> From: Grazvydas Ignotas <notasas@gmail.com>
>> Date: Tue, 28 Oct 2008 22:01:42 +0200
>> Subject: [PATCH] OMAP3: fix McSPI transfers
>>
>> Currently on OMAP3 if both write and read is set up for a transfer,
>> the first byte returned on read is corrupted. Work around this by
>> disabling channel between reads and writes, instead of transfers.
>> ---
>> drivers/spi/omap2_mcspi.c |    7 ++++---
>> 1 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index 454a271..4890b6c 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -710,7 +710,6 @@ static void omap2_mcspi_work(struct work_struct  
>> *work)
>> 		spi = m->spi;
>> 		cs = spi->controller_state;
>>
>> -		omap2_mcspi_set_enable(spi, 1);
>> 		list_for_each_entry(t, &m->transfers, transfer_list) {
>> 			if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
>> 				status = -EINVAL;
>> @@ -741,6 +740,8 @@ static void omap2_mcspi_work(struct work_struct  
>> *work)
>> 			if (t->len) {
>> 				unsigned	count;
>>
>> +				omap2_mcspi_set_enable(spi, 1);
>> +
>> 				/* RX_ONLY mode needs dummy data in TX reg */
>> 				if (t->tx_buf == NULL)
>> 					__raw_writel(0, cs->base
>> @@ -752,6 +753,8 @@ static void omap2_mcspi_work(struct work_struct  
>> *work)
>> 					count = omap2_mcspi_txrx_pio(spi, t);
>> 				m->actual_length += count;
>>
>> +				omap2_mcspi_set_enable(spi, 0);
>> +
>> 				if (count != t->len) {
>> 					status = -EIO;
>> 					break;
>> @@ -777,8 +780,6 @@ static void omap2_mcspi_work(struct work_struct  
>> *work)
>> 		if (cs_active)
>> 			omap2_mcspi_force_cs(spi, 0);
>>
>> -		omap2_mcspi_set_enable(spi, 0);
>> -
>> 		m->status = status;
>> 		m->complete(m->context);
>>
>> -- 
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>


