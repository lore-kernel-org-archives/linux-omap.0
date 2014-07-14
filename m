From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v4 01/11] ARM: omap: edma: add suspend suspend/resume
 hooks
Date: Mon, 14 Jul 2014 12:47:16 -0500
Message-ID: <53C417A4.2060301@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com> <1405047349-15101-2-git-send-email-d-gerlach@ti.com> <20140714110552.GA20068@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39865 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbaGNRri (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Jul 2014 13:47:38 -0400
In-Reply-To: <20140714110552.GA20068@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Daniel Mack <zonque@gmail.com>

On 07/14/2014 06:05 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [140710 19:58]:
>> From: Daniel Mack <zonque@gmail.com>
>>
>> This patch makes the edma driver resume correctly after suspend. Tested
>> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
>>
>> All information can be reconstructed by already known runtime
>> information.
>>
>> As we now use some functions that were previously only used from __init
>> context, annotations had to be dropped.
>
> This is something Sekhar needs to look at, did you maybe forget
> to Cc him?

Yes I did, I will make sure it goes to the right people when it gets split off.

Regards,
Dave

>
> Regards,
>
> Tony
>

