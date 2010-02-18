From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PATCH[V2 1/3]: Update Platform files for SPI
Date: Thu, 18 Feb 2010 10:29:36 -0700
Message-ID: <fa686aa41002180929u555e2af0s9f0646fccb744955@mail.gmail.com>
References: <9629.10.24.255.17.1265192505.squirrel@dbdmail.itg.ti.com>
	<20100209222513.GJ21755@atomide.com> <fa686aa41002180828l378a9550u125752e1e972a345@mail.gmail.com>
	<20100218170946.GO21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f200.google.com ([209.85.210.200]:55355 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758628Ab0BRR36 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 12:29:58 -0500
Received: by yxe38 with SMTP id 38so6615095yxe.4
        for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 09:29:56 -0800 (PST)
In-Reply-To: <20100218170946.GO21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Hemanth V <hemanthv@ti.com>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net

On Thu, Feb 18, 2010 at 10:09 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Grant Likely <grant.likely@secretlab.ca> [100218 08:26]:
>> On Tue, Feb 9, 2010 at 3:25 PM, Tony Lindgren <tony@atomide.com> wro=
te:
>> > * Hemanth V <hemanthv@ti.com> [100203 02:19]:
>> >> From ee48142ddc43129a21676dbb56a83e3e7d8063de Mon Sep 17 00:00:00=
 2001
>> >> From: Hemanth V <hemanthv@ti.com>
>> >> Date: Fri, 27 Nov 2009 14:22:30 +0530
>> >> Subject: [PATCH] Update platform files
>> >>
>> >> This patch updates platform files for
>> >> fifo, slave support
>> >>
>> >> Signed-off-by: Hemanth V <hemanthv@ti.com>
>> >
>> > This should get merged via the spi-devel list with the other patch=
es.
>> >
>> > Acked-by: Tony Lindgren <tony@atomide.com>
>>
>> Tony, do you want me to add your acked-by to patches 2 & 3?
>
> No thanks, I've only looked at them briefly.

Okay, thanks.

Hemanth, I'm going to drop this series for the moment.  I'd like to
see some feedback/acks from current users and maintainers of the
omap2_mcspi driver before I merge support, especially now when the
merge window is about to open and it hasn't gotten any linux-next
exposure.

>> Also, what is your feeling about patch 3/3, spi slave support. =A0sp=
i
>> slave usage model is still a matter under debate, but that patch
>> doesn't touch core spi code, so I'm okay to merge it as a
>> driver-specific feature. =A0However, I'm not convinced that it is
>> actually a useful patch to merge yet, so I'll defer to you on this
>> one. =A0Thoughts?
>
> Up to you to decide. But here's my experience so far..
>
> Based on my experience if temporary hacks are merged, then nobody
> bothers to clean them up properly afterwards and the clean-up task
> unfairly falls on the maintainer.
>
> So IMHO, hacks like that are better floating on the mailing list
> until they're properly done. It's best to concentrate on getting
> the core things done right to make long term support easier.

Right, I agree.  I'll ignore patch 3 entirely until I at least see a
patch for an in-tree user.

Thanks,
g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
