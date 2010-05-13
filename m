From: ye janboe <janboe.ye@gmail.com>
Subject: Re: [PATCHv2 1/2] ARM: VFP: Fixed suspend and added context save
	support
Date: Thu, 13 May 2010 14:59:44 +0800
Message-ID: <AANLkTimKKwe-_kjiSlr3fVVy0Bi1krK8rmyT8-0L3B0d@mail.gmail.com>
References: <1259847353-22725-1-git-send-email-tero.kristo@nokia.com>
	 <1259847353-22725-2-git-send-email-tero.kristo@nokia.com>
	 <AANLkTilyji16JTT1Oe8fOT6Oz5tzopQNc-3AIQ3UprCO@mail.gmail.com>
	 <20100511212719.GC32186@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:36973 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab0EMG7o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 02:59:44 -0400
Received: by pzk42 with SMTP id 42so536121pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 23:59:44 -0700 (PDT)
In-Reply-To: <20100511212719.GC32186@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <tero.kristo@nokia.com>

Thanks for Russell and Tony.

I think this patch is needed when MPU support OFF mode, special on
omap. Otherwise, VFP state will be lost.

Reviewed-by: Janboe Ye <janboe.ye@gmail.com>

2010/5/12 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, May 11, 2010 at 11:15:13AM +0800, ye janboe wrote:
>> Is this patch ignored by you? I do not see any ack for this patch.
>
> Patch is fine, shame some of the people on the Cc haven't acked it though.
> Can we get acks from anyone of those, and then submit it to the patch
> system?
>
>> > Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> > Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
>> > Cc: Rajendra Nayak <rnayak@ti.com>
>> > Cc: Richard Woodruff <r-woodruff2@ti.com>
>> > Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>
