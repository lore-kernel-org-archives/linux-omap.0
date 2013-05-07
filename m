From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH] ti_tscadc: Update with IIO map interface & deal with partial activation
Date: Tue, 7 May 2013 16:08:40 +0300
Message-ID: <902E054D-F014-4380-A493-96384AC85DD4@antoniou-consulting.com>
References: <1351698938-3839-1-git-send-email-panto@antoniou-consulting.com> <1367844539-6812-1-git-send-email-jlu@pengutronix.de> <5187D655.1010402@kernel.org>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:55737 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758536Ab3EGNP7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 May 2013 09:15:59 -0400
In-Reply-To: <5187D655.1010402@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jan Luebbe <jlu@pengutronix.de>, rachna@ti.com, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>

Hi Jonathan,

On May 6, 2013, at 7:12 PM, Jonathan Cameron wrote:

> On 05/06/2013 01:48 PM, Jan Luebbe wrote:
>> Hi Pantelis,
>> 
>> while trying out your patch on a custom AM335x board, I noticed that the
>> sysfs entries ware missing. This is fixed in the first patch, you might want
>> to squash that into your original patch.
>> 
>> The second one makes sure that the iio framework does not read invalid data.
>> 
>> Regards,
>> Jan
> 
> I don't believe Pantelis ever came back with a response to the various issues
> raised with the original patches?
> 

I am aware. We've been quite busy getting the new beaglebone out. I plan to
revisit the full patchset for all the various fixes we had to do in a month
or so.

> If Pantelis has moved on, Jan feel free to pick up the patches, respin them
> and resend to linux-iio if you like (with appropriate crediting naturally)
> 

I wouldn't mind Jan to pick up the IIO patches.

> Until these are appropriately fixed up and resent, I'm lazy so will ignore these.
> (your patches look reasonable to me based on a really superficial look)
> 
> Jonathan

Regards

-- Pantelis

