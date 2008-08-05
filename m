From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Added support for OMAP35x processor series
Date: Tue, 5 Aug 2008 15:43:50 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593013C9AECDA@dbde02.ent.ti.com>
References: <premi@ti.com> <1217591379-1515-1-git-send-email-premi@ti.com>
 <20080805092523.GK7193@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB593013C9AEC8E@dbde02.ent.ti.com>
 <1217929845.16579.164.camel@localhost>
 <9F0A21B6-F565-42A7-9134-4AAF15DDFD62@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:43407 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970AbYHEKXw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 06:23:52 -0400
In-Reply-To: <9F0A21B6-F565-42A7-9134-4AAF15DDFD62@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kridner, Jason" <jdk@ti.com>

A configure time selection will be definitive.

Best regards,
Sanjeev

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Koen Kooi
Sent: Tuesday, August 05, 2008 3:41 PM
To: linux-omap@vger.kernel.org
Cc: Kridner, Jason
Subject: Re: [PATCH] Added support for OMAP35x processor series


Op 5 aug 2008, om 11:50 heeft Igor Stoppa het volgende geschreven:

> On Tue, 2008-08-05 at 15:09 +0530, ext Premi, Sanjeev wrote:
>> This patch is needed to ensure that we can make decisions based on
>> the processor capabilities.
>> E.g. OMAP3503 does not contain a DSP. We shouldn't be trying to
>> disable/ manage the clocks for DSP on this processor. Same for SGX.
>
> Why can't the detection happen at runtime?

AIUI the ID bits are the same (linux misdetect the 3530 on my beagle for a 3430). I heard that the only definitive way to do it at runtime is to CRC check the ROM code.

Jason, is that correct?

regards,

Koen

>> Enabling NEON is support iby default is just based on the number of
>> requests I have been getting from various users.
>
> Huh?
>
>
> --
>
> Cheers, Igor
>
> ---
>
> Igor Stoppa
> Maemo Software - Nokia Devices R&D - Helsinki
> --
> To unsubscribe from this list: send the line "unsubscribe linux- omap"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
>

