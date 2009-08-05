From: John Sarman <johnsarman@gmail.com>
Subject: Fwd: MMC3 Overo
Date: Wed, 5 Aug 2009 12:02:01 -0400
Message-ID: <bb2708720908050902o39c67430pbdcd12e9b835ab70@mail.gmail.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
	 <6ed0b2680908050132n33abc45bgd4e91690c43ba277@mail.gmail.com>
	 <bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:39695 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZHEQCC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 12:02:02 -0400
Received: by bwz19 with SMTP id 19so180211bwz.37
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 09:02:01 -0700 (PDT)
In-Reply-To: <bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

---------- Forwarded message ----------
=46rom: John Sarman <johnsarman@gmail.com>
Date: Wed, Aug 5, 2009 at 12:01 PM
Subject: Re: MMC3 Overo
To: Grazvydas Ignotas <notasas@gmail.com>


On Wed, Aug 5, 2009 at 4:32 AM, Grazvydas Ignotas<notasas@gmail.com> wr=
ote:
>> <u-boot_snip>
>> =A0MUX_VAL(CP(ETK_CLK_ES2), =A0 =A0 =A0 (IDIS | PTU | EN =A0| M2)) /=
*MMC3_CLK*/\
>
> You must have input enable on CLK line for MMC3 or it won't work for
> some reason (MMC 1 and 2 doesn't need that). Without this part of the
> host controller hardware doesn't get the clock I guess, or something
> like that. You won't believe how much time we've wasted on this!
>
MUX_VAL(CP(ETK_CLK_ES2), =A0 =A0 =A0 (IEN | PTU | EN =A0| M2)) /*MMC3_C=
LK*/\

Works Beautifully, Thank you so much. =A0I have also burnt too much
midnight oil on this problem.
So looks like Overo MMC3 works like a champ!
John Sarman
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
