From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 0/3] DSPBRIDGE: Replace custom mailbox implementation
 with kernel mailbox module
Date: Mon, 15 Feb 2010 10:47:04 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA7C1B05@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602AA7C18E0@dlee06.ent.ti.com>
	 <20100215150750.GA4512@annwn.felipec.org>
 <1266249017.25508.1.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36315 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab0BOQrL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 11:47:11 -0500
In-Reply-To: <1266249017.25508.1.camel@sanganak>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>



>-----Original Message-----
>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>Sent: Monday, February 15, 2010 9:50 AM
>To: Contreras Felipe (Nokia-D/Helsinki)
>Cc: Guzman Lugo, Fernando; linux-omap; Doyu Hiroshi (Nokia-D/Helsinki)
>Subject: Re: [PATCH 0/3] DSPBRIDGE: Replace custom mailbox implementation
>with kernel mailbox module
>
>On Mon, 2010-02-15 at 16:07 +0100, Contreras Felipe (Nokia-D/Helsinki)
>wrote:
>> On Sat, Feb 13, 2010 at 03:01:57AM +0100, ext Guzman Lugo, Fernando
>wrote:
>> > >From d287e11cdb126f2c9b4be8d6d6f958ffdf7ff716 Mon Sep 17 00:00:00 2001
>> > From: Fernando Guzman Lugo <x0095840@ti.com>
>> > Date: Fri, 12 Feb 2010 19:55:55 -0600
>> > Subject: [PATCH] DSPBRIDGE: Replace custom mailbox implementation with
>> > kernel mailbox module
>> >
>> > This set of patches removes dspbridge mailbox implementation and
>migrates to
>> > use kernel mailbox module.
>>
>> Awesome! One big step on the right direction :)
>>
>
>Yes, I agree!  Thanks a lot Fernando :)
>
>Is there any plan for replacement of custom iommu interface with iommu
>module?

Yes there is. At this moment I not working on that, but I hope it could be available in a near future.

>
>Cheers,
>Ameya.

