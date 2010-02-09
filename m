From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PATCH[V2 1/3]: Update Platform files for SPI
Date: Tue, 9 Feb 2010 15:40:43 -0700
Message-ID: <fa686aa41002091440p588ad328i14d0fb28390b2672@mail.gmail.com>
References: <9629.10.24.255.17.1265192505.squirrel@dbdmail.itg.ti.com>
	<20100209222513.GJ21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f183.google.com ([209.85.223.183]:39166 "EHLO
	mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab0BIWlF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 17:41:05 -0500
Received: by iwn13 with SMTP id 13so8972881iwn.25
        for <linux-omap@vger.kernel.org>; Tue, 09 Feb 2010 14:41:03 -0800 (PST)
In-Reply-To: <20100209222513.GJ21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Hemanth V <hemanthv@ti.com>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net

On Tue, Feb 9, 2010 at 3:25 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Hemanth V <hemanthv@ti.com> [100203 02:19]:
>> From ee48142ddc43129a21676dbb56a83e3e7d8063de Mon Sep 17 00:00:00 2001
>> From: Hemanth V <hemanthv@ti.com>
>> Date: Fri, 27 Nov 2009 14:22:30 +0530
>> Subject: [PATCH] Update platform files
>>
>> This patch updates platform files for
>> fifo, slave support
>>
>> Signed-off-by: Hemanth V <hemanthv@ti.com>
>
> This should get merged via the spi-devel list with the other patches.
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Personally, I prefer not to carry arch/* changes in my next-spi
branch, since it means that my pull requests are less obvious for
Linus and there is greater chance of conflict.

But if you still really want me to merge it through my tree, (or if
getting the patches out of order will break things) then I'll pick it
up.  Just let me know.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
