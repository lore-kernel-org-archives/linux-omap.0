From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PATCH[V2 1/3]: Update Platform files for SPI
Date: Wed, 30 Jun 2010 14:03:32 -0600
Message-ID: <AANLkTinEfJqvRZKqMaXY3_EE4WJT3W3_j0Kwg89pt_SU@mail.gmail.com>
References: <9629.10.24.255.17.1265192505.squirrel@dbdmail.itg.ti.com>
	<20100209222513.GJ21755@atomide.com> <fa686aa41002180828l378a9550u125752e1e972a345@mail.gmail.com>
	<20100218170946.GO21755@atomide.com> <fa686aa41002180929u555e2af0s9f0646fccb744955@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42702 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757221Ab0F3UDx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 16:03:53 -0400
Received: by gwb15 with SMTP id 15so659909gwb.19
        for <linux-omap@vger.kernel.org>; Wed, 30 Jun 2010 13:03:52 -0700 (PDT)
In-Reply-To: <fa686aa41002180929u555e2af0s9f0646fccb744955@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Hemanth V <hemanthv@ti.com>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net

On Thu, Feb 18, 2010 at 11:29 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Thu, Feb 18, 2010 at 10:09 AM, Tony Lindgren <tony@atomide.com> wr=
ote:
>> * Grant Likely <grant.likely@secretlab.ca> [100218 08:26]:
>>> On Tue, Feb 9, 2010 at 3:25 PM, Tony Lindgren <tony@atomide.com> wr=
ote:
>>> > * Hemanth V <hemanthv@ti.com> [100203 02:19]:
>>> >> From ee48142ddc43129a21676dbb56a83e3e7d8063de Mon Sep 17 00:00:0=
0 2001
>>> >> From: Hemanth V <hemanthv@ti.com>
>>> >> Date: Fri, 27 Nov 2009 14:22:30 +0530
>>> >> Subject: [PATCH] Update platform files
>>> >>
>>> >> This patch updates platform files for
>>> >> fifo, slave support
>>> >>
>>> >> Signed-off-by: Hemanth V <hemanthv@ti.com>
>>> >
>>> > This should get merged via the spi-devel list with the other patc=
hes.
>>> >
>>> > Acked-by: Tony Lindgren <tony@atomide.com>
>>>
>>> Tony, do you want me to add your acked-by to patches 2 & 3?
>>
>> No thanks, I've only looked at them briefly.
>
> Okay, thanks.
>
> Hemanth, I'm going to drop this series for the moment. =A0I'd like to
> see some feedback/acks from current users and maintainers of the
> omap2_mcspi driver before I merge support, especially now when the
> merge window is about to open and it hasn't gotten any linux-next
> exposure.
>
>>> Also, what is your feeling about patch 3/3, spi slave support. =A0s=
pi
>>> slave usage model is still a matter under debate, but that patch
>>> doesn't touch core spi code, so I'm okay to merge it as a
>>> driver-specific feature. =A0However, I'm not convinced that it is
>>> actually a useful patch to merge yet, so I'll defer to you on this
>>> one. =A0Thoughts?
>>
>> Up to you to decide. But here's my experience so far..
>>
>> Based on my experience if temporary hacks are merged, then nobody
>> bothers to clean them up properly afterwards and the clean-up task
>> unfairly falls on the maintainer.
>>
>> So IMHO, hacks like that are better floating on the mailing list
>> until they're properly done. It's best to concentrate on getting
>> the core things done right to make long term support easier.
>
> Right, I agree. =A0I'll ignore patch 3 entirely until I at least see =
a
> patch for an in-tree user.

Hi Hemanth.  Could you please respin patches 1 and 2 against
2.6.35-rc3?  The current patches do not apply anymore.

Thanks,
g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
