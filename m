From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: omap clocksource timer selection: dmtimer OR 32K-Sync timer
Date: Fri, 13 Jan 2012 17:09:21 +0100
Message-ID: <4F105731.8010008@ti.com>
References: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com> <4F104B87.8080003@ti.com> <79CD15C6BA57404B839C016229A409A8317A52F0@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58400 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934Ab2AMQJb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 11:09:31 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317A52F0@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Russell King <rmk@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 1/13/2012 4:52 PM, Hiremath, Vaibhav wrote:
> On Fri, Jan 13, 2012 at 20:49:35, Cousson, Benoit wrote:

[...]

>> A series was sent to do that by Felipe last year, but we somehow forgot
>> to rebase it on newer kernel and thus never reposted it.
>
> If you are ok, I can help you here.

Thanks it will be cool if you can fix that series.

> Can you please point me to git repo for
> the same.
>
> And also, this is important for AM33xx support in mainline.

Here is the link to the original series.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37403.html

The hwmod format changed a lot since them, so it should be refreshed.

Regards,
Benoit
