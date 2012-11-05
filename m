From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 02/15] ARM: OMAP2+: mailbox: Add support for AM33XX
Date: Mon, 5 Nov 2012 20:30:37 +0530
Message-ID: <5097D495.6000704@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-3-git-send-email-vaibhav.bedia@ti.com> <509541FD.4040307@ti.com> <B5906170F1614E41A8A28DE3B8D121433EBFFD1A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46585 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932251Ab2KEPAo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 10:00:44 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EBFFD1A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Sunday 04 November 2012 08:56 PM, Bedia, Vaibhav wrote:
> On Sat, Nov 03, 2012 at 21:40:37, Shilimkar, Santosh wrote:
> [...]
>
>>> +#if defined(CONFIG_SOC_AM33XX)
>>> +	else if (soc_is_am33xx()) {
>>> +		list = am33xx_mboxes;
>>> +
>>> +		list[0]->irq = platform_get_irq(pdev, 0);
>>> +	}
>>> +#endif
>> #ifdef in middle of the function looks really ugly. But I can't complain
>> just for your patch because looks like rest of the mailbox code is
>> flooded with #ifdeffery.
>>
>> Mailbox needs cleanup. and probably can be moved out of
>> arch/arm/*omap*/ to some driver directory.
>>
>
> Tony pointed out that the movement to drivers directory
> is underway [1]. Getting rid of the #ifdeffery could be next.
>
Thanks for the pointer. Nice to see mailbox is getting moved
to drivers directory.

Regards
Santosh

