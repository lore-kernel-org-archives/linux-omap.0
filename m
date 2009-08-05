From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] mtd: make onenand/generic.c more generic
Date: Wed, 5 Aug 2009 13:41:32 +0900
Message-ID: <aec7e5c30908042141l18b25ba4l66b3cb309f080b21@mail.gmail.com>
References: <20090804092046.16025.83910.sendpatchset@rx1.opensource.se>
	 <9c9fda240908042124y4f783dfehd575601c0a09550e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:59821 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbZHEElc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 00:41:32 -0400
In-Reply-To: <9c9fda240908042124y4f783dfehd575601c0a09550e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org, tony@atomide.com, lethal@linux-sh.org, linux-omap@vger.kernel.org, dwmw2@infradead.org, akpm@linux-foundation.org

Hi Kyungmin!

> On Tue, Aug 4, 2009 at 6:20 PM, Magnus Damm<magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> This patch removes the ARM dependency from the generic "onenand"
>> platform device driver. This change makes the driver useful for
>> other architectures as well. Needed for the SuperH kfr2r09 board.

On Wed, Aug 5, 2009 at 1:24 PM, Kyungmin Park<kmpark@infradead.org> wrote:
> Good idea add the onenand_platform_data, but dont' agree the renaming
> the onenand-flash.
> Other boards are use it even though it's not released it

I suspected so. But this is the only reason why changed the name. =)

If we don't change the name then the platform device will be attached
to the platform driver as usual, but the old platform data structure
will use a different binary format compated to what the driver
expects.

Changing the driver name makes sure that the old device disappears and
that people can move over to the new name and at the same time update
the platform data to the new format.

> Others are good.

Thanks.

I can post an updated version where I keep the driver name unchanged
if you prefer that. But I'm pretty sure out-of-tree drivers will break
with NULL pointer accesses or similar if we update the platform data
format without changing the name. I don't think you want that. =)

Cheers,

/ magnus
