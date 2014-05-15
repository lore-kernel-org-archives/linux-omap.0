From: Alex Shi <alex.shi@linaro.org>
Subject: Re: RCU stall on panda
Date: Thu, 15 May 2014 21:26:20 +0800
Message-ID: <5374C07C.1070400@linaro.org>
References: <53675C5F.10509@linaro.org> <20140505180617.GM8754@linux.vnet.ibm.com> <20140512212102.GF5668@atomide.com> <5371BD69.8010600@linaro.org> <20140513153220.GC16837@atomide.com> <53747E6D.60500@linaro.org> <53748371.5030704@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:62718 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbaEON0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 09:26:39 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so1112424pbb.3
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2014 06:26:39 -0700 (PDT)
In-Reply-To: <53748371.5030704@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "naresh.kamboju@linaro.org Kamboju" <naresh.kamboju@linaro.org>, Linaro Kernel <linaro-kernel@lists.linaro.org>, LAK <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@linaro.org>, linux-omap@vger.kernel.org

On 05/15/2014 05:05 PM, Daniel Lezcano wrote:
>>>
>>
>> After enable this patch, system maybe hang in idle. :(
> 
> Hi Alex,
> 
> do you mean even with this revert applied, the board hangs in idle ?
> 

yes.
My board is panda ES. without this revert, it works.

-- 
Thanks
    Alex
