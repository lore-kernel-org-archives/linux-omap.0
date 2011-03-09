From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2 00/18] I2C: OMAP: Fixes and removal of cpu_... from
 driver
Date: Wed, 9 Mar 2011 15:02:27 +0100
Message-ID: <4D778873.4070308@ti.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com> <4D76A164.2060801@ti.com> <20110308233820.GJ26463@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59806 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208Ab1CIOCt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 09:02:49 -0500
In-Reply-To: <20110308233820.GJ26463@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andy Green <andy@warmcat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, Paul Walmsley <paul@pwsan.com>

Hi Tony,

On 3/9/2011 12:38 AM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [110308 13:34]:
>> Hi Andy,
>>
>> Thanks for that really fast update. That looks pretty good at first
>> glance. I still have to review in details.
>
> Yes nice job!
>
>> And we need to find some volunteers for OMAP1&  2 testing.
>
> I gave it a quick try on osk5912, seems to work just fine.
> Will apply these for testing purposes to linux-omap tree while
> waiting for the minor fixes.
>
> Looks like Benoit should take the arch/arm/*omap*/*hwmod*
> patches, the rest should go throug Ben. So for all of them:

Paul and I already acked the hwmod data, but the whole series should 
maybe go through Ben, because the hwmod files will need some defines 
added in the i2c header file. So we cannot separate the hwmod* patches 
from the driver files patches.

I just have one minor comment to keep the OMAP4 data in sync with the 
autogen, but if Andy does not have any important update to do on that 
series, I can potentially fix that later.

Regards
Benoit
