From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 08/11] crypto: omap: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 10:59:33 +0530
Message-ID: <4FE7F73D.6090402@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1340372890-10091-9-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1206221257480.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46130 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752113Ab2FYF34 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 01:29:56 -0400
Received: by pbbrq13 with SMTP id rq13so6243758pbb.8
        for <linux-omap@vger.kernel.org>; Sun, 24 Jun 2012 22:29:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1206221257480.10198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Herbert Xu <herbert@gondor.hengli.com.au>

On Saturday 23 June 2012 12:28 AM, Paul Walmsley wrote:
> Hi
>
> On Fri, 22 Jun 2012, Rajendra Nayak wrote:
>
>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
>> and clk_unprepare() for the omap crypto clocks.
>
> These drivers should be converted to use runtime PM instead, since that
> needs to be done anyway.

So if CCF conversion patches get in before these get converted to
runtime PM, do we break them? or should CCF conversion for OMAP
wait till all remaining drivers get converted to runtime PM?

>
>
> - Paul

