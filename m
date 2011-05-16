From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: Re: [PATCHv2 0/2] [RFC] Shrink clock data utilizing preprocessor
Date: Mon, 16 May 2011 19:25:11 +0300
Message-ID: <BANLkTi=UE1YwBC3_Cd-Qo1YpGnLpjGWW5g@mail.gmail.com>
References: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com>
	<20110516075618.GC2429@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39520 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab1EPQZM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 12:25:12 -0400
Received: by qyg14 with SMTP id 14so2720403qyg.19
        for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 09:25:12 -0700 (PDT)
In-Reply-To: <20110516075618.GC2429@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Sascha,

On Mon, May 16, 2011 at 10:56 AM, Sascha Hauer <s.hauer@pengutronix.de>=
 wrote:
> Hi Vladimir,
>
> On Mon, May 16, 2011 at 12:45:56AM +0300, Vladimir Zapolskiy wrote:
>> This change shows a possibility to utilize C preprocessor to remove
>> redundant data from clock definitions for OMAP4 architecture.
>>
>> If the change is evaluated as a positive one, the same approach coul=
d
>> be applied in reducing LOCs from other files, which contain monotono=
us
>> data enumeration.
>>
>> Vladimir Zapolskiy (2):
>> =C2=A0 OMAP4: clock data: shrink clock data utilizing preprocessor.
>> =C2=A0 OMAP4: clock data: shrink more clock data.
>>
>> =C2=A0arch/arm/mach-omap2/clock44xx_data.c | 3313 +++++++++---------=
----------------
>> =C2=A01 files changed, 848 insertions(+), 2465 deletions(-)
>
> While the diffstat shows a huge saving in loc I suggest to delay this
> until we have common clock code merged so that we don't have to
> completely rework these files again in the near future.
>
> This has been said before, I just wanted to add my +1 on this opinion=
=2E

no objections from my side, the proposed change is deliberately marked
as RFC, and I've decided to resend the patches just to show them public=
ly
and to gather more comments.

Best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
