From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 07/11] w1: omap_hdq: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 10:55:51 +0530
Message-ID: <4FE7F65F.2080002@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1340372890-10091-8-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1206221234500.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:48047 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751676Ab2FYFZ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 01:25:59 -0400
Received: by obbun3 with SMTP id un3so10686069obb.27
        for <linux-omap@vger.kernel.org>; Sun, 24 Jun 2012 22:25:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1206221234500.10198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Evgeniy Polyakov <zbr@ioremap.net>

On Saturday 23 June 2012 12:05 AM, Paul Walmsley wrote:
> On Fri, 22 Jun 2012, Rajendra Nayak wrote:
>
>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
>> and clk_unprepare() for the hdq clocks.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Cc: Evgeniy Polyakov<zbr@ioremap.net>
>
> This one should not be needed soon:
>
> http://marc.info/?l=linux-omap&m=134037453807275&w=2

Ok, thanks, will drop this one then.

>
> - Paul

