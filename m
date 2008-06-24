From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] OMAP2EVM: add ethernet support (smc911x)
Date: Tue, 24 Jun 2008 07:57:50 -0500
Message-ID: <4c2f926971f553819251f824d239ca85@felipebalbi.com>
References: <dfeb90390806240504t3a900901t8879c3fc07aebb0f@mail.gmail.com> <0d8b982e9147570fe343aff404e7a1c6@felipebalbi.com> <dfeb90390806240554v549cf987h20c68685d3082f2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:49580 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbYFXM5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 08:57:52 -0400
In-Reply-To: <dfeb90390806240554v549cf987h20c68685d3082f2b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <getarunks@gmail.com>
Cc: linux-omap@vger.kernel.org



On Tue, 24 Jun 2008 18:24:11 +0530, "Arun KS" <getarunks@gmail.com> wrote:

>> it looks like drivers/net/smc911x doesn't use IORESOURCE_IRQ, am I
>> misreading it ?
>>
> 
> Yes this driver uses platform_get_irq(pdev, 0) to get its irq number.

Cool, thanks :-)

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

